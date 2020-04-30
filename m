Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E486C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B322082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjIpHhw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B322082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5sT-0003bf-2s
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lD-0006W2-Qg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lC-0004JR-4S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5lB-0004Fr-Kv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apNWU87hjHVa2GIW98twXqWvFvTWdJCln2F4EMeiPdg=;
 b=XjIpHhw13kNyVfUrxw+3xPUNrS1ye8ub3vQsTwQjnoWFCgvbiEpiXq9G98KgMXks0/OKr9
 4hykQlV39hPkRNMtFlIqHxpqM7+R4bWQ5r+PdbDoHXWcQMXKmtgtnXGpMcRKKAq24Tv3as
 AJUFEOnLuuOBjb58XBSxvePWDNWR/oA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-wDdpvzChNm2mXfkHDpK00g-1; Thu, 30 Apr 2020 05:45:32 -0400
X-MC-Unique: wDdpvzChNm2mXfkHDpK00g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B08F8005B7;
 Thu, 30 Apr 2020 09:45:31 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B965060FC2;
 Thu, 30 Apr 2020 09:45:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/20] s390x: protvirt: Move STSI data over SIDAD
Date: Thu, 30 Apr 2020 11:44:34 +0200
Message-Id: <20200430094445.25943-10-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

For protected guests, we need to put the STSI emulation results into
the SIDA, so SIE will write them into the guest at the next entry.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-9-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0e93778ed15d..e0b61680ab08 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -50,6 +50,7 @@
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-virtio-hcall.h"
+#include "hw/s390x/pv.h"
=20
 #ifndef DEBUG_KVM
 #define DEBUG_KVM  0
@@ -1808,7 +1809,9 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 add=
r, uint8_t ar)
     SysIB_322 sysib;
     int del, i;
=20
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, 0, &sysib, sizeof(sysib));
+    } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib)=
)) {
         return;
     }
     /* Shift the stack of Extended Names to prepare for our own data */
@@ -1861,7 +1864,11 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 ad=
dr, uint8_t ar)
     /* Insert UUID */
     memcpy(sysib.vm[0].uuid, &qemu_uuid, sizeof(sysib.vm[0].uuid));
=20
-    s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, sizeof(sysib));
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(cpu, 0, &sysib, sizeof(sysib));
+    } else {
+        s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, sizeof(sysib));
+    }
 }
=20
 static int handle_stsi(S390CPU *cpu)
--=20
2.21.1


