Received: from eggs.gnu.org ([2001:4830:134:3::10]:58262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTbqH-0005wt-5M
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTbqC-0003zd-Sv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:39:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTbqC-0003zP-N4
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:39:44 -0400
Received: by mail-qk0-x244.google.com with SMTP id j80-v6so4691831qke.9
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:39:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Jun 2018 20:39:35 -0300
Message-Id: <20180614233935.26585-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/isa/smc37c669: Change the parallel I/O base
 to 378H
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

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
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg04011.html

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
