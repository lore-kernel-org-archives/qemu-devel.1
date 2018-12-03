Received: from eggs.gnu.org ([2001:4830:134:3::10]:36554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gTl73-0003dv-Os
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gTl6x-0004Ci-Fx
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:01 -0500
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Mon, 3 Dec 2018 13:04:14 +0300
Message-ID: <20181203100415.53027-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-3.1 1/2] i386: hvf: Fix overrun of
 _decode_tbl1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Single opcode instructions in ff group were incorrectly processed
because an overrun of _decode_tbl1[0xff] resulted in access of
_decode_tbl2[0x0]. Thus, decode_sldtgroup was called instead of
decode_ffgroup:
  7d71: decode_sldtgroup: 1
  Unimplemented handler (7d71) for 108 (ff 0)

While at it correct maximum length for _decode_tbl2 and _decode_tbl3.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/x86_decode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 2e33b69541..d125a6ef83 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -454,9 +454,9 @@ struct decode_x87_tbl {
 struct decode_tbl invl_inst = {0x0, 0, 0, false, NULL, NULL, NULL, NULL,
                                decode_invalid};
 
-struct decode_tbl _decode_tbl1[255];
-struct decode_tbl _decode_tbl2[255];
-struct decode_x87_tbl _decode_tbl3[255];
+struct decode_tbl _decode_tbl1[256];
+struct decode_tbl _decode_tbl2[256];
+struct decode_x87_tbl _decode_tbl3[256];
 
 static void decode_x87_ins(CPUX86State *env, struct x86_decode *decode)
 {
-- 
2.17.2 (Apple Git-113)
