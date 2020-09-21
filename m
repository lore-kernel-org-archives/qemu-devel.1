Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE52C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF8920BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pb7Jpk8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF8920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOEL-0004Ze-4o
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKOC3-0002B5-Hc
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKOC0-0001J6-K2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600703844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7nNGPgoIAUnaCvp/C+6OjD+zeHiTsKiaNNu/a6qfaI=;
 b=Pb7Jpk8tDFFQEQ5GhuNDd7vwv1359jcgKk46Ne9peWvB2XYodl7lmgc2TOIyGNL7J6Y25Z
 pvpEtHAcn+kjmV8jJa4I196oRmIUKxma6Cu8nFvLGTqwWwsbYlRm8XxzLQoPy/GwH8N2xo
 14SHqd1zEYvvIT1Q9LnBPTB501sexNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-Do1QzwLNOseGk061RqRqWw-1; Mon, 21 Sep 2020 11:56:42 -0400
X-MC-Unique: Do1QzwLNOseGk061RqRqWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C28A1074654;
 Mon, 21 Sep 2020 15:56:40 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E5937366D;
 Mon, 21 Sep 2020 15:56:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 57/57] oss-fuzz: move linker arg to fix coverage-build
Date: Mon, 21 Sep 2020 11:56:38 -0400
Message-Id: <20200921155638.1328200-3-pbonzini@redhat.com>
In-Reply-To: <20200921155638.1328200-1-pbonzini@redhat.com>
References: <20200921155638.1328200-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

The order of the add_project_link_arguments calls impacts which
arguments are placed between --start-group and --end-group.
OSS-Fuzz coverage builds seem to just add these to CFLAGS:
-fprofile-instr-generate -fcoverage-mapping pthread -Wl,--no-as-needed
-Wl,-ldl -Wl,-lm Wno-unused-command-line-argument

The -Wl,-ldl flag that is enough to shift the fork_fuzz.ld linker-script
back into the linker group. Move the linker-script meson call before the
other calls to make sure the flag is placed correctly.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200909220516.614222-1-alxndr@bu.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index ace15dc8c0..9aeefa60fb 100644
--- a/meson.build
+++ b/meson.build
@@ -54,6 +54,14 @@ configure_file(input: files('scripts/ninjatool.py'),
 # Compiler flags #
 ##################
 
+# Specify linker-script with add_project_link_arguments so that it is not placed
+# within a linker --start-group/--end-group pair
+if 'CONFIG_FUZZ' in config_host
+   add_project_link_arguments(['-Wl,-T,',
+                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
+                              native: false, language: ['c', 'cpp', 'objc'])
+endif
+
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       native: false, language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
@@ -63,13 +71,6 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: ['c', 'cpp', 'objc'])
 
-# Specify linker-script with add_project_link_arguments so that it is not placed
-# within a linker --start-group/--end-group pair
-if 'CONFIG_FUZZ' in config_host
-   add_project_link_arguments(['-Wl,-T,',
-                               (meson.current_source_dir() / 'tests/qtest/fuzz/fork_fuzz.ld')],
-                              native: false, language: ['c', 'cpp', 'objc'])
-endif
 
 link_language = meson.get_external_property('link_language', 'cpp')
 if link_language == 'cpp'
-- 
2.26.2


