Received: from eggs.gnu.org ([2001:4830:134:3::10]:58370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4M-0004Km-4y
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4J-00029I-2k
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:10 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:35677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGG4I-00028X-Th
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:47:06 -0400
Received: by mail-qt0-x235.google.com with SMTP id f5-v6so30633533qth.2
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:47:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 May 2018 00:46:44 -0300
Message-Id: <20180509034658.26455-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/14] sdcard: Proper implementation of CRC7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>

Hi,

This series emerged after last Coverity scan and Peter suggestion in:
http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg05046.html

    (3) "proper" implementation of CRC, so that an sd controller
    can either (a) mark the SDRequest as "no CRC" and have
    sd_req_crc_validate() always pass, or (b) mark the SDRequest
    as having a CRC and have sd_req_crc_validate() actually
    do the check which it currently stubs out with "return 0"

- Coverity issues fixed
- new functions documented
- qtests added

This series would be much smaller without qtests (less refactor and code
movement), but I feel more confident having them passing :)

v2:
- simplified (do not touch CRC16: less code added)
- added R-b

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01130.html

Regards,

Phil.

Philippe Mathieu-Daudé (14):
  sdcard: Use the ldst API
  sdcard: Constify sd_crc*()'s message argument
  sdcard: Fix sd_crc*() style
  sdcard: Extract sd_frame48/136_calc_checksum()
  sdcard: Move sd_crc7() and calc_checksum() out for qtesting
  sdcard: Add test_sd_verify_cksum_frame136()
  sdcard: Invert the sd_req_crc_is_valid() logic
  sdcard: Extract sd_frame48_verify_checksum() out for qtesting
  sdcard: Add sd_frame136_verify_checksum()
  sdcard: Remove the SDRequest argument from internal functions
  sdcard: Add sd_frame48_init(), replace SDRequest by a raw buffer
  sdcard: Add tests to validate the 7-bit CRC checksum of 48-bit SD frame
  sdcard: Add a "validate-crc" property
  hw/sd/ssi-sd: Enable CRC validation

 include/hw/sd/sd.h        |  64 +++++++++++++---
 hw/sd/bcm2835_sdhost.c    |  21 +++---
 hw/sd/core.c              |   7 +-
 hw/sd/milkymist-memcard.c |  14 +---
 hw/sd/omap_mmc.c          |  14 ++--
 hw/sd/pl181.c             |  21 +++---
 hw/sd/pxa2xx_mmci.c       |   8 +-
 hw/sd/sd.c                | 153 ++++++++++++++++++--------------------
 hw/sd/sdhci.c             |  35 ++++-----
 hw/sd/sdmmc-internal.c    |  59 +++++++++++++++
 hw/sd/ssi-sd.c            |  19 ++---
 tests/sdcard-test.c       | 121 ++++++++++++++++++++++++++++++
 tests/Makefile.include    |   4 +
 13 files changed, 369 insertions(+), 171 deletions(-)
 create mode 100644 tests/sdcard-test.c

-- 
2.17.0
