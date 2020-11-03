Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A09C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F31622370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHhUyIss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F31622370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxea-0008W4-Ku
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPC-0005bU-Vp
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPB-0006m9-70
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cS4KIfPlpUgVDDoFSeX7cKA8yzTJmgIIdFHv/xDSqc0=;
 b=jHhUyIssNNj8z5LFRrYbbm8S86Vp1Tsjm1xC8WT6AZ5oa5zXO/AR2tLa3/8XJOUXsj78s1
 duxQkFLPH0eo38u+uap75kpjSo26HHsvozAmoPE6nmM7lcfyLapxrhhQYBZ23pxH3Xhgit
 NG0ttCbB2UUBCCjA/o+gPYo6lIrpj4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-rGXlJyh-P3m50WkvOEdBQg-1; Tue, 03 Nov 2020 09:35:22 -0500
X-MC-Unique: rGXlJyh-P3m50WkvOEdBQg-1
Received: by mail-wm1-f72.google.com with SMTP id t201so4681446wmt.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cS4KIfPlpUgVDDoFSeX7cKA8yzTJmgIIdFHv/xDSqc0=;
 b=mguJ8dKJeCq/RpjU7qcqpQ14HE8yx5ad2rnbxMBoU0vAtLIl8qboXyrtYUKD2fGF2G
 GA+TW71NJb0VjA7HMf7to7Tve676V1gaw1oTdhuB46p+SKVU0FaOcdLlu32g8qFtxkEc
 wPURHibKpUCwI9gX2MFC1VQnhzB40Z5JNphlEuHK877lwxJBt32PCjg2ECKfeEcvTdTe
 bq3+/jqdiT4WrqJm6hK6xeBVg/34uDZh2eRPakw5imE0XAarLejkPxy064rOSIlQartb
 AO1U2H/j0Zip3Gn+cBfBp3ksZ+5xUngggOvj9KfrPaW0zZddb1ulwVQrP0WOK2A5s27M
 kS7w==
X-Gm-Message-State: AOAM530dqkdikh2/Ext+AP38qnw1nMLetrH7oLRTul25Ckuz/kLeg2dP
 6p3HeAcmMoekTUv29BiXOikTa/eBLWHpHAk5S3ZLwNxryFX5IQmqtPL9LBWzeTaf2KEggCEDyJV
 9QZ1u/7dzz7CH0XA=
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr25906251wrr.377.1604414120999; 
 Tue, 03 Nov 2020 06:35:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIrmSW2G5zmuho0M5p+QIiHcE6jvrzbxdVfp4pWr0wX4snTWgG781v0ar2o6fQlVdtR0RB/w==
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr25906232wrr.377.1604414120851; 
 Tue, 03 Nov 2020 06:35:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id d134sm2974281wmd.8.2020.11.03.06.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:20 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/38] block/export: fix vhost-user-blk get_config()
 information leak
Message-ID: <20201103142306.71782-31-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Refuse get_config() requests in excess of sizeof(struct virtio_blk_config).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-5-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 block/export/vhost-user-blk-server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 33cc0818b8..62672d1cb9 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -266,6 +266,9 @@ vu_blk_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
 {
     VuServer *server = container_of(vu_dev, VuServer, vu_dev);
     VuBlkExport *vexp = container_of(server, VuBlkExport, vu_server);
+
+    g_return_val_if_fail(len <= sizeof(struct virtio_blk_config), -1);
+
     memcpy(config, &vexp->blkcfg, len);
     return 0;
 }
-- 
MST


