Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57916C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200CB2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1RwPpwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200CB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5w7-0001gh-A4
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lX-0007D8-E2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lV-0004u3-JB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5lV-0004tW-3c
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xx4GnwwIMEZJpXo95gX5MFEhzflTgauEL/OXE4r4toA=;
 b=E1RwPpwlGGwFYECfvbchJssKoMfU3bNYi4Fpv3+Ywo87RqV+TPFu9tVoOIfbp1A54ZRPfJ
 Z7R1zUYrTvYjpRaogQSXY1dwEbFKrQQ/AZdAxmvappWZIUMQVICL0U2cXSt+udiD9ugXhf
 5nTB+qJU8l2wjBoLE75iv0/3P7hjuCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-KZlcrWHhPz63v_1j0cQ0qA-1; Thu, 30 Apr 2020 05:45:52 -0400
X-MC-Unique: KZlcrWHhPz63v_1j0cQ0qA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D803A7BB3;
 Thu, 30 Apr 2020 09:45:50 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8BBE5117E;
 Thu, 30 Apr 2020 09:45:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/20] s390x: protvirt: Disable address checks for PV guest IO
 emulation
Date: Thu, 30 Apr 2020 11:44:38 +0200
Message-Id: <20200430094445.25943-14-cohuck@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

IO instruction data is routed through SIDAD for protected guests, so
adresses do not need to be checked, as this is kernel memory which is
always available.

Also the instruction data always starts at offset 0 of the SIDAD.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-13-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/ioinst.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 0e840cc5792a..8828482eec30 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -16,6 +16,25 @@
 #include "hw/s390x/ioinst.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
+#include "hw/s390x/pv.h"
+
+/* All I/O instructions but chsc use the s format */
+static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
+                                      uint8_t *ar)
+{
+    /*
+     * Addresses for protected guests are all offsets into the
+     * satellite block which holds the IO control structures. Those
+     * control structures are always starting at offset 0 and are
+     * always aligned and accessible. So we can return 0 here which
+     * will pass the following address checks.
+     */
+    if (s390_is_pv()) {
+        *ar =3D 0;
+        return 0;
+    }
+    return decode_basedisp_s(env, ipb, ar);
+}
=20
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *=
ssid,
                                  int *schid)
@@ -114,7 +133,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, ui=
nt32_t ipb, uintptr_t ra)
     CPUS390XState *env =3D &cpu->env;
     uint8_t ar;
=20
-    addr =3D decode_basedisp_s(env, ipb, &ar);
+    addr =3D get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -171,7 +190,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, ui=
nt32_t ipb, uintptr_t ra)
     CPUS390XState *env =3D &cpu->env;
     uint8_t ar;
=20
-    addr =3D decode_basedisp_s(env, ipb, &ar);
+    addr =3D get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -203,7 +222,7 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, ui=
ntptr_t ra)
     CPUS390XState *env =3D &cpu->env;
     uint8_t ar;
=20
-    addr =3D decode_basedisp_s(env, ipb, &ar);
+    addr =3D get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -234,7 +253,7 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, u=
int32_t ipb,
     CPUS390XState *env =3D &cpu->env;
     uint8_t ar;
=20
-    addr =3D decode_basedisp_s(env, ipb, &ar);
+    addr =3D get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
@@ -303,7 +322,7 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uin=
t32_t ipb, uintptr_t ra)
         return -EIO;
     }
     trace_ioinst_sch_id("tsch", cssid, ssid, schid);
-    addr =3D decode_basedisp_s(env, ipb, &ar);
+    addr =3D get_address_from_regs(env, ipb, &ar);
     if (addr & 3) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -EIO;
@@ -601,7 +620,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uin=
tptr_t ra)
 {
     ChscReq *req;
     ChscResp *res;
-    uint64_t addr;
+    uint64_t addr =3D 0;
     int reg;
     uint16_t len;
     uint16_t command;
@@ -610,7 +629,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uin=
tptr_t ra)
=20
     trace_ioinst("chsc");
     reg =3D (ipb >> 20) & 0x00f;
-    addr =3D env->regs[reg];
+    if (!s390_is_pv()) {
+        addr =3D env->regs[reg];
+    }
     /* Page boundary? */
     if (addr & 0xfff) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
--=20
2.21.1


