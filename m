Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYX-0003X0-QI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYV-0000gq-Vz
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:37 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWqYV-0000gS-QD
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:26:35 -0500
Received: by mail-qk0-x241.google.com with SMTP id 143so3245463qki.2
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:26:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:24:36 -0300
Message-Id: <20180103212436.15762-26-f4bug@amsat.org>
In-Reply-To: <20180103212436.15762-1-f4bug@amsat.org>
References: <20180103212436.15762-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 25/25] sdcard: introduce Spec v4.51 & v5.1
 MMC commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Olbrich <m.olbrich@pengutronix.de>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h |   1 +
 hw/sd/sd.c         | 181 ++++++++++++++++++++++++++++++++---------------------
 2 files changed, 112 insertions(+), 70 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 6874696ff7..1f1ec2a042 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -58,6 +58,7 @@
 typedef enum {
     PROTO_SD =  0,
     PROTO_SPI = 1 << 1,
+    PROTO_MMC = 1 << 2,
 } sd_bus_protocol_t;
 
 typedef enum {
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6fbc640d2e..c4701f9c7c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -63,6 +63,13 @@ typedef enum {
     SD_PHY_SPEC_VER_3_01 = 301, /* not yet supported */
 } sd_phy_spec_ver_t;
 
+typedef enum {
+    MMC_SPEC_VER_2_2    = 202,  /* not well supported */
+    /* e.MMC */
+    MMC_SPEC_VER_4_51   = 451,
+    MMC_SPEC_VER_5_1    = 501,  /* not supported */
+} mmc_phy_spec_ver_t;
+
 typedef enum {
     sd_capacity_unknown,
     sd_capacity_sdsc,           /* not well supported */
@@ -157,6 +164,8 @@ static const char *sd_protocol_name(sd_bus_protocol_t protocol)
         return "SD";
     case PROTO_SPI:
         return "SPI";
+    case PROTO_MMC:
+        return "MMC";
     default:
         g_assert_not_reached();
     }
@@ -299,78 +308,90 @@ typedef struct {
     struct {
         uint16_t version;
         uint32_t ccc_mask;
-    } sd, spi;
+    } sd, spi, mmc;
 } sd_cmd_supported_t;
 
 static const sd_cmd_supported_t cmd_supported[SDCARD_CMD_MAX] = {
-     /*           SD                  SPI          */
-     [0] = {{200, BIT(0)},      {200, BIT(0)},      },
-     [1] = {{301, BIT(0)},      {200, BIT(0)},      },
-     [2] = {{200, BIT(0)},      {},                 },
-     [3] = {{200, BIT(0)},      {},                 },
-     [4] = {{200, BIT(0)},      {},                 },
-     [5] = {{200, BIT(9)},      {200, BIT(9)},      },
-     [6] = {{200, BIT(10)},     {200, BIT(10)},     },
-     [7] = {{200, BIT(0)},      {},                 },
-     [8] = {{200, BIT(0)},      {200, BIT(0)},      },
-     [9] = {{200, BIT(0)},      {200, BIT(0)},      },
-    [10] = {{200, BIT(0)},      {200, BIT(0)},      },
-    [12] = {{200, BIT(0)},      {200, BIT(0)},      },
-    [13] = {{200, BIT(0)},      {200, BIT(0)},      },
-    [14] = {{200, BIT(0)},      {},                 },
-    [15] = {{200, BIT(0)},      {},                 },
-    [16] = {{200, BIT_2_4_7},   {200, BIT_2_4_7},   },
-    [17] = {{200, BIT(2)},      {200, BIT(2)},      },
-    [18] = {{200, BIT(2)},      {200, BIT(2)},      },
-    [23] = {{301, BIT_2_4},     {},                 },
-    [24] = {{200, BIT(4)},      {200, BIT(4)},      },
-    [25] = {{200, BIT(4)},      {200, BIT(4)},      },
-    [26] = {{200, BIT_MANUF},   {/*?*/},            },
-    [27] = {{200, BIT(4)},      {200, BIT(4)},      },
-    [28] = {{200, BIT(6)},      {200, BIT(6)},      },
-    [29] = {{200, BIT(6)},      {200, BIT(6)},      },
-    [30] = {{200, BIT(6)},      {200, BIT(6)},      },
-    [32] = {{200, BIT(5)},      {200, BIT(5)},      },
-    [33] = {{200, BIT(5)},      {200, BIT(5)},      },
-    [34] = {{200, BIT(10)},     {200, BIT(10)},     },
-    [35] = {{200, BIT(10)},     {200, BIT(10)},     },
-    [36] = {{200, BIT(10)},     {200, BIT(10)},     },
-    [37] = {{200, BIT(10)},     {200, BIT(10)},     },
-    [38] = {{200, BIT(5)},      {200, BIT(5)},      },
-    [42] = {{200, BIT(7)},      {200, BIT(7)},      },
-    [50] = {{200, BIT(10)},     {200, BIT(10)},     },
-    [52] = {{200, BIT(9)},      {200, BIT(9)},      },
-    [53] = {{200, BIT(9)},      {200, BIT(9)},      },
-    [54] = {{/* 2.00 SDIO */},  {/* 2.00 SDIO */},  },
-    [55] = {{200, BIT(8)},      {200, BIT(8)},      },
-    [56] = {{200, BIT(8)},      {200, BIT(8)},      },
-    [57] = {{200, BIT(10)},     {200, BIT(10)},     },
-    [58] = {{301, BIT(0)},      {200, BIT(0)},      },
-    [59] = {{301, BIT(0)},      {200, BIT(0)},      },
-    [60] = {{200, BIT_MANUF},   {/*?*/},            },
-    [61] = {{200, BIT_MANUF},   {/*?*/},            },
-    [62] = {{200, BIT_MANUF},   {/*?*/},            },
-    [63] = {{200, BIT_MANUF},   {/*?*/},            },
+     /*           SD                  SPI                 eMMC         */
+     [0] = {{200, BIT(0)},      {200, BIT(0)},      {451, BIT(0)}       },
+     [1] = {{301, BIT(0)},      {200, BIT(0)},      {451, BIT(0)}       },
+     [2] = {{200, BIT(0)},      {},                 {451, BIT(0)}       },
+     [3] = {{200, BIT(0)},      {},                 {451, BIT(0)}       },
+     [4] = {{200, BIT(0)},      {},                 {451, BIT(0)}       },
+     [5] = {{200, BIT(9)},      {200, BIT(9)},      {451, BIT(0)}       },
+     [6] = {{200, BIT(10)},     {200, BIT(10)},     {451, BIT(0)}       },
+     [7] = {{200, BIT(0)},      {},                 {451, BIT(0)}       },
+     [8] = {{200, BIT(0)},      {200, BIT(0)},      {451, BIT(0)}       },
+     [9] = {{200, BIT(0)},      {200, BIT(0)},      {451, BIT(0)}       },
+    [10] = {{200, BIT(0)},      {200, BIT(0)},      {451, BIT(0)}       },
+    [12] = {{200, BIT(0)},      {200, BIT(0)},      {451, BIT(0)}       },
+    [13] = {{200, BIT(0)},      {200, BIT(0)},      {451, BIT(0)}       },
+    [14] = {{200, BIT(0)},      {},                 {451, BIT(0)}       },
+    [15] = {{200, BIT(0)},      {},                 {451, BIT(0)}       },
+    [16] = {{200, BIT_2_4_7},   {200, BIT_2_4_7},   {451, BIT_2_4_7}    },
+    [17] = {{200, BIT(2)},      {200, BIT(2)},      {451, BIT(2)}       },
+    [18] = {{200, BIT(2)},      {200, BIT(2)},      {451, BIT(2)}       },
+    [19] = {{},                 {},                 {451, BIT(0)}       },
+    [21] = {{},                 {},                 {/* HS200 */}       },
+    [23] = {{301, BIT_2_4},     {},                 {/*BIT_2_4 ?*/}     },
+    [24] = {{200, BIT(4)},      {200, BIT(4)},      {451, BIT(4)}       },
+    [25] = {{200, BIT(4)},      {200, BIT(4)},      {451, BIT(4)}       },
+    [26] = {{200, BIT_MANUF},   {/*?*/},            {/*?*/}             },
+    [27] = {{200, BIT(4)},      {200, BIT(4)},      {451, BIT(4)}       },
+    [28] = {{200, BIT(6)},      {200, BIT(6)},      {451, BIT(6)}       },
+    [29] = {{200, BIT(6)},      {200, BIT(6)},      {451, BIT(6)}       },
+    [30] = {{200, BIT(6)},      {200, BIT(6)},      {451, BIT(6)}       },
+    [31] = {{},                 {},                 {451, BIT(6)}       },
+    [32] = {{200, BIT(5)},      {200, BIT(5)},      {}                  },
+    [33] = {{200, BIT(5)},      {200, BIT(5)},      {}                  },
+    [34] = {{200, BIT(10)},     {200, BIT(10)},     {}                  },
+    [35] = {{200, BIT(10)},     {200, BIT(10)},     {451, BIT(5)}       },
+    [36] = {{200, BIT(10)},     {200, BIT(10)},     {451, BIT(5)}       },
+    [37] = {{200, BIT(10)},     {200, BIT(10)},     {},                 },
+    [38] = {{200, BIT(5)},      {200, BIT(5)},      {451, BIT(5)}       },
+    [39] = {{},                 {},                 {451, BIT(9)}       },
+    [40] = {{},                 {},                 {451, BIT(9)}       },
+    [41] = {{},                 {},                 {/*451, BIT(7)*/}   },
+    [42] = {{200, BIT(7)},      {200, BIT(7)},      {451, BIT(4)}       },
+    [44] = {{},                 {},                 {501, BIT(10)}      },
+    [45] = {{},                 {},                 {501, BIT(10)}      },
+    [46] = {{},                 {},                 {501, BIT(10)}      },
+    [47] = {{},                 {},                 {501, BIT(10)}      },
+    [48] = {{},                 {},                 {501, BIT(10)}      },
+    [49] = {{},                 {},                 {451, BIT(4)}       },
+    [50] = {{200, BIT(10)},     {200, BIT(10)},     {}                  },
+    [52] = {{200, BIT(9)},      {200, BIT(9)},      {}                  },
+    [53] = {{200, BIT(9)},      {200, BIT(9)},      {451, BIT(10)}      },
+    [54] = {{/* 2.00 SDIO */},  {/* 2.00 SDIO */},  {451, BIT(10)}      },
+    [55] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(8)}       },
+    [56] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(8)}       },
+    [57] = {{200, BIT(10)},     {200, BIT(10)},     {}                  },
+    [58] = {{301, BIT(0)},      {200, BIT(0)},      {}                  },
+    [59] = {{301, BIT(0)},      {200, BIT(0)},      {}                  },
+    [60] = {{200, BIT_MANUF},   {/*?*/},            {/*?*/}             },
+    [61] = {{200, BIT_MANUF},   {/*?*/},            {/*?*/}             },
+    [62] = {{200, BIT_MANUF},   {/*?*/},            {/*?*/}             },
+    [63] = {{200, BIT_MANUF},   {/*?*/},            {/*?*/}             },
 }, acmd_supported[SDCARD_CMD_MAX] = {
-     /*           SD                  SPI          */
-     [6] = {{200, BIT(8)},      {},                 },
-    [13] = {{200, BIT(8)},      {200, BIT(8)},      },
-    [18] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [22] = {{200, BIT(8)},      {200, BIT(8)},      },
-    [23] = {{200, BIT(8)},      {200, BIT(8)},      },
-    [25] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [26] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [38] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [41] = {{200, BIT(8)},      {200, BIT(8)},      },
-    [42] = {{200, BIT(8)},      {200, BIT(8)},      },
-    [43] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [44] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [45] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [46] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [47] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [48] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [49] = {{200, BIT_SECU},    {200, BIT_SECU},    },
-    [51] = {{200, BIT(8)},      {200, BIT(8)},      },
+     /*           SD                  SPI                 eMMC         */
+     [6] = {{200, BIT(8)},      {},                 {451, BIT(0)}       },
+    [13] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(0)}       },
+    [18] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [22] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(4)}       },
+    [23] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(4)}       },
+    [25] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [26] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [38] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [41] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(8)}       },
+    [42] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(0)}       },
+    [43] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [44] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [45] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [46] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [47] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [48] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [49] = {{200, BIT_SECU},    {200, BIT_SECU},    {451, BIT(0)}       },
+    [51] = {{200, BIT(8)},      {200, BIT(8)},      {451, BIT(8)}       },
 };
 
 static const char *spec_version_name(uint16_t spec_version)
@@ -378,8 +399,14 @@ static const char *spec_version_name(uint16_t spec_version)
     switch (spec_version) {
     case SD_PHY_SPEC_VER_2_00:
         return "v2.00";
+    case MMC_SPEC_VER_2_2:
+        return "v2.2";
     case SD_PHY_SPEC_VER_3_01:
         return "v3.01";
+    case MMC_SPEC_VER_4_51:
+        return "v4.51";
+    case MMC_SPEC_VER_5_1:
+        return "v5.1";
     default:
         g_assert_not_reached();
     }
@@ -397,6 +424,9 @@ static bool cmd_version_supported(SDState *sd, uint8_t cmd, bool is_acmd)
     case PROTO_SPI:
         cmd_version = cmdset[cmd].spi.version;
         break;
+    case PROTO_MMC:
+        cmd_version = cmdset[cmd].mmc.version;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -424,6 +454,9 @@ static bool cmd_class_supported(SDState *sd, uint8_t cmd, uint8_t class,
         /* class 1, 3 and 9 are not supported in SPI mode */
         cmd_ccc_mask = cmdset[cmd].spi.ccc_mask;
         break;
+    case PROTO_MMC:
+        cmd_ccc_mask = cmdset[cmd].mmc.ccc_mask;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -602,7 +635,7 @@ static void sd_reset_csd(SDState *sd, uint64_t size)
 
 static void sd_reset_rca(SDState *sd)
 {
-    sd->rca = 0;
+    sd->rca = sd->bus_protocol == PROTO_MMC;
 }
 
 static void sd_set_rca(SDState *sd)
@@ -907,6 +940,9 @@ static SDState *sdcard_init(BlockBackend *blk, sd_bus_protocol_t bus_protocol)
     case PROTO_SPI:
         qdev_prop_set_bit(dev, "spi", true);
         break;
+    case PROTO_MMC:
+        qdev_prop_set_bit(dev, "mmc", true);
+        break;
     default:
         break;
     }
@@ -2163,7 +2199,11 @@ static void sd_realize(DeviceState *dev, Error **errp)
     int ret;
 
     sd->proto_name = sd_protocol_name(sd->bus_protocol);
-    sd->spec_version = SD_PHY_SPEC_VER_2_00;
+    if (sd->bus_protocol == PROTO_MMC) {
+        sd->spec_version = MMC_SPEC_VER_4_51;
+    } else {
+        sd->spec_version = SD_PHY_SPEC_VER_2_00;
+    }
 
     if (sd->blk && blk_is_read_only(sd->blk)) {
         error_setg(errp, "Cannot use read-only drive as SD card");
@@ -2209,6 +2249,7 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BIT("spi", SDState, bus_protocol, 1, false),
+    DEFINE_PROP_BIT("mmc", SDState, bus_protocol, 2, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.15.1
