Received: from eggs.gnu.org ([2001:4830:134:3::10]:40508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ47O-0001Af-L7
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eZ47N-0007ji-E7
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 19:19:46 -0500
Message-ID: <1515543573.1993.10.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 10 Jan 2018 11:19:33 +1100
In-Reply-To: <1515499621.3287.17.camel@redhat.com>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-2-sjitindarsingh@gmail.com>
	<1515499621.3287.17.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [RFC 1/3] hw/ppc/spapr_caps:
 Rework spapr_caps to use uint8 internal representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Tue, 2018-01-09 at 13:07 +0100, Andrea Bolognani wrote:
> On Tue, 2018-01-09 at 20:21 +1100, Suraj Jitindar Singh wrote:
> [...]
> > +static void cap_htm_allow(sPAPRMachineState *spapr, uint8_t val,
> > Error **errp)
> > +{
> > +    if (!val) {
> > +        /* TODO: We don't support disabling htm yet */
> > +        return;
> > +    }
> >      if (tcg_enabled()) {
> >          error_setg(errp,
> > -                   "No Transactional Memory support in TCG, try
> > cap-htm=off");
> > +                   "No Transactional Memory support in TCG, try
> > cap-htm=0");
> >      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
> >          error_setg(errp,
> > -"KVM implementation does not support Transactional Memory, try
> > cap-htm=off"
> > +"KVM implementation does not support Transactional Memory, try
> > cap-htm=0"
> >              );
> >      }
> >  }
> 
> Changing the command-line interface from off/on to 0/1 seems
> unnecessary, given that broken/workaround/fixed are used for the
> capabilities you introduce later in the series. off/on look much
> better IMHO.

These are booleans so they have to be "on"/"off" anyway... 0/1 doesn't
work. My bad :/ I'll fix the message.

> 
> [...]
> > -static bool spapr_caps_needed(void *opaque)
> > -{
> > -    sPAPRMachineState *spapr = opaque;
> > -
> > -    return (spapr->forced_caps.mask != 0) || (spapr-
> > >forbidden_caps.mask != 0);
> > -}
> > -
> >  /* This has to be called from the top-level spapr post_load, not
> > the
> >   * caps specific one.  Otherwise it wouldn't be called when the
> > source
> >   * caps are all defaults, which could still conflict with
> > overridden
> >   * caps on the destination */
> >  int spapr_caps_post_migration(sPAPRMachineState *spapr)
> >  {
> > -    uint64_t allcaps = 0;
> >      int i;
> >      bool ok = true;
> >      sPAPRCapabilities dstcaps = spapr->effective_caps;
> >      sPAPRCapabilities srccaps;
> >  
> >      srccaps = default_caps_with_cpu(spapr, first_cpu);
> > -    srccaps.mask |= spapr->mig_forced_caps.mask;
> > -    srccaps.mask &= ~spapr->mig_forbidden_caps.mask;
> > +    for (i = 0; i < SPAPR_CAP_NUM; i++) {
> > +        if (spapr->mig_caps.caps[i] & SPAPR_CAP_CMD_LINE) {
> > +            srccaps.caps[i] = spapr->mig_caps.caps[i] &
> > ~SPAPR_CAP_CMD_LINE;
> > +        }
> > +    }
> >  
> > -    for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
> > +    for (i = 0; i < SPAPR_CAP_NUM; i++) {
> >          sPAPRCapabilityInfo *info = &capability_table[i];
> >  
> > -        allcaps |= info->flag;
> > -
> > -        if ((srccaps.mask & info->flag) && !(dstcaps.mask & info-
> > >flag)) {
> > -            error_report("cap-%s=on in incoming stream, but off in
> > destination",
> > -                         info->name);
> > +        if (srccaps.caps[i] > dstcaps.caps[i]) {
> > +            error_report("cap-%s higher level (%d) in incoming
> > stream than on destination (%d)",
> > +                         info->name, srccaps.caps[i],
> > dstcaps.caps[i]);
> >              ok = false;
> >          }
> >  
> > -        if (!(srccaps.mask & info->flag) && (dstcaps.mask & info-
> > >flag)) {
> > -            warn_report("cap-%s=off in incoming stream, but on in
> > destination",
> > -                         info->name);
> > +        if (srccaps.caps[i] < dstcaps.caps[i]) {
> > +            warn_report("cap-%s lower level (%d) in incoming
> > stream than on destination (%d)",
> > +                         info->name, srccaps.caps[i],
> > dstcaps.caps[i]);
> >          }
> >      }
> 
> These numeric comparisons make me feel very uneasy :)
> 
> What if we need to add more possible values down the line? Should
> there be at least some room between existing values to avoid painting
> ourselves in a corner? Eg. instead of using 0/1/2 use 20/40/60...
> 
> You clearly know more about the problem than I do, so feel free to
> dismiss all of the above... I thought I would bring up my worries
> just in case :)

For these capabilities I think we're ok to keep it as 0/1/2. In the
event we need a bigger range another capability can be added with other
possible values which was the whole point of introducing this generic
framework. The basic idea is the receiving side must always support a
higher "level" than the source.

With these new capabilities it's more likely we'll have to add an
entirly new one than require more possible values. :)

It could even be possible to have a per capability comparison function
to confirm compatibility in future. But again thats an exercise for
when/if more complex capabilities are added.

> 
