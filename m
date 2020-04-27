Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3373C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB862064C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evs+M3DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB862064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT118-0005YM-Jo
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT0wN-0000cX-3Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT0wM-0005h9-N8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jT0wM-0005gl-An
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587983080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7s7H3k5TwkQuODm64N64lkO7MeSKnDaHw2Rggux3so=;
 b=Evs+M3DLN964oI2YSWsy9XyIWj0+Pynw9jtAFB9btKLHiZGiOKLcGNarSWaPttgCqAV0vQ
 PxGZK43M4l3eBFppi5HNxBwwdbPh+qBP8//2Ke6gee4sikT6UvK6N1i9pmf3OyFMV4ADAE
 FJr2VHuO4yG1PDi831oN4bVQRXyTjJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-INocbaIXP86AwD_JqVjItQ-1; Mon, 27 Apr 2020 06:24:38 -0400
X-MC-Unique: INocbaIXP86AwD_JqVjItQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB455835B40;
 Mon, 27 Apr 2020 10:24:37 +0000 (UTC)
Received: from localhost (ovpn-112-184.ams2.redhat.com [10.36.112.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5825F10013A1;
 Mon, 27 Apr 2020 10:24:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat
 handling
Date: Mon, 27 Apr 2020 12:24:15 +0200
Message-Id: <20200427102415.10915-4-cohuck@redhat.com>
In-Reply-To: <20200427102415.10915-1-cohuck@redhat.com>
References: <20200427102415.10915-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/net/virtio-net.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e85d902588b3..7449570c7123 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -77,14 +77,6 @@
    tso/gso/gro 'off'. */
 #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
=20
-/* temporary until standard header include it */
-#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
-
-#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
-#define VIRTIO_NET_F_RSC_EXT       61
-
-#endif
-
 static inline __virtio16 *virtio_net_rsc_ext_num_packets(
     struct virtio_net_hdr *hdr)
 {
--=20
2.21.1


