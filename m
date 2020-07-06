Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C66BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2CF206BE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPtHVPQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2CF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUXY-0006Ri-8w
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCU-0003zS-QD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCS-0003BG-GE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cuu7Gd/0ThqafhqxDN6MKfshUHRjWDAKG8WjMu6RZ7Q=;
 b=bPtHVPQsizonmu+OiqxFpyj2uPjfLUm0V8X1/AcCsDd7EnWKVUhwVZf1Nx3EUXyJl3s7My
 hGEGRVqo8n7lDYZUvr/g+XrhDEHEUHTuLMaKc4oSTdpgML4VsqEii14Q6sZaZVJqnVVrM1
 F0tx+KAjkUo8ZmSvhEIP/sQu5NEqRw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-a1AJTvZePxijmPu31iHoFA-1; Mon, 06 Jul 2020 12:42:30 -0400
X-MC-Unique: a1AJTvZePxijmPu31iHoFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FD388010C7;
 Mon,  6 Jul 2020 16:42:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3885F7D8;
 Mon,  6 Jul 2020 16:42:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/53] softmmu: move softmmu only files from root
Date: Mon,  6 Jul 2020 12:41:43 -0400
Message-Id: <20200706164155.24696-42-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

move arch_init, balloon, cpus, ioport, memory, memory_mapping, qtest.

They are all specific to CONFIG_SOFTMMU.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200629093504.3228-2-cfontana@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                  | 12 ++++++------
 Makefile.target                              |  7 ++-----
 softmmu/Makefile.objs                        | 10 ++++++++++
 arch_init.c => softmmu/arch_init.c           |  0
 balloon.c => softmmu/balloon.c               |  0
 cpus.c => softmmu/cpus.c                     |  0
 ioport.c => softmmu/ioport.c                 |  0
 memory.c => softmmu/memory.c                 |  0
 memory_mapping.c => softmmu/memory_mapping.c |  0
 qtest.c => softmmu/qtest.c                   |  0
 10 files changed, 18 insertions(+), 11 deletions(-)
 rename arch_init.c => softmmu/arch_init.c (100%)
 rename balloon.c => softmmu/balloon.c (100%)
 rename cpus.c => softmmu/cpus.c (100%)
 rename ioport.c => softmmu/ioport.c (100%)
 rename memory.c => softmmu/memory.c (100%)
 rename memory_mapping.c => softmmu/memory_mapping.c (100%)
 rename qtest.c => softmmu/qtest.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72d5871f41..fdf43228b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -115,7 +115,7 @@ Overall TCG CPUs
 M: Richard Henderson <rth@twiddle.net>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: cpus.c
+F: softmmu/cpus.c
 F: cpus-common.c
 F: exec.c
 F: accel/tcg/
@@ -1722,7 +1722,7 @@ M: David Hildenbrand <david@redhat.com>
 S: Maintained
 F: hw/virtio/virtio-balloon*.c
 F: include/hw/virtio/virtio-balloon.h
-F: balloon.c
+F: softmmu/balloon.c
 F: include/sysemu/balloon.h
 
 virtio-9p
@@ -2191,12 +2191,12 @@ Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: include/exec/ioport.h
-F: ioport.c
 F: include/exec/memop.h
 F: include/exec/memory.h
 F: include/exec/ram_addr.h
 F: include/exec/ramblock.h
-F: memory.c
+F: softmmu/ioport.c
+F: softmmu/memory.c
 F: include/exec/memory-internal.h
 F: exec.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
@@ -2228,13 +2228,13 @@ F: ui/cocoa.m
 Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: cpus.c
 F: include/qemu/main-loop.h
 F: include/sysemu/runstate.h
 F: util/main-loop.c
 F: util/qemu-timer.c
 F: softmmu/vl.c
 F: softmmu/main.c
+F: softmmu/cpus.c
 F: qapi/run-state.json
 
 Human Monitor (HMP)
@@ -2389,7 +2389,7 @@ M: Thomas Huth <thuth@redhat.com>
 M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: qtest.c
+F: softmmu/qtest.c
 F: accel/qtest.c
 F: tests/qtest/
 X: tests/qtest/bios-tables-test-allowed-diff.h
diff --git a/Makefile.target b/Makefile.target
index 8ed1eba95b..7fbf5d8b92 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -152,16 +152,13 @@ endif #CONFIG_BSD_USER
 #########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
-obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
-obj-y += qtest.o
+obj-y += softmmu/
+obj-y += gdbstub.o
 obj-y += dump/
 obj-y += hw/
 obj-y += monitor/
 obj-y += qapi/
-obj-y += memory.o
-obj-y += memory_mapping.o
 obj-y += migration/ram.o
-obj-y += softmmu/
 LIBS := $(libs_softmmu) $(LIBS)
 
 # Hardware support
diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
index dd15c24346..a4bd9f2f52 100644
--- a/softmmu/Makefile.objs
+++ b/softmmu/Makefile.objs
@@ -1,3 +1,13 @@
 softmmu-main-y = softmmu/main.o
+
+obj-y += arch_init.o
+obj-y += cpus.o
+obj-y += balloon.o
+obj-y += ioport.o
+obj-y += memory.o
+obj-y += memory_mapping.o
+
+obj-y += qtest.o
+
 obj-y += vl.o
 vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
diff --git a/arch_init.c b/softmmu/arch_init.c
similarity index 100%
rename from arch_init.c
rename to softmmu/arch_init.c
diff --git a/balloon.c b/softmmu/balloon.c
similarity index 100%
rename from balloon.c
rename to softmmu/balloon.c
diff --git a/cpus.c b/softmmu/cpus.c
similarity index 100%
rename from cpus.c
rename to softmmu/cpus.c
diff --git a/ioport.c b/softmmu/ioport.c
similarity index 100%
rename from ioport.c
rename to softmmu/ioport.c
diff --git a/memory.c b/softmmu/memory.c
similarity index 100%
rename from memory.c
rename to softmmu/memory.c
diff --git a/memory_mapping.c b/softmmu/memory_mapping.c
similarity index 100%
rename from memory_mapping.c
rename to softmmu/memory_mapping.c
diff --git a/qtest.c b/softmmu/qtest.c
similarity index 100%
rename from qtest.c
rename to softmmu/qtest.c
-- 
2.26.2



