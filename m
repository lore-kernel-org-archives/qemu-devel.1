Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DC8208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnhnyU+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DC8208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAzE-00027a-CV
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmK-00075T-Jp
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmI-0004pt-RN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cS4KIfPlpUgVDDoFSeX7cKA8yzTJmgIIdFHv/xDSqc0=;
 b=AnhnyU+tTPH9/Dr6EX+eptwtYdGMCxdIqlfFYPbiRZ2IHgNexd5164HtYEfuT/vGc+Ya/M
 bwm/WSbX/uhu4YmydqHXVLTQ0FLuRJtV6KyzEOJdKZH2anx1Ws7fxIK1SZml+Ckfv8BjMO
 NE+o/1jFHLbsF5LDKEwIQGRgU6otCsI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-ATAjRjdtMXio1Y9a8PAHlw-1; Tue, 03 Nov 2020 23:52:07 -0500
X-MC-Unique: ATAjRjdtMXio1Y9a8PAHlw-1
Received: by mail-wr1-f71.google.com with SMTP id 31so8704706wrg.12
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cS4KIfPlpUgVDDoFSeX7cKA8yzTJmgIIdFHv/xDSqc0=;
 b=jzCv/AJu9ElA7V3zMSz2Tg4juhN+Uh+WwOPnd4ykIYGVxEYeebAchq8PlFM1dxeoZl
 2znx1ZEXGSrduUKA4eWjRfY3UTy2L9rCHzuPbWWsExNUtAedrLaCTxNTlMgaE+spVF+v
 UJ4xH2PGOyqe5AbqG6OKSPdYaL1lOCfTn0Jrfr4/t3Co2TSz3fbS1eZ0N4mBOFGyUMZC
 K9DA+nyqOq15j+EEt6z4BZvZ1SwUfDyluDT025ohdlq/9SlXH2jefTsK4331/SfYtTYB
 q/9YqTdOybdCkLcoWS7Mojt7KiivgJzLHrpN7KuTHJ7/75rpyt5wZRAyMfaPt4K02rrN
 bqMQ==
X-Gm-Message-State: AOAM532+ghMkbUMpwelHAkCgKpW60zVKuNVg1s2RG0ag7OIZO/y4h09D
 ZfST4geTavQehsEGlCZQPeFNU3xikg4fFA6oeLMLHWWt3YqujF7vn6yxsQEt+xkn4G8U8ZW7pab
 ZKcnxoLTICDwTQAU=
X-Received: by 2002:a1c:e087:: with SMTP id x129mr2428140wmg.2.1604465525612; 
 Tue, 03 Nov 2020 20:52:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuqIeBrmrKF6BkldU+V/RGr8/Husc9SuIZSp2u+7EjY6s0Wzyoe8Bms+w7lSWr0oR2TPAkhg==
X-Received: by 2002:a1c:e087:: with SMTP id x129mr2428131wmg.2.1604465525474; 
 Tue, 03 Nov 2020 20:52:05 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id p13sm854792wrt.73.2020.11.03.20.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:04 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 30/38] block/export: fix vhost-user-blk get_config()
 information leak
Message-ID: <20201104044937.226370-31-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


