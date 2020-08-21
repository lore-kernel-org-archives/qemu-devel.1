Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FC3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F2A20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzxDxSo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F2A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DBY-0006ty-Vs
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7d-0007JC-J2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7b-0002je-PZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TqZzm1Kvd50b3ZJamR+XAsrd85Z+ArcaWN9nI9tRp0=;
 b=hzxDxSo/QBQ17I5ZviNgB94seswQsw1yQvGEJQUJ5gMRjuN83MpHBsAd8ekR05NYHfO9V8
 KBXNGK4dLh9tsc9EiT1wZr5tlf0J0JrmviCk5HivDRQz01DOFUq8mR1Hb3zPzfrMndEKCc
 skmNxYjY/doTB6ThqHmVGNMGlM48ps8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Jz9p_Fr_N6mtjlUWZfNcxg-1; Fri, 21 Aug 2020 15:54:41 -0400
X-MC-Unique: Jz9p_Fr_N6mtjlUWZfNcxg-1
Received: by mail-wr1-f70.google.com with SMTP id g3so770360wrx.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1TqZzm1Kvd50b3ZJamR+XAsrd85Z+ArcaWN9nI9tRp0=;
 b=mApFwifdrpb7LtPt3jZG7VG1z2S9FeL0n+FXfCHPHU3sl+yH2pKTXR9Pi7FRT7GZ3n
 l3yo2f98wb/luHVLRmhg5b3wAmu2YMYsWsAPM7KjhDM8VvESNjZKY7s6L9xFtV9pKrsA
 5Md4GYoZg6H8UitJ5JH7P7aA/lUgCUqwbjlSi/2LO8KPSze385C9w4z/FQVgXZafqvTk
 QeXHOLWU1RfmHQNlu1dp8BbaKJOZ1/9o4BWRQ1JAQwd3RK2/6uzyqXxYl66nWz7R390c
 pRkHIjP7Xa62xLjqOFGlq2nnIW+WxehDZNlP0J+mmPSHPgtOna8yVxA+eREE1UsUr00S
 XKRw==
X-Gm-Message-State: AOAM533lcSpomrtof2OqOXRS29iGFAQPWRmMp45CMAEg6c5lprn7A69Z
 S4lJWPByIsgJU6oxtRPWHHEAJJbNNApkDNnbfCWYficKLeLVg1H+dBc24gISNrMrD/jDw1ziPg6
 5gTsR7CHU+Vb0z1s=
X-Received: by 2002:a5d:674d:: with SMTP id l13mr3033049wrw.151.1598039678992; 
 Fri, 21 Aug 2020 12:54:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXEDpU04L/pwxn5Vq4df9EyeTE366/9PgNpkk/3FzixxwU6X+Ot6X9KZ19WFPIlxBj5mwqZg==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr3033043wrw.151.1598039678806; 
 Fri, 21 Aug 2020 12:54:38 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t23sm6727668wra.74.2020.08.21.12.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/15] block/nvme: Rename local variable
Date: Fri, 21 Aug 2020 21:53:51 +0200
Message-Id: <20200821195359.1285345-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to modify the code in the next commit. Renaming
the 'resp' variable to 'id' first makes the next commit easier
to review. No logical changes.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 419178adda3..15c5202c03c 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -510,8 +510,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     NvmeIdCtrl *idctrl;
     NvmeIdNs *idns;
+    uint8_t *id;
     NvmeLBAF *lbaf;
-    uint8_t *resp;
     uint16_t oncs;
     int r;
     uint64_t iova;
@@ -520,14 +520,14 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .cdw10 = cpu_to_le32(0x1),
     };
 
-    resp = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
-    if (!resp) {
+    id = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
+    if (!id) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
-    idctrl = (NvmeIdCtrl *)resp;
-    idns = (NvmeIdNs *)resp;
-    r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
+    idctrl = (NvmeIdCtrl *)id;
+    idns = (NvmeIdNs *)id;
+    r = qemu_vfio_dma_map(s->vfio, id, sizeof(NvmeIdCtrl), true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
@@ -554,8 +554,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(resp, 0, 4096);
-
+    memset(id, 0, 4096);
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
@@ -587,8 +586,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
     s->blkshift = lbaf->ds;
 out:
-    qemu_vfio_dma_unmap(s->vfio, resp);
-    qemu_vfree(resp);
+    qemu_vfio_dma_unmap(s->vfio, id);
+    qemu_vfree(id);
 }
 
 static bool nvme_poll_queues(BDRVNVMeState *s)
-- 
2.26.2


