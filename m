Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A100C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E817420758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5cjYEU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E817420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRQc-0006UP-4w
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKm-0002MJ-Ol
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKj-0006w1-Ka
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mo6O26S5Eq2rGa1L34o6YZdfxVHdvdfdOQVwTu0R88=;
 b=W5cjYEU0s8hUqaJ/QjoB2m5/Q/6/nEm3DRpcT31dBUnG4gApO+4Xr7VdczKMyFia1AcitA
 SY7uIqaAXfchLngNyXW9uSCOWPb5TzqI1aZtcmBMKlLf0tS24PfVdYLSixQ9A9DWdAMvlf
 DUm9JON1u7EinY62UKsCbMDRhBQ5N0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Q9I4LRvhOpmfC7No4XQKaw-1; Wed, 02 Sep 2020 07:53:42 -0400
X-MC-Unique: Q9I4LRvhOpmfC7No4XQKaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84F471008303;
 Wed,  2 Sep 2020 11:53:41 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4194E7EB8D;
 Wed,  2 Sep 2020 11:53:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/20] Revert "i386: Fix pkg_id offset for EPYC cpu models"
Date: Wed,  2 Sep 2020 07:53:13 -0400
Message-Id: <20200902115323.850385-11-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

This reverts commit 7b225762c8c05fd31d4c2be116aedfbc00383f8b.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Also fix all the references of pkg_offset.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <159889933119.21294.8112825730577505757.stgit@naples-babu.amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 -
 hw/i386/pc.c      | 1 -
 target/i386/cpu.c | 9 ++++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1a5c174dc..d5ad42d694 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1630,7 +1630,6 @@ typedef struct CPUX86State {
 
     unsigned nr_dies;
     unsigned nr_nodes;
-    unsigned pkg_offset;
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5d8d5ef8b3..6b708f4341 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1502,7 +1502,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     env->nr_dies = x86ms->smp_dies;
     env->nr_nodes = topo_info.nodes_per_pkg;
-    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     /*
      * If APIC ID is not set,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 588f32e136..173e6f4a07 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5678,7 +5678,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = env->pkg_offset;
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5712,7 +5712,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = env->pkg_offset;
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
@@ -5889,11 +5889,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /*
              * Bits 15:12 is "The number of bits in the initial
              * Core::X86::Apic::ApicId[ApicId] value that indicate
-             * thread ID within a package". This is already stored at
-             * CPUX86State::pkg_offset.
+             * thread ID within a package".
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
-            *ecx = (env->pkg_offset << 12) |
+            *ecx = (apicid_pkg_offset(&topo_info) << 12) |
                    ((cs->nr_cores * cs->nr_threads) - 1);
         } else {
             *ecx = 0;
-- 
2.26.2


