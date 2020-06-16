Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA473C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977D5207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977D5207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC6t-0004ES-RD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1o-00027S-Mb; Tue, 16 Jun 2020 09:53:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:36222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlC1m-0002QN-5B; Tue, 16 Jun 2020 09:53:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 81994748DCC;
 Tue, 16 Jun 2020 15:53:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D4E6A748DD9; Tue, 16 Jun 2020 15:53:17 +0200 (CEST)
Message-Id: <681515f214d7b0a8553be509dcba3d8a9085082d.1592315226.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592315226.git.balaton@eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 10/11] WIP macio/cuda: Attempt to add i2c support
Date: Tue, 16 Jun 2020 15:47:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 09:53:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a non-working RFC patch attempt to implement i2c bus in CUDA
needed for firmware to access SPD data of installed RAM. The skeleton
is there but actual operation fails because I don't know how this is
supposed to work and the i2c bus state becomes invalid quickly. Also
sending back results may be missing or wrong. Help fixing and
finishing this is welcome, I don't plan to spend more time with this
so just submitted it for whoever picks this up.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/misc/macio/cuda.c         | 62 +++++++++++++++++++++++++++++++++++-
 include/hw/misc/macio/cuda.h |  1 +
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 47aa3b0552..cfe4713527 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -28,6 +28,7 @@
 #include "hw/ppc/mac.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "hw/i2c/i2c.h"
 #include "hw/input/adb.h"
 #include "hw/misc/mos6522.h"
 #include "hw/misc/macio/cuda.h"
@@ -371,6 +372,61 @@ static bool cuda_cmd_set_time(CUDAState *s,
     return true;
 }
 
+static bool cuda_cmd_get_set_iic(CUDAState *s,
+                                 const uint8_t *in_data, int in_len,
+                                 uint8_t *out_data, int *out_len)
+{
+    int i;
+
+    qemu_log_mask(LOG_UNIMP, "CUDA: unimplemented GET_SET_IIC %s 0x%x %d\n",
+                  (in_data[0] & 1 ? "read" : "write"), in_data[0] >> 1,
+                  in_len);
+    if (i2c_start_transfer(s->i2c_bus, in_data[0] >> 1, in_data[0] & 1)) {
+        return false;
+    }
+    for (i = 0; i < in_len - 3; i++) {
+        if (i2c_send(s->i2c_bus, in_data[i])) {
+            i2c_end_transfer(s->i2c_bus);
+            return false;
+        }
+    }
+    return true;
+}
+
+static bool cuda_cmd_combined_iic(CUDAState *s,
+                                  const uint8_t *in_data, int in_len,
+                                  uint8_t *out_data, int *out_len)
+{
+    int i;
+
+    if (in_len < 3) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CUDA: COMBINED_FORMAT_IIC too few input bytes\n");
+        return false;
+    }
+    if ((in_data[0] & 0xfe) != (in_data[2] & 0xfe)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "CUDA: COMBINED_FORMAT_IIC address mismatch\n");
+        return false;
+    }
+
+    uint8_t data = in_data[1];
+    if (i2c_start_transfer(s->i2c_bus, in_data[0] >> 1, in_data[0] & 1) ||
+        i2c_send_recv(s->i2c_bus, &data, in_data[0] & 1)) {
+        return false;
+    } else {
+        for (i = 0; i < in_len - 3; i++) {
+            data = in_data[3 + i];
+            if (i2c_send_recv(s->i2c_bus, (in_data[2] & 1 ? &out_data[i] :
+                              &data), in_data[2] & 1)) {
+                i2c_end_transfer(s->i2c_bus);
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 static const CudaCommand handlers[] = {
     { CUDA_AUTOPOLL, "AUTOPOLL", cuda_cmd_autopoll },
     { CUDA_SET_AUTO_RATE, "SET_AUTO_RATE",  cuda_cmd_set_autorate },
@@ -383,6 +439,8 @@ static const CudaCommand handlers[] = {
       cuda_cmd_set_power_message },
     { CUDA_GET_TIME, "GET_TIME", cuda_cmd_get_time },
     { CUDA_SET_TIME, "SET_TIME", cuda_cmd_set_time },
+    { CUDA_GET_SET_IIC, "GET_SET_IIC", cuda_cmd_get_set_iic },
+    { CUDA_COMBINED_FORMAT_IIC, "COMBINED_FORMAT_IIC", cuda_cmd_combined_iic },
 };
 
 static void cuda_receive_packet(CUDAState *s,
@@ -553,6 +611,7 @@ static void cuda_init(Object *obj)
 {
     CUDAState *s = CUDA(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    DeviceState *dev = DEVICE(obj);
 
     object_initialize_child(obj, "mos6522-cuda", &s->mos6522_cuda,
                             TYPE_MOS6522_CUDA);
@@ -561,7 +620,8 @@ static void cuda_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mem);
 
     qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
-                        DEVICE(obj), "adb.0");
+                        dev, "adb.0");
+    s->i2c_bus = i2c_init_bus(dev, "i2c");
 }
 
 static Property cuda_properties[] = {
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 5768075ac5..0c798100dc 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -79,6 +79,7 @@ typedef struct CUDAState {
 
     ADBBusState adb_bus;
     MOS6522CUDAState mos6522_cuda;
+    I2CBus *i2c_bus;
 
     uint32_t tick_offset;
     uint64_t tb_frequency;
-- 
2.21.3


