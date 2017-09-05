Received: from eggs.gnu.org ([2001:4830:134:3::10]:51146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpIw8-0003Px-77
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dpIw2-0008TU-UJ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:51:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:54078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dpIw2-0008Ra-Le
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:50:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dpIvy-0007eM-Qw
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 18:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1F95D2E80D0
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 18:50:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Sep 2017 18:42:06 -0000
From: Chris Unsworth <1714331@bugs.launchpad.net>
Reply-To: Bug 1714331 <1714331@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150420685550.8035.5310753798215250364.malonedeb@soybean.canonical.com>
Message-Id: <150463692706.10750.12505622774232959951.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1714331] Re: Virtual machines not working anymore
 on 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think my issue looks like the same.  Sometimes I just get spinning
dots, and sometimes there is the message about doing an automatic repair
below the spinning dots before it stops and uses 100% cpu.  I just did a
git bisect:

# git bisect log
# bad: [1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec] Update version for v2.10.=
0 release
# good: [6c02258e143700314ebf268dae47eb23db17d1cf] Update version for v2.9.=
0 release
git bisect start 'v2.10.0' 'v2.9.0'
# bad: [269c20b2bbd2aa8531e0cdc741fb166f290d7a2b] tests/qdict: check more g=
et_try_int() cases
git bisect bad 269c20b2bbd2aa8531e0cdc741fb166f290d7a2b
# bad: [eba0161990af8509608332450ee7e338273cf5df] Merge remote-tracking bra=
nch 'rth/tags/pull-s390-20170512' into staging
git bisect bad eba0161990af8509608332450ee7e338273cf5df
# good: [9ea5ada76f34a0ef048b131c3a166d8564199bdb] audio: Use ARRAY_SIZE fr=
om qemu/osdep.h
git bisect good 9ea5ada76f34a0ef048b131c3a166d8564199bdb
# bad: [1effe6ad5eac1b2e50a077695ac801d172891d6a] Merge remote-tracking bra=
nch 'danpb/tags/pull-qcrypto-2017-05-09-1' into staging
git bisect bad 1effe6ad5eac1b2e50a077695ac801d172891d6a
# good: [f03f9f0c10dcfadee5811d43240f0a6af230f1ce] Merge remote-tracking br=
anch 'cohuck/tags/s390x-3270-20170504' into staging
git bisect good f03f9f0c10dcfadee5811d43240f0a6af230f1ce
# good: [6c02258e143700314ebf268dae47eb23db17d1cf] qobject-input-visitor: D=
ocument full_name_nth()
git bisect good 6c02258e143700314ebf268dae47eb23db17d1cf
# bad: [95615ce5a1beffff1a5dd3597d8cb6ba83f0010e] vhost-scsi: create a vhos=
t-scsi-common abstraction
git bisect bad 95615ce5a1beffff1a5dd3597d8cb6ba83f0010e
# bad: [31f5a726b59bda5580e2f9413867893501dd7d93] trace: add qemu mutex loc=
k and unlock trace events
git bisect bad 31f5a726b59bda5580e2f9413867893501dd7d93
# bad: [49e00a18708e27c815828d9440d5c9300d19547c] use _Static_assert in QEM=
U_BUILD_BUG_ON
git bisect bad 49e00a18708e27c815828d9440d5c9300d19547c
# bad: [6103451aeb749e92bf7d730429985189c6921c32] hw/i386: Build-time asser=
tion on pc/q35 reset register being identical.
git bisect bad 6103451aeb749e92bf7d730429985189c6921c32
# bad: [77af8a2b95b79699de650965d5228772743efe84] hw/i386: Use Rev3 FADT (A=
CPI 2.0) instead of Rev1 to improve guest OS support.
git bisect bad 77af8a2b95b79699de650965d5228772743efe84
# first bad commit: [77af8a2b95b79699de650965d5228772743efe84] hw/i386: Use=
 Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.


77af8a2b95b79699de650965d5228772743efe84 is the first bad commit
commit 77af8a2b95b79699de650965d5228772743efe84
Author: Phil Dennis-Jordan <phil@philjordan.eu>
Date:   Wed Mar 15 19:20:26 2017 +1300

    hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest
OS support.

    This updates the FADT generated for x86/64 machine types from
Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) The
intention is to expose the reset register information to guest operating
systems which require it, specifically OS X/macOS. Revision 1 FADTs do
not contain the fields relating to the reset register.

    The new layout and contents remains backwards-compatible with
operating systems which only support ACPI 1.0, as the existing fields
are not modified by this change, as the 64-bit and 32-bit variants are
allowed to co-exist according to the ACPI 2.0 standard. No regressions
became apparent in tests with a range of Windows (XP-10) and Linux
versions.

    The BIOS tables test suite's FADT checksum test has also been
updated to reflect the new FADT layout and content.

    Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
    Message-Id: <1489558827-28971-2-git-send-email-phil@philjordan.eu>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

:040000 040000 40063761c0b86f87e798e03ea48eff9ea0753425 6d2a94150cf1eafb16f=
0ccf6325281415fef64a6 M      hw
:040000 040000 fe3f1480a91b76fea238c765f0725e715932d96d 68f9368d8d78fd3267f=
609b603f97e8a74bdf528 M      include
:040000 040000 895e961b0a160100aa95b2f557cfe6b87a7d9bff 8ed08cef10fddee7814=
e38ad62be11371592a75a M      tests

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714331

Title:
  Virtual machines not working anymore on 2.10

Status in QEMU:
  New

Bug description:
  Using 2.10, my virtual machine(s) don't work anymore. This happens
  100% of the times.

  -----

  I use QEMU compiling it from source, on Ubuntu 16.04 amd64. This is
  the configure command:

      configure --target-list=3Dx86_64-softmmu --enable-debug --enable-gtk
  --enable-spice --audio-drv-list=3Dpa

  I have one virtual disk, with a Windows 10 64-bit, which I launch in
  two different ways; both work perfectly on 2.9 (and used to do on 2.8,
  but I haven't used it for a long time).

  This is the first way:

      qemu-system-x86_64
        -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.=
fd
        -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
        -enable-kvm
        -machine q35,accel=3Dkvm,mem-merge=3Doff
        -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinloc=
ks=3D0x1fff,hv_vapic,hv_time
        -smp 4,cores=3D4,sockets=3D1,threads=3D1
        -m 4096
        -display gtk
        -vga qxl
        -rtc base=3Dlocaltime
        -serial none
        -parallel none
        -usb
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device virtio-scsi-pci,id=3Dscsi
        -drive file=3D/path/to/image-diff.img,id=3Dhdd1,format=3Dqcow2,if=
=3Dnone,cache=3Dwriteback
        -device scsi-hd,drive=3Dhdd1
        -net nic,model=3Dvirtio
        -net user

  On QEMU 2.10, I get the `Recovery - Your PC/Device needs to be
  repaired` windows screen; on 2.9, it boots regularly.

  This is the second way:

      qemu-system-x86_64
        -drive if=3Dpflash,format=3Draw,readonly,file=3D/path/to/OVMF_CODE.=
fd
        -drive if=3Dpflash,format=3Draw,file=3D/tmp/OVMF_VARS.fd.tmp
        -enable-kvm
        -machine q35,accel=3Dkvm,mem-merge=3Doff
        -cpu host,kvm=3Doff,hv_vendor_id=3Dvgaptrocks,hv_relaxed,hv_spinloc=
ks=3D0x1fff,hv_vapic,hv_time
        -smp 4,cores=3D4,sockets=3D1,threads=3D1
        -m 10240
        -vga none
        -rtc base=3Dlocaltime
        -serial none
        -parallel none
        -usb
        -device vfio-pci,host=3D01:00.0,multifunction=3Don
        -device vfio-pci,host=3D01:00.1
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device usb-host,vendorid=3D0xNNNN,productid=3D0xNNNN
        -device virtio-scsi-pci,id=3Dscsi
        -drive file=3D/path/to/image-diff.img,id=3Dhdd1,format=3Dqcow2,if=
=3Dnone,cache=3Dwriteback
        -device scsi-hd,drive=3Dhdd1
        -net nic,model=3Dvirtio
        -net user

  On QEMU 2.10, I get the debug window on the linux monitor, and blank scre=
en on VFIO one (no BIOS screen at all); after 10/20 seconds, QEMU crashes w=
ithout any message.
  On 2.9, this works perfectly.

  -----

  I am able to perform a git bisect, if that helps, but if this is the
  case, I'd need this issue to be reviewed, since bisecting is going to
  take me a lot of time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714331/+subscriptions
