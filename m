Received: from eggs.gnu.org ([2001:4830:134:3::10]:40768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leandro.lupori@gmail.com>) id 1fBjXk-0007xt-3t
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leandro.lupori@gmail.com>) id 1fBjXj-0006E2-AT
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:14:48 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:33238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leandro.lupori@gmail.com>)
	id 1fBjXj-0006Dc-3D
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:14:47 -0400
Received: by mail-wm0-x22c.google.com with SMTP id x12so173912wmc.0
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 09:14:46 -0700 (PDT)
MIME-Version: 1.0
From: Leandro <leandro.lupori@gmail.com>
Date: Thu, 26 Apr 2018 13:14:25 -0300
Message-ID: <CAC7XEcLTBGZ815iMa_Uwz7+FiTm_8dVAT+banx4hcEbY=ui8uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] Allow PIR read in privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to PowerISA, the PIR register should be readable in privileged
mode also, not only in hypervisor privileged mode.

The following patch fixes this:

--- qemu-2.12.0-original/target/ppc/translate_init.c    2018-04-24
13:30:47.000000000 -0300
+++ qemu-2.12.0/target/ppc/translate_init.c     2018-04-25
16:40:04.248844415 -0300
@@ -7811,7 +7811,7 @@
     /* Processor identification */
     spr_register_hv(env, SPR_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, SPR_NOACCESS,
                  &spr_read_generic, NULL,
                  0x00000000);
     spr_register_hv(env, SPR_HID0, "HID0",
