Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CB920658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUGyoiid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CB920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxIl-0004za-NP
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH4-0002Xy-NS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH3-0000qM-2q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxH2-0000lv-Rr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CuM6HjQBtuKhH+tgQISPrj7uZw8Cf0Ok4K0Lu3+tI5Y=;
 b=QUGyoiidgVuHRLBG4NNRRF5SMs3JKUyv/j76KZzS2kZeLZashgfoDnMb/49jtZ6Ef9VCak
 NISUsvMkEegmOlYLWbm5qnFcuca3K0yXk45ddI0x886Y9rh+qMZvoLwnO06BUpO25L9VcG
 XlnL8PL0zAfx9QrOMZQ/M/FTmpeORSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-xQO1e_9ePBGz64qBxz7oLg-1; Mon, 16 Mar 2020 17:27:46 -0400
X-MC-Unique: xQO1e_9ePBGz64qBxz7oLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF57107ACC7;
 Mon, 16 Mar 2020 21:27:45 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B9EE19C4F;
 Mon, 16 Mar 2020 21:27:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/61] WHPX: Use QEMU values for trapped CPUID
Date: Mon, 16 Mar 2020 22:26:35 +0100
Message-Id: <1584394048-44994-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Currently, WHPX is using some default values for the trapped CPUID
functions. These were not in sync with the QEMU values because the
CPUID values were never set with WHPX during VCPU initialization.
Additionally, at the moment, WHPX doesn't support setting CPUID
values in the hypervisor at runtime (i.e. after the partition has
been setup). That is needed to be able to set the CPUID values in
the hypervisor during VCPU init.
Until that support comes, use the QEMU values for the trapped CPUIDs.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Message-Id: <SN4PR2101MB0880A8323EAD0CD0E8E2F423C0EB0@SN4PR2101MB0880.nampr=
d21.prod.outlook.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx-all.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index b947eb1..cb863b7 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1044,38 +1044,32 @@ static int whpx_vcpu_run(CPUState *cpu)
             WHV_REGISTER_VALUE reg_values[5];
             WHV_REGISTER_NAME reg_names[5];
             UINT32 reg_count =3D 5;
-            UINT64 rip, rax, rcx, rdx, rbx;
+            UINT64 cpuid_fn, rip =3D 0, rax =3D 0, rcx =3D 0, rdx =3D 0, r=
bx =3D 0;
+            X86CPU *x86_cpu =3D X86_CPU(cpu);
+            CPUX86State *env =3D &x86_cpu->env;
=20
             memset(reg_values, 0, sizeof(reg_values));
=20
             rip =3D vcpu->exit_ctx.VpContext.Rip +
                   vcpu->exit_ctx.VpContext.InstructionLength;
-            switch (vcpu->exit_ctx.CpuidAccess.Rax) {
-            case 1:
-                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-                /* Advertise that we are running on a hypervisor */
-                rcx =3D
-                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx |
-                    CPUID_EXT_HYPERVISOR;
-
-                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
-                break;
+            cpuid_fn =3D vcpu->exit_ctx.CpuidAccess.Rax;
+
+            /*
+             * Ideally, these should be supplied to the hypervisor during =
VCPU
+             * initialization and it should be able to satisfy this reques=
t.
+             * But, currently, WHPX doesn't support setting CPUID values i=
n the
+             * hypervisor once the partition has been setup, which is too =
late
+             * since VCPUs are realized later. For now, use the values fro=
m
+             * QEMU to satisfy these requests, until WHPX adds support for
+             * being able to set these values in the hypervisor at runtime=
.
+             */
+            cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx=
,
+                (UINT32 *)&rcx, (UINT32 *)&rdx);
+            switch (cpuid_fn) {
             case 0x80000001:
-                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
                 /* Remove any support of OSVW */
-                rcx =3D
-                    vcpu->exit_ctx.CpuidAccess.DefaultResultRcx &
-                    ~CPUID_EXT3_OSVW;
-
-                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                rcx &=3D ~CPUID_EXT3_OSVW;
                 break;
-            default:
-                rax =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-                rcx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
-                rdx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                rbx =3D vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
             }
=20
             reg_names[0] =3D WHvX64RegisterRip;
--=20
1.8.3.1



