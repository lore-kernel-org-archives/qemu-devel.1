Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44509C76195
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B2920818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc8cvP0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B2920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZnU-0002Bl-4n
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlg-0002PB-9h
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlf-0006TQ-6F
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlf-0006Sm-0C
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:34:07 -0400
Received: by mail-pg1-x543.google.com with SMTP id t132so10360754pgb.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZlmBo0TLQANZAtGi/aDCtbMrJkweF6r+WlH/gv43QgA=;
 b=oc8cvP0ATx4w+MylNhKJfJvNkpLnLAo/LlNlnXU9qU3hVy14KKhiCzedRyKSVHh92i
 p9PWeTancxN570mGLx7vYS3tGFymB/3zhTN0WE9OVRdZ2vIc3J6RoHOVQomrxAIqxqcP
 SSwNz5Gsz/Fm+5yU97KKrAmVFDiP7Adra3eyhT1oB2khw2Kg+F4Soz4pFQ7CLDPjOX0/
 dRE7p8YTz2UcdL50N0ZbuMbnA3dzTbABkGeKXvlf9Tpd2nWqlSg8SSj3JALFpsCEG9zb
 fdXXFdoSDSBIKhBpdbeo/9whSWGuiSuMyVU2T29BbKXe8u7chVdm1oR2P9yVyJbGYjz+
 WZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZlmBo0TLQANZAtGi/aDCtbMrJkweF6r+WlH/gv43QgA=;
 b=ORL4Ahuj8XO3cDz8ePpuMD7EvdW8cQMhAo1A3Lwo5eY7aKqgBZMDO01Z9mYXgf6INW
 Vm9ndYbd+AQ1jjj8qW0FMgmdVAaI/s6dkhW6u7if60WQlW2C2v16Vxi1zlDLcdlaFii0
 XnVXJ06w3Q0Rj4t3BMlN6322qVVcogVkj+eKcyr3RRXFo59A64FZIG3gppAopfRPQgTd
 yJ3nF4MPBEZVmyYxUYy+QK3ENEUTXYZ1o5ez4RJzub+MFJrkfZJW7lYPX0QDWfaS8cOk
 8QHSCgwEPrZs27g4j5XnPidokdeT6wDEIQSKTRIJSPw0XWaid2JcCOZ8YWHHMBs8oX8z
 6Y1g==
X-Gm-Message-State: APjAAAWyfCMdBtNpCjxlTkS8gkDnYdk93IwpsRitq+vOD2mn3IFZPsIy
 HZdPB2UaA5cCjgTVA4MIvnOYOrPJ
X-Google-Smtp-Source: APXvYqwoITl4shxkQG5p9IVRUvVMcI2KBVbBQHKg80HIatfrSBh9jgcMvBlOwow0dnnlvueNRm53UA==
X-Received: by 2002:a63:f13:: with SMTP id e19mr37682711pgl.132.1563330845374; 
 Tue, 16 Jul 2019 19:34:05 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.34.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:34:04 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:10 +0800
Message-Id: <20190717023310.197246-12-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v14 11/11] qemu_thread: supplement error
 handling for touch_all_pages
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Supplement the error handling for touch_all_pages: add an Error
parameter for it to propagate the error to its caller to do the
handling in case it fails.

Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 util/oslib-posix.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 55c1b9c098..eff5af3ccf 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -448,12 +448,12 @@ static inline int get_memset_num_threads(int smp_cpus)
 }
 
 static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
-                            int smp_cpus)
+                            int smp_cpus, Error **errp)
 {
     size_t numpages_per_thread;
     size_t size_per_thread;
     char *addr = area;
-    int i = 0;
+    int i = 0, j = 0;
 
     memset_thread_failed = false;
     memset_num_threads = get_memset_num_threads(smp_cpus);
@@ -465,20 +465,32 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
                                     numpages : numpages_per_thread;
         memset_thread[i].hpagesize = hpagesize;
-        /* TODO: let the callers handle the error instead of abort() here */
-        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
-                           do_touch_pages, &memset_thread[i],
-                           QEMU_THREAD_JOINABLE, &error_abort);
+        if (qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
+                               do_touch_pages, &memset_thread[i],
+                               QEMU_THREAD_JOINABLE, errp) < 0) {
+            break;
+        }
         addr += size_per_thread;
         numpages -= numpages_per_thread;
     }
-    for (i = 0; i < memset_num_threads; i++) {
-        qemu_thread_join(&memset_thread[i].pgthread);
+
+    for (j = 0; j < i; j++) {
+        qemu_thread_join(&memset_thread[j].pgthread);
     }
     g_free(memset_thread);
     memset_thread = NULL;
 
-    return memset_thread_failed;
+    if (i < memset_num_threads) {
+        /* qemu_thread_create() has set @errp */
+        return false;
+    }
+
+    if (memset_thread_failed) {
+        error_setg(errp, "os_mem_prealloc: Insufficient free host "
+                         "memory pages available to allocate guest RAM");
+        return false;
+    }
+    return true;
 }
 
 void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
@@ -501,10 +513,7 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
     }
 
     /* touch pages simultaneously */
-    if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
-        error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
-            "pages available to allocate guest RAM");
-    }
+    touch_all_pages(area, hpagesize, numpages, smp_cpus, errp);
 
     ret = sigaction(SIGBUS, &oldact, NULL);
     if (ret) {
-- 
2.11.0


