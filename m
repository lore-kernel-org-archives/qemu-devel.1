Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49852072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq87f4/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49852072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94i4-0006UE-VQ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dw-0002SE-On
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Ds-0001fo-8z
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrFnyMZH+f4YkyOO026qZZWf1ZTcWNcDftfN3KsDDwk=;
 b=Xq87f4/yyDjX865NRKzlpvtTwK97SaoEiOqVh1iOEa0k/NRWCCUxdmpZphOeEfMhfA+vqm
 Uv674h2TV1Iw1Umrp8g++IqnJGrhLXXNHTdnFFDed9+MozFKUWJB7GmXn/rt3dhLv8IRan
 34fknn6dYH4eNfZrPThGPcsBghvKsog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-MdWfYWqJOQyyOOUAu9LCwA-1; Fri, 21 Aug 2020 06:24:33 -0400
X-MC-Unique: MdWfYWqJOQyyOOUAu9LCwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59E3801ABF
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99B695C1D0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 074/152] meson: convert most of softmmu/
Date: Fri, 21 Aug 2020 06:22:11 -0400
Message-Id: <20200821102329.29777-75-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Leave out main.c, it's special due to fuzzing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           |  2 ++
 softmmu/Makefile.objs | 14 +-------------
 softmmu/meson.build   | 10 ++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)
 create mode 100644 softmmu/meson.build

diff --git a/meson.build b/meson.build
index ff200900ed..442855daef 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,8 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('softmmu')
+
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
 
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index c036887500..ec74d8a9fa 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,14 +1,2 @@
 softmmu-main-y = softmmu/main.o
-
-obj-y += arch_init.o
-obj-y += cpus.o
-obj-y += cpu-throttle.o
-obj-y += balloon.o
-obj-y += ioport.o
-obj-y += memory.o
-obj-y += memory_mapping.o
-
-obj-y += qtest.o
-
-obj-y += vl.o
-vl.o-cflags := $(SDL_CFLAGS)
+main.o-cflags := $(SDL_CFLAGS)
diff --git a/softmmu/meson.build b/softmmu/meson.build
new file mode 100644
index 0000000000..95d38df259
--- /dev/null
+++ b/softmmu/meson.build
@@ -0,0 +1,10 @@
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
+  'arch_init.c',
+  'balloon.c',
+  'cpus.c',
+  'cpu-throttle.c',
+  'ioport.c',
+  'memory.c',
+  'memory_mapping.c',
+  'qtest.c',
+  'vl.c'))
-- 
2.26.2



