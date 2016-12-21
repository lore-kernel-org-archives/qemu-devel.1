Received: from eggs.gnu.org ([2001:4830:134:3::10]:49800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJhgK-0001iu-HD
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJhgH-0005wO-B8
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:15:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJhgG-0005wA-VY
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:15:45 -0500
Date: Wed, 21 Dec 2016 12:15:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161221141541.GG3808@thinpad.lan.raisama.net>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<70e1f758-6f18-9821-b48e-bdebdfc0befc@redhat.com>
	<20161221131438.GF3808@thinpad.lan.raisama.net>
	<00508a0d-4279-298e-cbe2-217e7d2adab7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00508a0d-4279-298e-cbe2-217e7d2adab7@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/7] Move accel, KVM, Xen,
 qtest files to accel/ subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Christoffer Dall <christoffer.dall@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xensource.com

On Wed, Dec 21, 2016 at 02:47:54PM +0100, Paolo Bonzini wrote:
> 
> 
> On 21/12/2016 14:14, Eduardo Habkost wrote:
> > On Wed, Dec 21, 2016 at 12:21:44PM +0100, Paolo Bonzini wrote:
> >>
> >>
> >> On 20/12/2016 18:43, Eduardo Habkost wrote:
> >>> This moves the KVM and Xen files to the an accel/ subdir.
> >>>
> >>> Instead of moving the *-stubs.c file to accel/ as-is, I tried to
> >>> move most of the stub code to libqemustub.a. This way the obj-y
> >>> logic for accel/ is simpler: obj-y includes accel/ only if
> >>> CONFIG_SOFTMMU is set.
> >>>
> >>> The Xen stubs could be moved completely to stubs/, but some of
> >>> the KVM stubs depend on cpu.h. So most of the kvm-stub.c code was
> >>> moved to stubs/kvm.c, but some of that code was kept in
> >>> accel/kvm-stub.c.
> >>
> >> I think we need to decide what libqemustub is for.
> >>
> >> The original purpose was to provide different implementations of some
> >> functions for tools vs. emulators or (more rarely) for user-mode vs.
> >> system emulation.
> > 
> > So, is sysemu vs user-mode a valid reason for using libqemustub?
> 
> Yes, but I was thinking of a different distinction.
> 
> You'd use libqemustub if user-mode emulation (or tools) only needs 2-3
> functions out of a large file, while system-mode emulation needs all of it.
> 
> For example, of the entire monitor API, the tools need pretty much
> nothing but monitor_init, monitor_get_fd, cur_mon and
> monitor_cur_is_qmp.  Such a small extract of the API makes little sense
> except for "this is what is needed to compile the tools", so it's stubs/
> rather than monitor-stub.c.
> 
> Instead, non-KVM targets need a stub implementation of the entire API,
> so it's kvm-stub.c rather than stubs/kvm.c (kvm-stub.c depends on cpu.h
> but that's really only needed to compile it---the kvm-stub.c code
> actually has no dependency).
> 
> There are certainly cases where libqemustub is used instead of lnot.  In
> the specific case of sysemu vs. user-mode, stubs/cpus.c and
> stubs/replay-user.c should not be in libqemustub.  They should be in a
> separate file user-exec-stub.c, which is only used if !CONFIG_SOFTMMU.
> 
> > The main reason I have moved some code to sbus/kvm.c is to avoid
> > having to include accel/kvm-stub.c in *-user.
> 
> What's wrong with
> 
> ifeq ($(CONFIG_SOFTMMU),y)
> obj-$(CONFIG_KVM) += kvm-all.c
> obj-$(call lnot, $(CONFIG_KVM)) += kvm-stub.c
> endif
> 
> similar to what is done already in Makefile.objs?

I assume you mean:

 ifeq ($(CONFIG_SOFTMMU),y)
 obj-$(CONFIG_KVM) += kvm-all.c
 endif
 obj-$(call lnot, $(CONFIG_KVM)) += kvm-stub.c

Nothing really wrong, we can do that to avoid using libqemustub.
I was just trying to avoid a more complex rule involving
ifeq+lnot, and to avoid including accel/ in obj-y on the
non-softmmu case.

> 
> > Moving xen-stub.c to libqemustub, on the other hand, is really
> > unnecessary.
> 
> Why would it be different?

I meant the reason I mentioned above doesn't even exist in the
case of xen-stub.c.

> 
> >> In general, I think libqemustub should be the last resort.  If possible,
> >> inlines in headers should be the first choice, and stubs in objs-y or
> >> common-objs-y (using $(call lnot) in the Makefile) should be the second.
> > 
> > I understand the reasoning, but I fail to see cases when
> > libqemustub would be considered appropriate. Using stubs in
> > obj-y/common-obj-y using $(call lnot) is always possible, isn't
> > it?
> > 
> > Hmm, maybe on cases where the decision to use the stub doesn't
> > depend on a single build variable (e.g. a function implemented by
> > a handful of targets, but not all of them).
> 
> This is a good one.
> 
> > Are there other examples?
> 
> Does the one above (extract a small part of an API) make sense?

I think so. But if you only need a small part of the API, inlines
in header files looks like a very simple way to avoid
libqemustub.

> 
> libqemustub is a necessary evil and it's almost never necessary.  It
> basically exists for cases where you cannot replace a source file with
> another wholesale.
> 
> There are also some cases of premature optimization.  For example reset
> handlers are stubbed, but: 1) system emulation implements them in vl.c
> which is an antipattern of its own, and 2) they are small enough that
> including them in user-mode emulators (together with the rest of qdev)
> is not a big deal.  (I'm planning to remove some stubs in 2.9, so I'm
> taking these examples from that branch).
> 
> Paolo

-- 
Eduardo
