Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F68C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801E520643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9VFsVns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801E520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkfs-0002Bj-NG
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkXm-0000Kq-1E
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:42:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkXi-0002rT-L6
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70NlWPfiuzNDwJ1WClI9QnQALFzv92OS+bgBk12LGJk=;
 b=C9VFsVnsBNsIzKpiquQ/7dzAdorYRRu52ICjJ4C31fYITZ3wzsQ4eqcEvxyowqeo7ETqIx
 m/E/+VgxigPJNuuPyHbikU+pzKKuY16suGpbrTPFWrpiWfPmYT1rf/l5rzpzZX0ZZ4Prv2
 VNBusBYECbx73fYys+N4osqOOW7ugI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-8s4yPCVWOCKFTffhx9qYJw-1; Thu, 07 May 2020 13:42:09 -0400
X-MC-Unique: 8s4yPCVWOCKFTffhx9qYJw-1
Received: by mail-wm1-f71.google.com with SMTP id 71so2915657wmb.8
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3iNLy+87ImRK1vCCpmPAQkeNS9aRnVSHDrrD8jMf/sk=;
 b=rQiXPmYKG7YMhDLX9w2oH5CavaEtk1VnogUzjjtWrWUUdxGidNumbSYT60BLFNtDsA
 sd9ZKesoeP7/Goaqf/ot0QDkvxFy/h6VGz2DjkihmsPeiHgqSgKPLJ6EoB/xpZMFT6sk
 dtUYkF8wKHtA0dxnrqFJxMlUu26iRMGwqF6DH2YR2SA/xyXCPexnHSWp/5CkM2HyTa3V
 4Gd56mw7svykS2ySUSyl8qNEDvuHtP+62L1/BjS03SA0xGT6RIM9PW2WT5kM6oFF8Ea2
 WmtMIav6sKPqAYWzu3szoEMF6Qm3X7Yl4x2ffMhbwfRTTmqmJjaxbThU8v+1gXISwJNn
 knrg==
X-Gm-Message-State: AGi0PuZt+Kla4ZQljAzVSHt0ysuu5Rm4f/w+I1DdAgC4A3NdPmpoIhnG
 PTYSaURGy5sTuii3HSxx8CSzx6yGAgxiYlO9BT+Q2LGD5RSUY9omcwu/RxzoRiWJSNf250knoWU
 DpqQPdusNBLUjT4k=
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr12291402wml.133.1588873327448; 
 Thu, 07 May 2020 10:42:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypLbBY+ERloxY8NihCRunMVoMUh90zAydeWklGiK1gIKek9UL4Kq17oOgjkSawmvFr+8N9WaVw==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr12291349wml.133.1588873326876; 
 Thu, 07 May 2020 10:42:06 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t16sm9142379wrm.26.2020.05.07.10.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:42:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 10/10] exec: Move cpu_physical_memory_* functions to
 'exec/memory-internal.h'
Date: Thu,  7 May 2020 19:39:58 +0200
Message-Id: <20200507173958.25894-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory-internal.h | 305 ++++++++++++++++++++++++++++++++-
 include/exec/ram_addr.h        | 303 +-------------------------------
 accel/tcg/cputlb.c             |   1 -
 hw/ppc/spapr.c                 |   1 -
 hw/ppc/spapr_pci.c             |   1 -
 memory.c                       |   1 -
 6 files changed, 305 insertions(+), 307 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.=
h
index b2b7c1e78a..4abb3bbd85 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -21,8 +21,13 @@
 #define MEMORY_INTERNAL_H
=20
 #include "cpu.h"
+#include "sysemu/tcg.h"
+#include "sysemu/xen.h"
+#include "exec/ramlist.h"
+#include "exec/ramblock.h"
=20
 #ifdef CONFIG_SOFTMMU
+
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
     return fv->dispatch;
@@ -49,5 +54,303 @@ void address_space_dispatch_free(AddressSpaceDispatch *=
d);
=20
 void mtree_print_dispatch(struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
-#endif
+
+#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
+#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_COD=
E))
+
+static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
+                                                 ram_addr_t length,
+                                                 unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    bool dirty =3D false;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page =3D start >> TARGET_PAGE_BITS;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+
+        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        base =3D page - offset;
+        while (page < end) {
+            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE=
);
+            unsigned long num =3D next - base;
+            unsigned long found =3D find_next_bit(blocks->blocks[idx],
+                                                num, offset);
+            if (found < num) {
+                dirty =3D true;
+                break;
+            }
+
+            page =3D next;
+            idx++;
+            offset =3D 0;
+            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
+        }
+    }
+
+    return dirty;
+}
+
+static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
+                                                 ram_addr_t length,
+                                                 unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    bool dirty =3D true;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page =3D start >> TARGET_PAGE_BITS;
+
+    RCU_READ_LOCK_GUARD();
+
+    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+    base =3D page - offset;
+    while (page < end) {
+        unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long num =3D next - base;
+        unsigned long found =3D find_next_zero_bit(blocks->blocks[idx],
+                                                 num, offset);
+        if (found < num) {
+            dirty =3D false;
+            break;
+        }
+
+        page =3D next;
+        idx++;
+        offset =3D 0;
+        base +=3D DIRTY_MEMORY_BLOCK_SIZE;
+    }
+
+    return dirty;
+}
+
+static inline bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr,
+                                                      unsigned client)
+{
+    return cpu_physical_memory_get_dirty(addr, 1, client);
+}
+
+static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
+{
+    bool vga =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA=
);
+    bool code =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CO=
DE);
+    bool migration =3D cpu_physical_memory_get_dirty_flag(addr,
+                                                        DIRTY_MEMORY_MIGRA=
TION);
+    return !(vga && code && migration);
+}
+
+static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t =
start,
+                                                            ram_addr_t len=
gth,
+                                                            uint8_t mask)
+{
+    uint8_t ret =3D 0;
+
+    if (mask & (1 << DIRTY_MEMORY_VGA) &&
+        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
+        ret |=3D (1 << DIRTY_MEMORY_VGA);
+    }
+    if (mask & (1 << DIRTY_MEMORY_CODE) &&
+        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) =
{
+        ret |=3D (1 << DIRTY_MEMORY_CODE);
+    }
+    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
+        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATI=
ON)) {
+        ret |=3D (1 << DIRTY_MEMORY_MIGRATION);
+    }
+    return ret;
+}
+
+static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
+                                                      unsigned client)
+{
+    unsigned long page, idx, offset;
+    DirtyMemoryBlocks *blocks;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    page =3D addr >> TARGET_PAGE_BITS;
+    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+
+    RCU_READ_LOCK_GUARD();
+
+    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    set_bit_atomic(offset, blocks->blocks[idx]);
+}
+
+static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
+                                                       ram_addr_t length,
+                                                       uint8_t mask)
+{
+    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    int i;
+
+    if (!mask && !xen_enabled()) {
+        return;
+    }
+
+    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page =3D start >> TARGET_PAGE_BITS;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
+            blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i]);
+        }
+
+        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        base =3D page - offset;
+        while (page < end) {
+            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE=
);
+
+            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[i=
dx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
+                                  offset, next - page);
+            }
+
+            page =3D next;
+            idx++;
+            offset =3D 0;
+            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
+        }
+    }
+
+    xen_hvm_modified_memory(start, length);
+}
+
+#if !defined(_WIN32)
+static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *b=
itmap,
+                                                          ram_addr_t start=
,
+                                                          ram_addr_t pages=
)
+{
+    unsigned long i, j;
+    unsigned long page_number, c;
+    hwaddr addr;
+    ram_addr_t ram_addr;
+    unsigned long len =3D (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
+    unsigned long hpratio =3D qemu_real_host_page_size / TARGET_PAGE_SIZE;
+    unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
+
+    /* start address is aligned at the start of a word? */
+    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) &&
+        (hpratio =3D=3D 1)) {
+        unsigned long **blocks[DIRTY_MEMORY_NUM];
+        unsigned long idx;
+        unsigned long offset;
+        long k;
+        long nr =3D BITS_TO_LONGS(pages);
+
+        idx =3D (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
+        offset =3D BIT_WORD((start >> TARGET_PAGE_BITS) %
+                          DIRTY_MEMORY_BLOCK_SIZE);
+
+        WITH_RCU_READ_LOCK_GUARD() {
+            for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
+                blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i])->=
blocks;
+            }
+
+            for (k =3D 0; k < nr; k++) {
+                if (bitmap[k]) {
+                    unsigned long temp =3D leul_to_cpu(bitmap[k]);
+
+                    atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp=
);
+
+                    if (global_dirty_log) {
+                        atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][off=
set],
+                                  temp);
+                    }
+
+                    if (tcg_enabled()) {
+                        atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
+                                  temp);
+                    }
+                }
+
+                if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) =
{
+                    offset =3D 0;
+                    idx++;
+                }
+            }
+        }
+
+        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+    } else {
+        uint8_t clients =3D tcg_enabled() ? DIRTY_CLIENTS_ALL
+                                        : DIRTY_CLIENTS_NOCODE;
+
+        if (!global_dirty_log) {
+            clients &=3D ~(1 << DIRTY_MEMORY_MIGRATION);
+        }
+
+        /*
+         * bitmap-traveling is faster than memory-traveling (for addr...)
+         * especially when most of the memory is not dirty.
+         */
+        for (i =3D 0; i < len; i++) {
+            if (bitmap[i] !=3D 0) {
+                c =3D leul_to_cpu(bitmap[i]);
+                do {
+                    j =3D ctzl(c);
+                    c &=3D ~(1ul << j);
+                    page_number =3D (i * HOST_LONG_BITS + j) * hpratio;
+                    addr =3D page_number * TARGET_PAGE_SIZE;
+                    ram_addr =3D start + addr;
+                    cpu_physical_memory_set_dirty_range(ram_addr,
+                                       TARGET_PAGE_SIZE * hpratio, clients=
);
+                } while (c !=3D 0);
+            }
+        }
+    }
+}
+#endif /* not _WIN32 */
+
+bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
+                                              ram_addr_t length,
+                                              unsigned client);
+
+DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty(
+                                                            MemoryRegion *=
mr,
+                                                            hwaddr offset,
+                                                            hwaddr length,
+                                                            unsigned clien=
t);
+
+bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
+                                            ram_addr_t start,
+                                            ram_addr_t length);
+
+static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
+                                                         ram_addr_t length=
)
+{
+    cpu_physical_memory_test_and_clear_dirty(start, length,
+                                             DIRTY_MEMORY_MIGRATION);
+    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_V=
GA);
+    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_C=
ODE);
+}
+
+#endif /* CONFIG_SOFTMMU */
 #endif
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 6acde47a0f..64bf28a332 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -21,310 +21,9 @@
=20
 #ifndef CONFIG_USER_ONLY
 #include "cpu.h"
-#include "sysemu/xen.h"
-#include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
-
-
-
-#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
-#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_COD=
E))
-
-static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
-                                                 ram_addr_t length,
-                                                 unsigned client)
-{
-    DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    bool dirty =3D false;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page =3D start >> TARGET_PAGE_BITS;
-
-    WITH_RCU_READ_LOCK_GUARD() {
-        blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
-
-        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-        base =3D page - offset;
-        while (page < end) {
-            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE=
);
-            unsigned long num =3D next - base;
-            unsigned long found =3D find_next_bit(blocks->blocks[idx],
-                                                num, offset);
-            if (found < num) {
-                dirty =3D true;
-                break;
-            }
-
-            page =3D next;
-            idx++;
-            offset =3D 0;
-            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
-        }
-    }
-
-    return dirty;
-}
-
-static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
-                                                 ram_addr_t length,
-                                                 unsigned client)
-{
-    DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    bool dirty =3D true;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page =3D start >> TARGET_PAGE_BITS;
-
-    RCU_READ_LOCK_GUARD();
-
-    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
-
-    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-    base =3D page - offset;
-    while (page < end) {
-        unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-        unsigned long num =3D next - base;
-        unsigned long found =3D find_next_zero_bit(blocks->blocks[idx],
-                                                 num, offset);
-        if (found < num) {
-            dirty =3D false;
-            break;
-        }
-
-        page =3D next;
-        idx++;
-        offset =3D 0;
-        base +=3D DIRTY_MEMORY_BLOCK_SIZE;
-    }
-
-    return dirty;
-}
-
-static inline bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr,
-                                                      unsigned client)
-{
-    return cpu_physical_memory_get_dirty(addr, 1, client);
-}
-
-static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
-{
-    bool vga =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA=
);
-    bool code =3D cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CO=
DE);
-    bool migration =3D cpu_physical_memory_get_dirty_flag(addr,
-                                                        DIRTY_MEMORY_MIGRA=
TION);
-    return !(vga && code && migration);
-}
-
-static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t =
start,
-                                                            ram_addr_t len=
gth,
-                                                            uint8_t mask)
-{
-    uint8_t ret =3D 0;
-
-    if (mask & (1 << DIRTY_MEMORY_VGA) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
-        ret |=3D (1 << DIRTY_MEMORY_VGA);
-    }
-    if (mask & (1 << DIRTY_MEMORY_CODE) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) =
{
-        ret |=3D (1 << DIRTY_MEMORY_CODE);
-    }
-    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATI=
ON)) {
-        ret |=3D (1 << DIRTY_MEMORY_MIGRATION);
-    }
-    return ret;
-}
-
-static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
-                                                      unsigned client)
-{
-    unsigned long page, idx, offset;
-    DirtyMemoryBlocks *blocks;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    page =3D addr >> TARGET_PAGE_BITS;
-    idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-
-    RCU_READ_LOCK_GUARD();
-
-    blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
-
-    set_bit_atomic(offset, blocks->blocks[idx]);
-}
-
-static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
-                                                       ram_addr_t length,
-                                                       uint8_t mask)
-{
-    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    int i;
-
-    if (!mask && !xen_enabled()) {
-        return;
-    }
-
-    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page =3D start >> TARGET_PAGE_BITS;
-
-    WITH_RCU_READ_LOCK_GUARD() {
-        for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
-            blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i]);
-        }
-
-        idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
-        offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
-        base =3D page - offset;
-        while (page < end) {
-            unsigned long next =3D MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE=
);
-
-            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[i=
dx],
-                                  offset, next - page);
-            }
-            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
-                                  offset, next - page);
-            }
-            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
-                                  offset, next - page);
-            }
-
-            page =3D next;
-            idx++;
-            offset =3D 0;
-            base +=3D DIRTY_MEMORY_BLOCK_SIZE;
-        }
-    }
-
-    xen_hvm_modified_memory(start, length);
-}
-
-#if !defined(_WIN32)
-static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *b=
itmap,
-                                                          ram_addr_t start=
,
-                                                          ram_addr_t pages=
)
-{
-    unsigned long i, j;
-    unsigned long page_number, c;
-    hwaddr addr;
-    ram_addr_t ram_addr;
-    unsigned long len =3D (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
-    unsigned long hpratio =3D qemu_real_host_page_size / TARGET_PAGE_SIZE;
-    unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
-
-    /* start address is aligned at the start of a word? */
-    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) &&
-        (hpratio =3D=3D 1)) {
-        unsigned long **blocks[DIRTY_MEMORY_NUM];
-        unsigned long idx;
-        unsigned long offset;
-        long k;
-        long nr =3D BITS_TO_LONGS(pages);
-
-        idx =3D (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
-        offset =3D BIT_WORD((start >> TARGET_PAGE_BITS) %
-                          DIRTY_MEMORY_BLOCK_SIZE);
-
-        WITH_RCU_READ_LOCK_GUARD() {
-            for (i =3D 0; i < DIRTY_MEMORY_NUM; i++) {
-                blocks[i] =3D atomic_rcu_read(&ram_list.dirty_memory[i])->=
blocks;
-            }
-
-            for (k =3D 0; k < nr; k++) {
-                if (bitmap[k]) {
-                    unsigned long temp =3D leul_to_cpu(bitmap[k]);
-
-                    atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp=
);
-
-                    if (global_dirty_log) {
-                        atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][off=
set],
-                                  temp);
-                    }
-
-                    if (tcg_enabled()) {
-                        atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
-                                  temp);
-                    }
-                }
-
-                if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) =
{
-                    offset =3D 0;
-                    idx++;
-                }
-            }
-        }
-
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
-    } else {
-        uint8_t clients =3D tcg_enabled()
-                          ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
-
-        if (!global_dirty_log) {
-            clients &=3D ~(1 << DIRTY_MEMORY_MIGRATION);
-        }
-
-        /*
-         * bitmap-traveling is faster than memory-traveling (for addr...)
-         * especially when most of the memory is not dirty.
-         */
-        for (i =3D 0; i < len; i++) {
-            if (bitmap[i] !=3D 0) {
-                c =3D leul_to_cpu(bitmap[i]);
-                do {
-                    j =3D ctzl(c);
-                    c &=3D ~(1ul << j);
-                    page_number =3D (i * HOST_LONG_BITS + j) * hpratio;
-                    addr =3D page_number * TARGET_PAGE_SIZE;
-                    ram_addr =3D start + addr;
-                    cpu_physical_memory_set_dirty_range(ram_addr,
-                                       TARGET_PAGE_SIZE * hpratio, clients=
);
-                } while (c !=3D 0);
-            }
-        }
-    }
-}
-#endif /* not _WIN32 */
-
-bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
-                                              ram_addr_t length,
-                                              unsigned client);
-
-DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty(
-                                                            MemoryRegion *=
mr,
-                                                            hwaddr offset,
-                                                            hwaddr length,
-                                                            unsigned clien=
t);
-
-bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
-                                            ram_addr_t start,
-                                            ram_addr_t length);
-
-static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
-                                                         ram_addr_t length=
)
-{
-    cpu_physical_memory_test_and_clear_dirty(start, length,
-                                             DIRTY_MEMORY_MIGRATION);
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_V=
GA);
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_C=
ODE);
-}
-
+#include "exec/memory-internal.h"
=20
 /* Called with RCU critical section */
 static inline
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e3b5750c3b..922671f246 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -26,7 +26,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/cputlb.h"
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
 #include "tcg/tcg.h"
 #include "qemu/error-report.h"
 #include "exec/log.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c18eab0a23..d7c3bf3932 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -69,7 +69,6 @@
 #include "hw/virtio/vhost-scsi-common.h"
=20
 #include "exec/address-spaces.h"
-#include "exec/ram_addr.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 61b84a392d..8d9aeba6e6 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -36,7 +36,6 @@
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
 #include "exec/address-spaces.h"
-#include "exec/ram_addr.h"
 #include <libfdt.h>
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/memory.c b/memory.c
index e8e7bcd6c7..4e1d19c5fc 100644
--- a/memory.c
+++ b/memory.c
@@ -27,7 +27,6 @@
 #include "trace-root.h"
=20
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
 #include "exec/ramblock.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
--=20
2.21.3


