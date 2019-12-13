Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220E5C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFAB24671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDsSg5gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFAB24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjcB-0006tX-0W
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifjaf-0005rl-E3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifjae-0001x6-Bj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:58:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifjae-0001wT-7R
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576238315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqNnoloF1h6D/MeHLeDPb9zVUqDfufd7EkBBR1ZZ2bE=;
 b=fDsSg5gpEUFqcOABsezMsqiFc96RGG3/TCWo/tPF8uOCDFAkeQLIAhDtc/hM9e+F3WjaMX
 GgVslVjuDQgX6zot+ys9OPn8ufO3k9UmUqXuq5wvZ4RtPjPNk0EMeWUuyllzLO/hsw4Rqe
 EfD4hyWmuco1Cwn18i+S6AXUGmTRcXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-1vmY4vZWO9Oi2kvW-iEouQ-1; Fri, 13 Dec 2019 06:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62827800D4E
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 11:58:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E29319C4F;
 Fri, 13 Dec 2019 11:58:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] vhost-user-fs: remove "vhostfd" property
Date: Fri, 13 Dec 2019 11:58:21 +0000
Message-Id: <20191213115822.77260-2-dgilbert@redhat.com>
In-Reply-To: <20191213115822.77260-1-dgilbert@redhat.com>
References: <20191213115822.77260-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1vmY4vZWO9Oi2kvW-iEouQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: marcandre.lureau@redhat.com, stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The property doesn't make much sense for a vhost-user device.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191116112016.14872-1-marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user-fs.c         | 1 -
 include/hw/virtio/vhost-user-fs.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index f0df7f4746..ca0b7fc9de 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -263,7 +263,6 @@ static Property vuf_properties[] =3D {
     DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
                        conf.num_request_queues, 1),
     DEFINE_PROP_UINT16("queue-size", VHostUserFS, conf.queue_size, 128),
-    DEFINE_PROP_STRING("vhostfd", VHostUserFS, conf.vhostfd),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-us=
er-fs.h
index 539885b458..9ff1bdb7cf 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -28,7 +28,6 @@ typedef struct {
     char *tag;
     uint16_t num_request_queues;
     uint16_t queue_size;
-    char *vhostfd;
 } VHostUserFSConf;
=20
 typedef struct {
--=20
2.23.0


