Received: from eggs.gnu.org ([2001:4830:134:3::10]:58873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1efwbz-0007pn-L0
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1efwby-00078v-E8
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:43:47 -0500
Message-ID: <1517183014.2332.0.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 29 Jan 2018 10:43:34 +1100
In-Reply-To: <59acc32f-94e9-42b6-a8aa-4eddd504c8c8@ozlabs.ru>
References: <20180119050005.29392-1-sjitindarsingh@gmail.com>
	<20180119050005.29392-3-sjitindarsingh@gmail.com>
	<59acc32f-94e9-42b6-a8aa-4eddd504c8c8@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V5 2/7] target/ppc/spapr_caps:
 Add macro to generate spapr_caps migration vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Fri, 2018-01-19 at 16:18 +1100, Alexey Kardashevskiy wrote:
> On 19/01/18 16:00, Suraj Jitindar Singh wrote:
> > The vmstate description and the contained needed function for
> > migration
> > of spapr_caps is the same for each cap, with the name of the cap
> > substituted. As such introduce a macro to allow for easier
> > generation of
> > these.
> > 
> > Convert the three existing spapr_caps (htm, vsx, and dfp) to use
> > this
> > macro.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > 
> > ---
> > 
> > V5:
> >  - Patch added to series
> > ---
> >  hw/ppc/spapr_caps.c | 78 +++++++++++++++++----------------------
> > --------------
> >  1 file changed, 24 insertions(+), 54 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index d5c9ce774a..5d52969bd5 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -228,62 +228,32 @@ int
> > spapr_caps_post_migration(sPAPRMachineState *spapr)
> >      return ok ? 0 : -EINVAL;
> >  }
> >  
> > -static bool spapr_cap_htm_needed(void *opaque)
> > -{
> > -    sPAPRMachineState *spapr = opaque;
> > -
> > -    return spapr->cmd_line_caps[SPAPR_CAP_HTM] &&
> > -           (spapr->eff.caps[SPAPR_CAP_HTM] != spapr-
> > >def.caps[SPAPR_CAP_HTM]);
> > -}
> > -
> > -const VMStateDescription vmstate_spapr_cap_htm = {
> > -    .name = "spapr/cap/htm",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > -    .needed = spapr_cap_htm_needed,
> > -    .fields = (VMStateField[]) {
> > -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_HTM], sPAPRMachineState),
> > -        VMSTATE_END_OF_LIST()
> > -    },
> > -};
> > -
> > -static bool spapr_cap_vsx_needed(void *opaque)
> > -{
> > -    sPAPRMachineState *spapr = opaque;
> > -
> > -    return spapr->cmd_line_caps[SPAPR_CAP_VSX] &&
> > -           (spapr->eff.caps[SPAPR_CAP_VSX] != spapr-
> > >def.caps[SPAPR_CAP_VSX]);
> > +/* Used to generate the migration field and needed function for a
> > spapr cap */
> > +#define SPAPR_CAP_MIG_STATE(cap, ccap)                  \
> > +static bool spapr_cap_##cap##_needed(void *opaque)      \
> > +{                                                       \
> > +    sPAPRMachineState *spapr = opaque;                  \
> > +                                                        \
> > +    return spapr->cmd_line_caps[SPAPR_CAP_##ccap] &&    \
> > +           (spapr->eff.caps[SPAPR_CAP_##ccap] !=        \
> > +            spapr->def.caps[SPAPR_CAP_##ccap]);         \
> > +}                                                       \
> > +                                                        \
> > +const VMStateDescription vmstate_spapr_cap_##cap = {    \
> > +    .name = "spapr/cap/" #cap,                          \
> > +    .version_id = 1,                                    \
> > +    .minimum_version_id = 1,                            \
> > +    .needed = spapr_cap_##cap##_needed,                 \
> > +    .fields = (VMStateField[]) {                        \
> > +        VMSTATE_UINT8(mig.caps[SPAPR_CAP_##ccap],       \
> > +                      sPAPRMachineState),               \
> > +        VMSTATE_END_OF_LIST()                           \
> > +    },                                                  \
> >  }
> >  
> > -const VMStateDescription vmstate_spapr_cap_vsx = {
> > -    .name = "spapr/cap/vsx",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > -    .needed = spapr_cap_vsx_needed,
> > -    .fields = (VMStateField[]) {
> > -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_VSX], sPAPRMachineState),
> > -        VMSTATE_END_OF_LIST()
> > -    },
> > -};
> > -
> > -static bool spapr_cap_dfp_needed(void *opaque)
> > -{
> > -    sPAPRMachineState *spapr = opaque;
> > -
> > -    return spapr->cmd_line_caps[SPAPR_CAP_DFP] &&
> > -           (spapr->eff.caps[SPAPR_CAP_DFP] != spapr-
> > >def.caps[SPAPR_CAP_DFP]);
> > -}
> > -
> > -const VMStateDescription vmstate_spapr_cap_dfp = {
> > -    .name = "spapr/cap/dfp",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > -    .needed = spapr_cap_dfp_needed,
> > -    .fields = (VMStateField[]) {
> > -        VMSTATE_UINT8(mig.caps[SPAPR_CAP_DFP], sPAPRMachineState),
> > -        VMSTATE_END_OF_LIST()
> > -    },
> > -};
> > +SPAPR_CAP_MIG_STATE(htm, HTM);
> > +SPAPR_CAP_MIG_STATE(vsx, VSX);
> > +SPAPR_CAP_MIG_STATE(dfp, DFP);
> 
> 
> A nit: I really dislike this kind of parameters which you cannot
> really
> cscope/ctags for because they are joined to some other things.
> 
> "no matches found for cscope query g HTM of HTM" says vim's cscope
> when I
> search for "HTM".

Would something like:
SPAPR_CAP_MIG_STATE(htm, SPAPR_CAP_HTM);
SPAPR_CAP_MIG_STATE(htm, SPAPR_CAP_VSX);
SPAPR_CAP_MIG_STATE(htm, SPAPR_CAP_DFP);

be better?
I could send a follow up

> 
> 
> >  
> >  void spapr_caps_reset(sPAPRMachineState *spapr)
> >  {
> > 
> 
> 
