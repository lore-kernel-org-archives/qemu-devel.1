Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05019C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE33206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNxuMxjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE33206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoa1-0003Wc-W5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMV-0000g4-DG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMS-0007tN-Pu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCjqLrpq3STI/zR0Jd2dpzbux+828cWdkCvReZKkRjw=;
 b=UNxuMxjqQJ9QSsqeanC+3H3h8MarnINVrakUslpePIBAotKqSw713VQoGRjaDaLkWQ8bbq
 6MSrSsy7JEpr+3GitV2Hlsj0bbBPZ0kL9i7oULXlJb3Z76DtlImiz3kZPRS7ErwfucGvbR
 LdCMPHlRUYizs8TP/rDChrnQZ+3MrCE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Bp0jVM3oNsiTqyjFHeMAmw-1; Thu, 03 Sep 2020 08:29:00 -0400
X-MC-Unique: Bp0jVM3oNsiTqyjFHeMAmw-1
Received: by mail-wr1-f71.google.com with SMTP id l17so1016639wrw.11
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UCjqLrpq3STI/zR0Jd2dpzbux+828cWdkCvReZKkRjw=;
 b=gdpOKT6PrOFPFixx24z9ltVfSelx4p87KjzcJvAke5UwDM4dxWmfl0mhFrPlo/8b+u
 xUorZ60Gup+e0kvIa4QE7NwFeBDbr0xceVbBhEURWCva74jQoYbIv9vYH1Guv5+2rujP
 xERGaI4s7wQnHdxovIuqyqlSf58JVwRYVvxctuO6pptS1jGQSgIRb2junHEPKwobKLzA
 giDeKLS7Z0VVUyaX7Tt+YSVE7wzR+ZFbZPxNzMootxkAKKk/bJPwXPNUZgu1WkzHGQ4D
 lWVOccfltCaLql/fYcAPkqNGLEXbdL+WSJfPJ0hFSa3v5+EDIDekdX5KWOjoKakdAjY6
 lxpQ==
X-Gm-Message-State: AOAM531lCbX7Kq52BblUhDNONO4E+5SmDU3mUvVCOdHYCTH2DuZPm+61
 IWhLhcFAPI6b7GxtNZx3NOT6fEOHKlvghlMvS++XoLkExJRemVpq6xTeFJ4+8F8I3uPMXDKDA4r
 05UosZ7/GCzjGeuQ=
X-Received: by 2002:a05:600c:210c:: with SMTP id
 u12mr2406005wml.185.1599136139211; 
 Thu, 03 Sep 2020 05:28:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8hFE3CvHTi9Py94SC3XSsO9X1tDGI99PWFdfkU8QM5rLUDH1IojgEtK0eXq5W6MfXjO6VSA==
X-Received: by 2002:a05:600c:210c:: with SMTP id
 u12mr2405983wml.185.1599136139051; 
 Thu, 03 Sep 2020 05:28:59 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 31sm4270787wrd.26.2020.09.03.05.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/15] block/nvme: Simplify nvme_init_queue() arguments
Date: Thu,  3 Sep 2020 14:27:59 +0200
Message-Id: <20200903122803.405265-12-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvme_init_queue() doesn't require BlockDriverState anymore.
Replace it by BDRVNVMeState to simplify.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0c8ad1d60b6..e04e1fa4f8f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -165,10 +165,9 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
+static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
                             int nentries, int entry_bytes, Error **errp)
 {
-    BDRVNVMeState *s = bs->opaque;
     size_t bytes;
     int r;
 
@@ -251,14 +250,14 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
         req->prp_list_iova = prp_list_iova + i * s->page_size;
     }
 
-    nvme_init_queue(bs, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
+    nvme_init_queue(s, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
     }
     q->sq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale];
 
-    nvme_init_queue(bs, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
+    nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
-- 
2.26.2


