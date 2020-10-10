Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5607EC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17E5207CD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFTQWujV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17E5207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9mf-0005u6-3K
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 03:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lH-00041Q-IZ
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lC-0006fj-Od
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtj27x+pSzbQC0eIvSpIyo1m+6nhq6Agxy9aChLZOh8=;
 b=bFTQWujV0L60Q0pyNqME2RLyoKr5WzJKk/xMI6M+r8uPrIOV9CTk5zwC8mh7pVob7NTFuC
 3Tn4ABE6rnCiz+9Th6W77J1sZ9M1Wzr6RXZhA9ZjJFBzYKema4hZDPKv9D6/pYapnkszU0
 TXR2TkNEmKcw8wb7qphV0WvUcwMNK/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-W2gtXsiVO6OBT3SpzCtIFQ-1; Sat, 10 Oct 2020 03:57:44 -0400
X-MC-Unique: W2gtXsiVO6OBT3SpzCtIFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 753671868431
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 319C35576E;
 Sat, 10 Oct 2020 07:57:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/39] qom: Move the creation of the library to the main
 meson.build
Date: Sat, 10 Oct 2020 03:57:09 -0400
Message-Id: <20201010075739.951385-10-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Be consistent creating all the libraries in the main meson.build file.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201006125602.2311423-10-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build     | 8 ++++++++
 qom/meson.build | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 2736f74b8f..f4ef3b83f3 100644
--- a/meson.build
+++ b/meson.build
@@ -1192,6 +1192,7 @@ crypto_ss = ss.source_set()
 io_ss = ss.source_set()
 linux_user_ss = ss.source_set()
 qmp_ss = ss.source_set()
+qom_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 specific_fuzz_ss = ss.source_set()
 specific_ss = ss.source_set()
@@ -1454,6 +1455,13 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
 # Library dependencies #
 ########################
 
+qom_ss = qom_ss.apply(config_host, strict: false)
+libqom = static_library('qom', qom_ss.sources() + genh,
+                        dependencies: [qom_ss.dependencies()],
+                        name_suffix: 'fa')
+
+qom = declare_dependency(link_whole: libqom)
+
 authz_ss = authz_ss.apply(config_host, strict: false)
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
diff --git a/qom/meson.build b/qom/meson.build
index a1cd03c82c..062a3789d8 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -1,4 +1,3 @@
-qom_ss = ss.source_set()
 qom_ss.add(genh)
 qom_ss.add(files(
   'container.c',
@@ -9,10 +8,3 @@ qom_ss.add(files(
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
 softmmu_ss.add(files('qom-hmp-cmds.c'))
-
-qom_ss = qom_ss.apply(config_host, strict: false)
-libqom = static_library('qom', qom_ss.sources() + genh,
-                        dependencies: [qom_ss.dependencies()],
-                        name_suffix: 'fa')
-
-qom = declare_dependency(link_whole: libqom)
-- 
2.26.2



