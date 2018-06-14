Received: from eggs.gnu.org ([2001:4830:134:3::10]:55158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYv-00070Q-AN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYu-0000Pq-BM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:33 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYu-0000Pj-6r
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:32 -0400
Received: by mail-qk0-x244.google.com with SMTP id c131-v6so4156978qkb.0
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 11:01:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Jun 2018 15:01:19 -0300
Message-Id: <20180614180119.1704-3-f4bug@amsat.org>
In-Reply-To: <20180614180119.1704-1-f4bug@amsat.org>
References: <20180614180119.1704-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/2] hw/alpha/dp264: Disable the Super I/O
 parallel port
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

The 3BCh I/O address was used by "Parallel Ports which were
incorporated on to Video Cards" and "has now reappeared as
an option for Parallel Ports integrated onto motherboards,
upon which their configuration can be changed using BIOS."

The real PALcode is expected to configure the Super I/O and
disable the parallel port, to allow the 3c0-3cf range to be
assigned to the Cirrus VGA.

This fixes an issue introduced in a4cb773928e where the SIO
bind the parallel port in the address range used by the VGA
device, resulting in overlap:

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

Reported-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/alpha/dp264.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 80b987f7fb..87504add8e 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -58,6 +58,7 @@ static void clipper_init(MachineState *machine)
     AlphaCPU *cpus[4];
     PCIBus *pci_bus;
     ISABus *isa_bus;
+    DeviceState *superio;
     qemu_irq rtc_irq;
     long size, i;
     char *palcode_filename;
@@ -95,7 +96,10 @@ static void clipper_init(MachineState *machine)
     isa_create_simple(isa_bus, "i82374");
 
     /* Super I/O */
-    isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
+    superio = DEVICE(isa_create(isa_bus, TYPE_SMC37C669_SUPERIO));
+    /* Real PALcode configures the Super I/O and disable the parallel port */
+    qdev_prop_set_bit(superio, "parallel", false);
+    qdev_init_nofail(superio);
 
     /* IDE disk setup.  */
     {
-- 
2.17.1
