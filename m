Received: from eggs.gnu.org ([209.51.188.92]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gph6D-0001RE-Hg
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gph6C-0006rn-9R
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:15:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gph6B-0006ki-V7
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 17:15:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gph5z-0002z0-1t
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 22:15:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 072662E8048
	for <qemu-devel@nongnu.org>; Fri,  1 Feb 2019 22:15:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Feb 2019 22:06:34 -0000
From: Jonathan Behrens <1814343@bugs.launchpad.net>
Reply-To: Bug 1814343 <1814343@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154905879413.25667.2843143192142684785.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1814343] [NEW] Initrd not loaded on riscv32
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

I attempted to run qemu with a ram disk. However, when reading the
contents of the disk from within the VM I only get back zeros.

I was able to trace the issue to a mismatch of expectations on line 93
of hw/riscv/virt.c. Specifically, when running in 32-bit mode the value
of kernel_entry is sign extended to 64-bits, but load_image_targphys
expects the start address to not be sign extended.

Straw man patch (works for 32-bit but would probably break 64-bit VMs?):

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e7f0716fb6..32216f993c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -90,7 +90,7 @@ static hwaddr load_initrd(const char *filename, uint64_t =
mem_size,
      * halfway into RAM, and for boards with 256MB of RAM or more we put
      * the initrd at 128MB.
      */
-    *start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
+    *start =3D (kernel_entry & 0xffffffff) + MIN(mem_size / 2, 128 * MiB);
 =

     size =3D load_ramdisk(filename, *start, mem_size - *start);
     if (size =3D=3D -1) {


Run command:

$ qemu/build/riscv32-softmmu/qemu-system-riscv32 -machine virt -kernel
mykernel.elf -nographic -initrd payload

Commit hash:

3a183e330dbd7dbcac3841737ac874979552cca2

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814343

Title:
  Initrd not loaded on riscv32

Status in QEMU:
  New

Bug description:
  I attempted to run qemu with a ram disk. However, when reading the
  contents of the disk from within the VM I only get back zeros.

  I was able to trace the issue to a mismatch of expectations on line 93
  of hw/riscv/virt.c. Specifically, when running in 32-bit mode the
  value of kernel_entry is sign extended to 64-bits, but
  load_image_targphys expects the start address to not be sign extended.

  Straw man patch (works for 32-bit but would probably break 64-bit
  VMs?):

  diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
  index e7f0716fb6..32216f993c 100644
  --- a/hw/riscv/virt.c
  +++ b/hw/riscv/virt.c
  @@ -90,7 +90,7 @@ static hwaddr load_initrd(const char *filename, uint64_=
t mem_size,
        * halfway into RAM, and for boards with 256MB of RAM or more we put
        * the initrd at 128MB.
        */
  -    *start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
  +    *start =3D (kernel_entry & 0xffffffff) + MIN(mem_size / 2, 128 * MiB=
);
   =

       size =3D load_ramdisk(filename, *start, mem_size - *start);
       if (size =3D=3D -1) {

  =

  Run command:

  $ qemu/build/riscv32-softmmu/qemu-system-riscv32 -machine virt -kernel
  mykernel.elf -nographic -initrd payload

  Commit hash:

  3a183e330dbd7dbcac3841737ac874979552cca2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1814343/+subscriptions
