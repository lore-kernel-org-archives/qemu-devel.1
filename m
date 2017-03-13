Received: from eggs.gnu.org ([2001:4830:134:3::10]:51586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cnGFQ-0003Yi-IY
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cnGFM-0005tz-LZ
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:02:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cnGFM-0005tL-Cy
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:02:08 -0400
Date: Mon, 13 Mar 2017 11:02:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170313030201.GH17299@pxdev.xzpeter.org>
References: <1489345956-29167-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1489345956-29167-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] memory: use 128 bit in info mtree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Sun, Mar 12, 2017 at 09:12:43PM +0200, Michael S. Tsirkin wrote:
> info mtree is doing 64 bit math to figure out
> addresses from offsets, this does not work ncorrectly
> incase of overflow.
> 
> Overflow usually indicates a guest bug, so this is unusual
> but reporting correct addresses makes it easier to discover
> what is going on.

A tiny issue would be that we will always dump 128 bits even if
nothing went wrong. IMHO That's slightly awkward. Not sure whether
that will confuse people since they should be thinking why we need
that on 64bit systems...

Do you like below one instead? It'll keep the old interface, but just
warn user explicity when something wrong happens, and it's much easier
and obvious imho (along with a tiny cleanup):

(the code is not tested even for compile)

---------8<-----------
diff --git a/memory.c b/memory.c
index 284894b..64b0a60 100644
--- a/memory.c
+++ b/memory.c
@@ -2494,6 +2494,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     MemoryRegionListHead submr_print_queue;
     const MemoryRegion *submr;
     unsigned int i;
+    hwaddr cur_start, cur_end;

     if (!mr) {
         return;
@@ -2503,6 +2504,18 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
         mon_printf(f, MTREE_INDENT);
     }

+    cur_start = base + mr->addr;
+    cur_end = cur_start + MR_SIZE(mr->size);
+
+    /*
+     * Try to detect overflow of memory ranges. This should never
+     * happen normally. When it happens, we dump something to warn the
+     * user who is observing this.
+     */
+    if (cur_start < base || cur_end < cur_start) {
+        mon_printf(f, "[DETECTED OVERFLOW!] ");
+    }
+
     if (mr->alias) {
         MemoryRegionList *ml;
         bool found = false;
@@ -2522,8 +2535,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
         mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
                    " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
                    "-" TARGET_FMT_plx "%s\n",
-                   base + mr->addr,
-                   base + mr->addr + MR_SIZE(mr->size),
+                   cur_start, cur_end,
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
@@ -2534,8 +2546,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     } else {
         mon_printf(f,
                    TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
-                   base + mr->addr,
-                   base + mr->addr + MR_SIZE(mr->size),
+                   cur_start, cur_end,
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
@@ -2562,7 +2573,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }

     QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
-        mtree_print_mr(mon_printf, f, ml->mr, level + 1, base + mr->addr,
+        mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
                        alias_print_queue);
     }
--------->8-----------

Thanks,

-- peterx
