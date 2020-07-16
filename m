Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A82DC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D32E2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUcScb76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D32E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw8Vw-0005tP-89
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TU-0001BF-Fm
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jw8TS-0004nC-F4
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594923552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKxXY1WLpW8mzGCjBSCDIY0axBhexEozJDmheXWNOmQ=;
 b=MUcScb76xj1GV9MtEvfJWHFx/JB8Yq0KPnoQjlrcOt7zQulWseOocQhba+jiFuTT/trZc1
 2o8A6Tn7/D1prHfsMqdjxSAAdph4kV5sYeokaNDTaSowqZT4t9lR5oWT5pIDCvgO22zerV
 b2HKZUDGvZaYd4ons4lQ4ddXXUsyS/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-IBcHGkLyMH-FJ5mVu73_ZA-1; Thu, 16 Jul 2020 14:19:07 -0400
X-MC-Unique: IBcHGkLyMH-FJ5mVu73_ZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 345C615C27;
 Thu, 16 Jul 2020 18:19:06 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D097372ACF;
 Thu, 16 Jul 2020 18:19:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 1/6] i368/cpu: Clear env->user_features after loading versioned
 CPU model
Date: Thu, 16 Jul 2020 14:18:58 -0400
Message-Id: <20200716181903.1895314-2-ehabkost@redhat.com>
In-Reply-To: <20200716181903.1895314-1-ehabkost@redhat.com>
References: <20200716181903.1895314-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 13:59:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@intel.com>

Features defined in versioned CPU model are recorded in env->user_features
since they are updated as property. It's unwated because they are not
user specified.

Simply clear env->user_features as a fix. It won't clear user specified
features because user specified features are filled to
env->user_features later in x86_cpu_expand_features().

Cc: Chenyi Qiang <chenyi.qiang@intel.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-Id: <20200713174436.41070-2-xiaoyao.li@intel.com>
[ehabkost: fix coding style]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e5123251d..caf0334f3a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5159,6 +5159,13 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
     object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
 
     x86_cpu_apply_version_props(cpu, model);
+
+    /*
+     * Properties in versioned CPU model are not user specified features.
+     * We can simply clear env->user_features here since it will be filled later
+     * in x86_cpu_expand_features() based on plus_features and minus_features.
+     */
+    memset(&env->user_features, 0, sizeof(env->user_features));
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.26.2


