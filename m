Received: from eggs.gnu.org ([2001:4830:134:3::10]:53245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003Jf-7c
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHd-0007IM-6S
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007Cr-S5
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:49 -0500
Received: by mail-wm1-x344.google.com with SMTP id t15-v6so6531830wmt.0
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:17 +0100
Message-Id: <20181111233622.8976-7-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 06/11] scripts/decodetree: Allow empty
 specifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Starting with empty specifications allow to write stubs/templates,
useful when testing/rebasing.

This fixes:

  decode.inc.c: In function ‘decode’:
  decode.inc.c:9:7: error: unused variable ‘u’ [-Werror=unused-variable]
     } u;
       ^

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/decodetree.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 08aa52d544..41ed67132d 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1060,12 +1060,13 @@ def main():
     output(decode_scope, 'bool ', decode_function,
            '(DisasContext *ctx, ', insntype, ' insn)\n{\n')
 
-    i4 = str_indent(4)
-    output(i4, 'union {\n')
-    for n in sorted(arguments.keys()):
-        f = arguments[n]
-        output(i4, i4, f.struct_name(), ' f_', f.name, ';\n')
-    output(i4, '} u;\n\n')
+    if arguments:
+        i4 = str_indent(4)
+        output(i4, 'union {\n')
+        for n in sorted(arguments.keys()):
+            f = arguments[n]
+            output(i4, i4, f.struct_name(), ' f_', f.name, ';\n')
+        output(i4, '} u;\n\n')
 
     t.output_code(4, False, 0, 0)
 
-- 
2.17.2
