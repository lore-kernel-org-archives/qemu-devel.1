Received: from eggs.gnu.org ([2001:4830:134:3::10]:57266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMtWr-0004a7-B1
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMtWm-0006ky-Ft
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dMtWm-0006kf-9P
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:03:24 -0400
References: <20170615203735.19649-1-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7998cb6b-018e-8069-9d11-a3e1e4e70380@redhat.com>
Date: Mon, 19 Jun 2017 12:03:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170615203735.19649-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 15.06.2017 22:37, Richard Henderson wrote:
> There are no uses in a Linux system with which to test,
> but it Looks Right by my reading of the PoO.

I am using next.git/master with this patch applied:
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=8aa8680aa383bf6e2ac

I am using QEMU with the mvcos patch and your patch applied (and a patch
that allows enabling csst/csst2).

I am using the following qemu command line:

#!/bin/bash
/home/dhildenb/git/qemu/s390x-softmmu/qemu-system-s390x \
	-nographic -nodefaults -machine s390-ccw-virtio,accel=tcg \
	-cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on,\
          eimm=on,stckf=on,csst=on,csst2=on,ginste=on,exrl=on\
	-m 256M -smp 1 -chardev stdio,id=con0 \
	-device sclpconsole,chardev=con0 \
	-kernel vmlinux -initrd /home/dhildenb/initrd.debian

Right now, I can start a z9 compiled kernel.

When trying to start a z10 compiled kernel (which generates many csst),
qemu simply crashes / the guests exits (have to debug) without any
command line output.

So either something in csst is broken or in the other instructions for z10.

-- 

Thanks,

David
