Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65005CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3520021929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhkdnq90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNv6y-0003Pp-SK
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNv4j-0000QM-LY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNv4h-0007dY-IV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNv4h-0007Zu-EU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571992553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RP4sJcJV5+cS5FBPAfqlXPo1zZhyeRWjVcYfOrolyAw=;
 b=dhkdnq90BYlyaulISt4gdTaIIkIGb8wKA3J+tEGeeLo0697vlI7x6p2ktpritTcUZ4d5MP
 XNEsubQudWaR1BRT7r5dp795J01Y/XJZeAzSqNLtChrM8qfzwM6sdrN7tJzwOCARGMxn1n
 VkEODrnLjuUM5GCmLAAcM/XgzWO5igw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-X4knY--ZPzisoEwwcr3swQ-1; Fri, 25 Oct 2019 04:35:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C45961800E01;
 Fri, 25 Oct 2019 08:35:48 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D729060BE0;
 Fri, 25 Oct 2019 08:35:45 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 1/8] virtio: basic structure for packed ring
Date: Fri, 25 Oct 2019 10:35:20 +0200
Message-Id: <20191025083527.30803-2-eperezma@redhat.com>
In-Reply-To: <20191025083527.30803-1-eperezma@redhat.com>
References: <20191025083527.30803-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: X4knY--ZPzisoEwwcr3swQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Xu <wexu@redhat.com>

Define packed ring structure according to Qemu nomenclature,
field data(wrap counter, etc) are also included.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/virtio/virtio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03bfd..fdac203cdf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -43,6 +43,13 @@ typedef struct VRingDesc
     uint16_t next;
 } VRingDesc;
=20
+typedef struct VRingPackedDesc {
+    uint64_t addr;
+    uint32_t len;
+    uint16_t id;
+    uint16_t flags;
+} VRingPackedDesc;
+
 typedef struct VRingAvail
 {
     uint16_t flags;
@@ -81,17 +88,25 @@ typedef struct VRing
     VRingMemoryRegionCaches *caches;
 } VRing;
=20
+typedef struct VRingPackedDescEvent {
+    uint16_t off_wrap;
+    uint16_t flags;
+} VRingPackedDescEvent ;
+
 struct VirtQueue
 {
     VRing vring;
=20
     /* Next head to pop */
     uint16_t last_avail_idx;
+    bool last_avail_wrap_counter;
=20
     /* Last avail_idx read from VQ. */
     uint16_t shadow_avail_idx;
+    bool shadow_avail_wrap_counter;
=20
     uint16_t used_idx;
+    bool used_wrap_counter;
=20
     /* Last used index value we have signalled on */
     uint16_t signalled_used;
--=20
2.16.5


