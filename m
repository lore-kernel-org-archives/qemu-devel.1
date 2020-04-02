Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B09C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92F6206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUxYGkdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92F6206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8Fd-0006YU-T4
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jK8DS-0002Dk-MI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jK8DR-0007ap-GA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jK8DR-0007ah-Cd
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585866097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bk5VqIK038e7G5IPRCsE90+B2JrEtJOic+qVj7wHDQU=;
 b=iUxYGkdtLtuH06csAcf6gUM/e703p4DVX+CwIQSgTTcUkDog2sxj3T7gH2+TTsnOzPBp2+
 zmxoATjU4oNO7O1472FvVrAhz1Sj2BzBts+HJV+KBl7dv1G8gxb7ZLXN1KAHmnPLm/MnSF
 nheSA6t+nsPFn3UDvaRAEuT8qRz7v3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-DERb047rPj-5PIbnUN7pPw-1; Thu, 02 Apr 2020 18:21:34 -0400
X-MC-Unique: DERb047rPj-5PIbnUN7pPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A5F18A6EC0;
 Thu,  2 Apr 2020 22:21:33 +0000 (UTC)
Received: from localhost (ovpn-116-71.gru2.redhat.com [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3221089F0A;
 Thu,  2 Apr 2020 22:21:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 7/9] i386: Fix pkg_id offset for EPYC cpu models
Date: Thu,  2 Apr 2020 19:20:49 -0300
Message-Id: <20200402222051.523093-8-ehabkost@redhat.com>
In-Reply-To: <20200402222051.523093-1-ehabkost@redhat.com>
References: <20200402222051.523093-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

If the system is numa configured the pkg_offset needs
to be adjusted for EPYC cpu models. Fix it calling the
model specific handler.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <158396725589.58170.16424607815207074485.stgit@naples-babu.amd.=
com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c      | 1 +
 target/i386/cpu.c | 4 ++--
 target/i386/cpu.h | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b58925d063..5143c51653 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1526,6 +1526,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
=20
     env->nr_dies =3D x86ms->smp_dies;
     env->nr_nodes =3D topo_info.nodes_per_pkg;
+    env->pkg_offset =3D x86ms->apicid_pkg_offset(&topo_info);
=20
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 468e03a153..6ad24774c5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5610,7 +5610,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax =3D apicid_pkg_offset(&topo_info);
+            *eax =3D env->pkg_offset;
             *ebx =3D cs->nr_cores * cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5644,7 +5644,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax =3D apicid_pkg_offset(&topo_info);
+            *eax =3D env->pkg_offset;
             *ebx =3D env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |=3D CPUID_TOPOLOGY_LEVEL_DIE;
             break;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8227479c94..e818fc712a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1610,6 +1610,7 @@ typedef struct CPUX86State {
=20
     unsigned nr_dies;
     unsigned nr_nodes;
+    unsigned pkg_offset;
 } CPUX86State;
=20
 struct kvm_msrs;
--=20
2.24.1


