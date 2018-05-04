Received: from eggs.gnu.org ([2001:4830:134:3::10]:54777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7N-0002OB-FV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7H-0001Ka-LC
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:33 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEd7H-0001K4-GL
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:59:27 -0400
Received: by mail-qt0-x231.google.com with SMTP id m9-v6so7208395qtb.5
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:59:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  4 May 2018 12:58:58 -0300
Message-Id: <20180504155918.21287-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/20] sdcard: proper implementation of CRC
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

- Coverity issues fixed (up to patch 6)
- crc16 now works
- new functions documented
- qtests added

Regards,

Phil.

Philippe Mathieu-Daudé (20):
  sdcard: Use the ldst API
  sdcard: Extract sd_calc_frame48_crc7() from sd_req_crc_validate()
  sdcard: Rename the SDRequest as SDFrame48
  sdcard: Add sd_prepare_request[_with_crc]()
  sdcard: Use the sd_prepare_request*() functions
  sdcard: Add a "validate-crc" property
  sdcard: Constify sd_crc*()'s message argument
  sdcard: Fix sd_crc*() style
  sdcard: Expose sd_crc*() functions for QTest use
  sdcard: Expose sd_prepare_request*() functions for QTest use
  sdcard: Add test_sd_request_frame_crc7() qtest (request command CRC7)
  sdcard: Let sd_frame48_crc7_calc() work on response frames
  sdcard: Expose sd_prepare_frame48() for QTest use
  sdcard: Add test_sd_response_frame48_crc7 qtest (command response CRC7)
  sdcard: Add SDFrame136 struct and 136-bit SD response frames functions
  sdcard: Add test_sd_response_frame136_crc7() qtest
  sdcard: Add SDFrameData struct and data frame checksum functions
  sdcard: Fix sd_crc16()
  sdcard: Add test_sd_data_frame_crc16() qtest
  sdcard: Add test_sd_verify_cksum_frame48() qtest

 hw/sd/sdmmc-internal.h    |  24 +++++++
 include/hw/sd/sd.h        | 136 +++++++++++++++++++++++++++++++++++++-
 hw/sd/bcm2835_sdhost.c    |   3 +-
 hw/sd/milkymist-memcard.c |   9 ++-
 hw/sd/omap_mmc.c          |   4 +-
 hw/sd/pxa2xx_mmci.c       |   4 +-
 hw/sd/sd.c                |  48 +++-----------
 hw/sd/sdhci.c             |   6 +-
 hw/sd/sdmmc-internal.c    | 114 ++++++++++++++++++++++++++++++++
 hw/sd/ssi-sd.c            |   6 +-
 tests/sdcard-test.c       | 116 ++++++++++++++++++++++++++++++++
 tests/Makefile.include    |   2 +
 12 files changed, 409 insertions(+), 63 deletions(-)
 create mode 100644 tests/sdcard-test.c

-- 
2.17.0
