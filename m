Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4621C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2888920848
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xkd/O43H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2888920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJF7c-00060z-LZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kJF6c-0005RQ-4q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1kJF6a-0008C2-3P
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600430586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dmvEpsKwbLXEiPeeTTMn0eN0xQb7ohyugOBeaC2LxCc=;
 b=Xkd/O43HSo/lgPomWBXtqpY2B9OSt25XYvB6tSyMaCSxm21cy9GEfQi7Eru58IIFK2bQqH
 NUAN2y5ehIzWx57Mf6dDZrj/oo617wUpKc8d4DS4IcH13U+4SxYzXRwnQwlHEsgRIfoi4W
 aLyqAPbP01WwRsPdWENgKwXbOkVmBxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-fRf4dQJIMwm3b7lb5j-OjQ-1; Fri, 18 Sep 2020 08:03:05 -0400
X-MC-Unique: fRf4dQJIMwm3b7lb5j-OjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D5E28030A6;
 Fri, 18 Sep 2020 12:03:04 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-15.ams2.redhat.com [10.36.113.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F4F968876;
 Fri, 18 Sep 2020 12:03:02 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost-vdpa: don't check g_malloc() return value
Date: Fri, 18 Sep 2020 14:03:01 +0200
Message-Id: <20200918120301.729794-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On failure, g_malloc() aborts the program, we don't need to check the
return value

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4580f3efd8a2..23a4a957ef77 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -321,9 +321,6 @@ static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
     int ret;
     unsigned long config_size = offsetof(struct vhost_vdpa_config, buf);
     config = g_malloc(size + config_size);
-    if (config == NULL) {
-        return -1;
-    }
     config->off = offset;
     config->len = size;
     memcpy(config->buf, data, size);
@@ -340,9 +337,6 @@ static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
     int ret;
 
     v_config = g_malloc(config_len + config_size);
-    if (v_config == NULL) {
-        return -1;
-    }
     v_config->len = config_len;
     v_config->off = 0;
     ret = vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
-- 
2.26.2


