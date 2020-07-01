Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4775C20663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="dypFHAYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4775C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqd97-00067F-JE
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1jqaOc-000535-MD
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:55:18 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xieyongji@bytedance.com>)
 id 1jqaOZ-0002Uy-TJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:55:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id b92so10882774pjc.4
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LlJqlZJa7ZWuVtTSYOwar8XRwVNpJmGU+/htF3nvuQo=;
 b=dypFHAYmqjU0uE3H4VXv6wlJ6MuJlodOMcGBJJbZLDhC+V9MqP0QH3d33BU0Zs2+Ky
 2qc2Bf1Mfhy2UHwGaqPinTDYaN1wORuH+u5YSqj93rAA4ygxWDH4yPQzzv82fXzLa3+/
 cCRHXfBLuyT/OIh/tFdZdKon+wXV91ErNUW78gRCLn9gFJAXVQnCLqxMarGq/Fu2p9hm
 7tW+q+3QR5LkCJcA8onPPqJSoKjI/y4xITdvMokqERC2WwJag8HwpNeghpPdvWfLdbpU
 T4I8gdgIJgXsd5Bt1MD/75UongA0wC2az53Xfml6iIjAwfLui8YtqdOnAsSfisjMJJHI
 qO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LlJqlZJa7ZWuVtTSYOwar8XRwVNpJmGU+/htF3nvuQo=;
 b=XkfTfdse62tLmlAg3E3LBRtFI5tja6Zn1rWAjnQPAXCQXtKV3RdmQT/dltogMitmZR
 KEm3HECcE9c+DWAnyLeqd6SGKTNIaa2CA1VavCBNXl8y7b0weLsXD6ZB8a/pUbDMpROy
 NEIQsvlaAOaTFX1SmY2yIdBJYnfLO+kN2s+1bGs23EiLvbUi9J3HgEGGRV1m8Dqb6cRe
 KdEa6RkRAeIx4nZugqHEAMvzC3hgUpcUJag/efTxB9fwYHC8QMFYRN2FYcymBv7zxXiE
 eRAnn1f6gqgnrzcFZQTmEQ/FwOhkiEeS/I3ZYlA/oIVz67wJIZDA9pi4tYxv7DOyekee
 UDCw==
X-Gm-Message-State: AOAM531BhdzlkxVNwOmsBD5aOUkGD18iKXB2kuyQ/ck+/fW5/hsT9Oav
 M8VYaA4KPRhwsGVmimxgNnMX
X-Google-Smtp-Source: ABdhPJymDfvAJB3tXTh8DLtXb3+5/vZH0sAivmtzJBYc1gP8KykZLoJr8mu2kYvTi/NeYRxhFo3C6w==
X-Received: by 2002:a17:90b:f97:: with SMTP id
 ft23mr24007872pjb.21.1593600914613; 
 Wed, 01 Jul 2020 03:55:14 -0700 (PDT)
Received: from localhost ([103.136.221.66])
 by smtp.gmail.com with ESMTPSA id hg13sm4736522pjb.21.2020.07.01.03.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 03:55:14 -0700 (PDT)
From: Xie Yongji <xieyongji@bytedance.com>
To: pbonzini@redhat.com,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH 2/2] iscsi: return -EIO when sense fields are meaningless
Date: Wed,  1 Jul 2020 18:54:44 +0800
Message-Id: <20200701105444.3226-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701105444.3226-1-xieyongji@bytedance.com>
References: <20200701105444.3226-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=xieyongji@bytedance.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2020 09:50:45 -0400
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
Cc: xieyongji@bytedance.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 elohimes@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When an I/O request failed, now we only return correct
value on scsi check condition. We should also have a
default errno such as -EIO in other case.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 block/iscsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 2964c9f8d2..387ed872ef 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -241,9 +241,11 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 
     iTask->status = status;
     iTask->do_retry = 0;
+    iTask->err_code = 0;
     iTask->task = task;
 
     if (status != SCSI_STATUS_GOOD) {
+        iTask->err_code = -EIO;
         if (iTask->retries++ < ISCSI_CMD_RETRIES) {
             if (status == SCSI_STATUS_BUSY ||
                 status == SCSI_STATUS_TIMEOUT ||
-- 
2.11.0


