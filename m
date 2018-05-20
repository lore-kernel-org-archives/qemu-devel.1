Received: from eggs.gnu.org ([2001:4830:134:3::10]:40024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1fKSn2-0003yj-Rc
	for qemu-devel@nongnu.org; Sun, 20 May 2018 14:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1fKSmy-0001GX-Ny
	for qemu-devel@nongnu.org; Sun, 20 May 2018 14:10:40 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:42884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1fKSmy-0001G8-Cj
	for qemu-devel@nongnu.org; Sun, 20 May 2018 14:10:36 -0400
Received: by mail-lf0-x22f.google.com with SMTP id b18-v6so20714851lfa.9
	for <qemu-devel@nongnu.org>; Sun, 20 May 2018 11:10:35 -0700 (PDT)
Received: from [192.168.1.102] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	y23-v6sm2174907ljh.88.2018.05.20.11.10.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 20 May 2018 11:10:33 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Sun, 20 May 2018 20:54:50 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201805202054.50525.randrianasulu@gmail.com>
Subject: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + SATA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think I was hit with very same bug.

I did bisect with 2.11.0 as good point and 2.12.0 as bad point.

configure was 

setarch 
i486 ./configure --prefix=/usr --disable-gtk --enable-virglrenderer --enable-sdl --with-sdlabi=2.0 --audio-drv-list=alsa,oss --host-cc=/opt/gcc49/bin/gcc --enable-opengl --extra-cflags="-I/usr/X11R7/include -O3 -march=i686 -mtune=native -m32 -Wno-maybe-uninitialized -Wno-nested-externs -Wno-implicit-function-declaration" --disable-werror --target-list="x86_64-softmmu"

and launch command

x86_64-softmmu/qemu-system-x86_64 -cdrom 
~/Downloads/ISO/slax-English-US-7.0.8-x86_64.iso -enable-kvm -m 1G -M q35



------------
git bisect bad
66eb7825d0bd84a870a054fb208fe765317109fa is the first bad commit
commit 66eb7825d0bd84a870a054fb208fe765317109fa
Author: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date:   Tue Feb 27 12:53:05 2018 +0300

    replay: avoid recursive call of checkpoints

    This patch adds a flag which denies recursive call of replay_checkpoint
    function. Checkpoints may be accompanied by the hardware events. When event
    is processed, virtual device may invoke timer modification functions that
    also invoke the checkpoint function. This leads to infinite loop.

    Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
    Message-Id: <20180227095305.1060.56463.stgit@pasha-VirtualBox>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

:040000 040000 f8d1eb18d3a8fcd0df0329e6b899a515e4b0e16e 
a286be2d590b42b15f9facf033348ee37c460d25 M      replay

-------------

git bisect log
git bisect start
# good: [0a0dc59d27527b78a195c2d838d28b7b49e5a639] Update version for v2.11.0 
release
git bisect good 0a0dc59d27527b78a195c2d838d28b7b49e5a639
# bad: [4743c23509a51bd4ee85cc272287a41917d1be35] Update version for v2.12.0 
release
git bisect bad 4743c23509a51bd4ee85cc272287a41917d1be35
# skip: [db57d7a3c284db2315d92f55962597cc7276579a] wdt_ib700-test: Drop 
dependence on global_qtest
git bisect skip db57d7a3c284db2315d92f55962597cc7276579a
# good: [539022dd6089cdef36589d608ed63cbdaacfd71f] chardev: Clean up previous 
patch indentation
git bisect good 539022dd6089cdef36589d608ed63cbdaacfd71f
# good: [9db0855e8501365334e859370800c240d25322a2] Merge remote-tracking 
branch 'remotes/pmaydell/tags/pull-target-arm-20180301' into staging
git bisect good 9db0855e8501365334e859370800c240d25322a2
# good: [a57946ff2acb9c0d95c9f127914540586b0b8c21] Merge remote-tracking 
branch 'remotes/awilliam/tags/vfio-update-20180313.0' into staging
git bisect good a57946ff2acb9c0d95c9f127914540586b0b8c21
# bad: [211d6260208d079429fd0d447b86ff480d0524ca] Merge remote-tracking 
branch 'remotes/kevin/tags/for-upstream' into staging
git bisect bad 211d6260208d079429fd0d447b86ff480d0524ca
# bad: [09b68dab5a11e8657119bc1d2ab18e98a70530ed] vhdx: Support .bdrv_co_create
git bisect bad 09b68dab5a11e8657119bc1d2ab18e98a70530ed
# bad: [3788c7b6e56fa34ee2a73e41706eb2a2447ba75a] Merge remote-tracking 
branch 'remotes/bonzini/tags/for-upstream' into staging
git bisect bad 3788c7b6e56fa34ee2a73e41706eb2a2447ba75a
# good: [63f01a74aeeb9c4fb39e2b4100beb084f5c10c95] hw/isa/pc87312: Inherit from 
the abstract TYPE_ISA_SUPERIO
git bisect good 63f01a74aeeb9c4fb39e2b4100beb084f5c10c95
# good: [1a96e3c1e7dbb466a8c93743b8f5ae37cc023766] replay: fix processing async 
events
git bisect good 1a96e3c1e7dbb466a8c93743b8f5ae37cc023766
# good: [1a423896fa4fc2ea49c64e7a493d88a8b251950d] replay: don't destroy mutex 
at exit
git bisect good 1a423896fa4fc2ea49c64e7a493d88a8b251950d
# bad: [821c113033075d4f1b50966d92022a1064085422] scripts/replay-dump.py: replay 
log dumper
git bisect bad 821c113033075d4f1b50966d92022a1064085422
# good: [6dc0f5296359ff59c248215a965c8658dea9544b] replay: check return values 
of fwrite
git bisect good 6dc0f5296359ff59c248215a965c8658dea9544b
# bad: [66eb7825d0bd84a870a054fb208fe765317109fa] replay: avoid recursive call 
of checkpoints
git bisect bad 66eb7825d0bd84a870a054fb208fe765317109fa
# first bad commit: [66eb7825d0bd84a870a054fb208fe765317109fa] replay: avoid 
recursive call of checkpoints
------------------------
