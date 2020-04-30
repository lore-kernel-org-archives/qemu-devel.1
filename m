Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F09C8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B932082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfF9zFWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B932082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5uQ-0006EZ-Vc
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lH-0006cA-1D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lG-0004bf-7w
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20622
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5lF-0004Wg-Ot
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RVvsWyNZUt7E5MwYPz1auAHYOJALy8Yl9ZcQwGtXHs=;
 b=QfF9zFWDFwzL691AD4IRXdgGiAsho3N89/GuKGggGw3qT2uYxKSazHVF0eX+Fef40JAaMG
 M03iR1oXMbVSNsvdbNIZ7/bWi7BkQLGRTfmPTrtkB+1U+8+yeoBjU63zPXUaHWP6vddy5Q
 S09Y3BiFSwnMTIaxjHqI1aUs5i9csIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-5jQDkDiqObmy3ZQlkMwnGQ-1; Thu, 30 Apr 2020 05:45:37 -0400
X-MC-Unique: 5jQDkDiqObmy3ZQlkMwnGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11195107ACCD;
 Thu, 30 Apr 2020 09:45:36 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D889910016E8;
 Thu, 30 Apr 2020 09:45:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/20] s390x: protvirt: SCLP interpretation
Date: Thu, 30 Apr 2020 11:44:35 +0200
Message-Id: <20200430094445.25943-11-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

SCLP for a protected guest is done over the SIDAD, so we need to use
the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
memory when reading/writing SCBs.

To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
since the function that injects the sclp external interrupt would
reject a zero sccb address.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200319131921.2367-10-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c         | 56 +++++++++++++++++++++++++++++++++--------
 include/hw/s390x/sclp.h |  2 ++
 target/s390x/kvm.c      | 25 ++++++++++++++----
 3 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f0c35aa57afd..ede056b3efd7 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -33,6 +33,22 @@ static inline SCLPDevice *get_sclp_device(void)
     return sclp;
 }
=20
+static inline bool sclp_command_code_valid(uint32_t code)
+{
+    switch (code & SCLP_CMD_CODE_MASK) {
+    case SCLP_CMDW_READ_SCP_INFO:
+    case SCLP_CMDW_READ_SCP_INFO_FORCED:
+    case SCLP_CMDW_READ_CPU_INFO:
+    case SCLP_CMDW_CONFIGURE_IOA:
+    case SCLP_CMDW_DECONFIGURE_IOA:
+    case SCLP_CMD_READ_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_DATA:
+    case SCLP_CMD_WRITE_EVENT_MASK:
+        return true;
+    }
+    return false;
+}
+
 static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *co=
unt)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
@@ -193,6 +209,34 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb,=
 uint32_t code)
     }
 }
=20
+/*
+ * We only need the address to have something valid for the
+ * service_interrupt call.
+ */
+#define SCLP_PV_DUMMY_ADDR 0x4000
+int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
+                                uint32_t code)
+{
+    SCLPDevice *sclp =3D get_sclp_device();
+    SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
+    SCCB work_sccb;
+    hwaddr sccb_len =3D sizeof(SCCB);
+
+    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
+
+    if (!sclp_command_code_valid(code)) {
+        work_sccb.h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCLP_COM=
MAND);
+        goto out_write;
+    }
+
+    sclp_c->execute(sclp, &work_sccb, code);
+out_write:
+    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
+                          be16_to_cpu(work_sccb.h.length));
+    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
+    return 0;
+}
+
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
 {
     SCLPDevice *sclp =3D get_sclp_device();
@@ -225,17 +269,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t scc=
b, uint32_t code)
         return -PGM_SPECIFICATION;
     }
=20
-    switch (code & SCLP_CMD_CODE_MASK) {
-    case SCLP_CMDW_READ_SCP_INFO:
-    case SCLP_CMDW_READ_SCP_INFO_FORCED:
-    case SCLP_CMDW_READ_CPU_INFO:
-    case SCLP_CMDW_CONFIGURE_IOA:
-    case SCLP_CMDW_DECONFIGURE_IOA:
-    case SCLP_CMD_READ_EVENT_DATA:
-    case SCLP_CMD_WRITE_EVENT_DATA:
-    case SCLP_CMD_WRITE_EVENT_MASK:
-        break;
-    default:
+    if (!sclp_command_code_valid(code)) {
         work_sccb.h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCLP_COM=
MAND);
         goto out_write;
     }
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index cd7b24359f28..822eff4396ff 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -217,5 +217,7 @@ void s390_sclp_init(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
 int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
+int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
+                                uint32_t code);
=20
 #endif
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e0b61680ab08..870dd1b52b6e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1233,12 +1233,27 @@ static void kvm_sclp_service_call(S390CPU *cpu, str=
uct kvm_run *run,
     sccb =3D env->regs[ipbh0 & 0xf];
     code =3D env->regs[(ipbh0 & 0xf0) >> 4];
=20
-    r =3D sclp_service_call(env, sccb, code);
-    if (r < 0) {
-        kvm_s390_program_interrupt(cpu, -r);
-        return;
+    switch (run->s390_sieic.icptcode) {
+    case ICPT_PV_INSTR_NOTIFICATION:
+        g_assert(s390_is_pv());
+        /* The notification intercepts are currently handled by KVM */
+        error_report("unexpected SCLP PV notification");
+        exit(1);
+        break;
+    case ICPT_PV_INSTR:
+        g_assert(s390_is_pv());
+        sclp_service_call_protected(env, sccb, code);
+        /* Setting the CC is done by the Ultravisor. */
+        break;
+    case ICPT_INSTRUCTION:
+        g_assert(!s390_is_pv());
+        r =3D sclp_service_call(env, sccb, code);
+        if (r < 0) {
+            kvm_s390_program_interrupt(cpu, -r);
+            return;
+        }
+        setcc(cpu, r);
     }
-    setcc(cpu, r);
 }
=20
 static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
--=20
2.21.1


