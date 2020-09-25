Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5597C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCB32076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zT3p1w6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCB32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnTT-0004OH-DN
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJc-0002QT-Qz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJa-0002GH-Kk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so3550056wrv.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L9eT1oZ9PgrU1jdXi7fYi4acA1czIwdtwVY/kAyMWRU=;
 b=zT3p1w6zUFNJ20/+EwFBQqMR+Y5rKNFb9ZY04ww0i/XqWnq5j5v4z8NxLDJBr+Us/1
 wTdtmpy4LKMBgniZ9C6xNXpgGff8U/mvjX+cd3niKGQnc1c6FcFUXXpDawolWTT4E5b4
 0FmTYLVplO2F+SbcpE8R4a1vX6BW0O4nWnr6dDex7VK7Qqx4vDo1f7QPh60180QERAyk
 NNIgjw04m/V0krJh01tzmrUP5XXxMiv+4PDk0RXDSN06k6VMbJ1jE8RI3M13G4FSwOXr
 9waI5ISaS3T8Rcpfv7dQxKijf2l38ytY5793syneVyry9t1rp88sisn/yqDIpoayZ5DL
 /WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L9eT1oZ9PgrU1jdXi7fYi4acA1czIwdtwVY/kAyMWRU=;
 b=IR/Clz/IW6FXzyXy9+ASefnRb6OxjWNiCJJIlcvJUB737rEKw778z3lhDHxxnNxpZj
 u0AyGhOiPyH6gESSTnM6k1W8No+AGBP6q0ZUH3EwkJM8BIGfXTpEeZyHZWmqDTSgo1CC
 szptp8dovbWBtJ1Ue7c8I7NdjAC4jvqCoQGxj03Y12eM0zDXCnV4ko+yIi9BRC79f0pm
 ndK6Czrx/smt+cnPI3AAhlF5UXfLQ7t2G4cmzJz10fsO94PsXFQk5BE/f1UOQtC5PXpm
 Ew4nk06JLlULZYeYse6CapsiqURaBvGr5KWPzn+FVonVYqFDWzyt/UCSlqAGizZNR5Yu
 kQNA==
X-Gm-Message-State: AOAM533eZsO755RF8NwdGwToV4YTSmPL0o9aeSVOD/Qz0h1FAXVNxNqq
 nyjdJ3jB3uj97xUPYcoz13xR7w==
X-Google-Smtp-Source: ABdhPJy5z2JTSE7xjlqn9lmm3x6ZThm35XF11X2xktR9qINldTWdDf5oKrIdHbtjdTA4P0VidpRpFw==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr4373496wrw.253.1601038744992; 
 Fri, 25 Sep 2020 05:59:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u63sm2867369wmb.13.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A112E1FF9E;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 15/19] tools/vhost-user-rpmb: implement
 VIRTIO_RPMB_REQ_DATA_WRITE
Date: Fri, 25 Sep 2020 13:51:43 +0100
Message-Id: <20200925125147.26943-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this command we are finally updating data to the backing store
and cycling the write_count and each successful write. We also include
the write count in all response frames as the spec is a little unclear
but the example test code expected it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 111 +++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 6 deletions(-)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 88747c50fa44..a17c3b4bcc4e 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -62,6 +62,7 @@ enum {
 #define KiB     (1UL << 10)
 #define MAX_RPMB_SIZE (KiB * 128 * 256)
 #define RPMB_KEY_MAC_SIZE 32
+#define RPMB_BLOCK_SIZE 256
 
 /* RPMB Request Types */
 #define VIRTIO_RPMB_REQ_PROGRAM_KEY        0x0001
@@ -100,7 +101,7 @@ struct virtio_rpmb_config {
 struct virtio_rpmb_frame {
     uint8_t stuff[196];
     uint8_t key_mac[RPMB_KEY_MAC_SIZE];
-    uint8_t data[256];
+    uint8_t data[RPMB_BLOCK_SIZE];
     uint8_t nonce[16];
     /* remaining fields are big-endian */
     uint32_t write_counter;
@@ -124,6 +125,7 @@ typedef struct VuRpmb {
     uint8_t  last_nonce[16];
     uint16_t last_result;
     uint16_t last_reqresp;
+    uint16_t last_address;
     uint32_t write_count;
 } VuRpmb;
 
@@ -239,17 +241,30 @@ vrpmb_set_config(VuDev *dev, const uint8_t *data,
  * which itself uses a 3 clause BSD chunk of code.
  */
 
+static const int rpmb_frame_dlen = (sizeof(struct virtio_rpmb_frame) -
+                                    offsetof(struct virtio_rpmb_frame, data));
+
 static void vrpmb_update_mac_in_frame(VuRpmb *r, struct virtio_rpmb_frame *frm)
 {
     hmac_sha256_ctx ctx;
-    static const int dlen = (sizeof(struct virtio_rpmb_frame) -
-                             offsetof(struct virtio_rpmb_frame, data));
 
     hmac_sha256_init(&ctx, r->key, RPMB_KEY_MAC_SIZE);
-    hmac_sha256_update(&ctx, frm->data, dlen);
+    hmac_sha256_update(&ctx, frm->data, rpmb_frame_dlen);
     hmac_sha256_final(&ctx, &frm->key_mac[0], 32);
 }
 
+static bool vrpmb_verify_mac_in_frame(VuRpmb *r, struct virtio_rpmb_frame *frm)
+{
+    hmac_sha256_ctx ctx;
+    uint8_t calculated_mac[RPMB_KEY_MAC_SIZE];
+
+    hmac_sha256_init(&ctx, r->key, RPMB_KEY_MAC_SIZE);
+    hmac_sha256_update(&ctx, frm->data, rpmb_frame_dlen);
+    hmac_sha256_final(&ctx, calculated_mac, RPMB_KEY_MAC_SIZE);
+
+    return memcmp(calculated_mac, frm->key_mac, RPMB_KEY_MAC_SIZE) == 0;
+}
+
 /*
  * Handlers for individual control messages
  */
@@ -324,6 +339,82 @@ vrpmb_handle_get_write_counter(VuDev *dev, struct virtio_rpmb_frame *frame)
     return resp;
 }
 
+/*
+ * vrpmb_handle_write:
+ *
+ * We will report the success/fail on receipt of
+ * VIRTIO_RPMB_REQ_RESULT_READ. Returns the number of extra frames
+ * processed in the request.
+ */
+static int vrpmb_handle_write(VuDev *dev, struct virtio_rpmb_frame *frame)
+{
+    VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
+    int extra_frames = 0;
+    uint16_t block_count = be16toh(frame->block_count);
+    uint32_t write_counter = be32toh(frame->write_counter);
+    size_t offset;
+
+    r->last_reqresp = VIRTIO_RPMB_RESP_DATA_WRITE;
+    r->last_address = be16toh(frame->address);
+    offset =  r->last_address * RPMB_BLOCK_SIZE;
+
+    /*
+     * Run the checks from:
+     * 5.12.6.1.3 Device Requirements: Device Operation: Data Write
+     */
+    if (!r->key) {
+        g_warning("no key programmed");
+        r->last_result = VIRTIO_RPMB_RES_NO_AUTH_KEY;
+    } else if (block_count == 0 ||
+               block_count > r->virtio_config.max_wr_cnt) {
+        r->last_result = VIRTIO_RPMB_RES_GENERAL_FAILURE;
+    } else if (false /* what does an expired write counter mean? */) {
+        r->last_result = VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED;
+    } else if (offset > (r->virtio_config.capacity * (128 * KiB))) {
+        r->last_result = VIRTIO_RPMB_RES_ADDR_FAILURE;
+    } else if (!vrpmb_verify_mac_in_frame(r, frame)) {
+        r->last_result = VIRTIO_RPMB_RES_AUTH_FAILURE;
+    } else if (write_counter != r->write_count) {
+        r->last_result = VIRTIO_RPMB_RES_COUNT_FAILURE;
+    } else {
+        int i;
+        /* At this point we have a valid authenticated write request
+         * so the counter can incremented and we can attempt to
+         * update the backing device.
+         */
+        r->write_count++;
+        for (i = 0; i < block_count; i++) {
+            void *blk = r->flash_map + offset;
+            g_debug("%s: writing block %d", __func__, i);
+            if (mprotect(blk, RPMB_BLOCK_SIZE, PROT_WRITE) != 0) {
+                r->last_result =  VIRTIO_RPMB_RES_WRITE_FAILURE;
+                break;
+            }
+            memcpy(blk, frame[i].data, RPMB_BLOCK_SIZE);
+            if (msync(blk, RPMB_BLOCK_SIZE, MS_SYNC) != 0) {
+                g_warning("%s: failed to sync update", __func__);
+                r->last_result = VIRTIO_RPMB_RES_WRITE_FAILURE;
+                break;
+            }
+            if (mprotect(blk, RPMB_BLOCK_SIZE, PROT_READ) != 0) {
+                g_warning("%s: failed to re-apply read protection", __func__);
+                r->last_result = VIRTIO_RPMB_RES_GENERAL_FAILURE;
+                break;
+            }
+            offset += RPMB_BLOCK_SIZE;
+        }
+        r->last_result = VIRTIO_RPMB_RES_OK;
+        extra_frames = i - 1;
+    }
+
+    g_info("%s: %s (%x, %d extra frames processed), write_count=%d", __func__,
+           r->last_result == VIRTIO_RPMB_RES_OK ? "successful":"failed",
+           r->last_result, extra_frames, r->write_count);
+
+    return extra_frames;
+}
+
+
 /*
  * Return the result of the last message. This is only valid if the
  * previous message was VIRTIO_RPMB_REQ_PROGRAM_KEY or
@@ -339,10 +430,14 @@ static struct virtio_rpmb_frame * vrpmb_handle_result_read(VuDev *dev)
     g_info("%s: for request:%x result:%x", __func__,
            r->last_reqresp, r->last_result);
 
-    if (r->last_reqresp == VIRTIO_RPMB_RESP_PROGRAM_KEY ||
-        r->last_reqresp == VIRTIO_RPMB_REQ_DATA_WRITE) {
+    if (r->last_reqresp == VIRTIO_RPMB_RESP_PROGRAM_KEY) {
         resp->result = htobe16(r->last_result);
         resp->req_resp = htobe16(r->last_reqresp);
+    } else if (r->last_reqresp == VIRTIO_RPMB_RESP_DATA_WRITE) {
+        resp->result = htobe16(r->last_result);
+        resp->req_resp = htobe16(r->last_reqresp);
+        resp->write_counter = htobe32(r->write_count);
+        resp->address = htobe16(r->last_address);
     } else {
         resp->result = htobe16(VIRTIO_RPMB_RES_GENERAL_FAILURE);
     }
@@ -445,6 +540,10 @@ vrpmb_handle_ctrl(VuDev *dev, int qidx)
                               __func__);
                 }
                 break;
+            case VIRTIO_RPMB_REQ_DATA_WRITE:
+                /* we can have multiple blocks handled */
+                n += vrpmb_handle_write(dev, f);
+                break;
             default:
                 g_debug("un-handled request: %x", f->req_resp);
                 break;
-- 
2.20.1


