Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B4C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76A62073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnwMTUT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76A62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokRv-0005vT-6D
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojQq-0007T0-0T
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojQo-0000Jj-Lr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49227
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojQo-0000JO-Iq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10wNZRiSDwsgBzUvgX+qZm4UOG4d0UwTiZy8rXJV4jo=;
 b=KnwMTUT/ayyCjRT9/F1OjAWgzc9bS1MFh1gX5FleiI2frAtBsNT7r9hUiIi1CaGiBt0ZPF
 lNQEGw9FI2h6HipH47B9wDyIHKplxxfAvvfTc9bs4U6RFn27b+Na+tys9QfhKxNNt4EJiM
 24y9Ggr4d4BgSjRBrWtmLarMOF7zGmI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-1TY63rK3Mu-rjYGwW7Dh-g-1; Tue, 07 Jan 2020 02:37:36 -0500
Received: by mail-qv1-f71.google.com with SMTP id e14so6012498qvr.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tfGwPPQntx/q9Ytbl/8/C6b7fB9jJ0SAUnXApOete/4=;
 b=fMB6Tc784QkPBIVsVDZcRVxvsSHhHngMsmInkoBE+UDjxR4V34D+SldNULYMlCR9ek
 7nW7NJomDMIAgvoe3nSQ2tW2UMA7NVAIgUtZlZDa1022p6GqgOE0+KYS1aQlil7gsOdv
 pT5WcCZbi/JkDEvwSv+st70xfPGaSzOV9flKY9JsXxVX97jUhqHea50lAIWxj21+c/L4
 0Nf4TwZkcp+yJ5a2x8rkuJYRZobpoV0P1VKAzdY/Er5d40Y3Sy8Dkr+QS9XOtScoFK4K
 YZ2420CxNiUGheGuYXOi+jSMe3TA+2slMXgoeyh/K6CfkOb1eEs/8nsibJfde66EVM3z
 pN7w==
X-Gm-Message-State: APjAAAWxIPOXOVTZCFPvr0YZJK008tSArnxuf5QDfnLlwzVJ037xwMIH
 Dy7kqtGIVotfIycP3liL+o50QN5gUp0hn3RXOuyvygO7RER3wb2eMRgYPpjrh/blqypqUolfmQZ
 S6p27ryxcQ+VDRg8=
X-Received: by 2002:ac8:1c43:: with SMTP id j3mr76672176qtk.316.1578382655130; 
 Mon, 06 Jan 2020 23:37:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5QKrWDYKpdXFMExmNHnQzb+SllAW9n6qaWuM27WedOIDrFvFG5tLHhnUb8G37wskVZ3RO0g==
X-Received: by 2002:ac8:1c43:: with SMTP id j3mr76672171qtk.316.1578382654978; 
 Mon, 06 Jan 2020 23:37:34 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id g62sm21970507qkd.25.2020.01.06.23.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:34 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 28/32] virtio-mmio: update queue size on guest write
Message-ID: <20200107073451.298261-29-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 1TY63rK3Mu-rjYGwW7Dh-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

Some guests read back queue size after writing it.
Always update the on size write otherwise they might be confused.

Cc: qemu-stable@nongnu.org
Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20191224081446.17003-1-dplotnikov@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index ef40b7a9b2..872f2cd237 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -308,8 +308,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offs=
et, uint64_t value,
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
         trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
+        virtio_queue_set_num(vdev, vdev->queue_sel, value);
+
         if (proxy->legacy) {
-            virtio_queue_set_num(vdev, vdev->queue_sel, value);
             virtio_queue_update_rings(vdev, vdev->queue_sel);
         } else {
             proxy->vqs[vdev->queue_sel].num =3D value;
--=20
MST


