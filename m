Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA2CC43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932A4222CD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXZpwr+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932A4222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWm7N-0003jC-OV
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iWm3A-0000Xv-1H
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iWm39-0002bi-1D
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60246
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iWm38-0002bb-TG
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574102818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyxd0sp1/GjKH5UkyrvH4H0BnhF/R8eDGrWX2sUoNmo=;
 b=CXZpwr+lD38Nn0lZPKcDgie/WZ6kp2E9QVwLEnh4wMRuJ8SIVefqwPe3Dg+aps4by/kYEN
 UTWueARKvyGxRLyZ4HVzfoH8vRs+CpLs37qu52+WtgV2Lag9HOk7t1wKIcSA8gIlfgMZbg
 YHZv0Cpkh2s1F3as+CO9C58JXSGKnWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-AiK6UtM3PKudA5-okXXvbA-1; Mon, 18 Nov 2019 13:46:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8193A801FA1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 18:46:56 +0000 (UTC)
Received: from gimli.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54CE719C4F;
 Mon, 18 Nov 2019 18:46:53 +0000 (UTC)
Subject: [PULL 2/3] vfio: don't ignore return value of migrate_add_blocker
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 18 Nov 2019 11:46:53 -0700
Message-ID: <157410280915.24655.2269183247539766479.stgit@gimli.home>
In-Reply-To: <157410270703.24655.9333886493163056872.stgit@gimli.home>
References: <157410270703.24655.9333886493163056872.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AiK6UtM3PKudA5-okXXvbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

When an error occurs in migrate_add_blocker() it sets a
negative return value and uses error pointer we pass in.
Instead of just looking at the error pointer check for a negative return
value and avoid a coverity error because the return value is
set but never used. This fixes CID 1407219.

Reported-by: Coverity (CID 1407219)
Fixes: f045a0104c8c ("vfio: unplug failover primary device before migration=
")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c165995df32..0c55883bba77 100644
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
             vdev->migration_blocker =3D NULL;


