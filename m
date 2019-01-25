Received: from eggs.gnu.org ([209.51.188.92]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gn3iG-0005vJ-SO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gn3iE-0003ho-TA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:48:12 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:54328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gn3iC-0003eT-Oe
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:48:08 -0500
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Fri, 25 Jan 2019 18:47:43 +0300
Message-ID: <20190125154743.14498-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] i386: hvf: Don't miss 16-bit displacement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

In 16-bit addressing mode, when Mod =3D 0 and R/M =3D 6, decoded displace=
ment
doesn't reach decode_linear_addr and gets lost. Instructions that
involve the combination of ModRM always get a pointer with zero offset
from the beginning of DS segment.

The change fixes drawing in F-BIRD from day 1 of '18 advent calendar.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/x86_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 5f513c5563..9ef7d7513f 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -1642,7 +1642,7 @@ void calc_modrm_operand16(CPUX86State *env, struct =
x86_decode *decode,
     X86Seg seg =3D R_DS;
=20
     if (!decode->modrm.mod && 6 =3D=3D decode->modrm.rm) {
-        op->ptr =3D (uint16_t)decode->displacement;
+        ptr =3D decode->displacement;
         goto calc_addr;
     }
=20
--=20
2.20.1
