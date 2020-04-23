Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EBBC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254522075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VeH+FXYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254522075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTHI-0001Ko-8t
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTG2-0007vm-Mi
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTG0-0006LU-OT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTG0-00061i-6R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4Cu6O064372;
 Thu, 23 Apr 2020 04:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Dq17oLGMkiAo2smvjYVDn/C8e6ACsRCA6fQR44BDUcQ=;
 b=VeH+FXYzq/VkbUGAzkcbFfAbPNj2+c6VQakyXjqdYRYoh5TaLEBsUxWg9ohZM0JfDWdG
 4mcEDMXSgPnAB9c3nrpnFBRB8vR4F3xOPKHkdbsfqw4Iw+OeKEyTGz7a9dreayhY22X5
 qK8GVSDpGCBlCWUfk78wySiCvPiE1l2UNXAuCHDIaBLgpn2VGoezKHWZNXCKr8+416Ox
 wEWdI7gpErRWwxnVSPFbIOzQNH+KTOmmmHP1agnHAbuvQ9SWUf1lSoY9+Blx5A0IJ6qS
 di+cx9whe/l1VPYRke2nAx3rj8ERd0lcxlnBlqOqxyqzygP2M1TRuMMjkIbWPWMcduN5 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 30grpgtrrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CZdd156914;
 Thu, 23 Apr 2020 04:14:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 30gbbjtvqx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:18 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N4EHgr026322;
 Thu, 23 Apr 2020 04:14:17 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:16 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
Date: Wed, 22 Apr 2020 21:13:36 -0700
Message-Id: <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=3 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=3 bulkscore=0 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Allow RAM MemoryRegion to be created from an offset in a file, instead
of allocating at offset of 0 by default. This is needed to synchronize
RAM between QEMU & remote process.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                    | 11 +++++++----
 include/exec/ram_addr.h   |  2 +-
 include/qemu/mmap-alloc.h |  3 ++-
 memory.c                  |  2 +-
 util/mmap-alloc.c         |  7 ++++---
 util/oslib-posix.c        |  2 +-
 6 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index 2874bb5088..d0ac9545f4 100644
--- a/exec.c
+++ b/exec.c
@@ -1801,6 +1801,7 @@ static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
                             int fd,
                             bool truncate,
+                            off_t offset,
                             Error **errp)
 {
     void *area;
@@ -1851,7 +1852,8 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     area = qemu_ram_mmap(fd, memory, block->mr->align,
-                         block->flags & RAM_SHARED, block->flags & RAM_PMEM);
+                         block->flags & RAM_SHARED, block->flags & RAM_PMEM,
+                         offset);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
@@ -2283,7 +2285,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 #ifdef CONFIG_POSIX
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
-                                 Error **errp)
+                                 off_t offset, Error **errp)
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
@@ -2328,7 +2330,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
+    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
+                                     errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -2358,7 +2361,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
+    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5e59a3d8d7..1b9f489ff0 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -121,7 +121,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
-                                 Error **errp);
+                                 off_t offset, Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index e786266b92..4f579858bc 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -25,7 +25,8 @@ void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
                     bool shared,
-                    bool is_pmem);
+                    bool is_pmem,
+                    off_t start);
 
 void qemu_ram_munmap(int fd, void *ptr, size_t size);
 
diff --git a/memory.c b/memory.c
index 601b749906..f5fec476b7 100644
--- a/memory.c
+++ b/memory.c
@@ -1596,7 +1596,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
                                            share ? RAM_SHARED : 0,
-                                           fd, &err);
+                                           fd, 0, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
         mr->size = int128_zero();
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 27dcccd8ec..a28f7025f0 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -86,7 +86,8 @@ void *qemu_ram_mmap(int fd,
                     size_t size,
                     size_t align,
                     bool shared,
-                    bool is_pmem)
+                    bool is_pmem,
+                    off_t start)
 {
     int flags;
     int map_sync_flags = 0;
@@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
     ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-               flags | map_sync_flags, fd, 0);
+               flags | map_sync_flags, fd, start);
 
     if (ptr == MAP_FAILED && map_sync_flags) {
         if (errno == ENOTSUP) {
@@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
          * we will remove these flags to handle compatibility.
          */
         ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-                   flags, fd, 0);
+                   flags, fd, start);
     }
 
     if (ptr == MAP_FAILED) {
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..4c6b9e90c6 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -209,7 +209,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
+    void *ptr = qemu_ram_mmap(-1, size, align, shared, false, 0);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
2.25.GIT


