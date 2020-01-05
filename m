Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAB6C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1042085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 12:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISQ01Htl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1042085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5V1-0002O4-Ex
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 07:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5TJ-0000QU-Gl
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5TI-0003UR-Kd
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22193
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5TI-0003Sz-H8
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTcB6zAIaRzY9EwvftE6Rtrz5u5tIha89kZ+phnxUYk=;
 b=ISQ01HtlT38FA2S1uttdcBNWLKHkN406W+pfib+d29gX6IFFDJpQ5pre4A7DyKFCGySBWu
 lsyErAZWxjgC3Jz5s0j9qD8exxW7sQxnZ8jdPIAceYVEjv3x+3gdyRq3759dRqSYaui5FP
 5et3gTxyQXhF9SmRRfNTvr6t3XaCtwM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-yWCbzG0NNKufGFWsJP9ZSw-1; Sun, 05 Jan 2020 07:57:30 -0500
Received: by mail-qt1-f200.google.com with SMTP id r9so8038518qtc.4
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RMQMUHnYVnq2AcC/aQn0pR+4gejts1KmX+FDMoG77/0=;
 b=GNEpGqz4jDdRqb3Sk5Oi/mhATe0/SldRsVMahI7FCCr+dI5WerXdR7qqOlwUaidnL0
 5G3cVgyq0Rpi13VT6oQJFL1vqF6kk2564U2L7iaC0gGWlecIepkHRFy9RyhFMJIuCAAU
 yt0iE6vsovC4iiByP+hgHlTEd8t1T66AfPMRSu8nZ9Lhc5Hds2Y9HlaOAuNdLe8jF0ex
 K9J/6L5FR1nLdwMztJ7lqNXu7wtuABuKdeyBA+JSTLHq0ffnpljAh4bXpYRlMt6YwvpO
 n5Cewo3bK7xW8ADJdAzhDKwR5xguSKFDSbIok3zLjihtboHmtfviYEejcmzrazGDPGab
 AXag==
X-Gm-Message-State: APjAAAXxng/njOuiP9sspgKFfUQLMO4ocXO+Sk32wtxb75x/owDHoP7u
 dca+B1O7404M3vOXXpMuVdJ7QRKZzNsPdTRI6o+Xs12jLpqEth15md0AT36Hwv8nQjCueTVo+2e
 4pKjdGtJWNnwSjZM=
X-Received: by 2002:a05:6214:bc3:: with SMTP id
 ff3mr72052508qvb.155.1578229050061; 
 Sun, 05 Jan 2020 04:57:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8oVrUoPL39KIBn1pNBGLdD/EJLWzQHz74WL16hL0dBEFOW0Gk19pzHD8MgRR14gqBxAG2QQ==
X-Received: by 2002:a05:6214:bc3:: with SMTP id
 ff3mr72052502qvb.155.1578229049911; 
 Sun, 05 Jan 2020 04:57:29 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id k88sm1558531qte.32.2020.01.05.04.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:57:29 -0800 (PST)
Date: Sun, 5 Jan 2020 07:57:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 02/32] virtio: make virtio_delete_queue idempotent
Message-ID: <20200105125622.27231-3-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: yWCbzG0NNKufGFWsJP9ZSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Pan Nengyuan <pannengyuan@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's make sure calling this twice is harmless -
no known instances, but seems safer.

Suggested-by: Pan Nengyuan <pannengyuan@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 31dd140990..6de3cfdc2c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2337,6 +2337,7 @@ void virtio_delete_queue(VirtQueue *vq)
     vq->handle_output =3D NULL;
     vq->handle_aio_output =3D NULL;
     g_free(vq->used_elems);
+    vq->used_elems =3D NULL;
 }
=20
 void virtio_del_queue(VirtIODevice *vdev, int n)
--=20
MST


