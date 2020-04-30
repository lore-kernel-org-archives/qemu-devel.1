Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46335C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA64214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COv8x8K1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA64214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5nt-00044p-6h
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5l5-0006BD-3H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5l2-0003m8-8U
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5l1-0003l1-Q3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spc9pBJlBPplWaKVu6x/YhfSRkiSVaKGDS1D5vyH1X0=;
 b=COv8x8K1jZiVnlgX6j38N82CuRIAS9jSJBXrY99uX/GcUBjTsLlXlO94Xm4VVOgTFUopi/
 HV0qQzTYn7DLoLbUNed6+xbr134mVBKtJW+SohidQM3azdfY6NOlfk0VdNsbUN367vauUw
 G6BnWTn/Uys2jLuTjMHD733ZaANWCbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-dcGm6j8VMPedZThAR1r_dw-1; Thu, 30 Apr 2020 05:45:22 -0400
X-MC-Unique: dcGm6j8VMPedZThAR1r_dw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C491107BEF5;
 Thu, 30 Apr 2020 09:45:21 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B04DE605DD;
 Thu, 30 Apr 2020 09:45:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/20] s390x: protvirt: Inhibit balloon when switching to
 protected mode
Date: Thu, 30 Apr 2020 11:44:31 +0200
Message-Id: <20200430094445.25943-7-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Ballooning in protected VMs can only be done when the guest shares the
pages it gives to the host. If pages are not shared, the integrity
checks will fail once those pages have been altered and are given back
to the guest.

As we currently do not yet have a solution for this we will continue
like this:

1. We block ballooning now in QEMU (with this patch).

2. Later we will provide a change to virtio that removes the blocker
and adds VIRTIO_F_IOMMU_PLATFORM automatically by QEMU when doing the
protvirt switch. This is OK, as the balloon driver in Linux (the only
supported guest) will refuse to work with the IOMMU_PLATFORM feature
bit set.

3. Later, we can fix the guest balloon driver to accept the IOMMU
feature bit and correctly exercise sharing and unsharing of balloon
pages.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-6-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e00040a00ba6..db45249320ab 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -43,6 +43,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/balloon.h"
 #include "hw/s390x/pv.h"
 #include <linux/kvm.h>
 #include "migration/blocker.h"
@@ -329,6 +330,7 @@ static void s390_machine_unprotect(S390CcwMachineState =
*ms)
     ms->pv =3D false;
     migrate_del_blocker(pv_mig_blocker);
     error_free_or_abort(&pv_mig_blocker);
+    qemu_balloon_inhibit(false);
 }
=20
 static int s390_machine_protect(S390CcwMachineState *ms)
@@ -336,10 +338,18 @@ static int s390_machine_protect(S390CcwMachineState *=
ms)
     Error *local_err =3D NULL;
     int rc;
=20
+   /*
+    * Ballooning on protected VMs needs support in the guest for
+    * sharing and unsharing balloon pages. Block ballooning for
+    * now, until we have a solution to make at least Linux guests
+    * either support it or fail gracefully.
+    */
+    qemu_balloon_inhibit(true);
     error_setg(&pv_mig_blocker,
                "protected VMs are currently not migrateable.");
     rc =3D migrate_add_blocker(pv_mig_blocker, &local_err);
     if (rc) {
+        qemu_balloon_inhibit(false);
         error_report_err(local_err);
         error_free_or_abort(&pv_mig_blocker);
         return rc;
@@ -348,6 +358,7 @@ static int s390_machine_protect(S390CcwMachineState *ms=
)
     /* Create SE VM */
     rc =3D s390_pv_vm_enable();
     if (rc) {
+        qemu_balloon_inhibit(false);
         error_report_err(local_err);
         migrate_del_blocker(pv_mig_blocker);
         error_free_or_abort(&pv_mig_blocker);
--=20
2.21.1


