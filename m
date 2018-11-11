Received: from eggs.gnu.org ([2001:4830:134:3::10]:53239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003Jc-6i
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007HQ-Ig
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007BG-6B
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id y3-v6so7365726wrh.10
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:16 +0100
Message-Id: <20181111233622.8976-6-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 05/11] decodetree: Force Python to print
 unsigned values
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

Python internal representation is signed, so unsigned values
bigger than 31-bit are interpreted as signed (and printed with
a '-' signed).
Mask out to force unsigned values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
TODO: display error encountered:

   case 0x-1:
       ....
---
 scripts/decodetree.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 5dea15e7a5..08aa52d544 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -900,12 +900,12 @@ class Tree:
             def str_case(b):
                 return '0x{0:08x}'.format(b)
 
-        output(ind, 'switch (', str_switch(self.thismask), ') {\n')
+        output(ind, 'switch (', str_switch(self.thismask & insnmask), ') {\n')
         for b, s in sorted(self.subs):
             assert (self.thismask & ~s.fixedmask) == 0
             innermask = outermask | self.thismask
             innerbits = outerbits | b
-            output(ind, 'case ', str_case(b), ':\n')
+            output(ind, 'case ', str_case(b & insnmask), ':\n')
             output(ind, '    /* ',
                    str_match_bits(innerbits, innermask), ' */\n')
             s.output_code(i + 4, extracted, innerbits, innermask)
-- 
2.17.2
