Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F1C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A52D206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eupM13Rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A52D206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFIY-00087a-1u
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iVFH3-0007HU-J1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iVFH2-0006hf-L3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:35:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20294
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iVFH2-0006cy-63
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573738496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n0F7GP5OBDnX8bTqVEsag6D95SbKx/q+o2G/jKsVy5k=;
 b=eupM13RwjGbeSZFT6+xBRXDFz9T8GsCbsHdi2Vq9tJMqHc2MMN77TzICsmMJFMerAc2g8A
 BhFIGPtgx7ReNMlP/bP4VhNDTkGIpDiqBWrQs3C9aQhufYnHFY8nPbya41Fh3zSAGKws1r
 KN8oICiQgMr9PjbgLWQRASap3Nb3/Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-kO6GKXiDPhORxw0LaRhysA-1; Thu, 14 Nov 2019 08:34:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A95F91223
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 13:34:54 +0000 (UTC)
Received: from localhost (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F2FC5E254;
 Thu, 14 Nov 2019 13:34:51 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vfio: don't ignore return value of migrate_add_blocker
Date: Thu, 14 Nov 2019 14:34:49 +0100
Message-Id: <20191114133449.11536-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: kO6GKXiDPhORxw0LaRhysA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: alex.williamson@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When an error occurs in migrate_add_blocker() it sets a
negative return value and uses error pointer we pass in.
Instead of just looking at the error pointer check for a negative return
value and avoid a coverity error because the return value is
set but never used. This fixes CID 1407219.

Fixes: f045a0104c8c ("vfio: unplug failover primary device before
  migration")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e6569a7968..ed01774673 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2737,7 +2737,7 @@ static void vfio_realize(PCIDevice *pdev, Error **err=
p)
         error_setg(&vdev->migration_blocker,
                 "VFIO device doesn't support migration");
         ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
-        if (err) {
+        if (ret) {
             error_propagate(errp, err);
             error_free(vdev->migration_blocker);
             return;
--=20
2.21.0


