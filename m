Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7797C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC5D206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmcZLZKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC5D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX17-0008Kj-5h
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWw2-0008Gm-VH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58806
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWw1-00012I-AF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0bzcP/UpAbQ5jPMODfTO9c6ylEsOtXCw+c/HFqzYb0=;
 b=SmcZLZKrQpaV6bdo4DlLNdTYyu1q+/iMzATK4H54UQ2e1eGa0bbiDKPFtmHpushmPI+/tw
 0Im2q8ht5eKCyWNiK7FkpWBRKAaSgoliJIo17RoBUDS49rW8TsRFRj/gkM8JpFn+4JDiRx
 23x/ncjV61niO/xwR3R6oIHvA6cFnDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-4vIC9PyLP4C1G58ykPQlcQ-1; Thu, 25 Jun 2020 14:49:14 -0400
X-MC-Unique: 4vIC9PyLP4C1G58ykPQlcQ-1
Received: by mail-wr1-f71.google.com with SMTP id a18so7731056wrm.14
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m0bzcP/UpAbQ5jPMODfTO9c6ylEsOtXCw+c/HFqzYb0=;
 b=bfj5dfrzAJwL2t65NGayF1nUt39qFivXye/GVLaT45ed5sPJgR3DTQP7TlWujcv0oX
 nUi7TJhb9CXQ/GAWZsXxf6g1ZJ1+wUW5V7C1HsYzn0O9bCqjgnkyPWhLUY2Xbz+WA8b+
 1us3c9+aKFBTyZynRsdaIIt0xnFywKMjWteGEuo6Tm2HnWRGuXcG2JG93CeObdYEJXVo
 w8l+maTyw8pv+/Sxo6CM1z8QqUhicsZoEMBiQmR8zaNMWtzU4Cl5LxND7cyLuPVcJqi3
 s4URbwcHcinYKvYssd1BY40t2r9+VAm0GLM50JTaydmRFmLOl+TD2VfkozjtQB232JHh
 9ekQ==
X-Gm-Message-State: AOAM530b2HREUWq7+olG2hNCvrHQkZ5wI02WG41SyY01yD3TX9T+7BV0
 5LvdLm5SkjWjNbh3E5aijMneT7g3sL6OQZK6yLiqv7JfL9nmVYWv5o4nP5OauglepoWTrav+x8x
 0q+AbUwAjPQdY4fY=
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr4623892wmc.146.1593110953484; 
 Thu, 25 Jun 2020 11:49:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ+v+Rr3Z3igwd657UXI2rM8WYawdUWGIyGhgmTRIQrvaFBNzmKuRWfzAtiZOfqee2AyWw8g==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr4623880wmc.146.1593110953328; 
 Thu, 25 Jun 2020 11:49:13 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v66sm14152417wme.13.2020.06.25.11.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 07/17] block/nvme: Move code around
Date: Thu, 25 Jun 2020 20:48:28 +0200
Message-Id: <20200625184838.28172-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

Move assignments previous to where the assigned variable is used,
to make the nvme_identify() body easier to review. No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index cec9ace3dd..1bba496294 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -456,17 +456,15 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
-    idctrl = (NvmeIdCtrl *)resp;
-    idns = (NvmeIdNs *)resp;
     r = qemu_vfio_dma_map(s->vfio, resp, idsz_max, true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
 
-    memset(resp, 0, sizeof(NvmeIdCtrl));
+    idctrl = (NvmeIdCtrl *)resp;
+    memset(idctrl, 0, sizeof(NvmeIdCtrl));
     cmd.prp1 = cpu_to_le64(iova);
-
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to identify controller");
         goto out;
@@ -487,8 +485,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(resp, 0, sizeof(NvmeIdNs));
-
+    idns = (NvmeIdNs *)resp;
+    memset(idns, 0, sizeof(NvmeIdNs));
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
-- 
2.21.3


