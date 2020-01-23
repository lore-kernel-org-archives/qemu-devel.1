Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DD3C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB80624655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtrJ7eRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB80624655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWiw-0003fG-92
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWde-0006NI-MX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdd-0008KB-Mq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdd-0008K3-Ik
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBcIJ+XtEg+ynI5J149ubW51ZuYdwReRoLvMT6MynBM=;
 b=gtrJ7eRI1bWOswNjKAUiDknszs3Uoihw5It7tOc9fTDKvDe/cezoe1ZA3eNvAZEkceEFAC
 m2FhXUJ88aubsnqzYG2Dc1IgBO5lx2ynLqTDO1H8cpRavTt7wfCTSqUTn4OG6uV8iRX/O7
 b/0hmmksGKQMYdes05lVc2OHOwkj600=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-ttwloaPeN-K6rpFFxI3-Ww-1; Thu, 23 Jan 2020 02:10:45 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so1266045wrm.23
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=crW7LUnM5y+vbTajSaV+13MSOoh5cZCcUuqLsKZn8gg=;
 b=itCHtLjMks6b02ASw5aw/V+mo8lkTtUBFpkz7zEY6l/TQBsNSsz9VwhUke+N6D4Zzm
 j70GNEyqIJUWO/e71GFWyAAJLPE/FSE60slIt25WuCJoVmBiA/CP+04DU+4tGTHxSH6r
 SNqs70ZI8TYwBbsMt9kXsEhaoV6qD9QQhrhV7AwPfAdwipTZ28uzq0o5f6QaFWZME3Rk
 noc3fM99HGfbnQmWcqQZOfkcPciw/+G5c0TFj328GjF69L6Byemark93Fu537D8nRWAy
 AXitu+et1Q+zhA/d4n7AktlIZKo1YKn6IeiHZ1HD+3qwRHRE1J7G0sGJ9t9EXScEurIo
 A2dw==
X-Gm-Message-State: APjAAAVdLoCKtixmeXG5GNZw24ynsv2/EsReyfQwMbcC2u/Q9u8N5TUJ
 Ti4OdrrudYM0UUNuQ1LeUYIaKqIZ6onde9TmBcYb4WBmFRidRjbD5mvjqpQnwGCe9w55i0n2BO9
 Kz1ShgFQ53J5Fx/I=
X-Received: by 2002:adf:a141:: with SMTP id r1mr14581458wrr.285.1579763443774; 
 Wed, 22 Jan 2020 23:10:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxj+GrKspIpNxhPKJqGA5fUm/32iQYPkKyyGPVleKZfLUSZ9cQmEZU1iKDHvjTufd7sb3P7ug==
X-Received: by 2002:adf:a141:: with SMTP id r1mr14581436wrr.285.1579763443584; 
 Wed, 22 Jan 2020 23:10:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 w83sm1388709wmb.42.2020.01.22.23.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:42 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 11/18] virtio-9p-device: convert to new virtio_delete_queue
Message-ID: <20200123070913.626488-12-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: ttwloaPeN-K6rpFFxI3-Ww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Use virtio_delete_queue to make it more clear.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200117060927.51996-3-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index ba35892940..1d1c50409c 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -218,7 +218,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev=
, Error **errp)
     V9fsVirtioState *v =3D VIRTIO_9P(dev);
     V9fsState *s =3D &v->state;
=20
-    virtio_del_queue(vdev, 0);
+    virtio_delete_queue(v->vq);
     virtio_cleanup(vdev);
     v9fs_device_unrealize_common(s, errp);
 }
--=20
MST


