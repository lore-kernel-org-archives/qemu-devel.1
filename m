Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC6C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8280223D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLxH4U2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8280223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMpu-0007tR-RT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXMpE-0007Bi-A8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXMpD-00072k-B6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:03:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXMpD-00072S-7A
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574244182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N0YO9aq8dPMLduzr+NixeVuzUQBBWmON9U10Qp9kz8=;
 b=MLxH4U2HQT5gzd4cVsnbjrePREWpjVMO6KGm+O6xF11j4N5hP2t5bNSraaAcH4ZDGdP4jV
 1/TMhjqhwRGxCAApBJTK1NXb4gJpKsAFnX4LfA+fn8DOc/Jrk8bHcNssAe/GRW+PCMO2Mq
 LKtwXQCId8LDOhv/2p1KCSbhQgon2eM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-UGAP9IPKOYSbI54x7D4wow-1; Wed, 20 Nov 2019 04:59:43 -0500
Received: by mail-qt1-f199.google.com with SMTP id h15so16692216qtn.6
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OQFdwkIthF4kIPw5/zTWhuJUEuuTMGScbyEP0azu+ZE=;
 b=BEbshRgd41idHM4uKO1wbW5b742gJID9k4zI1ClBgVFjzHoOXW6DkKNcMgikZZcwF/
 9KO/4ku7G+gVMTGg/NzllYN9sZd4jbHD2j9RL0XbeHBPoaQ6HYasown1Y/x60hFbEVMX
 uIsalWrs3b4v2EVRieQvwXu/esvgBW2zkUOQcAiJREjIPtaPPL+9TXuX2hKsWNfNCrCg
 akL7N6aDO+6QiY0VNNOUYm7wNW21sTK88l5JD7GS2XyyHgIV4Ik3y68/VNefVRaZXvaL
 USgOUAr4MiApKVfgY9bZE2w54kA6FhQRkkbjfOOteEroYOai4jpwBs5grR0YUIG+KsQN
 evPw==
X-Gm-Message-State: APjAAAUSdrTeH1DFR/6oN4KZRo0igNZi3B3vPXLKZ9OiXKZBfzpQThwq
 7zdVAu816/K4NYGpMZWSBNJ7xT+CBSFhGMRY63PYMUERv0vFxyg/grn674v6PNrOXNMXwrKmr2d
 QE+Bsf7CNJmHEfOQ=
X-Received: by 2002:ac8:53c1:: with SMTP id c1mr1702393qtq.328.1574243982692; 
 Wed, 20 Nov 2019 01:59:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwi6pSI+nCkSX+Xo7OQWjcSYlb7mj5Ad8yKiZozFAemOMhtyZA/hEpop2vEmDwBfySsI6FmzA==
X-Received: by 2002:ac8:53c1:: with SMTP id c1mr1702382qtq.328.1574243982542; 
 Wed, 20 Nov 2019 01:59:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id m186sm634642qkc.39.2019.11.20.01.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 01:59:41 -0800 (PST)
Date: Wed, 20 Nov 2019 04:59:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] vhost-user-input: use free(elem) instead of g_free(elem)
Message-ID: <20191120095904.11384-3-mst@redhat.com>
References: <20191120095904.11384-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120095904.11384-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: UGAP9IPKOYSbI54x7D4wow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The virtqueue element returned by vu_queue_pop() is allocated using
malloc(3) by virtqueue_alloc_element().  Use the matching free(3)
function instead of glib's g_free().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20191119111626.112206-1-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 contrib/vhost-user-input/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/mai=
n.c
index 449fd2171a..ef4b7769f2 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -77,7 +77,7 @@ static void vi_input_send(VuInput *vi, struct virtio_inpu=
t_event *event)
         len =3D iov_from_buf(elem->in_sg, elem->in_num,
                            0, &vi->queue[i].event, sizeof(virtio_input_eve=
nt));
         vu_queue_push(dev, vq, elem, len);
-        g_free(elem);
+        free(elem);
     }
=20
     vu_queue_notify(&vi->dev.parent, vq);
@@ -153,7 +153,7 @@ static void vi_handle_sts(VuDev *dev, int qidx)
                          0, &event, sizeof(event));
         vi_handle_status(vi, &event);
         vu_queue_push(dev, vq, elem, len);
-        g_free(elem);
+        free(elem);
     }
=20
     vu_queue_notify(&vi->dev.parent, vq);
--=20
MST


