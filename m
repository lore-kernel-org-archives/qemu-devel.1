Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C98C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3AE20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDGDxwYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3AE20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioken-0002z9-4h
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojQy-0007s8-P3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojQx-0000Qv-HS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojQx-0000QV-EF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgmNsnDUrIKv5qIqtQ+hIbBMXsq7KvX1kSU3ybRDZeQ=;
 b=bDGDxwYxjgq1328Mz46Yrp2hhwQ89NsGHwJ1x1hw0a1YtCZp2ANgGSQSrOPwx9Yp5Na2v+
 5TIaTeI1lv+nsv5MxNe9h3qylQqfZzh9zz7tH+i7M1S65KExkRonM3s8pcWnUnXjFTgg/2
 ppEPResQ1/mQbZuFu/9Il2hoJJl072Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-p44CKW4mMgS9BL4wCQ6dFQ-1; Tue, 07 Jan 2020 02:37:45 -0500
Received: by mail-qv1-f72.google.com with SMTP id e10so5028767qvq.18
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tdoWlLoYwJDJiT74CT7GYIP+izHUlkgXXi1RbTtf6v8=;
 b=fAWLH+/kc3cPjrSKMp2sN6eh39gCOc4viI1hAW/3JPBnNl03kyhbDc2lE3eOxFZHq5
 46Da3CGZEt6fxgwKJx6HTv/CLD2FLr5CCqCD6mP1/bQp9bvKVvctzzFgY3U/maT2ms/K
 qKDDpm0Beyo9HdCbxd+O/GvCAwFZEz5IK7YoU1CIr2hiE75F/Y5Sb+YrcAUWZIlz3f/C
 LzBk4jq0RJfq18x6KESpXmVcEMizEeOP1DXE6Z8oh/y6YFV/0hsh6OIkqPy/a31nbcIl
 JYRc0kYj8jtc6N94lgMA2uAIuAaBhuC1F2evlzYqD0Oybj9ZoEo9qqVpXz9v+yl01I1m
 csHQ==
X-Gm-Message-State: APjAAAXz9rCodn5yCv1HoY+D2oWQBN1sQ3F8k5QzSx5EHkqQrBbhVxyC
 gdiGLa+9uOFGj3AU25Yj1yRSXHKP6dhbjjl+YCcsNb90ZiWNDTypJbOHt429c9S4P02QVrqN6bs
 FpcnuxiPZ9p6V56s=
X-Received: by 2002:ae9:eb56:: with SMTP id b83mr84984609qkg.123.1578382664490; 
 Mon, 06 Jan 2020 23:37:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkxVXy8Z6rbJqWbSG3GqdciP9jGj9AX7KTv1EPoDdYvT9CajzD+HKFvSQ0i7kK3JHCoK+fIw==
X-Received: by 2002:ae9:eb56:: with SMTP id b83mr84984601qkg.123.1578382664283; 
 Mon, 06 Jan 2020 23:37:44 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 186sm22061395qkm.93.2020.01.06.23.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:43 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 30/32] virtio-net: delete also control queue when TX/RX
 deleted
Message-ID: <20200107073451.298261-31-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: p44CKW4mMgS9BL4wCQ6dFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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


