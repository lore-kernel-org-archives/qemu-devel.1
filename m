Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A402074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A15F1utx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A402074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhESZ-0000hB-PV
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQC-0004dv-Js
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQB-000224-Td
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591371495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TxaCHgB2fK2kQxCyRNCkFcnDElrURaziYY/3ClYoEA=;
 b=A15F1utx5uY2VFf1O0rTI+rG/dMW4MzVeZswhInn+0LqqGjCLckU3WxlDF6CytbuVHQASe
 0H9+6PqIsHTp4PkdwT55GW45lEMrumgmNI2QYTKh4v1K1N1lPV5Uexw1w17C0jXbTG+yaC
 Zj5vBWWW+UCB/FQUebkMafni0Wtbg+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-cw15HUhoPb2uzNlz37J8vA-1; Fri, 05 Jun 2020 11:38:10 -0400
X-MC-Unique: cw15HUhoPb2uzNlz37J8vA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9F78018A7;
 Fri,  5 Jun 2020 15:38:09 +0000 (UTC)
Received: from localhost (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E78C860C1C;
 Fri,  5 Jun 2020 15:38:05 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/10] s390x: pv: Fix KVM_PV_PREP_RESET command wrapper name
Date: Fri,  5 Jun 2020 17:37:48 +0200
Message-Id: <20200605153756.392825-3-cohuck@redhat.com>
In-Reply-To: <20200605153756.392825-1-cohuck@redhat.com>
References: <20200605153756.392825-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

s390_pv_perf_clear_reset() is not a very helpful name since that
function needs to be called for a normal and a clear reset via
diag308.

Let's instead name it s390_pv_prep_reset() which reflects the purpose
of the function a bit better.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200505124159.24099-1-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/pv.c              | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 include/hw/s390x/pv.h      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index f11868e865fa..ab3a2482aad7 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -88,7 +88,7 @@ int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
     return s390_pv_cmd(KVM_PV_UNPACK, &args);
 }
 
-void s390_pv_perf_clear_reset(void)
+void s390_pv_prep_reset(void)
 {
     s390_pv_cmd_exit(KVM_PV_PREP_RESET, NULL);
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 67ae2e02ffd8..60b16fef77f7 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -401,7 +401,7 @@ static void s390_pv_prepare_reset(S390CcwMachineState *ms)
         s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
     }
     s390_pv_unshare();
-    s390_pv_perf_clear_reset();
+    s390_pv_prep_reset();
 }
 
 static void s390_machine_reset(MachineState *machine)
diff --git a/include/hw/s390x/pv.h b/include/hw/s390x/pv.h
index 522ca6a04ee8..aee758bc2d34 100644
--- a/include/hw/s390x/pv.h
+++ b/include/hw/s390x/pv.h
@@ -39,7 +39,7 @@ int s390_pv_vm_enable(void);
 void s390_pv_vm_disable(void);
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
 int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
-void s390_pv_perf_clear_reset(void);
+void s390_pv_prep_reset(void);
 int s390_pv_verify(void);
 void s390_pv_unshare(void);
 void s390_pv_inject_reset_error(CPUState *cs);
@@ -49,7 +49,7 @@ static inline int s390_pv_vm_enable(void) { return 0; }
 static inline void s390_pv_vm_disable(void) {}
 static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) { return 0; }
 static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0; }
-static inline void s390_pv_perf_clear_reset(void) {}
+static inline void s390_pv_prep_reset(void) {}
 static inline int s390_pv_verify(void) { return 0; }
 static inline void s390_pv_unshare(void) {}
 static inline void s390_pv_inject_reset_error(CPUState *cs) {};
-- 
2.25.4


