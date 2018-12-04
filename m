Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fwsgonzo@hotmail.com>) id 1gUEFA-0002Ct-Vi
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:12:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fwsgonzo@hotmail.com>) id 1gUDz1-0004Hu-Rr
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:55:44 -0500
Received: from mail-oln040092072060.outbound.protection.outlook.com
	([40.92.72.60]:39712
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fwsgonzo@hotmail.com>)
	id 1gUDz1-0004GB-Gt
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 11:55:39 -0500
From: Gonzo FWS <fwsgonzo@hotmail.com>
Date: Tue, 4 Dec 2018 16:55:34 +0000
Message-ID: <HE1P190MB00739AD5A654DAA3FE9B4662DEAF0@HE1P190MB0073.EURP190.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  i386: don't require elf64 for multiboot kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Right now IncludeOS on x86_64 must use a chainloader for multiboot support.=
 The chainloader is an ELF32 kernel that loads the real ELF64 kernel and ju=
mps to it. As long as the ELF has the .multiboot section and conforms to th=
e spec, meaning _start is be a 32-bit entry, it should be fine.

By removing the extra check in multiboot.c, we can also boot ELF64 files. A=
s can be seen here:
https://cloud.fwsnet.net/index.php/s/XrkBkC8zy7MLa9p

Signed-off-by: Alf-Andr=E9 Walla <fwsgonzo@hotmail.com>
---
 hw/i386/multiboot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 1a4344f5fc..d07ebf3361 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -194,11 +194,6 @@ int load_multiboot(FWCfgState *fw_cfg,
         int kernel_size;
         fclose(f);

-        if (((struct elf64_hdr*)header)->e_machine =3D=3D EM_X86_64) {
-            error_report("Cannot load x86-64 image, give a 32bit one.");
-            exit(1);
-        }
-
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, &elf_entry,
                                &elf_low, &elf_high, 0, I386_ELF_MACHINE,
                                0, 0);
--
2.17.1
