Received: from eggs.gnu.org ([209.51.188.92]:42888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GqM-0002oL-PK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GqL-00057Z-Dt
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:34 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:50 +0100
Message-Id: <20190311090322.21603-2-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/33] target/s390x: Remove non-architected
 entries from struct LowCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

There are some fields in our struct LowCore which apparently have
been copied from a very old version of the Linux kernel. These
fields are not architected in the "Principles of Operation", and
only used on these memory locations in Linux kernels older than
2.6.29. Newer Linux kernels moved the entries to different locations
or are not using them at all anymore. Thus we should never access
these fields from the QEMU side, so they should be removed.

While we're at it, also add a QEMU_BUILD_BUG_ON() statement to
assert that struct LowCore has the right size.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1551775581-27989-1-git-send-email-thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/internal.h | 41 ++---------------------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 7baf0e2404b4..07b69b8ea000 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -63,45 +63,7 @@ typedef struct LowCore {
     PSW             program_new_psw;          /* 0x1d0 */
     PSW             mcck_new_psw;             /* 0x1e0 */
     PSW             io_new_psw;               /* 0x1f0 */
-    PSW             return_psw;               /* 0x200 */
-    uint8_t         irb[64];                  /* 0x210 */
-    uint64_t        sync_enter_timer;         /* 0x250 */
-    uint64_t        async_enter_timer;        /* 0x258 */
-    uint64_t        exit_timer;               /* 0x260 */
-    uint64_t        last_update_timer;        /* 0x268 */
-    uint64_t        user_timer;               /* 0x270 */
-    uint64_t        system_timer;             /* 0x278 */
-    uint64_t        last_update_clock;        /* 0x280 */
-    uint64_t        steal_clock;              /* 0x288 */
-    PSW             return_mcck_psw;          /* 0x290 */
-    uint8_t         pad9[0xc00 - 0x2a0];      /* 0x2a0 */
-    /* System info area */
-    uint64_t        save_area[16];            /* 0xc00 */
-    uint8_t         pad10[0xd40 - 0xc80];     /* 0xc80 */
-    uint64_t        kernel_stack;             /* 0xd40 */
-    uint64_t        thread_info;              /* 0xd48 */
-    uint64_t        async_stack;              /* 0xd50 */
-    uint64_t        kernel_asce;              /* 0xd58 */
-    uint64_t        user_asce;                /* 0xd60 */
-    uint64_t        panic_stack;              /* 0xd68 */
-    uint64_t        user_exec_asce;           /* 0xd70 */
-    uint8_t         pad11[0xdc0 - 0xd78];     /* 0xd78 */
-
-    /* SMP info area: defined by DJB */
-    uint64_t        clock_comparator;         /* 0xdc0 */
-    uint64_t        ext_call_fast;            /* 0xdc8 */
-    uint64_t        percpu_offset;            /* 0xdd0 */
-    uint64_t        current_task;             /* 0xdd8 */
-    uint32_t        softirq_pending;          /* 0xde0 */
-    uint32_t        pad_0x0de4;               /* 0xde4 */
-    uint64_t        int_clock;                /* 0xde8 */
-    uint8_t         pad12[0xe00 - 0xdf0];     /* 0xdf0 */
-
-    /* 0xe00 is used as indicator for dump tools */
-    /* whether the kernel died with panic() or not */
-    uint32_t        panic_magic;              /* 0xe00 */
-
-    uint8_t         pad13[0x11b0 - 0xe04];    /* 0xe04 */
+    uint8_t         pad13[0x11b0 - 0x200];    /* 0x200 */
 
     uint64_t        mcesad;                    /* 0x11B0 */
 
@@ -130,6 +92,7 @@ typedef struct LowCore {
 
     uint8_t         pad18[0x2000 - 0x1400];    /* 0x1400 */
 } QEMU_PACKED LowCore;
+QEMU_BUILD_BUG_ON(sizeof(LowCore) != 8192);
 #endif /* CONFIG_USER_ONLY */
 
 #define MAX_ILEN 6
-- 
2.17.2
