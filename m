Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAABC4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09FC2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj2A9Qj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09FC2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMYW-0002S6-TD
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXD-0000yB-4U
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXA-00089x-T0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSqVm/KgbrzU6qODZkZODJ8w9yZNykzM/TsBNSVpeWk=;
 b=Tj2A9Qj7R+JKAiUY4JgPvOnRjcqqkrIFlvmCg2PJ4LjYYz4ysBhQHm7iTidq1brwxTAkMC
 fJO8AIBxvuLBXHN8mWGkB4dI5/kjN235IP1X8+L6ZISicha8+51Kr952Lk8hdD1oKrwLDy
 Fv42g4qXsGcmUq6mskng+mDg8TnnI8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-XsdCSUo2O4Wk_pKIXQigbg-1; Wed, 04 Nov 2020 12:25:17 -0500
X-MC-Unique: XsdCSUo2O4Wk_pKIXQigbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04B031028D41;
 Wed,  4 Nov 2020 17:25:16 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD11A508E9;
 Wed,  4 Nov 2020 17:25:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] sparc: Fix property/field size mismatch for iu-version
Date: Wed,  4 Nov 2020 12:25:06 -0500
Message-Id: <20201104172512.2381656-2-ehabkost@redhat.com>
In-Reply-To: <20201104172512.2381656-1-ehabkost@redhat.com>
References: <20201104172512.2381656-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "iu-version" property is declared as uint64_t but points to a
target_ulong struct field.  On the sparc 32-bit target, This
makes every write of iu-version corrupt the 4 bytes after
sparc_def_t.iu_version (where the fpu_version field is located).

Change the type of the iu_version struct field to uint64_t,
and just use DEFINE_PROP_UINT64.

The only place where env.def.iu_version field is read is the
    env->version = env->def.iu_version;
assignment at sparc_cpu_realizefn().  This means behavior will be
kept exactly the same (except for the memory corruption bug fix).

It would be nice to explicitly validate iu_version against
target_ulong limits, but that would be a new feature (since the
first version of this code, iu-version was parsed as 64-bit value
value).  It can be done later, once we have an appropriate API to
define limits for integer properties.

Fixes: de05005bf785 ("sparc: convert cpu features to qdev properties")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org
---
 target/sparc/cpu.h | 2 +-
 target/sparc/cpu.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b9369398f2..8ed0f4fef3 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -252,7 +252,7 @@ typedef struct trap_state {
 
 struct sparc_def_t {
     const char *name;
-    target_ulong iu_version;
+    uint64_t iu_version;
     uint32_t fpu_version;
     uint32_t mmu_version;
     uint32_t mmu_bm;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ec59a13eb8..5a9397f19a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -576,7 +576,7 @@ void sparc_cpu_list(void)
     unsigned int i;
 
     for (i = 0; i < ARRAY_SIZE(sparc_defs); i++) {
-        qemu_printf("Sparc %16s IU " TARGET_FMT_lx
+        qemu_printf("Sparc %16s IU %" PRIx64
                     " FPU %08x MMU %08x NWINS %d ",
                     sparc_defs[i].name,
                     sparc_defs[i].iu_version,
@@ -838,8 +838,7 @@ static Property sparc_cpu_properties[] = {
     DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features, 11, false),
     DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
     DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
-    DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
-                         prop_info_uint64, target_ulong),
+    DEFINE_PROP_UINT64("iu-version", SPARCCPU, env.def.iu_version, 0),
     DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
     DEFINE_PROP_UINT32("mmu-version", SPARCCPU, env.def.mmu_version, 0),
     DEFINE_PROP("nwindows",     SPARCCPU, env.def.nwindows,
-- 
2.28.0


