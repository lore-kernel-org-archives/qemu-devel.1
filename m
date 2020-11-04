Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D4BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FF220780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTxfkq/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FF220780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNtR-0001IM-2I
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNkC-00026y-8l
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNkA-00028u-Fr
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cS4KIfPlpUgVDDoFSeX7cKA8yzTJmgIIdFHv/xDSqc0=;
 b=NTxfkq/Ov9DAdRdkKaWMXrI4feW6bmBSC+ZsJXnWvD9+SP+plEx/WW9pysmhZ47J+7Mb2v
 CvNPjTfbzf/KB6nIwWDGjoOx1VVyWRKPJys5sYV2BgWut+1cHPWPohmtFRq6+eG9vKK4Th
 VQ6QeHKJ01sP9hhuvn4bqajyY6PUHTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-_kIg8_mSM6y-YO_QhsmIRw-1; Wed, 04 Nov 2020 13:42:46 -0500
X-MC-Unique: _kIg8_mSM6y-YO_QhsmIRw-1
Received: by mail-wm1-f72.google.com with SMTP id s85so937450wme.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cS4KIfPlpUgVDDoFSeX7cKA8yzTJmgIIdFHv/xDSqc0=;
 b=oVvvtgH4s/4wc4sfEyq0cmA4/agNlv0uRezl5fkA2rWyG/y3JH0UxbcmbrYr/XUYYc
 OzKoxXl6vDv/+0A2BWjsIQSe/jSUgw23BRYD4hLuGz9KBcGr+5hfwUxN23V/8oYwuNdF
 /pE4l2OTfeuo/bFUUnKJJXRn+dn8p4M4WFByDpWzkYwM7u4q2GVlIB92vS5FWk9YLp+j
 CQ+tz9mhth2EhzBeQA9ktHZRRf7+1bmRz9Iljjgo2DlNO311ClbjNTGAjKOXUExRD5YK
 UCXDxX9rAqhFjS1MKStc5X8YsX/OAgmdw5ubbWNTKFiLkdVWckmjPhICdZHvSKYqRvar
 vMKA==
X-Gm-Message-State: AOAM531TTiiR1BotFriyoSIdhD8MUE0HRyxb45SdsgsUkEBNM+2OUVaf
 Mo6qGhQqB+gDnn+qTWXF9kc5fEoAjMgIXD/EwtE7h4MBwFm9/vIvN+zrax0uovgIK+QBAMOBDJv
 5wsUYVhPwaPhevSs=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr8431819wrn.124.1604515364576; 
 Wed, 04 Nov 2020 10:42:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCiUmSyJM7wWGHb04L1f/thUiVYmbfsoZ6xudGz3Ugz46gi0nwGiODkgvYdjDFrOyHeutHcQ==
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr8431810wrn.124.1604515364389; 
 Wed, 04 Nov 2020 10:42:44 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id s11sm3681961wrm.56.2020.11.04.10.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:43 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 30/31] block/export: fix vhost-user-blk get_config()
 information leak
Message-ID: <20201104184040.285057-31-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
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


