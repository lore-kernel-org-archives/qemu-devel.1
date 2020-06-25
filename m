Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD368206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnxnJhCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD368206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWxJ-0001RT-Sk
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvo-0007tj-VY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvn-0000xL-4e
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++38kJtX9k0JLhjdquKhWs3mX7Qkr34rNt494GRRank=;
 b=MnxnJhCePSPwHnn/BaL2L+FGB9FZR3Zjuh2lWQH8AKq+Fdogw1yldZSKOk39CB6zxzK2lk
 1VEYSHCfHxsZb4uDw3M0+F/Fh+hipSI/JczRCgQWhPDHbGq9gZpkx7fh6wuuZX4dQI9gBS
 fn93CSr/Qyuh+svq4r5tVlxgkbV0WSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-OXyif-SYOayi1UY7olRLBA-1; Thu, 25 Jun 2020 14:49:00 -0400
X-MC-Unique: OXyif-SYOayi1UY7olRLBA-1
Received: by mail-wm1-f69.google.com with SMTP id v6so5725108wmg.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=++38kJtX9k0JLhjdquKhWs3mX7Qkr34rNt494GRRank=;
 b=Pjqbg5F7P3izD8HwK440SlhccgrRXA9e/WRwwmSdHqCSMPyK4ie6u8ejxk+co8Iaq2
 RJTGLLo9vXSNG6nofTMoDu/k923xEGrqUTw6gJdbDpPpvJde9ndO8665iEXwCuDqAYAP
 1k5cvNCOvNyPj5SDGrMvI3xIfZtjH+2fkpxmMYNyNEU3a8dFor9TX0rCKApUiiB216y3
 lUz8p6OS8xh8TMU4YEWYPQlXPNZCPpDvWbmNsoadSutHv62F8jriP/7f6eBsDqvZbxVf
 CToSYccKQqrSyE9JQG69fFVxQcNDw3/fis1DrFIZFXdXDzwTahx2S7vf45LsvaHO51ML
 maCg==
X-Gm-Message-State: AOAM531M2TAx/Pl5E2dHMWzABnIyAFSVuLxG3pcfqMb67Nekefz3Hz7u
 NlORAAvTyfkbrb+6ABLvWqBCike9XfUQWz9Dhz9qxwRl4Is6FoXstErreRSh1Kxt/HCv8zZCu+k
 XSSL/N4wktrtdX2g=
X-Received: by 2002:a1c:790a:: with SMTP id l10mr4696092wme.80.1593110939415; 
 Thu, 25 Jun 2020 11:48:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiHMQn3r4Gaj/rwVZ+u7W4xq+Xm13Vg31DrBxfxhHFfnjgHPeM3ijP8irZ99+sKkU9/OrSBg==
X-Received: by 2002:a1c:790a:: with SMTP id l10mr4696073wme.80.1593110939255; 
 Thu, 25 Jun 2020 11:48:59 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w2sm22168661wrs.77.2020.06.25.11.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:48:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 04/17] block/nvme: Be explicit we share NvmeIdCtrl / NvmeIdNs
 structures
Date: Thu, 25 Jun 2020 20:48:25 +0200
Message-Id: <20200625184838.28172-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We allocate an unique chunk of memory then use it for two
different structures. Introduce the 'idsz_max' variable to
hold the maximum size, to make it clearer the size is enough
to hold the two structures.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
FIXME: reword with something that makes more sense...
---
 block/nvme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 71f8cf27a8..ffda804a8e 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -438,6 +438,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     NvmeIdCtrl *idctrl;
     NvmeIdNs *idns;
+    size_t idsz_max;
     NvmeLBAF *lbaf;
     uint8_t *resp;
     uint16_t oncs;
@@ -448,14 +449,15 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .cdw10 = cpu_to_le32(0x1),
     };
 
-    resp = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
+    idsz_max = MAX_CONST(sizeof(NvmeIdCtrl), sizeof(NvmeIdNs));
+    resp = qemu_try_blockalign0(bs, idsz_max);
     if (!resp) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
     idctrl = (NvmeIdCtrl *)resp;
     idns = (NvmeIdNs *)resp;
-    r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
+    r = qemu_vfio_dma_map(s->vfio, resp, idsz_max, true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
-- 
2.21.3


