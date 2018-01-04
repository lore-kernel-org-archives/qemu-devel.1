Received: from eggs.gnu.org ([2001:4830:134:3::10]:33199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1eXDh6-0001DS-Ic
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ytht.net@gmail.com>) id 1eXDh5-0001Rk-Bp
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:09:00 -0500
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:36979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ytht.net@gmail.com>) id 1eXDh5-0001QZ-6k
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:08:59 -0500
Received: by mail-it0-x22c.google.com with SMTP id d137so4052529itc.2
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 14:08:59 -0800 (PST)
MIME-Version: 1.0
From: lepton <ytht.net@gmail.com>
Date: Thu, 4 Jan 2018 14:08:57 -0800
Message-ID: <CALqoU4wfxotcrh0EE_JAy1_RsMe29VCY0=YqXf=2b7BNEw-PfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Some linux kernel with KAISER/KPTI patch can't work
 under qemu + haxm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linux-kernel@vger.kernel.org

It seems for some reason, some linux kernel with KAISER/KPTI patch can't
work with qemu + haxm.
The mainline kernel from Linus is fine. But the patch to 4.4/4.10 doesn't
work.

I am not familiar with HAXM and KPTI either. so not sure if this is a qemu
bug or KPTI bug or haxm bug.

The same kernel works fine under qemu + kvm.

This is the way to reproduce it:

1. Download qemu for windows, follow instructions here:

https://www.qemu.org/2017/11/22/haxm-usage-windows/

2. Build a kernel with KAISER/KPTI,  I am using kernel here:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-4.4.y
Or follow instruction here to build a 4.10 kernel:
https://github.com/IAIK/KAISER/tree/master/KAISER

3. Build an ext2 image which has a simple init:
dd of=img count=8192 bs=4096 if=/dev/zero
mke2fs img
gcc --static -o init init.c
debugfs -R "write init init" -w img
cat init.c
#include <stdio.h>
#include <time.h>

int main()
{
        while(1) {
                printf("This is init %d\n", time(NULL));
                sleep(3600);
        }
}

4. copy kernel and disk image generated from 3 to windows and run it:
qemu-system-x86_64.exe -kernel bzImage -hda img -append "init=/init
root=/dev/sda" -serial stdio -accel hax

You will see kernel panic or "vpu shutdown reqeust" to qemu.
