Received: from eggs.gnu.org ([2001:4830:134:3::10]:53237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003Ja-6o
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007H9-5J
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHb-00076T-Sw
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id f19-v6so7677806wmb.0
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:13 +0100
Message-Id: <20181111233622.8976-3-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 02/11] decodetree: Add multiple include
 guard
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

It is necessary when splitting an ISA, or when using multiple ISAs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
TODO: explain why, use case
TODO: escape full path?
---
 scripts/decodetree.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 0bc73b5990..5dea15e7a5 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1030,7 +1030,11 @@ def main():
     else:
         output_fd = sys.stdout
 
+    hdr_guard = filename.split(os.path.sep)[-1].upper().replace('.', '_') + "_H"
+
     output_autogen()
+    output('#ifndef ' + hdr_guard + '\n')
+    output('#define ' + hdr_guard + '\n')
     for n in sorted(arguments.keys()):
         f = arguments[n]
         f.output_def()
@@ -1066,6 +1070,7 @@ def main():
     t.output_code(4, False, 0, 0)
 
     output('}\n')
+    output('#endif /* ' + hdr_guard + ' */\n')
 
     if output_file:
         output_fd.close()
-- 
2.17.2
