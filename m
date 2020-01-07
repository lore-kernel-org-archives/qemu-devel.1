Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C06C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DD1206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcG0G5Rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DD1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokYR-0004rk-1H
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojQt-0007dW-Sv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojQs-0000MR-6I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojQs-0000M5-2h
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9q2/1/1fqOdhU65sqIDbx6cBRpFU6//iIePNlnfAizE=;
 b=fcG0G5RdjQZn0BM1EjT9CO2vJXyEjD1ms5AwMgNVmyvMyWF8wjtnAHDK1oKXIJoE1U1Cm4
 a8RpTes/ruuY8isy7uwdv4JN5yP+m6HKDH44lvmkDpIDQouJwiWVc6e/tym0X2F0EKL4P9
 E02P9CYy48SSMK2BzvWw9LWrkkXkFvo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-NabluuqIOPupEz_Y4IMGuQ-1; Tue, 07 Jan 2020 02:37:40 -0500
Received: by mail-qv1-f72.google.com with SMTP id g15so29363714qvk.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6oUZcRx6oHUh2LroAUnKmJ6d2Eg7LapR5X4J56q3mek=;
 b=o99HeBRQ1Hx5WlFXv2hnSrq1SrqL6Vx0NMSeGqhb67Zi5trEw3xu7rRyN69jEA7cl5
 WCY/l2rbtvhNBQnsN0VRUgfT9KSGw6el06QmLZJLv5d0qzaf8H8ayRgHEZwn9Mg7eyZ7
 seQgvbqFXFD2rpeYcKuLNzjAQpYm7L3LDVS7h5My8XAhaZNFtwL2mi798lGnNvuUQ12a
 6qUNNxo9bMQxCQtfLOakQZpejUM4EyX29+Avdad5V8RzeU3g8Ya6KpMoceqpSrRR+ROz
 OIwbnBo8DJbW7LQpP9GkLwssGc9DlHZsZvt4ghlDcgNPtuRxO8VDgEEQdfgC6pOrqrp0
 5T7Q==
X-Gm-Message-State: APjAAAWq+PqhvLqdILcIreGbORl7nIP1ltMR2bY43n6cvTyqi8AEzsjO
 IywdvG0Rlq1stdvbuRqsTI0NIIIqApc2NcgYw4H8Jhu2M2KLuSWnCV8KEa7txQEF+9yiHEDYYyV
 Tln8MkGayYtdpcpw=
X-Received: by 2002:ac8:5257:: with SMTP id y23mr77909428qtn.88.1578382659641; 
 Mon, 06 Jan 2020 23:37:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcUQfprY/T4508lENvp8oBfEOEzWlLY6q23kLzPLB+gdUaLOioi+0xbGUCJ7iqUqW8Fj7d6w==
X-Received: by 2002:ac8:5257:: with SMTP id y23mr77909422qtn.88.1578382659494; 
 Mon, 06 Jan 2020 23:37:39 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id i5sm24521666qtv.80.2020.01.06.23.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:38 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 29/32] virtio: reset region cache when on queue deletion
Message-ID: <20200107073451.298261-30-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: NabluuqIOPupEz_Y4IMGuQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
Fix leak of region reference that prevents complete
device deletion on hot unplug.

Cc: qemu-stable@nongnu.org
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20191226043649.14481-2-yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 95d8ff8508..7b861e0ca0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2344,6 +2344,7 @@ void virtio_delete_queue(VirtQueue *vq)
     vq->handle_aio_output =3D NULL;
     g_free(vq->used_elems);
     vq->used_elems =3D NULL;
+    virtio_virtqueue_reset_region_cache(vq);
 }
=20
 void virtio_del_queue(VirtIODevice *vdev, int n)
--=20
MST


