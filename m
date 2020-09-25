Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46BBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F132076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFOBI8Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F132076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnVL-0006qR-By
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJl-0002dg-IP
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJi-0002Hd-Gk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so3525646wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kjcelvvovVPpABaKJSYVdSxl5UaJWqhfw0gOadK/FqU=;
 b=rFOBI8Z/RXPzGJ54j6yDyARsXqgXrWBJScBJqf9ABJFKS4dAg2QKZTqsQJ2e6b6XVL
 klf2Dfm1xFQGAAPaQFKYdDHmI2g6rKakJuzlIdVR/Jo1ycHmcurFG+nShetNucqKayf+
 9nL6g6xloQjox9U6xWTlVhh2alG5a9qNEZUvqJ0Y86VwBrnNMWmtjs3PNuS3wFCC2+Vk
 q95Kdzk0/5A4F5xPYWVDQi6Xhlfi/qh6/EySkqZZ5h8Y7DDhs1oh3dRKMyv802zPDGLI
 LCGCTS60G8uBxOxCb/PYZpBVt1hHMJuOv1MLBxM1POI3XUfYvu3HfIf76ymgi9Wqzedm
 y1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kjcelvvovVPpABaKJSYVdSxl5UaJWqhfw0gOadK/FqU=;
 b=V7FrC869FYX9voVrS6ylrxMzEJMAVc37kF901+DjihSulV9/pNc7A9ZdJ63ZMYfh1d
 bLooo4TyNFkMTgTi6gkhQrvSU8/p+OEKJp7aksbhHq0jVbfvCyfq/0vfIo8t1ox461DP
 DW1gKTCp6Hhtwbkh6agfBN9HFj+DUeu7DDx/tvKvxYu07TYD6hHlvBF99u0DVuKePc6Y
 tUFRZn91qGrNQhwJ6VvQNA6OD/vufAK2mWW15heuhjUohLDhptV2+AzP/Ms2O6JMmjo3
 nojlEaE6nhfupdGdvsdrzg6LTNFwf0IjmhNmjsJVmGTYPqIhSjG4RhPGRMtIZROA4OG4
 +1Ww==
X-Gm-Message-State: AOAM530bKe+oWM43+ZqQbyL5r/LcsDNCvZF0uE0xPH0g0tuSK2dZ0BWA
 S4Ixv8C6Hlm9lruWkqHb4JPFgg==
X-Google-Smtp-Source: ABdhPJz/pSEUzxyT825aVOOpaDQxurDcxtpN6iSAvnZnK6Jj718Enur34F0X+qcoNK0bh0dijaHmJg==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr4334999wrn.400.1601038753214; 
 Fri, 25 Sep 2020 05:59:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm2777107wme.11.2020.09.25.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BC0F1FF9D;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 14/19] tools/vhost-user-rpmb: implement
 VIRTIO_RPMB_REQ_GET_WRITE_COUNTER
Date: Fri, 25 Sep 2020 13:51:42 +0100
Message-Id: <20200925125147.26943-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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

This is the first function with an implied response that doesn't need
a VIRTIO_RPMB_REQ_RESULT_READ.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index 9c98f6916f6f..88747c50fa44 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -121,8 +121,10 @@ typedef struct VuRpmb {
     int flash_fd;
     void *flash_map;
     uint8_t *key;
+    uint8_t  last_nonce[16];
     uint16_t last_result;
     uint16_t last_reqresp;
+    uint32_t write_count;
 } VuRpmb;
 
 /* refer to util/iov.c */
@@ -286,6 +288,42 @@ static void vrpmb_handle_program_key(VuDev *dev, struct virtio_rpmb_frame *frame
     return;
 }
 
+/*
+ * vrpmb_handle_get_write_counter:
+ *
+ * We respond straight away with re-using the frame as sent.
+ */
+static struct virtio_rpmb_frame *
+vrpmb_handle_get_write_counter(VuDev *dev, struct virtio_rpmb_frame *frame)
+{
+    VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
+    struct virtio_rpmb_frame *resp = g_new0(struct virtio_rpmb_frame, 1);
+
+    /*
+     * Run the checks from:
+     * 5.12.6.1.2 Device Requirements: Device Operation: Get Write Counter
+     */
+
+    resp->req_resp = htobe16(VIRTIO_RPMB_RESP_GET_COUNTER);
+    if (!r->key) {
+        g_debug("no key programmed");
+        resp->result = htobe16(VIRTIO_RPMB_RES_NO_AUTH_KEY);
+        return resp;
+    } else if (be16toh(frame->block_count) > 1) { /* allow 0 (NONCONF) */
+        g_debug("invalid block count (%d)", be16toh(frame->block_count));
+        resp->result = htobe16(VIRTIO_RPMB_RES_GENERAL_FAILURE);
+    } else {
+        resp->write_counter = htobe32(r->write_count);
+    }
+    /* copy nonce */
+    memcpy(&resp->nonce, &frame->nonce, sizeof(frame->nonce));
+
+    /* calculate MAC */
+    vrpmb_update_mac_in_frame(r, resp);
+
+    return resp;
+}
+
 /*
  * Return the result of the last message. This is only valid if the
  * previous message was VIRTIO_RPMB_REQ_PROGRAM_KEY or
@@ -298,6 +336,9 @@ static struct virtio_rpmb_frame * vrpmb_handle_result_read(VuDev *dev)
     VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
     struct virtio_rpmb_frame *resp = g_new0(struct virtio_rpmb_frame, 1);
 
+    g_info("%s: for request:%x result:%x", __func__,
+           r->last_reqresp, r->last_result);
+
     if (r->last_reqresp == VIRTIO_RPMB_RESP_PROGRAM_KEY ||
         r->last_reqresp == VIRTIO_RPMB_REQ_DATA_WRITE) {
         resp->result = htobe16(r->last_result);
@@ -393,6 +434,9 @@ vrpmb_handle_ctrl(VuDev *dev, int qidx)
             case VIRTIO_RPMB_REQ_PROGRAM_KEY:
                 vrpmb_handle_program_key(dev, f);
                 break;
+            case VIRTIO_RPMB_REQ_GET_WRITE_COUNTER:
+                resp = vrpmb_handle_get_write_counter(dev, f);
+                break;
             case VIRTIO_RPMB_REQ_RESULT_READ:
                 if (!responded) {
                     resp = vrpmb_handle_result_read(dev);
-- 
2.20.1


