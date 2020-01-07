Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C490C33C9B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C9C208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9exI0DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C9C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios02-00059L-4u
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorlq-0000LF-P2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlp-0005uK-KV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorlp-0005tw-Go
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgmNsnDUrIKv5qIqtQ+hIbBMXsq7KvX1kSU3ybRDZeQ=;
 b=e9exI0DQAmGuSUlb49EmEzKK5qvn6MsM9mlDPbFMl32y6UCSclJYqT/lgnczPhjgtEfX5K
 320YK30pOhkkBtVjvEXQp3LE9rYYqHFYp+ym3eLVztm69pm6BRIv8cnR0hX3ixjSdS9sBC
 77a37Ms8jSVC1BfEJQVfRCHkUSTh1rA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Zm_bMpedPl6ipgeP0x-h-w-1; Tue, 07 Jan 2020 11:31:50 -0500
Received: by mail-qk1-f200.google.com with SMTP id 11so141274qkk.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tdoWlLoYwJDJiT74CT7GYIP+izHUlkgXXi1RbTtf6v8=;
 b=paS035tEVgQiUDHwaTO54IsFuETL0Q51jCHcy+9DWgC/M5396pbnm6LLOdqx22XVIa
 GcGFuzJJA11D4qy5XkBIQwLjB8OYh+Gs8lT8PyKrFvAY3Xj/HNyEbXadgCN5Qt9+Xr7u
 8nH7IHTPsaJKQdJMT9pMOrzanOUE9dT5Mn1GS94eVeZC5p/FLz+97vshdzSq2UdxCLVc
 onRES0O1JOKhAA9jL1rIDqVT0YlIGtIK9sT8KfGBg0E6zppLCw1u443tbfeHuMupQ5t1
 QgjvOOaf4jRsTi20E5/XSL/awZ/j9fZqlHREgTEVUtPSsYlMhxCi8tINq8lx/ICmQt5H
 DIYg==
X-Gm-Message-State: APjAAAUIPmzseA0/KBKFhntuDpgNPbdMVBT/XXqLeWNP2+StC/pd5MOx
 1R4WptywQuVs3fMcSIHrVCNTpkuVq32AuKntdIQGxv9KreXa0fQjQmPz8qkLfnelCA9RSGZvVz0
 RVAiepgF25c3mYT0=
X-Received: by 2002:a05:6214:965:: with SMTP id
 do5mr234693qvb.202.1578414709818; 
 Tue, 07 Jan 2020 08:31:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoMgg8OtyFiNoK+ZXqXiuH3lonojNzltmM8yAYTvdBDzCKbvtHnN/qetpi/uIK5AziIU+OLg==
X-Received: by 2002:a05:6214:965:: with SMTP id
 do5mr234674qvb.202.1578414709586; 
 Tue, 07 Jan 2020 08:31:49 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 201sm46809qkf.10.2020.01.07.08.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:31:48 -0800 (PST)
Date: Tue, 7 Jan 2020 11:31:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 30/32] virtio-net: delete also control queue when TX/RX
 deleted
Message-ID: <20200107162850.411448-31-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Zm_bMpedPl6ipgeP0x-h-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
If the control queue is not deleted together with TX/RX, it
later will be ignored in freeing cache resources and hot
unplug will not be completed.

Cc: qemu-stable@nongnu.org
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20191226043649.14481-3-yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index db3d7c38e6..f325440d01 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3101,7 +3101,8 @@ static void virtio_net_device_unrealize(DeviceState *=
dev, Error **errp)
     for (i =3D 0; i < max_queues; i++) {
         virtio_net_del_queue(n, i);
     }
-
+    /* delete also control vq */
+    virtio_del_queue(vdev, max_queues * 2);
     qemu_announce_timer_del(&n->announce_timer, false);
     g_free(n->vqs);
     qemu_del_nic(n->nic);
--=20
MST


