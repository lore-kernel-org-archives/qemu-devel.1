Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLdDa-0008Sy-Ro
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 19:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLdDX-0007f2-M1
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 19:03:10 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLdDX-0007e9-Ei
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 19:03:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id u5-v6so300052wrn.9
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 16:03:07 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 11 Nov 2018 01:02:59 +0100
Message-Id: <20181111000259.7665-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] decodetree: Force Python to print unsigned
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Python internal representation is signed, so unsigned values
bigger than 31-bit are interpreted as signed (and printed with
a '-' signed).
Mask out to force unsigned values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/decodetree.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 5dea15e7a5..a24017d33e 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -895,10 +895,10 @@ class Tree:
                 return '0x{0:x}'.format(b >> sh)
         else:
             def str_switch(b):
-                return 'insn & 0x{0:08x}'.format(b)
+                return 'insn & 0x{0:08x}'.format(b & 0xffffffff)
 
             def str_case(b):
-                return '0x{0:08x}'.format(b)
+                return '0x{0:08x}'.format(b & 0xffffffff)
 
         output(ind, 'switch (', str_switch(self.thismask), ') {\n')
         for b, s in sorted(self.subs):
-- 
2.19.1
