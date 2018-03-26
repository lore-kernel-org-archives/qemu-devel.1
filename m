Received: from eggs.gnu.org ([2001:4830:134:3::10]:34460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U9B-00038E-0g
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U96-00009W-4L
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:34:57 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0U95-000097-W1
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:34:52 -0400
Received: by mail-qk0-x243.google.com with SMTP id 132so20543106qkd.5
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 08:34:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Mar 2018 12:34:36 -0300
Message-Id: <20180326153441.32641-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Nageswara Sastry <nasastry@in.ibm.com>

Hi,

This series intend to fix: https://bugs.launchpad.net/qemu/+bug/1721224

Patch #1 is the fix for 2.12, following patches are just refactors for 2.13.

The 8257 only has 4 DMA channels. To have 8 channels, the IBM PC/AT
implementation uses 2x 8257, the second cascaded onto the first.
The i8257_dma_init() name is misleading since this function creates two
8257 to register a total of 8 channels on the ISA bus.

The refactor is to enforce that 2 controllers are used (cascaded) - no
logical change.

Regards,

Phil.

Philippe Mathieu-Daudé (5):
  hw/dma/i82374: Avoid double creation of the 82374 controller
  hw/dma/i8257: Define I8257_CHANNEL_COUNT
  hw/dma/i8257: Split i8257_dma_init() by master/slave
  hw/dma/i8257: Rename i8257_dma_init() -> i8257_dma_init_cascaded()
  hw/dma/i8257: Rename i8257_dma_init(false) -> i8257_dma_init_pc_at()

 include/hw/dma/i8257.h  | 23 +++++++++++++++++++++--
 hw/dma/i82374.c         |  9 ++++++++-
 hw/dma/i8257.c          | 38 ++++++++++++++++++++++++++++----------
 hw/i386/pc.c            |  2 +-
 hw/mips/mips_fulong2e.c |  2 +-
 hw/mips/mips_jazz.c     |  2 +-
 hw/mips/mips_malta.c    |  2 +-
 7 files changed, 61 insertions(+), 17 deletions(-)

-- 
2.16.3
