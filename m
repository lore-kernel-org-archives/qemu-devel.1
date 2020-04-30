Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE1C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A762082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxd62dx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A762082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5pR-0006r8-8E
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5kx-0005xI-0H
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5kv-0003KT-Ik
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5kv-0003H5-3C
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vQseW9xGDpCMesRX0DZUCewOpDoFT2h2kquDmKVOYE=;
 b=bxd62dx6AGUhmURDlCRMENSb+4Cx87vUnxBxZckfhLjjHcyvJj8wm6cK/feAMTFbefFPUn
 7ioFKYFG2bYgMNlEedNmekj+n8sSWRV804GZQh31FMadaXlzAtNaD/07DBX+oSRCa4fx+J
 R+qjpg3KoydKSDgRyfRqFlZ9miBvSDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-rs3pTTNzNVGZqu9lrZXWng-1; Thu, 30 Apr 2020 05:45:18 -0400
X-MC-Unique: rs3pTTNzNVGZqu9lrZXWng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5B9B1005510;
 Thu, 30 Apr 2020 09:45:16 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A00785EDE3;
 Thu, 30 Apr 2020 09:45:13 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/20] s390x: protvirt: Add migration blocker
Date: Thu, 30 Apr 2020 11:44:30 +0200
Message-Id: <20200430094445.25943-6-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Migration is not yet supported.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-5-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b4d681da43af..e00040a00ba6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,6 +45,9 @@
 #include "sysemu/sysemu.h"
 #include "hw/s390x/pv.h"
 #include <linux/kvm.h>
+#include "migration/blocker.h"
+
+static Error *pv_mig_blocker;
=20
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -324,15 +327,30 @@ static void s390_machine_unprotect(S390CcwMachineStat=
e *ms)
 {
     s390_pv_vm_disable();
     ms->pv =3D false;
+    migrate_del_blocker(pv_mig_blocker);
+    error_free_or_abort(&pv_mig_blocker);
 }
=20
 static int s390_machine_protect(S390CcwMachineState *ms)
 {
+    Error *local_err =3D NULL;
     int rc;
=20
+    error_setg(&pv_mig_blocker,
+               "protected VMs are currently not migrateable.");
+    rc =3D migrate_add_blocker(pv_mig_blocker, &local_err);
+    if (rc) {
+        error_report_err(local_err);
+        error_free_or_abort(&pv_mig_blocker);
+        return rc;
+    }
+
     /* Create SE VM */
     rc =3D s390_pv_vm_enable();
     if (rc) {
+        error_report_err(local_err);
+        migrate_del_blocker(pv_mig_blocker);
+        error_free_or_abort(&pv_mig_blocker);
         return rc;
     }
=20
--=20
2.21.1


