Received: from eggs.gnu.org ([2001:4830:134:3::10]:52908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqMaj-0006WO-11
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqMaf-0000gv-Sb
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqMaf-0000gB-MH
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:24:57 -0400
References: <CAFEAcA9Z0X_nnYo7xEDY0arO0QF-REXxBNRqXv9vL8DhSikiyw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ef847f2-1072-f6c9-dc15-f9d42cad4f3a@redhat.com>
Date: Tue, 21 Mar 2017 17:24:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Z0X_nnYo7xEDY0arO0QF-REXxBNRqXv9vL8DhSikiyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] NetBSD doesn't boot under KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>



On 21/03/2017 17:14, Peter Maydell wrote:
> So if you try to boot NetBSD inside KVM:
> 
> 
>  qemu-img create -f qcow2 disk.qcow2 15G
>  wget http://cdn.netbsd.org/pub/NetBSD/NetBSD-7.1/images/NetBSD-7.1-amd64.iso
>  qemu-system-x86_64 -m 2048 -enable-kvm \
>    -drive if=virtio,file=disk.qcow2,format=qcow2 \
>    -netdev user,id=mynet0,hostfwd=tcp::7722-:22 \
>    -device e1000,netdev=mynet0 \
>    -cdrom NetBSD-7.1-amd64.iso
> 
> the guest kernel hangs during boot. This works fine for
> running on real h/w (I assume), and also if you run in
> TCG by dropping -enable-kvm.
> 
> It also works if you add -smp 2 -cpu kvm64,-sse2,-cx8
> because the bit that causes problems seems to be
> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/arch/x86/x86/patch.c?rev=1.2.4.3&content-type=text/x-cvsweb-markup
> where x86_patch() patches various bits of the guest kernel,
> and turning off those cpuid features causes it to skip the
> patching.
> 
> Any ideas? Does this sound like a KVM bug, or a guest bug?

It sounds like a weird bug. :)  I'm downloading the image.

> (Tested on 4.4.0-31-generic #50-Ubuntu x86-64 host kernel
> and QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.8).
> Yes, I know that's really old...)
> 
> thanks
> -- PMM
> 
