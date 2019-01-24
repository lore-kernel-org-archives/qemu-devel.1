Received: from eggs.gnu.org ([209.51.188.92]:47336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmlBO-0001CW-3I
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmlBM-000312-1K
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:01:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:46190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gmlBK-0002zM-QN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:00:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gmlBH-0001S1-Q9
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 20:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BAE982E8087
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 20:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Jan 2019 19:53:56 -0000
From: Alberto Ortega <1813201@bugs.launchpad.net>
Reply-To: Bug 1813201 <1813201@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154835963658.2045.2300981728946163161.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1813201] [NEW] QEMU TCG i386 / x86_64 system
 emulation crash when executing int instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

QEMU version:
-------------

qemu from git, master branch commit
d058a37a6e8daa8d71a6f2b613eb415b69363755

Release versions are also affected.

Summary:
--------

QEMU i386 and x86_64 system emulation crash when executing the following
"int" instruction:

cd08  int 8

This generates a kernel NULL pointer dereference error in Linux, and a
BSOD error in Windows.

No special permissions are required to execute the instruction, any
unprivileged user can execute it.

This issue has been reproduced in QEMU running in TCG mode. KVM is not
affected.

Kernel panic log:

[  111.091138] BUG: unable to handle kernel NULL pointer dereference at 000=
00014
[  111.092145] IP: [<ce0513ad>] doublefault_fn+0xd/0x130
[  111.092145] *pdpt =3D 0000000000000000 *pde =3D f000ff53f000ff53 [  111.=
092145] =

[  111.092145] Oops: 0000 [#1] SMP
[  111.092145] Modules linked in: kvm_amd bochs_drm ppdev ttm drm_kms_helpe=
r drm kvm irqbypass evdev pcspkr serio_raw sg parport_pc parport button ip_=
tables x_tables autofs4 ext4 crc16 jbd2 crc32c_generic fscrypto ecb xts lrw=
 gf128mul ablk_helper cryptd aes_i586 mbcache sr_mod sd_mod cdrom ata_gener=
ic ata_piix libata psmouse e1000 scsi_mod i2c_piix4 floppy
[  111.092145] CPU: 0 PID: 409 Comm: int8.elf Not tainted 4.9.0-8-686-pae #=
1 Debian 4.9.130-2
[  111.092145] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[  111.092145] task: f6c88a80 task.stack: f6e52000
[  111.092145] EIP: 0060:[<ce0513ad>] EFLAGS: 00004086 CPU: 0
[  111.092145] EIP is at doublefault_fn+0xd/0x130
[  111.092145] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  111.092145] ESI: 00000000 EDI: 00000000 EBP: ce8f13fc ESP: ce8f13d4
[  111.092145]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  111.092145] CR0: 8005003b CR2: 00000014 CR3: 0e8e1000 CR4: 000006f0
[  111.092145] Stack:
[  111.092145]  00000000 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000
[  111.092145]  00000000 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000
[  111.092145]  00000000 00000000 00000000 00000000 fed00000 ce474ad0 00000=
000 00017d78
[  111.092145] Call Trace:
[  111.092145] Code: 86 fd ff eb a3 89 f6 8d bc 27 00 00 00 00 55 89 e5 3e =
8d 74 26 00 5d e9 e2 79 fd ff 66 90 55 89 e5 56 53 83 ec 20 3e 8d 74 26 00 =
<65> a1 14 00 00 00 89 45 f4 31 c0 31 c0 c7 45 f0 00 00 00 00 66
[  111.092145] EIP: [<ce0513ad>] [  111.092145] doublefault_fn+0xd/0x130
[  111.092145]  SS:ESP 0068:ce8f13d4
[  111.092145] CR2: 0000000000000014
[  111.092145] ---[ end trace 8afa7884b76cafc1 ]---

Testcase:
---------

void main() {
        asm("int $0x8");
}

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: tcg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1813201

Title:
  QEMU TCG i386 / x86_64 system emulation crash when executing int
  instruction

Status in QEMU:
  New

Bug description:
  QEMU version:
  -------------

  qemu from git, master branch commit
  d058a37a6e8daa8d71a6f2b613eb415b69363755

  Release versions are also affected.

  Summary:
  --------

  QEMU i386 and x86_64 system emulation crash when executing the
  following "int" instruction:

  cd08  int 8

  This generates a kernel NULL pointer dereference error in Linux, and a
  BSOD error in Windows.

  No special permissions are required to execute the instruction, any
  unprivileged user can execute it.

  This issue has been reproduced in QEMU running in TCG mode. KVM is not
  affected.

  Kernel panic log:

  [  111.091138] BUG: unable to handle kernel NULL pointer dereference at 0=
0000014
  [  111.092145] IP: [<ce0513ad>] doublefault_fn+0xd/0x130
  [  111.092145] *pdpt =3D 0000000000000000 *pde =3D f000ff53f000ff53 [  11=
1.092145] =

  [  111.092145] Oops: 0000 [#1] SMP
  [  111.092145] Modules linked in: kvm_amd bochs_drm ppdev ttm drm_kms_hel=
per drm kvm irqbypass evdev pcspkr serio_raw sg parport_pc parport button i=
p_tables x_tables autofs4 ext4 crc16 jbd2 crc32c_generic fscrypto ecb xts l=
rw gf128mul ablk_helper cryptd aes_i586 mbcache sr_mod sd_mod cdrom ata_gen=
eric ata_piix libata psmouse e1000 scsi_mod i2c_piix4 floppy
  [  111.092145] CPU: 0 PID: 409 Comm: int8.elf Not tainted 4.9.0-8-686-pae=
 #1 Debian 4.9.130-2
  [  111.092145] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
  [  111.092145] task: f6c88a80 task.stack: f6e52000
  [  111.092145] EIP: 0060:[<ce0513ad>] EFLAGS: 00004086 CPU: 0
  [  111.092145] EIP is at doublefault_fn+0xd/0x130
  [  111.092145] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
  [  111.092145] ESI: 00000000 EDI: 00000000 EBP: ce8f13fc ESP: ce8f13d4
  [  111.092145]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
  [  111.092145] CR0: 8005003b CR2: 00000014 CR3: 0e8e1000 CR4: 000006f0
  [  111.092145] Stack:
  [  111.092145]  00000000 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000
  [  111.092145]  00000000 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000
  [  111.092145]  00000000 00000000 00000000 00000000 fed00000 ce474ad0 000=
00000 00017d78
  [  111.092145] Call Trace:
  [  111.092145] Code: 86 fd ff eb a3 89 f6 8d bc 27 00 00 00 00 55 89 e5 3=
e 8d 74 26 00 5d e9 e2 79 fd ff 66 90 55 89 e5 56 53 83 ec 20 3e 8d 74 26 0=
0 <65> a1 14 00 00 00 89 45 f4 31 c0 31 c0 c7 45 f0 00 00 00 00 66
  [  111.092145] EIP: [<ce0513ad>] [  111.092145] doublefault_fn+0xd/0x130
  [  111.092145]  SS:ESP 0068:ce8f13d4
  [  111.092145] CR2: 0000000000000014
  [  111.092145] ---[ end trace 8afa7884b76cafc1 ]---

  Testcase:
  ---------

  void main() {
          asm("int $0x8");
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1813201/+subscriptions
