Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C8AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8C2206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8jzdqHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8C2206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41139 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4Pv-00073v-FT
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1is4Oj-0005bb-Od
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1is4Of-00076a-Sv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:37:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1is4Oe-00075y-Kf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579178232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M6gMA224XdlEvjzouDJg3C1I1QdcAIZUhp49KsLBcWY=;
 b=N8jzdqHZTM2BdL4O5VIrQCZlwEI9Q87/v5O1O/PshYgWg8fYOwfaNv3+ZlUBesuXWlFcdr
 u5pIj4z7QtTjzJ1QNtX2BM38lXhHVAPMsGHM9bhgLmIOvmzPeIJO/ujXpGH35k92hm/X7b
 JtnNtcQc4VOimMLuriDSrADDutF3fU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-EGXm9640N5ackl0UHegazA-1; Thu, 16 Jan 2020 07:37:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72CC1137858;
 Thu, 16 Jan 2020 12:37:07 +0000 (UTC)
Received: from localhost (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F247927098;
 Thu, 16 Jan 2020 12:37:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] s390x/flic: adapter routes handling if !kernel_irqchip
Date: Thu, 16 Jan 2020 13:37:03 +0100
Message-Id: <20200116123703.14624-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: EGXm9640N5ackl0UHegazA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the kernel irqchip has been disabled, we don't want the
{add,release}_adapter_routes routines to call any kvm_irqchip_*
interfaces, as they may rely on an irqchip actually having been
created. Just take a quick exit in that case instead.

Fixes: d426d9fba8ea ("s390x/virtio-ccw: wire up irq routing and irqfds")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Without this patch, QEMU with kernel_irqchip=3Doff will crash in
kvm_irqchip_release_virq(), so alternatively, we could add a check
there. kvm_irqchip_add_adapter_route() is actually fine.

---
 hw/intc/s390_flic_kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index dddd33ea61c8..44b7960ebcc8 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -331,6 +331,10 @@ static int kvm_s390_add_adapter_routes(S390FLICState *=
fs,
     int ret, i;
     uint64_t ind_offset =3D routes->adapter.ind_offset;
=20
+    if (!kvm_gsi_routing_enabled()) {
+        return -ENOSYS;
+    }
+
     for (i =3D 0; i < routes->num_routes; i++) {
         ret =3D kvm_irqchip_add_adapter_route(kvm_state, &routes->adapter)=
;
         if (ret < 0) {
@@ -358,6 +362,10 @@ static void kvm_s390_release_adapter_routes(S390FLICSt=
ate *fs,
 {
     int i;
=20
+    if (!kvm_gsi_routing_enabled()) {
+        return;
+    }
+
     for (i =3D 0; i < routes->num_routes; i++) {
         if (routes->gsi[i] >=3D 0) {
             kvm_irqchip_release_virq(kvm_state, routes->gsi[i]);
--=20
2.21.1


