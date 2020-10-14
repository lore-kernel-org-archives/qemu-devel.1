Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E57C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA0C20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI7Ptz92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA0C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjEz-0006md-3M
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAw-0004XL-Gn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAv-0000vz-0q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n55Tojzee3U5y86sm0YRlgiaSZuSyN/j5wbWS6M55NQ=;
 b=XI7Ptz92jzM0lDHv23O4OqUzgc6oSuL1SvXGr4bKFjK0co5O7LwxYBkKN3O61DYdoax3+c
 I/fmYUweMRti2Aj1jQol0DsbpCYqAg1MU5T8ZpxU5xzphm1+h8jh6FWYsQ6CJYh06Hhjfu
 UJQzsi4O+5vJJyLFqvQK52hT6+gvHkM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-5Th9mXdiNfGvoTSxmHIn8Q-1; Wed, 14 Oct 2020 11:58:44 -0400
X-MC-Unique: 5Th9mXdiNfGvoTSxmHIn8Q-1
Received: by mail-wr1-f70.google.com with SMTP id t11so677279wrv.10
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n55Tojzee3U5y86sm0YRlgiaSZuSyN/j5wbWS6M55NQ=;
 b=eu3CH2UVUsOndwQTATtwTombglFk8ky6sdmrilg714QsLCoii0KQ24Lm+w51W+bhXh
 7f8S7piU737JxvmNdoHzGE6FC1Xr5C7vAuhOfADS6YxyXVtk/MihTdaDAA4QZokAdDNd
 GPdh9iR3ucShHR6APv0xrJ4y2cSw4YMyu1v4AkcFdx/F4livajabY0dI86iId/7M8n2T
 H+dXw0Y99aBD/1Q7xk/19AE6UFVtqTYv5PnjSIQnsDQ0/TzihUX95l/KOE+DLohJz9tB
 ZE35JAx2CefGIrrWJUG3mnDFOb1nEyKBjJKCvilZXeX0E/dp0c25Yrf7SRmlr0Ms90L9
 PuRw==
X-Gm-Message-State: AOAM533pIPWRySiMIzVCn43FaY/kfEaMzhfDDO1YGLPkl6i/ApdipKbm
 pe81ZNkfUDZUn41fkhPXFjwjJpyYgcFix4G9GdyWZpA8UjM92mRpVFXM5x+F/ey+3EivY9OY762
 3Ci1mMwYb2qScHeI=
X-Received: by 2002:a1c:e48b:: with SMTP id b133mr142443wmh.0.1602691123051;
 Wed, 14 Oct 2020 08:58:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU5/fKCXdU6560Jh9AUqT/0+Qts4e54qcj5ajEnL+jQMGHTPBVChIr9SLcJF5frgRKodrzrQ==
X-Received: by 2002:a1c:e48b:: with SMTP id b133mr142431wmh.0.1602691122885;
 Wed, 14 Oct 2020 08:58:42 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y14sm52505wma.48.2020.10.14.08.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/15] block/nvme: Make nvme_identify() return boolean
 indicating error
Date: Wed, 14 Oct 2020 17:58:01 +0200
Message-Id: <20201014155810.102841-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014155810.102841-1-philmd@redhat.com>
References: <20201014155810.102841-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just for consistency, following the example documented since
commit e3fe3988d7 ("error: Document Error API usage rules"),
return a boolean value indicating an error is set or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 95f19e12cd6..95f8f8b360b 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -496,9 +496,11 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     return ret;
 }
 
-static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
+/* Returns true on success, false on failure. */
+static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    bool ret = false;
     union {
         NvmeIdCtrl ctrl;
         NvmeIdNs ns;
@@ -575,10 +577,13 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         goto out;
     }
 
+    ret = true;
     s->blkshift = lbaf->ds;
 out:
     qemu_vfio_dma_unmap(s->vfio, id);
     qemu_vfree(id);
+
+    return ret;
 }
 
 static bool nvme_poll_queue(NVMeQueuePair *q)
-- 
2.26.2


