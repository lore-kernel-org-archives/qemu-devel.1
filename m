Received: from eggs.gnu.org ([2001:4830:134:3::10]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYs-0006z5-TK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYp-0000OX-3q
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYo-0000OG-V8
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id a18-v6so6652052qtj.4
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 11:01:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Jun 2018 15:01:17 -0300
Message-Id: <20180614180119.1704-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/2] smc37c669: Fix parallel overlapping
 VGA ioport
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

Hi,

This RFC series attempt to fix a regression introduced in a4cb773928e,
and reported by Emilio:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00317.html

Mark noticed the VGA and parallel I/O were overlapping:

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

In reset the parallel port is enabled. Since the emulated PALcode
directly accesses the VGA port without checking if the SIO parallel
port is enabled, I suppose the real PALcode does this check.

To avoid changing the emulated PALcode, a "parallel" property is used
to reset the SIO with the parallel device disabled.

I tried to implement the quickest simpler fix...

references used:
- http://www.osdever.net/FreeVGA/vga/portidx.htm
- https://retired.beyondlogic.org/spp/parallel.htm
- http://ww1.microchip.com/downloads/en/DeviceDoc/37c669.pdf
- linux/arch/alpha/kernel/smc37c669.c
- https://github.com/rth7680/qemu-palcode/blob/master/init.c#L290
- https://github.com/rth7680/qemu-palcode/blob/master/ioport.h#L48

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  hw/isa/smc37c669-superio: Basic 'Config Registers' implementation
  hw/alpha/dp264: Disable the Super I/O parallel port

 hw/alpha/dp264.c           |  6 +++-
 hw/isa/smc37c669-superio.c | 73 +++++++++++++++++++++++++++++++++-----
 2 files changed, 70 insertions(+), 9 deletions(-)

-- 
2.17.1
