Received: from eggs.gnu.org ([209.51.188.92]:58389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0O-0007bf-Dl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0N-0007Dy-Ei
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:28 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0N-0007Di-8Y
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id e80so13118371ote.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:27 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
Date: Mon,  8 Apr 2019 14:27:48 -0400
Message-Id: <20190408182748.1238-6-jan.bobek@gmail.com>
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 5/5] risu_i386: remove old unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Bobek <jan.bobek@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The code being removed is a remnant of the past implementation; it has
since been replaced by its more powerful, architecture-independent
counterpart in reginfo.c.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c | 58 -----------------------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/risu_i386.c b/risu_i386.c
index eb4dff4..14b0db3 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -16,13 +16,6 @@
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
-struct reginfo master_ri, apprentice_ri;
-
-static int insn_is_ud2(uint32_t insn)
-{
-    return ((insn & 0xffff) == 0x0b0f);
-}
-
 void advance_pc(void *vuc)
 {
     ucontext_t *uc = (ucontext_t *) vuc;
@@ -61,54 +54,3 @@ uintptr_t get_pc(struct reginfo *ri)
 {
     return ri->gregs[REG_EIP];
 }
-
-int send_register_info(int sock, void *uc)
-{
-    struct reginfo ri;
-    fill_reginfo(&ri, uc);
-    return send_data_pkt(sock, &ri, sizeof(ri));
-}
-
-/* Read register info from the socket and compare it with that from the
- * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
- * NB: called from a signal handler.
- */
-int recv_and_compare_register_info(int sock, void *uc)
-{
-    int resp;
-    fill_reginfo(&master_ri, uc);
-    recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri));
-    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) != 0) {
-        /* mismatch */
-        resp = 2;
-    } else if (insn_is_ud2(master_ri.faulting_insn)) {
-        /* end of test */
-        resp = 1;
-    } else {
-        /* either successful match or expected undef */
-        resp = 0;
-    }
-    send_response_byte(sock, resp);
-    return resp;
-}
-
-/* Print a useful report on the status of the last comparison
- * done in recv_and_compare_register_info(). This is called on
- * exit, so need not restrict itself to signal-safe functions.
- * Should return 0 if it was a good match (ie end of test)
- * and 1 for a mismatch.
- */
-int report_match_status(void)
-{
-    fprintf(stderr, "match status...\n");
-    fprintf(stderr, "master reginfo:\n");
-    dump_reginfo(&master_ri);
-    fprintf(stderr, "apprentice reginfo:\n");
-    dump_reginfo(&apprentice_ri);
-    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) == 0) {
-        fprintf(stderr, "match!\n");
-        return 0;
-    }
-    fprintf(stderr, "mismatch!\n");
-    return 1;
-}
-- 
2.20.1
