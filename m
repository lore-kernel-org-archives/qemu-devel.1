Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D905C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E0120829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biU/fysD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E0120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k197e-00030I-I1
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k1961-00025n-Hc
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:59:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k195y-0002DF-QC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596117581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QVsnilQZ1vhpy0OO9SwSmJY9XUdq3f2mYSRQhQYQpd0=;
 b=biU/fysD5iJ830ovnELZmYGRflgasdAN7OTSmrY3Io3zUSObrHW5ALhhHn5D22Wv41VGk7
 gZztOaNRMBtId1qnaDCH787J3UuWkDxD0BQXSPODW51d3KqR2GXa6+/HF4H2uhxAQxcxvQ
 9Fz0KwFQSX1Dw0gXIsek1hiDYJWxHFo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-g8Qma25mP6SCnBuBJ3JAtA-1; Thu, 30 Jul 2020 09:59:40 -0400
X-MC-Unique: g8Qma25mP6SCnBuBJ3JAtA-1
Received: by mail-wr1-f70.google.com with SMTP id m7so7961997wrb.20
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QVsnilQZ1vhpy0OO9SwSmJY9XUdq3f2mYSRQhQYQpd0=;
 b=goRUV8rSVX2Q+IVMGPKFLi3vrH57hqZK+1jF2AdQNKzlTUIEujlewZVS+btIo83DQb
 qO93eMVze5un1dHokFJR7AWfHzbPhxMj0XUBqs46Q8EEFRFOvJYK7I4Jaagkl10S2OHM
 AY1r41xjwbQmaRabKD8eEKckSS1QBR04OXl70/Y+/WzvDGOc2/zDRVmGvPGU8B8MTjCg
 wgOlNgsn04OjkXOZ2NJG/VSfMntlT29eomnT/sVctIKeaEVIyvSm1NDBEuSrQOPVwNRW
 UqTPy/SDUi8oSiGzOBwr1EQGgQrK5UQO8FyYy0XarMUhjRczR8iCyFrZ6Q+8+qLg82zm
 VYGQ==
X-Gm-Message-State: AOAM531RuBkjoU85QR9qZeQXi9+z7CIhJ9BIL71w77fUIAUAO4V0VGUT
 mcdHc8hWbpM2B4hKs6MEJhApQCwOYkhGPAh2eYXWQcIaJJx+vi9uagYHOs7CodgWDrvAkanKYmo
 MvQDt71z8fPNY/Gg=
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr2889854wrq.162.1596117578426; 
 Thu, 30 Jul 2020 06:59:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTXtEmmLwOZCBchzadGbKx9FHz1Av/y+TsvELbV7aOdz4Ua8L9CsS4+c2FcuHNw7nHHW9XBQ==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr2889823wrq.162.1596117578170; 
 Thu, 30 Jul 2020 06:59:38 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id y11sm10120598wrs.80.2020.07.30.06.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 06:59:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1?] util/pagesize: Make qemu_real_host_page_size of type
 size_t
Date: Thu, 30 Jul 2020 15:59:35 +0200
Message-Id: <20200730135935.23968-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
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
Cc: Kevin Wolf <kwolf@redhat.com>, Bruce Rogers <brogers@suse.com>,
 Kaige Li <likaige@loongson.cn>, kvm@vger.kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use different types to hold 'qemu_real_host_page_size'.
Unify picking 'size_t' which seems the best candidate.

Doing so fix a format string issue in hw/virtio/virtio-mem.c
reported when building with GCC 4.9.4:

  hw/virtio/virtio-mem.c: In function ‘virtio_mem_set_block_size’:
  hw/virtio/virtio-mem.c:756:9: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 7 has type ‘uintptr_t’ [-Werror=format=]
         error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
         ^

Fixes: 910b25766b ("virtio-mem: Paravirtualized memory hot(un)plug")
Reported-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/ram_addr.h  | 4 ++--
 include/qemu/osdep.h     | 2 +-
 accel/kvm/kvm-all.c      | 3 ++-
 block/qcow2-cache.c      | 2 +-
 exec.c                   | 8 ++++----
 hw/ppc/spapr_pci.c       | 2 +-
 hw/virtio/virtio-mem.c   | 2 +-
 migration/migration.c    | 2 +-
 migration/postcopy-ram.c | 2 +-
 monitor/misc.c           | 2 +-
 util/pagesize.c          | 2 +-
 11 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 3ef729a23c..e07532266e 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -93,8 +93,8 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 
 bool ramblock_is_pmem(RAMBlock *rb);
 
-long qemu_minrampagesize(void);
-long qemu_maxrampagesize(void);
+size_t qemu_minrampagesize(void);
+size_t qemu_maxrampagesize(void);
 
 /**
  * qemu_ram_alloc_from_file,
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 20872e793e..619b8a7a8c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -635,10 +635,10 @@ char *qemu_get_pid_name(pid_t pid);
  */
 pid_t qemu_fork(Error **errp);
 
+extern size_t qemu_real_host_page_size;
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
  */
-extern uintptr_t qemu_real_host_page_size;
 extern intptr_t qemu_real_host_page_mask;
 
 extern int qemu_icache_linesize;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1..59becfbd6c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -674,7 +674,8 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start,
     KVMState *s = kvm_state;
     uint64_t end, bmap_start, start_delta, bmap_npages;
     struct kvm_clear_dirty_log d;
-    unsigned long *bmap_clear = NULL, psize = qemu_real_host_page_size;
+    unsigned long *bmap_clear = NULL;
+    size_t psize = qemu_real_host_page_size;
     int ret;
 
     /*
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 7444b9c4ab..4ad9f5929f 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -74,7 +74,7 @@ static void qcow2_cache_table_release(Qcow2Cache *c, int i, int num_tables)
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
     void *t = qcow2_cache_get_table_addr(c, i);
-    int align = qemu_real_host_page_size;
+    size_t align = qemu_real_host_page_size;
     size_t mem_size = (size_t) c->table_size * num_tables;
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
     size_t length = QEMU_ALIGN_DOWN(mem_size - offset, align);
diff --git a/exec.c b/exec.c
index 6f381f98e2..4b6d52e01f 100644
--- a/exec.c
+++ b/exec.c
@@ -1657,7 +1657,7 @@ static int find_max_backend_pagesize(Object *obj, void *opaque)
  * TODO: We assume right now that all mapped host memory backends are
  * used as RAM, however some might be used for different purposes.
  */
-long qemu_minrampagesize(void)
+size_t qemu_minrampagesize(void)
 {
     long hpsize = LONG_MAX;
     Object *memdev_root = object_resolve_path("/objects", NULL);
@@ -1666,7 +1666,7 @@ long qemu_minrampagesize(void)
     return hpsize;
 }
 
-long qemu_maxrampagesize(void)
+size_t qemu_maxrampagesize(void)
 {
     long pagesize = 0;
     Object *memdev_root = object_resolve_path("/objects", NULL);
@@ -1675,11 +1675,11 @@ long qemu_maxrampagesize(void)
     return pagesize;
 }
 #else
-long qemu_minrampagesize(void)
+size_t qemu_minrampagesize(void)
 {
     return qemu_real_host_page_size;
 }
-long qemu_maxrampagesize(void)
+size_t qemu_maxrampagesize(void)
 {
     return qemu_real_host_page_size;
 }
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 363cdb3f7b..a9da84fe30 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1810,7 +1810,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     char *namebuf;
     int i;
     PCIBus *bus;
-    uint64_t msi_window_size = 4096;
+    size_t msi_window_size = 4096;
     SpaprTceTable *tcet;
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
     Error *local_err = NULL;
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c12e9f79b0..34344cec39 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -753,7 +753,7 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
     }
 
     if (value < VIRTIO_MEM_MIN_BLOCK_SIZE) {
-        error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
+        error_setg(errp, "'%s' property has to be at least 0x%zx", name,
                    VIRTIO_MEM_MIN_BLOCK_SIZE);
         return;
     } else if (!is_power_of_2(value)) {
diff --git a/migration/migration.c b/migration/migration.c
index 8fe36339db..b8abbbeabb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2433,7 +2433,7 @@ static struct rp_cmd_args {
 static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
                                        ram_addr_t start, size_t len)
 {
-    long our_host_ps = qemu_real_host_page_size;
+    size_t our_host_ps = qemu_real_host_page_size;
 
     trace_migrate_handle_rp_req_pages(rbname, start, len);
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 1bb22f2b6c..f296efd612 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -345,7 +345,7 @@ static int test_ramblock_postcopiable(RAMBlock *rb, void *opaque)
  */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
-    long pagesize = qemu_real_host_page_size;
+    size_t pagesize = qemu_real_host_page_size;
     int ufd = -1;
     bool ret = false; /* Error unless we change it */
     void *testarea = NULL;
diff --git a/monitor/misc.c b/monitor/misc.c
index e847b58a8c..7970f4ff72 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -740,7 +740,7 @@ static uint64_t vtop(void *ptr, Error **errp)
     uint64_t pinfo;
     uint64_t ret = -1;
     uintptr_t addr = (uintptr_t) ptr;
-    uintptr_t pagesize = qemu_real_host_page_size;
+    size_t pagesize = qemu_real_host_page_size;
     off_t offset = addr / pagesize * sizeof(pinfo);
     int fd;
 
diff --git a/util/pagesize.c b/util/pagesize.c
index 998632cf6e..a08bf1717a 100644
--- a/util/pagesize.c
+++ b/util/pagesize.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 
-uintptr_t qemu_real_host_page_size;
+size_t qemu_real_host_page_size;
 intptr_t qemu_real_host_page_mask;
 
 static void __attribute__((constructor)) init_real_host_page_size(void)
-- 
2.21.3


