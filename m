Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2F8C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCDC20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKXbvLJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCDC20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSaS-0001uX-9I
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMa-0006QF-5k
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53744
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMW-0007AP-7w
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRgWFwPCsjiXsgvA8dt9YmKQcm3JhszpEXfGbn5juR0=;
 b=YKXbvLJ274XHgS76YdQ/I17Q8//exrNnHAs/ARCSSO7ArYya2DlOIxYpdiCBF3XqlnOp+/
 04VAB8qynrGMXtMK8aOFsvPcl1ue3wLw1Exc6mOhCeL2BQYEFMCV8oZxcMfGfoVuBwZ28y
 kqpxNNgyDOTzKOQJw0Xs/LQFfIgIAaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-D-YzEJm_MuqgVIiVBD85RA-1; Wed, 02 Sep 2020 08:59:37 -0400
X-MC-Unique: D-YzEJm_MuqgVIiVBD85RA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05CC1191E2C0
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6E1A5D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/39] meson: keep all compiler flags detection together
Date: Wed,  2 Sep 2020 08:59:10 -0400
Message-Id: <20200902125917.26021-33-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index 57fadd3dab..4c32f5286f 100644
--- a/meson.build
+++ b/meson.build
@@ -32,6 +32,23 @@ endforeach
 have_tools = 'CONFIG_TOOLS' in config_host
 have_block = have_system or have_tools
 
+python = import('python').find_installation()
+
+supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
+supported_cpus = ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv64', 'x86', 'x86_64',
+  'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']
+
+cpu = host_machine.cpu_family()
+targetos = host_machine.system()
+
+configure_file(input: files('scripts/ninjatool.py'),
+               output: 'ninjatool',
+               configuration: config_host)
+
+##################
+# Compiler flags #
+##################
+
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       native: false, language: ['c', 'objc'])
 add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
@@ -39,12 +56,6 @@ add_project_link_arguments(config_host['QEMU_LDFLAGS'].split(),
 add_project_arguments(config_host['QEMU_INCLUDES'].split(),
                       language: ['c', 'cpp', 'objc'])
 
-python = import('python').find_installation()
-
-##################
-# Compiler flags #
-##################
-
 link_language = 'c'
 if not add_languages('cpp', required: false, native: false)
   # no warning
@@ -73,17 +84,6 @@ if 'SPARSE_CFLAGS' in config_host
                        'compile_commands.json'])
 endif
 
-configure_file(input: files('scripts/ninjatool.py'),
-               output: 'ninjatool',
-               configuration: config_host)
-
-supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']
-
-cpu = host_machine.cpu_family()
-targetos = host_machine.system()
-
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 winmm = []
-- 
2.26.2



