Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE2DC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA702082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnS4d80U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA702082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5qS-0008Jh-3t
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lX-0007Cf-64
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lV-0004uF-Oo
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5lV-0004tc-6s
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJOcx0OjtOmXGJ3hnRw2y1yspKqO3K36s9ct7/O20m8=;
 b=KnS4d80UG+2hImL+BCCSuHupLo/o6tguFiMrjfIxUjxLSfWPExHdojbNXhqLUkkYu1CiQH
 W29Q8o8c4oOuz5z7evgSZ4lhXhnatExbW7jSGT1YjxezAsLNNaIApC8iWn2uITE+hlp8HY
 2bRfjkgsZ0pLNw0izM8SltW8DZPxIcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-1Au9xXfQOxG1c9xn-r0oQA-1; Thu, 30 Apr 2020 05:45:54 -0400
X-MC-Unique: 1Au9xXfQOxG1c9xn-r0oQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31FA08018AD;
 Thu, 30 Apr 2020 09:45:53 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD6C52B4A5;
 Thu, 30 Apr 2020 09:45:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/20] s390x: protvirt: Move IO control structures over SIDA
Date: Thu, 30 Apr 2020 11:44:39 +0200
Message-Id: <20200430094445.25943-15-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

For protected guests, we need to put the IO emulation results into the
SIDA, so SIE will write them into the guest at the next entry.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-14-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/ioinst.c | 61 +++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 8828482eec30..7a14c52c123b 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -138,7 +138,9 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, ui=
nt32_t ipb, uintptr_t ra)
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, addr, &schib, sizeof(schib));
+    } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib)=
)) {
         s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
@@ -195,7 +197,9 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, ui=
nt32_t ipb, uintptr_t ra)
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
     }
-    if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, addr, &orig_orb, sizeof(orb));
+    } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb=
))) {
         s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
@@ -231,14 +235,19 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, =
uintptr_t ra)
     cc =3D css_do_stcrw(&crw);
     /* 0 - crw stored, 1 - zeroes stored */
=20
-    if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) =3D=3D 0=
) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(cpu, addr, &crw, sizeof(crw));
         setcc(cpu, cc);
     } else {
-        if (cc =3D=3D 0) {
-            /* Write failed: requeue CRW since STCRW is suppressing */
-            css_undo_stcrw(&crw);
+        if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) =3D=
=3D 0) {
+            setcc(cpu, cc);
+        } else {
+            if (cc =3D=3D 0) {
+                /* Write failed: requeue CRW since STCRW is suppressing */
+                css_undo_stcrw(&crw);
+            }
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
         }
-        s390_cpu_virt_mem_handle_exc(cpu, ra);
     }
 }
=20
@@ -260,6 +269,13 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, =
uint32_t ipb,
     }
=20
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        /*
+         * The Ultravisor checks schid bit 16 to be one and bits 0-12
+         * to be 0 and injects a operand exception itself.
+         *
+         * Hence we should never end up here.
+         */
+        g_assert(!s390_is_pv());
         /*
          * As operand exceptions have a lower priority than access excepti=
ons,
          * we check whether the memory area is writeable (injecting the
@@ -292,14 +308,17 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1,=
 uint32_t ipb,
         }
     }
     if (cc !=3D 3) {
-        if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
-                                    sizeof(schib)) !=3D 0) {
+        if (s390_is_pv()) {
+            s390_cpu_pv_mem_write(cpu, addr, &schib, sizeof(schib));
+        } else if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
+                                           sizeof(schib)) !=3D 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
     } else {
         /* Access exceptions have a higher priority than cc3 */
-        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib)) !=
=3D 0) {
+        if (!s390_is_pv() &&
+            s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib)) !=
=3D 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
@@ -336,7 +355,9 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uin=
t32_t ipb, uintptr_t ra)
     }
     /* 0 - status pending, 1 - not status pending, 3 - not operational */
     if (cc !=3D 3) {
-        if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) !=3D 0) =
{
+        if (s390_is_pv()) {
+            s390_cpu_pv_mem_write(cpu, addr, &irb, irb_len);
+        } else if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) !=
=3D 0) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return -EFAULT;
         }
@@ -344,7 +365,8 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uin=
t32_t ipb, uintptr_t ra)
     } else {
         irb_len =3D sizeof(irb) - sizeof(irb.emw);
         /* Access exceptions have a higher priority than cc3 */
-        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) !=3D 0) =
{
+        if (!s390_is_pv() &&
+            s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) !=3D 0) =
{
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return -EFAULT;
         }
@@ -642,7 +664,9 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uin=
tptr_t ra)
      * present CHSC sub-handlers ... if we ever need more, we should take
      * care of req->len here first.
      */
-    if (s390_cpu_virt_mem_read(cpu, addr, reg, buf, sizeof(ChscReq))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, addr, buf, sizeof(ChscReq));
+    } else if (s390_cpu_virt_mem_read(cpu, addr, reg, buf, sizeof(ChscReq)=
)) {
         s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
@@ -675,11 +699,16 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, u=
intptr_t ra)
         break;
     }
=20
-    if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
-                                 be16_to_cpu(res->len))) {
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(cpu, addr + len, res, be16_to_cpu(res->len))=
;
         setcc(cpu, 0);    /* Command execution complete */
     } else {
-        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
+                                     be16_to_cpu(res->len))) {
+            setcc(cpu, 0);    /* Command execution complete */
+        } else {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+        }
     }
 }
=20
--=20
2.21.1


