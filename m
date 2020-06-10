Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC49C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129632072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R62+4zvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129632072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jislx-0006Uj-7d
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisM1-0002SF-NN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisM0-0008Pz-Th
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7i0b3GPG3H6Dh/tglQZmkCX3+dgrOP3sk2+xsAeedP8=;
 b=R62+4zvykcJMpr3jYpxoILi2trG2fwygE3j7PtIdiXYh1xbhqvxzA+yY3OAh5yVHQaD5uL
 X2PfJFOBeiGemjLizfZI7fJ9e281CR9JupPwYMMWiX94MmDHPGRZw9L3wkO0adJj98Rz9F
 7FQsSYR9ueWN64nhKdMYnxLl8iooa14=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-sXEeM9VrN0q-CmoD4PXc5w-1; Wed, 10 Jun 2020 00:28:42 -0400
X-MC-Unique: sXEeM9VrN0q-CmoD4PXc5w-1
Received: by mail-wr1-f69.google.com with SMTP id j16so492396wre.22
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7i0b3GPG3H6Dh/tglQZmkCX3+dgrOP3sk2+xsAeedP8=;
 b=QywDyd6N6XpdT6zqadMNgF4jUksCSgbVNwnF2dS7Pxlmxcvnt8bCuJPz61oalA8Cy1
 5utSOs/Q78ISCWJYoKl5EubYNLwSwnrOJSEbMW6e7XvCL7mpXg5SGvhH86m21CR9eTRj
 7zVpyUPgVjy+oG8l/B5q2pnSF9lAcsg9WKTwByttbEerk0o0iavPW4a7xoSFNK05qEkU
 iLxB+RdoI2Z1hzVqxTjiqOotGwmCvrMZXfJcoD5DYTnWR9eD5T6Vl6QYhlDHuYYIKKlE
 xgqlAx++Y20GqmacEL/2Z45pyaiFvCIU6ZLQ7wicJA3I2MZK/Pelg/Vr5kZ/IVmVR27X
 S+Fg==
X-Gm-Message-State: AOAM533av5TgFsFmPJcv/odWR5UZvOcTxDIaAWuI7zxbqE05KsUJBUp3
 LlK/ovwatvInDoGjbfrmarMy96w2DPaeFnnUWYkTWnpcUWejEG9IUZo+sW5Q8GnsFMJazU3/IBK
 YabED/jD2NKBgcHE=
X-Received: by 2002:a1c:f003:: with SMTP id a3mr1146350wmb.119.1591763320955; 
 Tue, 09 Jun 2020 21:28:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrGKbufNYZ0ol2ZEBHR5d7tg6/WcEqRutvCmeGAM4c3L0DIOX8zJwCQoQhdsQp+C9QYgpztA==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr1146326wmb.119.1591763320684; 
 Tue, 09 Jun 2020 21:28:40 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id u9sm5407664wme.16.2020.06.09.21.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:40 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/56] Fix parameter type in vhost migration log path
Message-ID: <20200610042613.1459309-57-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.s.norwitz@gmail.com>

The ‘enable’ parameter to the vhost_migration_log() function is given as
an int, but "true"/"false" values are passed in wherever it is invoked.
Inside the function itself it is only ever compared with bool values.
Therefore the parameter value itself should be changed to bool.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <CAFubqFtqNZw=Y-ar3N=3zTQi6LkKg_G-7W7OOHHbE7Y1fV7HAQ@mail.gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0ede..aa06a36919 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -809,12 +809,12 @@ err_features:
     return r;
 }
 
-static int vhost_migration_log(MemoryListener *listener, int enable)
+static int vhost_migration_log(MemoryListener *listener, bool enable)
 {
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          memory_listener);
     int r;
-    if (!!enable == dev->log_enabled) {
+    if (enable == dev->log_enabled) {
         return 0;
     }
     if (!dev->started) {
-- 
MST


