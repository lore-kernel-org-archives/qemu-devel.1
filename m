Received: from eggs.gnu.org ([2001:4830:134:3::10]:60049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJgjI-0005VC-0N
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cJgjE-0004Dq-0N
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:14:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cJgjD-0004Cn-O2
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:14:43 -0500
Date: Wed, 21 Dec 2016 11:14:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161221131438.GF3808@thinpad.lan.raisama.net>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<70e1f758-6f18-9821-b48e-bdebdfc0befc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70e1f758-6f18-9821-b48e-bdebdfc0befc@redhat.com>
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

On Wed, Dec 21, 2016 at 12:21:44PM +0100, Paolo Bonzini wrote:
> 
> 
> On 20/12/2016 18:43, Eduardo Habkost wrote:
> > This moves the KVM and Xen files to the an accel/ subdir.
> > 
> > Instead of moving the *-stubs.c file to accel/ as-is, I tried to
> > move most of the stub code to libqemustub.a. This way the obj-y
> > logic for accel/ is simpler: obj-y includes accel/ only if
> > CONFIG_SOFTMMU is set.
> > 
> > The Xen stubs could be moved completely to stubs/, but some of
> > the KVM stubs depend on cpu.h. So most of the kvm-stub.c code was
> > moved to stubs/kvm.c, but some of that code was kept in
> > accel/kvm-stub.c.
> 
> I think we need to decide what libqemustub is for.
> 
> The original purpose was to provide different implementations of some
> functions for tools vs. emulators or (more rarely) for user-mode vs.
> system emulation.
> 

So, is sysemu vs user-mode a valid reason for using libqemustub?
The main reason I have moved some code to sbus/kvm.c is to avoid
having to include accel/kvm-stub.c in *-user.

Moving xen-stub.c to libqemustub, on the other hand, is really
unnecessary.

> There are also some cases where we use it for functions that are only
> implemented by some targets.
> 
> In general, I think libqemustub should be the last resort.  If possible,
> inlines in headers should be the first choice, and stubs in objs-y or
> common-objs-y (using $(call lnot) in the Makefile) should be the second.

I understand the reasoning, but I fail to see cases when
libqemustub would be considered appropriate. Using stubs in
obj-y/common-obj-y using $(call lnot) is always possible, isn't
it?

Hmm, maybe on cases where the decision to use the stub doesn't
depend on a single build variable (e.g. a function implemented by
a handful of targets, but not all of them). Are there other
examples?

> 
> The reason is that stubs/ hides files from the corresponding maintainer;
> for example, commit 07a32d6b's addition of stubs/get-next-serial.c was
> in all likelihood unnecessary, but the new file went in without an ack
> for a character device maintainer.  Tracking stubs in the MAINTAINERS
> file is unwieldy and, from this point of view, I find
> 
> 	F: accel/kvm*
> 
> to be preferrable to
> 
> 	F: accel/kvm*
> 	F: stubs/kvm.c

> 
> Thanks,
> 
> Paolo
> 
> > About TCG:
> > ----------
> > 
> > It is not obvious to me which TCG-related files could be moved to
> > accel/, so this series don't move any of them yet.
> > 
> > About other CONFIG_SOFTMMU top-level files:
> > -------------------------------------------
> > 
> > I would like to know what we should do with the top-level
> > CONFIG_SOFTMMU-only files that don't belong to hw/. Some
> > candidates: arch_init.c cpus.c monitor.c gdbstub.c balloon.c
> > ioport.c bootdevice.c memory.c cputlb.c memory_mapping.c dump.c.
> > 
> > Maybe a sysemu/ subdir? In that case, should we still create an
> > accel/ subdir, or move xen-*, kvm-* and friends to sysemu/ too?
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: Christoffer Dall <christoffer.dall@linaro.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: xen-devel@lists.xensource.com
> > 
> > Eduardo Habkost (7):
> >   xen: Move xen-*-stub.c to stubs/
> >   xen: Move xen files to accel/
> >   kvm: Move some kvm-stub.c code to stubs/kvm.c
> >   kvm: Include kvm-stub.o only on CONFIG_SOFTMMU
> >   kvm: Move kvm*.c files to accel/
> >   accel: Move accel.c to accel/
> >   accel: Move qtest.c to accel/

-- 
Eduardo
