Received: from eggs.gnu.org ([2001:4830:134:3::10]:53454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUxLz-0000Db-3m
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUxLv-0000yd-PW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:50:07 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUxLv-0000yK-JC
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:50:03 -0400
Received: by mail-pg0-x241.google.com with SMTP id m5-v6so7800975pgd.3
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 09:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 06:49:55 -1000
Message-Id: <20180618164955.6923-2-richard.henderson@linaro.org>
In-Reply-To: <20180618164955.6923-1-richard.henderson@linaro.org>
References: <20180618164955.6923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/1] hw/isa/smc37c669: Change the parallel I/O
 base to 378H
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

On the Alpha DP264 machine, the Cirrus VGA is I/O mapped
in the 3C0H-3CFH range, thus I/O base used by the parallel
device clashes, and since a4cb773928e the VGA is not
working:

(qemu) info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    00000801fc000000-00000801fdffffff (prio 0, i/o): pci0-io
      ...
      00000801fc0003b4-00000801fc0003b5 (prio 0, i/o): vga
      00000801fc0003ba-00000801fc0003ba (prio 0, i/o): vga
      00000801fc0003bc-00000801fc0003c3 (prio 0, i/o): parallel
                                    ^^^                ^^^^^^^^
      00000801fc0003c0-00000801fc0003cf (prio 0, i/o): vga
                   ^^^
      00000801fc0003d4-00000801fc0003d5 (prio 0, i/o): vga
      00000801fc0003da-00000801fc0003da (prio 0, i/o): vga
      ...

As there is no particular reason to use this base address
(introduced in 7bea0dd434e), change to 378H which is the
default on PC machines.

Reported-by: Emilio G. Cota <cota@braap.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180614233935.26585-1-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/isa/smc37c669-superio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index aa233c6967..64466a9373 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -37,7 +37,7 @@ static bool is_parallel_enabled(ISASuperIODevice *sio, uint8_t index)
 
 static uint16_t get_parallel_iobase(ISASuperIODevice *sio, uint8_t index)
 {
-    return 0x3bc;
+    return 0x378;
 }
 
 static unsigned int get_parallel_irq(ISASuperIODevice *sio, uint8_t index)
-- 
2.17.1
