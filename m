Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2034BC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECE220838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnQrQqf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECE220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU61D-00081J-RZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lz-0008Rd-A4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5ly-0005o8-ID
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5ly-0005lB-2N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+FYK0gZ2oue/dMjLCxLFtn8kIVzjoVNJyGIFXndMIU=;
 b=HnQrQqf/GSiRqeT27w3W2uOiJsGguz5dRhOFQfKSQ8F0T0ulKgBVZgRgqMfF8SeRVCrqGd
 atnV04RxdObVjScJxyoiXP1y08zJhh1JZSSfWTunWlAoEzg5TUnqTQEEbng/CwJ0eE8jeF
 O9a/1MjloBZAcBK52LimUzUv9KVywcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-KpkDlPz8OWWTpbqA0KhIKA-1; Thu, 30 Apr 2020 05:46:21 -0400
X-MC-Unique: KpkDlPz8OWWTpbqA0KhIKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BCC919200C2;
 Thu, 30 Apr 2020 09:46:20 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 263CB5C1B0;
 Thu, 30 Apr 2020 09:46:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 20/20] s390x/s390-virtio-ccw: Fix build on systems without KVM
Date: Thu, 30 Apr 2020 11:44:45 +0200
Message-Id: <20200430094445.25943-21-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

linux/kvm.h is not available on all platforms. Let us move
s390_machine_inject_pv_error into pv.c as it uses KVM structures.
Also rename the function to s390_pv_inject_reset_error.

While at it, ipl.h needs an include for "exec/address-spaces.h"
as it uses address_space_memory.

Fixes: c3347ed0d2ee ("s390x: protvirt: Support unpack facility")
Reported-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200406100158.5940-2-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.h             |  1 +
 hw/s390x/pv.c              | 11 +++++++++++
 hw/s390x/s390-virtio-ccw.c | 12 +-----------
 include/hw/s390x/pv.h      |  3 +++
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 89b3044d7a2e..53cc9eb5ac4d 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -14,6 +14,7 @@
 #define HW_S390_IPL_H
=20
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
=20
 struct IPLBlockPVComp {
diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index cb0dce4a4f06..f11868e865fa 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -13,8 +13,10 @@
=20
 #include <linux/kvm.h>
=20
+#include "cpu.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "hw/s390x/ipl.h"
 #include "hw/s390x/pv.h"
=20
 static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
@@ -100,3 +102,12 @@ void s390_pv_unshare(void)
 {
     s390_pv_cmd_exit(KVM_PV_UNSHARE_ALL, NULL);
 }
+
+void s390_pv_inject_reset_error(CPUState *cs)
+{
+    int r1 =3D (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
+    CPUS390XState *env =3D &S390_CPU(cs)->env;
+
+    /* Report that we are unable to enter protected mode */
+    env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
+}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b2689073953e..45292fb5a8b6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,7 +45,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "hw/s390x/pv.h"
-#include <linux/kvm.h>
 #include "migration/blocker.h"
=20
 static Error *pv_mig_blocker;
@@ -390,15 +389,6 @@ out_err:
     return rc;
 }
=20
-static void s390_machine_inject_pv_error(CPUState *cs)
-{
-    int r1 =3D (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
-    CPUS390XState *env =3D &S390_CPU(cs)->env;
-
-    /* Report that we are unable to enter protected mode */
-    env->regs[r1 + 1] =3D DIAG_308_RC_INVAL_FOR_PV;
-}
-
 static void s390_pv_prepare_reset(S390CcwMachineState *ms)
 {
     CPUState *cs;
@@ -484,7 +474,7 @@ static void s390_machine_reset(MachineState *machine)
         run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
=20
         if (s390_machine_protect(ms)) {
-            s390_machine_inject_pv_error(cs);
+            s390_pv_inject_reset_error(cs);
             /*
              * Continue after the diag308 so the guest knows something
              * went wrong.
diff --git a/include/hw/s390x/pv.h b/include/hw/s390x/pv.h
index c6cb360f2f6a..522ca6a04ee8 100644
--- a/include/hw/s390x/pv.h
+++ b/include/hw/s390x/pv.h
@@ -13,6 +13,7 @@
 #define HW_S390_PV_H
=20
 #ifdef CONFIG_KVM
+#include "cpu.h"
 #include "hw/s390x/s390-virtio-ccw.h"
=20
 static inline bool s390_is_pv(void)
@@ -41,6 +42,7 @@ int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t=
 tweak);
 void s390_pv_perf_clear_reset(void);
 int s390_pv_verify(void);
 void s390_pv_unshare(void);
+void s390_pv_inject_reset_error(CPUState *cs);
 #else /* CONFIG_KVM */
 static inline bool s390_is_pv(void) { return false; }
 static inline int s390_pv_vm_enable(void) { return 0; }
@@ -50,6 +52,7 @@ static inline int s390_pv_unpack(uint64_t addr, uint64_t =
size, uint64_t tweak) {
 static inline void s390_pv_perf_clear_reset(void) {}
 static inline int s390_pv_verify(void) { return 0; }
 static inline void s390_pv_unshare(void) {}
+static inline void s390_pv_inject_reset_error(CPUState *cs) {};
 #endif /* CONFIG_KVM */
=20
 #endif /* HW_S390_PV_H */
--=20
2.21.1


