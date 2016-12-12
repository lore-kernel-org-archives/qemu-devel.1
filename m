Received: from eggs.gnu.org ([2001:4830:134:3::10]:39037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGWjQ-0003Jp-86
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGWjN-00007P-CD
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:57:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGWjN-00007I-6S
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:57:49 -0500
Date: Mon, 12 Dec 2016 17:57:45 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161212195745.GI3808@thinpad.lan.raisama.net>
References: <20161210172148.361793326@redhat.com>
	<20161210172324.482367805@redhat.com>
	<20161212180105.GF3808@thinpad.lan.raisama.net>
	<20161212194451.GA20241@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161212194451.GA20241@amt.cnet>
Subject: Re: [Qemu-devel] [qemu patch V4 2/2] kvmclock: reduce kvmclock
 difference on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On Mon, Dec 12, 2016 at 05:44:52PM -0200, Marcelo Tosatti wrote:
> On Mon, Dec 12, 2016 at 04:01:05PM -0200, Eduardo Habkost wrote:
> > On Sat, Dec 10, 2016 at 03:21:50PM -0200, Marcelo Tosatti wrote:
> > [...]
> > >  static void kvmclock_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      KVMClockState *s = KVM_CLOCK(dev);
> > >  
> > > +    if (kvm_has_adjust_clock_stable()) {
> > > +        s->clock_is_reliable = true;
> > > +    }
> > > +
> > 
> > This seems unnecessary, as kvmclock_vm_state_change() makes sure
> > it is set at the same time as s->clock. Should we just remove it?
> 
> There is this initialization that goes from ~running -> running
> which assumes its initialized:

Right: I forgot about the very first time
kvmclock_vm_state_change() is called.

It doesn't seem to make any difference (as both s->clock
kvmclock_current_nsec() will return 0 anyway), but at least it
makes clock_is_reliable consistent with its documented purpose.

I would simplify it to a single line:
    s->clock_is_reliable = kvm_has_adjust_clock_stable();

But it is not a big deal, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks!

> 
> static void kvmclock_vm_state_change(void *opaque, int running,
>                                      RunState state)
> {
>     KVMClockState *s = opaque;
>     CPUState *cpu;
>     int cap_clock_ctrl = kvm_check_extension(kvm_state,
> KVM_CAP_KVMCLOCK_CTRL);
>     int ret;
> 
>     if (running) {
>         struct kvm_clock_data data = {};
>         uint64_t pvclock_via_mem = 0;
> 
>         /*
>          * If the host where s->clock was read did not support reliable
>          * KVM_GET_CLOCK, read kvmclock value from memory.
>          */
>         if (!s->clock_is_reliable) {
>             pvclock_via_mem = kvmclock_current_nsec(s);
>         }
> 

-- 
Eduardo
