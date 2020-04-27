Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA1CC5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD2D2064C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1/kQldc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD2D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0yl-0002dW-DV
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT0wI-0000UV-Cl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jT0wC-0005fX-LX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jT0wC-0005f6-8K
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587983070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ra7aW7uNGiw8iPZbhmCLLgBCNHpVQnxVEG+Vv9atVfc=;
 b=H1/kQldce3nOGNgZnpVb8c6o2A4i6b4rYzjBUW49XLMnA4Ab0YGbgKb7n4+0iY9oSxuqn4
 edEpbVSOmomHfmrjmtgwlfs2ehItvUzva4hWeSiU11ptqRoq4GAICnGS1QjcZvbTHy+nYB
 yvnf0ny8PODHGXq8xdLrkag/mAeWWzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-0RNogpTOOW6MLzuFtDaK8g-1; Mon, 27 Apr 2020 06:24:28 -0400
X-MC-Unique: 0RNogpTOOW6MLzuFtDaK8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD647801504;
 Mon, 27 Apr 2020 10:24:27 +0000 (UTC)
Received: from localhost (ovpn-112-184.ams2.redhat.com [10.36.112.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F6DE60CD3;
 Mon, 27 Apr 2020 10:24:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] virtio-net: fix rsc_ext compat handling
Date: Mon, 27 Apr 2020 12:24:13 +0200
Message-Id: <20200427102415.10915-2-cohuck@redhat.com>
In-Reply-To: <20200427102415.10915-1-cohuck@redhat.com>
References: <20200427102415.10915-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

virtio_net_rsc_ext_num_{packets,dupacks} needs to be available
independently of the presence of VIRTIO_NET_HDR_F_RSC_INFO.

Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windows=
 HCK")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/net/virtio-net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a46e3b37a7cd..e85d902588b3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -83,6 +83,8 @@
 #define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
 #define VIRTIO_NET_F_RSC_EXT       61
=20
+#endif
+
 static inline __virtio16 *virtio_net_rsc_ext_num_packets(
     struct virtio_net_hdr *hdr)
 {
@@ -95,8 +97,6 @@ static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
     return &hdr->csum_offset;
 }
=20
-#endif
-
 static VirtIOFeature feature_sizes[] =3D {
     {.flags =3D 1ULL << VIRTIO_NET_F_MAC,
      .end =3D endof(struct virtio_net_config, mac)},
--=20
2.21.1


