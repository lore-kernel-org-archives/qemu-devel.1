Received: from eggs.gnu.org ([209.51.188.92]:33990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h4-0004Dk-09
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h0-000105-9O
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:20 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:54755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3gy-0000xU-AC
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:16 -0400
Received: by mail-it1-x142.google.com with SMTP id a190so6785122ite.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:12 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Date: Fri, 26 Apr 2019 12:26:21 -0400
Message-Id: <20190426162624.55977-8-stephen.checkoway@oberlin.edu>
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 07/10] block/pflash_cfi02: Fix reset command
 not ignored during erase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>

When the flash device is performing a chip erase, all commands are
ignored. When it is performing a sector erase, only the erase suspend
command is valid, which is currently not supported.

In particular, the reset command should not cause the device to reset to
read array mode while programming is on going.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index be10036886..cb1160eb35 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -325,7 +325,8 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                     pfl->bank_width * 2, value);
         }
 
-        if (cmd == 0xF0) {
+        /* Reset does nothing during chip erase and sector erase. */
+        if (cmd == 0xF0 && pfl->cmd != 0x10 && pfl->cmd != 0x30) {
             if (pfl->wcycle == WCYCLE_AUTOSELECT_CFI) {
                 /* Return to autoselect mode. */
                 pfl->wcycle = 3;
-- 
2.20.1 (Apple Git-117)
