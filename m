Received: from eggs.gnu.org ([2001:4830:134:3::10]:57909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fP63A-0006LO-Rc
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 08:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fP636-0000mi-TO
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 08:54:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:52213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fP636-0000l8-Mh
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 08:54:24 -0400
Date: Sat, 2 Jun 2018 14:54:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1806021437320.49196@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] icbt on PPC440 after commit 01662f3e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

Hello,

I get an invalid instruction exception for the icbt instruction on the 
sam460ex machine (PPC440 core 460EX CPU) but I think this should not raise 
exception as it's valid on BookE that this CPU should support. Commit 
01662f3e PPC: Implement e500 (FSL) MMU has introduced an extended 
instruction type (type2) in PPC opcodes and changed 
taget/ppc/translate_init.c as:

@@ -9437,7 +9492,8 @@ static int create_ppc_opcodes (CPUPPCState *env, const ppc_def_t *def)

      fill_new_table(env->opcodes, 0x40);
      for (opc = opcodes; opc < &opcodes[ARRAY_SIZE(opcodes)]; opc++) {
-        if ((opc->handler.type & def->insns_flags) != 0) {
+        if (((opc->handler.type & def->insns_flags) != 0) ||
+            ((opc->handler.type2 & def->insns_flags2) != 0)) {
              if (register_insn(env->opcodes, opc) < 0) {
                  printf("*** ERROR initializing PowerPC instruction "
                         "0x%02x 0x%02x 0x%02x\n", opc->opc1, opc->opc2,


it also made this change in target/ppc/translate.c:

-GEN_HANDLER(mbar, 0x1F, 0x16, 0x1a, 0x001FF801, PPC_BOOKE),
-GEN_HANDLER(msync, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
-GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001, PPC_BOOKE),
+GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
+              PPC_BOOKE, PPC2_BOOKE206),
+GEN_HANDLER_E(msync, 0x1F, 0x16, 0x12, 0x03FFF801,
+              PPC_BOOKE, PPC2_BOOKE206),
+GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
+               PPC_BOOKE, PPC2_BOOKE206),

If I revert this change to icbt_440 it works without exception but 
according to the above it should also work for either type == BOOKE _or_ 
type2 == BOOKE206 but I still get exception in that case. Any idea why is 
this not working as expected?

Thank you,
BALATON Zoltan
