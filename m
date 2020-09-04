Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA75C2BB84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C131206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="d202gZnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C131206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECg1-00077f-EN
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaM-0003Mm-HH; Fri, 04 Sep 2020 10:21:02 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaK-0002jC-M7; Fri, 04 Sep 2020 10:21:02 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 6ECC3BFAFF;
 Fri,  4 Sep 2020 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229234;
 bh=ghTHzL0RGC/yyl0C9NlaoYrGykOslGwT28dRWldXulQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d202gZnCwAOlL/ykE0opM+Iadinc+JeMZPfEi81ds9GlG/gB0yWPpEs9BwKonhfNX
 xBQkSWlaQhBl56vVvwIeqVQbEAcECdFmtOn9dkUEoDAqQ2yBzfqf0E5lMgqNgG5hOz
 ShHD+xJeI5mrru3EHc0rk0tpovU1UpU4mEr0gdEg/Zn4IdQMnmroCyZmn3CC9//VQd
 5sWapkp5xAU+EtgiDMAwcB8ASDILOybQtYT1FOqcxzwbEGbAvFWSSC86ySJcKyaAb2
 pmGbKhIAEAWPwF+Bs7k99LdPJE2xnmDRFCngdbTvp522MnKxEyyvxmAtqzN+Cvlxm3
 uVlRgndplfw/Q==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/17] hw/block/nvme: default request status to success
Date: Fri,  4 Sep 2020 16:19:48 +0200
Message-Id: <20200904141956.576630-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Make the default request status NVME_SUCCESS so only error status codes
has to be set.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3e32f39c7c1d..64c8f232e3ea 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -231,6 +231,7 @@ static void nvme_req_clear(NvmeRequest *req)
 {
     req->ns = NULL;
     memset(&req->cqe, 0x0, sizeof(req->cqe));
+    req->status = NVME_SUCCESS;
 }
 
 static void nvme_req_exit(NvmeRequest *req)
@@ -547,8 +548,6 @@ static void nvme_process_aers(void *opaque)
         result->log_page = event->result.log_page;
         g_free(event);
 
-        req->status = NVME_SUCCESS;
-
         trace_pci_nvme_aer_post_cqe(result->event_type, result->event_info,
                                     result->log_page);
 
@@ -713,7 +712,6 @@ static void nvme_aio_cb(void *opaque, int ret)
 
     if (!ret) {
         block_acct_done(stats, acct);
-        req->status = NVME_SUCCESS;
     } else {
         uint16_t status;
 
-- 
2.28.0


