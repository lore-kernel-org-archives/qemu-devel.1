Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B386CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B28E2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+8v8kRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B28E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxQ5-0008Mq-HO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNwvB-0007aB-1z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNwv8-0006ws-G0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44805
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNwv8-0006vF-CP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571999652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvseWFuyCkVdj28XK4TAICuVZjayhGBCIoU5xjHu05k=;
 b=I+8v8kRpMyNyzcfyZmGPSTFK0Dc5RENzC/yHhjdbt/FM2b2YifWSLGesnwQr1YUYY4kOB2
 fUXfFUES8N3mzUaq235gb9lCUoIX7BekvAuDiMVONRkNb7Pe/UaGlxRFrsSQBYLk4e6Ky3
 DIxeO+fwkzxsKXqLUYg4MnTgSs3PDWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-3bW2GG32OburN8O2rvuUUg-1; Fri, 25 Oct 2019 06:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8160E1800E00
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:34:10 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A34945D9CA;
 Fri, 25 Oct 2019 10:34:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/2] virtio/vhost: Use auto_rcu_read macros
Date: Fri, 25 Oct 2019 11:34:02 +0100
Message-Id: <20191025103403.120616-2-dgilbert@redhat.com>
In-Reply-To: <20191025103403.120616-1-dgilbert@redhat.com>
References: <20191025103403.120616-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3bW2GG32OburN8O2rvuUUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD instead of manual rcu_read_(un)lock

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99de5f196f..4da0d5a6c5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -924,7 +924,7 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint=
64_t iova, int write)
     uint64_t uaddr, len;
     int ret =3D -EFAULT;
=20
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
=20
     trace_vhost_iotlb_miss(dev, 1);
=20
@@ -956,8 +956,6 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint=
64_t iova, int write)
     trace_vhost_iotlb_miss(dev, 2);
=20
 out:
-    rcu_read_unlock();
-
     return ret;
 }
=20
--=20
2.23.0


