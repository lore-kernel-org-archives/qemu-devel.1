Received: from eggs.gnu.org ([209.51.188.92]:51110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gylDS-0002hM-JA
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 17:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gylDR-0005wL-FX
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 17:28:46 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gylDR-0005pb-4T
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 17:28:45 -0500
Received: by mail-pg1-x533.google.com with SMTP id i130so6894239pgd.1
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 14:28:40 -0800 (PST)
Received: from [192.168.1.102] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	b26sm17845026pfo.33.2019.02.26.14.28.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 26 Feb 2019 14:28:38 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Wed, 27 Feb 2019 01:25:35 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201902270125.36158.randrianasulu@gmail.com>
Subject: [Qemu-devel] regression: target/ppc: convert VSX logical operations
 to vector operations broke X for ppc64le guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello.

I bisected this problem with fonts (and multicolored vertical stripes) in qemu 
git (ppc64-softmmu)

guest@slax:/dev/shm/qemu$ git bisect good
7b8fe477e12b164dda97f79e27b55b805d90384f is the first bad commit
commit 7b8fe477e12b164dda97f79e27b55b805d90384f
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Feb 15 10:00:46 2019 +0000

    target/ppc: convert VSX logical operations to vector operations

    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
    Acked-by: David Gibson <david@gibson.dropbear.id.au>
    Message-Id: <20190215100058.20015-6-mark.cave-ayland@ilande.co.uk>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

:040000 040000 da3024ad2c9dfc3b7170516a8b321ef8c5d5bdf8 
a0257b9f5880ecc8e7001a59ccaa10407084623f M      target


guest@slax:/dev/shm/qemu$ git bisect log
git bisect start
# good: [32a1a94dd324d33578dca1dc96d7896a0244d768] Update version for v3.1.0 
release
git bisect good 32a1a94dd324d33578dca1dc96d7896a0244d768
# bad: [86c7e2f4a93322a76afea5ee6806a83420d1dfea] Merge remote-tracking 
branch 'remotes/berrange/tags/authz-core-pull-request' into staging
git bisect bad 86c7e2f4a93322a76afea5ee6806a83420d1dfea
# good: [95ebd99dcd37b8574426c876502bfcc7c299584b] target/arm: Decode PAuth 
within disas_data_proc_1src
git bisect good 95ebd99dcd37b8574426c876502bfcc7c299584b
# good: [268dfefa690b2bdee1f8c5090d2343871cf3467c] hw/microblaze/Makefile.objs: 
Create configs for petalogix and xilinx boards
git bisect good 268dfefa690b2bdee1f8c5090d2343871cf3467c
# good: [f5117fd28552fe3fe32ef0495582b1caaef7a28d] hw/mips_cpc: kick a VP when 
putting it into Run statewq
git bisect good f5117fd28552fe3fe32ef0495582b1caaef7a28d
# bad: [2e68b8620637a4ee8c79b5724144b726af1e261b] Merge remote-tracking 
branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging
git bisect bad 2e68b8620637a4ee8c79b5724144b726af1e261b
# good: [4c668f4a3d684ec133a52d936314379f6edd672e] target/ppc: Remove some #if 
0'ed code
git bisect good 4c668f4a3d684ec133a52d936314379f6edd672e
# bad: [9b5b74da0a07a89ef71c7f7da0b36560a3bac521] target/ppc: Split out VSCR_SAT 
to a vector field
git bisect bad 9b5b74da0a07a89ef71c7f7da0b36560a3bac521
# good: [444d6ca301d97de141a502851940943b09a9ebee] spapr/irq: Use the "simple" 
ICS class for KVM
git bisect good 444d6ca301d97de141a502851940943b09a9ebee
# bad: [9bb0048ec6f8f3bcc144b2c5769d9301e824f946] target/ppc: convert xxspltw to 
vector operations
git bisect bad 9bb0048ec6f8f3bcc144b2c5769d9301e824f946
# good: [471ff3d0257135b938d0a5f2181f22cd753d50de] target/ppc: convert 
vspltis[bhw] to use vector operations
git bisect good 471ff3d0257135b938d0a5f2181f22cd753d50de
# bad: [7b8fe477e12b164dda97f79e27b55b805d90384f] target/ppc: convert VSX 
logical operations to vector operations
git bisect bad 7b8fe477e12b164dda97f79e27b55b805d90384f
# good: [0f6a6d5db853c0cbe438c1831c70710bfb6530ee] target/ppc: convert 
vsplt[bhw] to use vector operations
git bisect good 0f6a6d5db853c0cbe438c1831c70710bfb6530ee
# first bad commit: [7b8fe477e12b164dda97f79e27b55b805d90384f] target/ppc: 
convert VSX logical operations to vector operations
guest@slax:/dev/shm/qemu$                                                

configure line:
setarch i686 ./configure --target-list=ppc64-softmmu             

launch line:
ppc64-softmmu/qemu-system-ppc64 -display 
sdl,gl=on -hda /mnt/sdb1/PPC-img/alpine_disk.img

where alpine_disk.img is HDD installed Alpine 3.7 for ppc64le with xfce4 
desktop.

               
