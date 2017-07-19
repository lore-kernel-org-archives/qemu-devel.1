Received: from eggs.gnu.org ([2001:4830:134:3::10]:41745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3y-0003pK-J3
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3v-0002H0-Hm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:18 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3v-0002Gf-Bu
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:15 -0400
Received: by mail-pg0-x241.google.com with SMTP id y129so5430215pgy.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:58:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:21 -1000
Message-Id: <20170719045722.25492-14-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/14] tcg/tci: enable bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Jaroslaw Pelczar <j.pelczar@samsung.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Altough correctly implemented, bswap16_i64() never got tested/executed so the
safety TODO() statement was never removed.

Since it got now tested the TODO() can be removed.

while running Alex Bennée's image aarch64-linux-3.15rc2-buildroot.img:

Trace 0x7fa1904b0890 [0: ffffffc00036cd04]
----------------
IN:
0xffffffc00036cd24:  5ac00694      rev16 w20, w20

OP:
 ---- ffffffc00036cd24 0000000000000000 0000000000000000
 ext32u_i64 tmp3,x20
 ext16u_i64 tmp2,tmp3
 bswap16_i64 x20,tmp2
 movi_i64 tmp4,$0x10
 shr_i64 tmp2,tmp3,tmp4
 ext16u_i64 tmp2,tmp2
 bswap16_i64 tmp2,tmp2
 deposit_i64 x20,x20,tmp2,$0x10,$0x10

Linking TBs 0x7fa1904b0890 [ffffffc00036cd04] index 0 -> 0x7fa1904b0aa0 [ffffffc00036cd24]
Trace 0x7fa1904b0aa0 [0: ffffffc00036cd24]
TODO qemu/tci.c:1049: tcg_qemu_tb_exec()
qemu/tci.c:1049: tcg fatal error
Aborted

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20170718045540.16322-11-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 4bdc645..f39bfb9 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -1046,7 +1046,6 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             break;
 #if TCG_TARGET_HAS_bswap16_i64
         case INDEX_op_bswap16_i64:
-            TODO();
             t0 = *tb_ptr++;
             t1 = tci_read_r16(&tb_ptr);
             tci_write_reg64(t0, bswap16(t1));
-- 
2.9.4
