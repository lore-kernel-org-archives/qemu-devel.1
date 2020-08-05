Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEAEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9C622CE3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7cMgm2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9C622CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3J5N-0000Oa-4v
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3J3x-0007ni-4w
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:02:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3J3u-00089h-Tx
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596632549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XKv1EJ1gTx82r2VbG6+uU/EElW0KR6QaQ53bdZKXy/A=;
 b=T7cMgm2mC8/JIa28SUOFz0eXg8RomkoL7Pa2eyjFzTjKDXFG8ryeKHojN3taRjnvuwj4zY
 rxTcjEspXH6A0r2q1O10gD+6C/GsQNZHMhg4h22uXjFr+V7I3lzFdIvswIx3FcMjo6ibU8
 aldRg2FD2L5o3FFS7J6lgkWZpgff0k4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-xI8--UccPR-Y6tW1m-zHFA-1; Wed, 05 Aug 2020 09:02:26 -0400
X-MC-Unique: xI8--UccPR-Y6tW1m-zHFA-1
Received: by mail-wr1-f69.google.com with SMTP id r29so9241914wrr.10
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 06:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XKv1EJ1gTx82r2VbG6+uU/EElW0KR6QaQ53bdZKXy/A=;
 b=VlQwg6NZUS7r/vcPgFFZMAAyrdp3DrADhNjam79LFlj39G1dIf100j4woy9AYqXQmi
 /vowIu5sJ7xrkkLHvD29JDGVVBzJhtG+NgYg9PnCvKQc+vqKOdFNaZXVaDTmdXFqpfI3
 C+lRrBoNIVF2wsSdPxNP7fhXt5oSpvRLHEpXfnRKzkKbK5dYQfJVMzF9rwmLkC+dKX6d
 QTtCaxVjsHsKxa6Jv/aNqtOs4xb8Ko2aVOlBMGibrAGn0M965pWGWv6glINoF3NbEpNl
 tHpQ+cgZeuGHXxqxQUxPwX07WbvEsznhkjx6QTvgh2YS55Egb0273w4PmYu4y43ZRLXy
 AixA==
X-Gm-Message-State: AOAM5324I7hbUFA3IHVKllNFUR8YwYDDHTDYRdK/Y6pEUIxw+I2x7Cch
 xzQKuPvNJ+spN3XPsn1Ynr7BQ8VZXEGiPY1zT8EEIxVyGhqOWIyxHbyM7HHWwzI8WICH+ACWTsi
 L2xWtbiCAQIN3lQ0=
X-Received: by 2002:adf:dd01:: with SMTP id a1mr2914821wrm.301.1596632544780; 
 Wed, 05 Aug 2020 06:02:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH0E9uF04QeygLyC8c/dlTA7EchVnv7v60QVOPQNWDYchqAx2UogCcUtb0P/twn42fOyQtwg==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr2914785wrm.301.1596632544360; 
 Wed, 05 Aug 2020 06:02:24 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y84sm2776667wmg.38.2020.08.05.06.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:02:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] softmmu: Add missing trace-events file
Date: Wed,  5 Aug 2020 15:02:20 +0200
Message-Id: <20200805130221.24487-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Hildenbrand <david@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit c7f419f584 moved softmmu-only files out of the root
directory, but forgot to move the trace events, which should
no longer be generated to "trace-root.h". Fix that by adding
softmmu/trace-events.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile.objs        |  1 +
 softmmu/balloon.c    |  2 +-
 softmmu/ioport.c     |  2 +-
 softmmu/memory.c     |  2 +-
 softmmu/vl.c         |  2 +-
 softmmu/trace-events | 28 ++++++++++++++++++++++++++++
 trace-events         | 27 ---------------------------
 7 files changed, 33 insertions(+), 31 deletions(-)
 create mode 100644 softmmu/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index d22b3b45d7..61c1ad3c3b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -190,6 +190,7 @@ trace-events-subdirs += hw/gpio
 trace-events-subdirs += hw/riscv
 trace-events-subdirs += migration
 trace-events-subdirs += net
+trace-events-subdirs += softmmu
 trace-events-subdirs += ui
 endif
 trace-events-subdirs += hw/core
diff --git a/softmmu/balloon.c b/softmmu/balloon.c
index 354408c6ea..23452295cd 100644
--- a/softmmu/balloon.c
+++ b/softmmu/balloon.c
@@ -28,10 +28,10 @@
 #include "qemu/atomic.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
-#include "trace-root.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
+#include "trace.h"
 
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index 04e360e79a..cb8adb0b93 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -28,9 +28,9 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/ioport.h"
-#include "trace-root.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
+#include "trace.h"
 
 typedef struct MemoryRegionPortioList {
     MemoryRegion mr;
diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987518..d030eb6f7c 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -24,7 +24,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "qom/object.h"
-#include "trace-root.h"
+#include "trace.h"
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4eb9d1f7fd..f7b103467c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -90,7 +90,7 @@
 
 #include "disas/disas.h"
 
-#include "trace-root.h"
+#include "trace.h"
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
diff --git a/softmmu/trace-events b/softmmu/trace-events
new file mode 100644
index 0000000000..b80ca042e1
--- /dev/null
+++ b/softmmu/trace-events
@@ -0,0 +1,28 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# balloon.c
+# Since requests are raised via monitor, not many tracepoints are needed.
+balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
+
+# ioport.c
+cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
+cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
+
+# memory.c
+memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
+flatview_new(void *view, void *root) "%p (root %p)"
+flatview_destroy(void *view, void *root) "%p (root %p)"
+flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
+
+# vl.c
+vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
+load_file(const char *name, const char *path) "name %s location %s"
+runstate_set(int current_state, const char *current_state_str, int new_state, const char *new_state_str) "current_run_state %d (%s) new_state %d (%s)"
+system_wakeup_request(int reason) "reason=%d"
+qemu_system_shutdown_request(int reason) "reason=%d"
+qemu_system_powerdown_request(void) ""
diff --git a/trace-events b/trace-events
index 42107ebc69..5882c2d5fc 100644
--- a/trace-events
+++ b/trace-events
@@ -25,22 +25,6 @@
 #
 # The <format-string> should be a sprintf()-compatible format string.
 
-# ioport.c
-cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
-cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
-
-# balloon.c
-# Since requests are raised via monitor, not many tracepoints are needed.
-balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
-
-# vl.c
-vm_state_notify(int running, int reason, const char *reason_str) "running %d reason %d (%s)"
-load_file(const char *name, const char *path) "name %s location %s"
-runstate_set(int current_state, const char *current_state_str, int new_state, const char *new_state_str) "current_run_state %d (%s) new_state %d (%s)"
-system_wakeup_request(int reason) "reason=%d"
-qemu_system_shutdown_request(int reason) "reason=%d"
-qemu_system_powerdown_request(void) ""
-
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
 dma_aio_cancel(void *dbs) "dbs=%p"
@@ -55,17 +39,6 @@ ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_
 memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
 memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
 
-# memory.c
-memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
-flatview_new(void *view, void *root) "%p (root %p)"
-flatview_destroy(void *view, void *root) "%p (root %p)"
-flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
-
 # gdbstub.c
 gdbstub_op_start(const char *device) "Starting gdbstub using device %s"
 gdbstub_op_exiting(uint8_t code) "notifying exit with code=0x%02x"
-- 
2.21.3


