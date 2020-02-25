Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FA4C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FEA20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pk/3S4I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FEA20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZdI-0006Mo-HD
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0V-00044n-LD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0R-0003fn-Vm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0R-0003em-Me
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:07 -0500
Received: by mail-wm1-x341.google.com with SMTP id z12so2724207wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HZHzP8N5auJ+8tEymgxdWqmFlBp/rJEHoVe8+UtDFwI=;
 b=pk/3S4I5aGP52sJuap8cquvcTxBZUdm1CUMMyWfbDIPqo/d8UIjK5k0+50USSS2ZfI
 DQjOFnpd2DjIpVvBM13kPOzZIyALfkZkjVXaDRg2dfWMQcKecvevTn0FWZbV9ApCqiuP
 hyYANFUV2zUm2PtIe1ylKPEw7TaJXaY7hH5upNQTF5VlZXluFkjrhRAW1S945le705Dp
 XXoJccrgb/Y/Nwcpc9VsmoDr2rt/xJNijNNMJQ4R3XRWxN//iTD0mk2Y1pZqWMVi2J8h
 K/gTkFrqbmwngpIXD6GSmZhjOBom/7y5O0EqynczvUsjxEY5YCovcDDKE+XCCwVIClso
 XtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HZHzP8N5auJ+8tEymgxdWqmFlBp/rJEHoVe8+UtDFwI=;
 b=XwinuhvddDtNsYM0IXgP6NmTD8rgLJvIG95h4lsQDSJL23jDa020d7/vQsCtEmkyqR
 IAlf/18+g8+6FBmxn2FJL1hNDWP6Z3TBkQ17LJ/7XepL0MqKNyhvjsvv69uWs8S7EhcP
 7To7kBIjeYvCc9VSZPXQI5ktk9f7gG45d9vGXHq5LNFRTepOM+qCsHiO1ySwj3q+0JYf
 M7emsH8FQbsYAWgwDZznkYSAfyC7AXpB9S8Cqz69pq1DoXNptARwgMLyC8et9jiPicZt
 C6M7kjkAzMRPfCxvf3E255zCw90nxlF2BSgZe5IGozcAt2Ctiv//GLcHzBy/NqJhu2Ma
 HY2g==
X-Gm-Message-State: APjAAAUa53CNNKs2fgNw/AdzhA3ChD3meoKP8CwosnXuA5/lfVNQkzr/
 ZmG2jT9VPtN6oFoUiekgEDHXjWuw
X-Google-Smtp-Source: APXvYqyayTP6cPETYG1uKpasiif4lUOlA8nAhroadBbC/OyHEOU7uMUabDFfALjYv5mBBPZe5hto0w==
X-Received: by 2002:a1c:f60e:: with SMTP id w14mr4987825wmc.188.1582632485217; 
 Tue, 25 Feb 2020 04:08:05 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 132/136] mem-prealloc: optimize large guest startup
Date: Tue, 25 Feb 2020 13:07:30 +0100
Message-Id: <1582632454-16491-30-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: bauerchen <bauerchen@tencent.com>

[desc]:
    Large memory VM starts slowly when using -mem-prealloc, and
    there are some areas to optimize in current method;

    1、mmap will be used to alloc threads stack during create page
    clearing threads, and it will attempt mm->mmap_sem for write
    lock, but clearing threads have hold read lock, this competition
    will cause threads createion very slow;

    2、methods of calcuating pages for per threads is not well;if we use
    64 threads to split 160 hugepage,63 threads clear 2page,1 thread
    clear 34 page,so the entire speed is very slow;

    to solve the first problem,we add a mutex in thread function,and
    start all threads when all threads finished createion;
    and the second problem, we spread remainder to other threads,in
    situation that 160 hugepage and 64 threads, there are 32 threads
    clear 3 pages,and 32 threads clear 2 pages.

[test]:
    320G 84c VM start time can be reduced to 10s
    680G 84c VM start time can be reduced to 18s

Signed-off-by: bauerchen <bauerchen@tencent.com>
Reviewed-by: Pan Rui <ruippan@tencent.com>
Reviewed-by: Ivan Ren <ivanren@tencent.com>
[Simplify computation of the number of pages per thread. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-posix.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 5a291cc..897e8f3 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -76,6 +76,10 @@ static MemsetThread *memset_thread;
 static int memset_num_threads;
 static bool memset_thread_failed;
 
+static QemuMutex page_mutex;
+static QemuCond page_cond;
+static bool threads_created_flag;
+
 int qemu_get_thread_id(void)
 {
 #if defined(__linux__)
@@ -403,6 +407,17 @@ static void *do_touch_pages(void *arg)
     MemsetThread *memset_args = (MemsetThread *)arg;
     sigset_t set, oldset;
 
+    /*
+     * On Linux, the page faults from the loop below can cause mmap_sem
+     * contention with allocation of the thread stacks.  Do not start
+     * clearing until all threads have been created.
+     */
+    qemu_mutex_lock(&page_mutex);
+    while(!threads_created_flag){
+        qemu_cond_wait(&page_cond, &page_mutex);
+    }
+    qemu_mutex_unlock(&page_mutex);
+
     /* unblock SIGBUS */
     sigemptyset(&set);
     sigaddset(&set, SIGBUS);
@@ -451,27 +466,28 @@ static inline int get_memset_num_threads(int smp_cpus)
 static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
                             int smp_cpus)
 {
-    size_t numpages_per_thread;
-    size_t size_per_thread;
+    size_t numpages_per_thread, leftover;
     char *addr = area;
     int i = 0;
 
     memset_thread_failed = false;
+    threads_created_flag = false;
     memset_num_threads = get_memset_num_threads(smp_cpus);
     memset_thread = g_new0(MemsetThread, memset_num_threads);
-    numpages_per_thread = (numpages / memset_num_threads);
-    size_per_thread = (hpagesize * numpages_per_thread);
+    numpages_per_thread = numpages / memset_num_threads;
+    leftover = numpages % memset_num_threads;
     for (i = 0; i < memset_num_threads; i++) {
         memset_thread[i].addr = addr;
-        memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
-                                    numpages : numpages_per_thread;
+        memset_thread[i].numpages = numpages_per_thread + (i < leftover);
         memset_thread[i].hpagesize = hpagesize;
         qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
                            do_touch_pages, &memset_thread[i],
                            QEMU_THREAD_JOINABLE);
-        addr += size_per_thread;
-        numpages -= numpages_per_thread;
+        addr += memset_thread[i].numpages * hpagesize;
     }
+    threads_created_flag = true;
+    qemu_cond_broadcast(&page_cond);
+
     for (i = 0; i < memset_num_threads; i++) {
         qemu_thread_join(&memset_thread[i].pgthread);
     }
-- 
1.8.3.1



