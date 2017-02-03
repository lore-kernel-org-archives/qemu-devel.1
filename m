Received: from eggs.gnu.org ([2001:4830:134:3::10]:49539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY3E-0005Bp-OE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cZY3B-0005TY-Id
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:12:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cZY3B-0005Sy-CR
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:12:53 -0500
Date: Fri, 3 Feb 2017 15:12:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170203071247.GN5151@pxdev.xzpeter.org>
References: <20170120133139.31080-1-pbonzini@redhat.com>
	<20170120133139.31080-24-pbonzini@redhat.com>
	<CAFEAcA_gr01FzACvyyraa4D1ZVxp1WZ1Fkdw2ow-qFq23GwC7g@mail.gmail.com>
	<7f7fe07e-e0cc-5e8b-9119-7a20874f5493@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f7fe07e-e0cc-5e8b-9119-7a20874f5493@redhat.com>
Subject: Re: [Qemu-devel] [PULL 23/35] x86: ioapic: dump version for "info
 ioapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 30, 2017 at 02:33:32PM -0500, Paolo Bonzini wrote:
> 
> 
> On 30/01/2017 09:07, Peter Maydell wrote:
> > On 20 January 2017 at 13:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> From: Peter Xu <peterx@redhat.com>
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> Message-Id: <1483952153-7221-3-git-send-email-peterx@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  hw/intc/ioapic_common.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> >> index 1b7ec5e..97c4f9c 100644
> >> --- a/hw/intc/ioapic_common.c
> >> +++ b/hw/intc/ioapic_common.c
> >> @@ -58,7 +58,8 @@ void ioapic_print_redtbl(Monitor *mon, IOAPICCommonState *s)
> >>      uint32_t remote_irr = 0;
> >>      int i;
> >>
> >> -    monitor_printf(mon, "ioapic id=0x%02x sel=0x%02x", s->id, s->ioregsel);
> >> +    monitor_printf(mon, "ioapic ver=0x%x id=0x%02x sel=0x%02x",
> >> +                   s->version, s->id, s->ioregsel);
> >>      if (s->ioregsel) {
> >>          monitor_printf(mon, " (redir[%u])\n",
> >>                         (s->ioregsel - IOAPIC_REG_REDTBL_BASE) >> 1);
> > 
> > Coverity points out (CID 1369422) that this is a use of a possibly
> > uninitialized field. In kvm_ioapic_dump_state() we do:
> > 
> >     IOAPICCommonState s;
> >     kvm_ioapic_get(&s);
> >     ioapic_print_redtbl(mon, &s);
> > 
> > and kvm_ioapic_get() doesn't initialize s->version, so when we
> > come to print it in ioapic_print_redtbl() it's uninitialized.
> > 
> > The easy fix is to initialize version to something. The
> > underlying problem here I think is that we're manufacturing
> > a fake IOAPICCommonState rather than finding the one that
> > corresponds to the actual IOAPIC device in the system...
> 
> Right, we can probably use object_resolve_path to get one.

I'll use this and post a fix for it. Thanks!

-- peterx
