Received: from eggs.gnu.org ([2001:4830:134:3::10]:57447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cJey0-0002X7-Mz
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cJexw-0002Ul-Mj
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:21:52 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cJexw-0002TI-G7
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:21:48 -0500
Received: by mail-wm0-x244.google.com with SMTP id u144so29859057wmu.0
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 03:21:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70e1f758-6f18-9821-b48e-bdebdfc0befc@redhat.com>
Date: Wed, 21 Dec 2016 12:21:44 +0100
MIME-Version: 1.0
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Christoffer Dall <christoffer.dall@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xensource.com



On 20/12/2016 18:43, Eduardo Habkost wrote:
> This moves the KVM and Xen files to the an accel/ subdir.
> 
> Instead of moving the *-stubs.c file to accel/ as-is, I tried to
> move most of the stub code to libqemustub.a. This way the obj-y
> logic for accel/ is simpler: obj-y includes accel/ only if
> CONFIG_SOFTMMU is set.
> 
> The Xen stubs could be moved completely to stubs/, but some of
> the KVM stubs depend on cpu.h. So most of the kvm-stub.c code was
> moved to stubs/kvm.c, but some of that code was kept in
> accel/kvm-stub.c.

I think we need to decide what libqemustub is for.

The original purpose was to provide different implementations of some
functions for tools vs. emulators or (more rarely) for user-mode vs.
system emulation.

There are also some cases where we use it for functions that are only
implemented by some targets.

In general, I think libqemustub should be the last resort.  If possible,
inlines in headers should be the first choice, and stubs in objs-y or
common-objs-y (using $(call lnot) in the Makefile) should be the second.

The reason is that stubs/ hides files from the corresponding maintainer;
for example, commit 07a32d6b's addition of stubs/get-next-serial.c was
in all likelihood unnecessary, but the new file went in without an ack
for a character device maintainer.  Tracking stubs in the MAINTAINERS
file is unwieldy and, from this point of view, I find

	F: accel/kvm*

to be preferrable to

	F: accel/kvm*
	F: stubs/kvm.c

Thanks,

Paolo

> About TCG:
> ----------
> 
> It is not obvious to me which TCG-related files could be moved to
> accel/, so this series don't move any of them yet.
> 
> About other CONFIG_SOFTMMU top-level files:
> -------------------------------------------
> 
> I would like to know what we should do with the top-level
> CONFIG_SOFTMMU-only files that don't belong to hw/. Some
> candidates: arch_init.c cpus.c monitor.c gdbstub.c balloon.c
> ioport.c bootdevice.c memory.c cputlb.c memory_mapping.c dump.c.
> 
> Maybe a sysemu/ subdir? In that case, should we still create an
> accel/ subdir, or move xen-*, kvm-* and friends to sysemu/ too?
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xensource.com
> 
> Eduardo Habkost (7):
>   xen: Move xen-*-stub.c to stubs/
>   xen: Move xen files to accel/
>   kvm: Move some kvm-stub.c code to stubs/kvm.c
>   kvm: Include kvm-stub.o only on CONFIG_SOFTMMU
>   kvm: Move kvm*.c files to accel/
>   accel: Move accel.c to accel/
>   accel: Move qtest.c to accel/
