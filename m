Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45349C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4BD2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhC+qGuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4BD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5mR-0000OF-3f
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lP-0006vA-9l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lO-0004t1-Iw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37300
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5lO-0004sp-5N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BS1OTMj3cM/dQU9uL1hNwAoaKVh1h7yVeS/oW2+J0wk=;
 b=hhC+qGuDJAkuuGnLiV470UDTS0YngPi8RjEgOD4DEQAq24E5zoH2etx+pIsjfYlm5Zo5JR
 Rer1XDk6vEnYazgGKAKS1EosX07W2WgRfc4oKaBcLVJc8z6SCPwL+pe3aaTNlKir8HbNVs
 vRfU1UgL2hXM/r5oAFCJl89rVAUwQCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-13skX_mTMBKHuzUy8mjv-A-1; Thu, 30 Apr 2020 05:45:47 -0400
X-MC-Unique: 13skX_mTMBKHuzUy8mjv-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35654835B41;
 Thu, 30 Apr 2020 09:45:46 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 052C026552;
 Thu, 30 Apr 2020 09:45:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/20] s390x: protvirt: Move diag 308 data over SIDA
Date: Thu, 30 Apr 2020 11:44:37 +0200
Message-Id: <20200430094445.25943-13-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

For protected guests the IPIB is written/read to/from the SIDA, so we
need those accesses to go through s390_cpu_pv_mem_read/write().

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-12-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/diag.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b2cbefb8cfe4..1a4842956402 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -75,6 +75,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uin=
t64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs =3D env_cpu(env);
+    S390CPU *cpu =3D S390_CPU(cs);
     uint64_t addr =3D  env->regs[r1];
     uint64_t subcode =3D env->regs[r3];
     IplParameterBlock *iplb;
@@ -111,13 +112,22 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
             return;
         }
         iplb =3D g_new0(IplParameterBlock, 1);
-        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        if (!s390_is_pv()) {
+            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        } else {
+            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
+        }
+
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
             goto out;
         }
=20
-        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+        if (!s390_is_pv()) {
+            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+        } else {
+            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
+        }
=20
         valid =3D subcode =3D=3D DIAG308_PV_SET ? iplb_valid_pv(iplb) : ip=
lb_valid(iplb);
         if (!valid) {
@@ -140,12 +150,17 @@ out:
         } else {
             iplb =3D s390_ipl_get_iplb();
         }
-        if (iplb) {
+        if (!iplb) {
+            env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
+            return;
+        }
+
+        if (!s390_is_pv()) {
             cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-            env->regs[r1 + 1] =3D DIAG_308_RC_OK;
         } else {
-            env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
+            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
         }
+        env->regs[r1 + 1] =3D DIAG_308_RC_OK;
         return;
     case DIAG308_PV_START:
         iplb =3D s390_ipl_get_iplb_pv();
--=20
2.21.1


