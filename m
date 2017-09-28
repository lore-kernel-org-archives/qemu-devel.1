Received: from eggs.gnu.org ([2001:4830:134:3::10]:33898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <teisenbe@google.com>) id 1dxcR1-0007ER-Aj
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <teisenbe@google.com>) id 1dxcQv-00050u-QA
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:17:15 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:50948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <teisenbe@google.com>) id 1dxcQv-0004zp-Kt
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:17:09 -0400
Received: by mail-qt0-x22a.google.com with SMTP id f15so2590866qtf.7
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 10:17:08 -0700 (PDT)
MIME-Version: 1.0
From: Todd Eisenberger <teisenbe@google.com>
Date: Thu, 28 Sep 2017 10:17:06 -0700
Message-ID: <CAP26EVRNVb=Mq=O3s51w7fDhGVmf-e3XFFA73MRzc5b4qKBA4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] x86: Correct translation of some rdgsbase and
 wrgsbase encodings
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
List-ID: <qemu-devel.nongnu.org>

It looks like there was a transcription error when writing this code
initially.  The code previously only decoded src or dst of rax.  This
resolves
https://bugs.launchpad.net/qemu/+bug/1719984.

Signed-off-by: Todd Eisenberger <teisenbe@google.com>
---
 target/i386/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a8986f4c1a..7b920115f9 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8155,9 +8155,9 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
             break;

         case 0xc0 ... 0xc7: /* rdfsbase (f3 0f ae /0) */
-        case 0xc8 ... 0xc8: /* rdgsbase (f3 0f ae /1) */
+        case 0xc8 ... 0xcf: /* rdgsbase (f3 0f ae /1) */
         case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
-        case 0xd8 ... 0xd8: /* wrgsbase (f3 0f ae /3) */
+        case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
             if (CODE64(s)
                 && (prefixes & PREFIX_REPZ)
                 && !(prefixes & PREFIX_LOCK)
