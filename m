Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54194C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2BE235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z32Cq78C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2BE235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNzN-0005zF-Ng
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU1-0001eG-1w
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTx-000689-Fd
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7nNGPgoIAUnaCvp/C+6OjD+zeHiTsKiaNNu/a6qfaI=;
 b=Z32Cq78CYKHEH9RDgv9nsVPXYBeuwrMEreZ+6seLpvZ7EU113rh6H7HrX2uQA54zefvnuw
 clay7C26royx6cUI4ZTgstDxqMvULKK7vUOXBnFTRts6mpBFtEgfi3xCq8dQBjY7UP3fqe
 Uq55hQlacPp++oifzG6+GSJWqWNki70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-IVuuClKfPTycohI3oxsINQ-1; Thu, 24 Sep 2020 05:24:02 -0400
X-MC-Unique: IVuuClKfPTycohI3oxsINQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A249C1007470;
 Thu, 24 Sep 2020 09:24:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 620535C1DC;
 Thu, 24 Sep 2020 09:24:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 57/92] oss-fuzz: move linker arg to fix coverage-build
Date: Thu, 24 Sep 2020 05:22:39 -0400
Message-Id: <20200924092314.1722645-58-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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



