Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D62C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399DF2076B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/4+NjmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399DF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnVU-00070j-3w
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJe-0002V5-H3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJc-0002GW-JB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so3500833wrx.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uzbbYkb4NnbTBJGCofcpI1INW2euUpldKIpyeVgpePE=;
 b=G/4+NjmMBCwOaEnAD8G4WHhVWosqSJutwj2jU41+Wz3f+z5Pu+x3w+Apvq4vw/gI6v
 OWEZlnT5uP58hV4MyLlM6VfpFHdnUJ4oqdaUQf4zXdNX3SOuQgljdobicUopdh9+6Ttb
 tXUTPX9pd8fHN81fYhE73C+f0Vr4nbSfPJs/eTSm7mBApwHMwISTgoEUPS1o/1aTGy59
 Ly1MU/lRmWaDwMuBlaDKximatvYG0mrhUzV1I42Ya1KBavcxdPG4gy+D1vTEfCiEcnNY
 0b0zurgjWbBhlZV/04f0ObAWGAtX/EUic+h5M9zvFuDlqSnXZHFaMy2ek4+dRMByrReH
 XEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uzbbYkb4NnbTBJGCofcpI1INW2euUpldKIpyeVgpePE=;
 b=JdkuRMINdU1TX4ZOidrCAn93NmhK6xGD6kINi6LCGvTdv6VCw/pTUmJ6kWk8b/M/at
 /V6nr8IkzMU/rVZFiZTVfbdxytib9r8sJ4xrPFB065GiiGv9jdjwTi52KVaxS0r3JfM8
 cGnuiBX8QE/RgjblD48Zl78NUy0TH1h3vS5rNHHeW+S0kc8aIem6dp85b0aYVIO5J93+
 RxOLNEquceq5HnaPVByZCCCXqPB0NdFQiSZyrzpgV0PaU17ydWAItBFXeV/iaSrQPxaN
 ZMQ88hFl/7SoQ/YkUX4f/OpV+WC6zwZBrqHVjebPGmPLW30jTSa0L02JdBtEgK7eT2yM
 Uz/Q==
X-Gm-Message-State: AOAM533IvYLjrNGQl57h1sYHsNSDRUQDYSy7WUn9DeBaclDQc/ZPT5UC
 3DHkYk8Qq8gtQlcJOOczKPJ4sg==
X-Google-Smtp-Source: ABdhPJy8Ipyz4jx7i9Y+XtUqRtfhW1VyFR6m8SCZSQPxBY5fr63M/xHX3v8k/G7hF1I7i6WrR75kfg==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr4392648wrs.230.1601038747151; 
 Fri, 25 Sep 2020 05:59:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a17sm3054427wra.24.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5F5C1FF9F;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 16/19] tools/vhost-user-rpmb: implement
 VIRTIO_RPMB_REQ_DATA_READ
Date: Fri, 25 Sep 2020 13:51:44 +0100
Message-Id: <20200925125147.26943-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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

The read command is a lot simpler to implement. However the spec does
specify you can only read a single block at a time so we limit it to
that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index a17c3b4bcc4e..49d4e00b24a9 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -414,6 +414,55 @@ static int vrpmb_handle_write(VuDev *dev, struct virtio_rpmb_frame *frame)
     return extra_frames;
 }
 
+/*
+ * vrpmb_handle_read:
+ *
+ * Unlike the write operation we return a frame with the result of the
+ * read here. While the config specifies a maximum read count the spec
+ * is limited to a single read at a time.
+ */
+static struct virtio_rpmb_frame *
+vrpmb_handle_read(VuDev *dev, struct virtio_rpmb_frame *frame)
+{
+    VuRpmb *r = container_of(dev, VuRpmb, dev.parent);
+    size_t offset = be16toh(frame->address) * RPMB_BLOCK_SIZE;
+    uint16_t block_count = be16toh(frame->block_count);
+    struct virtio_rpmb_frame *resp = g_new0(struct virtio_rpmb_frame, 1);
+
+    resp->req_resp = htobe16(VIRTIO_RPMB_RESP_DATA_READ);
+    resp->address = frame->address;
+    resp->block_count = htobe16(1);
+
+    /*
+     * Run the checks from:
+     * 5.12.6.1.4 Device Requirements: Device Operation: Data Read
+     */
+    if (!r->key) {
+        g_warning("no key programmed");
+        resp->result = htobe16(VIRTIO_RPMB_RES_NO_AUTH_KEY);
+    } else if (block_count != 1) {
+        /*
+         * Despite the config the spec only allows for reading one
+         * block at a time: "If block count has not been set to 1 then
+         * VIRTIO_RPMB_RES_GENERAL_FAILURE SHOULD be responded as
+         * result."
+         */
+        resp->result = htobe16(VIRTIO_RPMB_RES_GENERAL_FAILURE);
+    } else if (offset > (r->virtio_config.capacity * (128 * KiB))) {
+        resp->result = htobe16(VIRTIO_RPMB_RES_ADDR_FAILURE);
+    } else {
+        void *blk = r->flash_map + offset;
+        g_debug("%s: reading block from %p (%zu)", __func__, blk, offset);
+        memcpy(resp->data, blk, RPMB_BLOCK_SIZE);
+        resp->result = htobe16(VIRTIO_RPMB_RES_OK);
+    }
+
+    /* Final housekeeping, copy nonce and calculate MAC */
+    memcpy(&resp->nonce, &frame->nonce, sizeof(frame->nonce));
+    vrpmb_update_mac_in_frame(r, resp);
+
+    return resp;
+}
 
 /*
  * Return the result of the last message. This is only valid if the
@@ -544,6 +593,9 @@ vrpmb_handle_ctrl(VuDev *dev, int qidx)
                 /* we can have multiple blocks handled */
                 n += vrpmb_handle_write(dev, f);
                 break;
+            case VIRTIO_RPMB_REQ_DATA_READ:
+                resp = vrpmb_handle_read(dev, f);
+                break;
             default:
                 g_debug("un-handled request: %x", f->req_resp);
                 break;
-- 
2.20.1


