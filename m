Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D4CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C66C2086A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrbiYqb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C66C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lsQ-0002ku-VY
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPG-0006h2-HD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPE-0006bb-LB
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Tj1KWSH7qE4tC4PDfz6aCpuVUDkFTXqkXYs3G2LNzQA=;
 b=FrbiYqb3G7kEbrdpOoC4jU7z0Ag4xDVbTKDvNV4taFo34fillNVvV0i6eU2X9DAaT8RV0U
 g2WLyrTWf9b3QTM4sUHln2BbhL05HH0zxPPJw7OpBVTwd3MEhWsQhfMCNUaam2NNDepGa/
 fa/aNTFUbRhRe7UlLLJ8AhOLXmJO4Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-Wj7OVUO4PHWq85EHCPqKHw-1; Thu, 06 Aug 2020 15:18:21 -0400
X-MC-Unique: Wj7OVUO4PHWq85EHCPqKHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CEE3107BEF6
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:21 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55D5C5F9DC
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:18:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 067/143] meson: convert most of softmmu/
Date: Thu,  6 Aug 2020 21:15:03 +0200
Message-Id: <1596741379-12902-68-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Leave out main.c and vl.c, they're special due to fuzzing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build           |  2 ++
 softmmu/Makefile.objs | 11 -----------
 softmmu/meson.build   |  9 +++++++++
 3 files changed, 11 insertions(+), 11 deletions(-)
 create mode 100644 softmmu/meson.build

diff --git a/meson.build b/meson.build
index 266ff64..bab875e 100644
--- a/meson.build
+++ b/meson.build
@@ -618,6 +618,8 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('softmmu')
+
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
 
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index a414a74..dd15c24 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,14 +1,3 @@
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
 obj-y += vl.o
 vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
diff --git a/softmmu/meson.build b/softmmu/meson.build
new file mode 100644
index 0000000..d4ac51b
--- /dev/null
+++ b/softmmu/meson.build
@@ -0,0 +1,9 @@
+specific_ss.add(files(
+  'arch_init.c',
+  'balloon.c',
+  'cpus.c',
+  'cpu-throttle.c',
+  'ioport.c',
+  'memory.c',
+  'memory_mapping.c',
+  'qtest.c'))
-- 
1.8.3.1



