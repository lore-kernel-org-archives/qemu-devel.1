Received: from eggs.gnu.org ([2001:4830:134:3::10]:33060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gM4ux-0002El-1F
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 00:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gM4uq-0002bq-U7
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 00:37:46 -0500
Received: from mail-eopbgr680108.outbound.protection.outlook.com
	([40.107.68.108]:2496
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gM4uq-0002al-B2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 00:37:40 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 12 Nov 2018 05:37:33 +0000
Message-ID: <BN6PR2201MB1251ADAEA3C596FD3F1AB3E6C6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181111233622.8976-1-f4bug@amsat.org>,
	<20181111233622.8976-9-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-9-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] target/mips: Add a decodetree
 stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

> Subject: [RFC PATCH 08/11] target/mips: Add a decodetree stub

There is no plan to use decodetree for MIPS target. MIPS decoding engine is=
 mostly stable mature code that was well tested over many years, and there =
is no point in introducing such drastic change to the code that works.

Thanks,
Aleksandar

________________________________________
From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on behalf=
 of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
Sent: Monday, November 12, 2018 12:36:19 AM
To: Bastian Koppelmann; Peer Adelt; Richard Henderson
Cc: Philippe Mathieu-Daud=E9; qemu-devel@nongnu.org; Aurelien Jarno; Aleksa=
ndar Markovic
Subject: [RFC PATCH 08/11] target/mips: Add a decodetree stub

Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
---
 target/mips/Makefile.objs   |  8 ++++++++
 target/mips/insns.decode    |  2 ++
 target/mips/translate.c     |  7 +++++++
 target/mips/translate.inc.c | 13 +++++++++++++
 4 files changed, 30 insertions(+)
 create mode 100644 target/mips/insns.decode
 create mode 100644 target/mips/translate.inc.c

diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index 651f36f517..3510835d57 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -2,3 +2,11 @@ obj-y +=3D translate.o dsp_helper.o op_helper.o lmi_helper=
.o helper.o cpu.o
 obj-y +=3D gdbstub.o msa_helper.o mips-semi.o
 obj-$(CONFIG_SOFTMMU) +=3D machine.o cp0_timer.o
 obj-$(CONFIG_KVM) +=3D kvm.o
+
+DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
+
+target/mips/decode.inc.c: $(SRC_PATH)/target/mips/insns.decode $(DECODETRE=
E)
+       $(call quiet-command,\
+         $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
+
+target/mips/translate.o: target/mips/decode.inc.c
diff --git a/target/mips/insns.decode b/target/mips/insns.decode
new file mode 100644
index 0000000000..7fbf21cbb9
--- /dev/null
+++ b/target/mips/insns.decode
@@ -0,0 +1,2 @@
+# MIPS32/MIPS64 Instruction Set
+#
diff --git a/target/mips/translate.c b/target/mips/translate.c
index e726f3ec00..560325c563 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27848,6 +27848,8 @@ static void gen_msa(CPUMIPSState *env, DisasContext=
 *ctx)

 }

+#include "translate.inc.c"
+
 static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     int32_t offset;
@@ -27872,6 +27874,11 @@ static void decode_opc(CPUMIPSState *env, DisasCon=
text *ctx)
         gen_set_label(l1);
     }

+    /* Transition to the auto-generated decoder.  */
+    if (decode(ctx, ctx->opcode)) {
+        return;
+    }
+
     op =3D MASK_OP_MAJOR(ctx->opcode);
     rs =3D (ctx->opcode >> 21) & 0x1f;
     rt =3D (ctx->opcode >> 16) & 0x1f;
diff --git a/target/mips/translate.inc.c b/target/mips/translate.inc.c
new file mode 100644
index 0000000000..69fe78ac89
--- /dev/null
+++ b/target/mips/translate.inc.c
@@ -0,0 +1,13 @@
+/*
+ *  MIPS emulation for QEMU - MIPS32 translation routines
+ *
+ *  Copyright (c) 2004-2005 Jocelyn Mayer
+ *  Copyright (c) 2006 Marius Groeger (FPU operations)
+ *  Copyright (c) 2006 Thiemo Seufer (MIPS32R2 support)
+ *  Copyright (c) 2018 Philippe Mathieu-Daud=E9
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
--
2.17.2
