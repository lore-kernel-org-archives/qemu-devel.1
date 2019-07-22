Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DA3C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C956216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C956216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYa2-0002L2-5T
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david@redhat.com>) id 1hpYZ9-0007Xl-Dw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hpYZ8-0005CY-9L
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:41:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hpYZ8-0005Br-49; Mon, 22 Jul 2019 09:41:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68AE43082131;
 Mon, 22 Jul 2019 13:41:21 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-75.ams2.redhat.com [10.36.116.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B204E101F97D;
 Mon, 22 Jul 2019 13:41:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 15:41:03 +0200
Message-Id: <20190722134108.22151-2-david@redhat.com>
In-Reply-To: <20190722134108.22151-1-david@redhat.com>
References: <20190722134108.22151-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 22 Jul 2019 13:41:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1 v3 1/6] virtio-balloon: Fix wrong sign
 extension of PFNs
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we directly cast from int to uint64_t, we will first sign-extend to
an int64_t, which is wrong. We actually want to treat the PFNs like
unsigned values.

As far as I can see, this dates back to the initial virtio-balloon
commit, but wasn't triggered as fairly big guests would be required.

Cc: qemu-stable@nongnu.org
Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e85d1c0d5c..515abf6553 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -343,8 +343,8 @@ static void virtio_balloon_handle_output(VirtIODevice=
 *vdev, VirtQueue *vq)
         }
=20
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) =
=3D=3D 4) {
+            unsigned int p =3D virtio_ldl_p(vdev, &pfn);
             hwaddr pa;
-            int p =3D virtio_ldl_p(vdev, &pfn);
=20
             pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset +=3D 4;
--=20
2.21.0


