Received: from eggs.gnu.org ([2001:4830:134:3::10]:49776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqMQb-00045w-Vs
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqMQb-0002Dh-1Y
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:14:33 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:34208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqMQa-0002DC-Qr
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:14:32 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 196so3676510wmm.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:14:32 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 16:14:11 +0000
Message-ID: <CAFEAcA9Z0X_nnYo7xEDY0arO0QF-REXxBNRqXv9vL8DhSikiyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] NetBSD doesn't boot under KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

So if you try to boot NetBSD inside KVM:


 qemu-img create -f qcow2 disk.qcow2 15G
 wget http://cdn.netbsd.org/pub/NetBSD/NetBSD-7.1/images/NetBSD-7.1-amd64.iso
 qemu-system-x86_64 -m 2048 -enable-kvm \
   -drive if=virtio,file=disk.qcow2,format=qcow2 \
   -netdev user,id=mynet0,hostfwd=tcp::7722-:22 \
   -device e1000,netdev=mynet0 \
   -cdrom NetBSD-7.1-amd64.iso

the guest kernel hangs during boot. This works fine for
running on real h/w (I assume), and also if you run in
TCG by dropping -enable-kvm.

It also works if you add -smp 2 -cpu kvm64,-sse2,-cx8
because the bit that causes problems seems to be
http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/arch/x86/x86/patch.c?rev=1.2.4.3&content-type=text/x-cvsweb-markup
where x86_patch() patches various bits of the guest kernel,
and turning off those cpuid features causes it to skip the
patching.

Any ideas? Does this sound like a KVM bug, or a guest bug?

(Tested on 4.4.0-31-generic #50-Ubuntu x86-64 host kernel
and QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.8).
Yes, I know that's really old...)

thanks
-- PMM
