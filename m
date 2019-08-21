Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD1C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E1022CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="f/IPOlTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E1022CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0X5e-0007rG-HE
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 16:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60471)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3TqddXQMKCgUxh1lttlqj.htrvjrz-ij0jqstslsz.twl@flex--scw.bounces.google.com>)
 id 1i0X4t-0007SP-Ak
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3TqddXQMKCgUxh1lttlqj.htrvjrz-ij0jqstslsz.twl@flex--scw.bounces.google.com>)
 id 1i0X4s-0000h4-2K
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:19:31 -0400
Received: from mail-yw1-xc49.google.com ([2607:f8b0:4864:20::c49]:48818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3TqddXQMKCgUxh1lttlqj.htrvjrz-ij0jqstslsz.twl@flex--scw.bounces.google.com>)
 id 1i0X4r-0000gK-ST
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:19:30 -0400
Received: by mail-yw1-xc49.google.com with SMTP id h22so2301747ywk.15
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=s+ndl3VqHc//jkjH2CP3u+dZiSg4o9u5DjFzgvWfkBo=;
 b=f/IPOlTXC68gaWZdaAybXxC8mD92sMUN3lIUs/D3mnhFBmS7tnkR4GXl5ZSYAfOTNy
 UNNE7OSft0y2bte7xaTShrPnHf74uwy79j5C4z48XjtXYm4NDBnV2NWYlhKyC+rTDY7O
 YO2+Yiphjo0JCODHQOkuRy/TuNzHRUHctW0VoA4RfgeW9xRNF+I3RycZZM9UxElKWyrl
 Wu3+NFnwdnrd2OdRzgO6oqRLbQ7+GnNWxbYxXARmGFafJ99HxjCDKB7y/kdqBtpgOwXr
 2A2rg5vSsrLCV2cx4UpcyA82Q6QIj7JDLC4uxuu0/o7awQu/jnmYeDBaprVJs7NTdOby
 G4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=s+ndl3VqHc//jkjH2CP3u+dZiSg4o9u5DjFzgvWfkBo=;
 b=pTG23VlbmTz3FiTy3hwglBNypK7R7Z5jLa4/Xwybtnz/S+bV8FyENzrKJbOHNCqsMB
 gF+y9wFQxxwGQfShkOpg47LBhT+PYkrwjpV1nHT8FVxl2klgKnqTNwEIEsSEP8J45es+
 XnR6Cfci0z5RBuvWGQ2ZIk4cZV5aqEdk1Ad/m7pGXlrdXixUoVQs0+OkLs0oQvH3HGdp
 zDUfLoL6AtAYyg57FWl62UpjTyKIDQZHT5XbcIIfSvl6MHjc7sJ3YZPI6E0ozwaQMRFq
 xF4hl/q51jc+eAYCGoJZ7475flT6z547uVH1OPsdw63ZEajfmkygXaZL4VToPNk3B+iZ
 A1RA==
X-Gm-Message-State: APjAAAXnHbbe7daCwS2P2cUqsZgZx42PhKpHBP6KTrb8fNqvqPMliPWY
 DjiVqY6C8bRgjBqo9u/rExwK/R8=
X-Google-Smtp-Source: APXvYqxmQjvQDNb4FD1GwdXWF8mBZH90ie5+X50odV49sID4k94fNG46JR+51ps3R+W7z2QncksmhkQ=
X-Received: by 2002:a0d:df8e:: with SMTP id i136mr26313949ywe.19.1566418766993; 
 Wed, 21 Aug 2019 13:19:26 -0700 (PDT)
Date: Wed, 21 Aug 2019 13:19:21 -0700
Message-Id: <20190821201921.106902-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c49
Subject: [Qemu-devel] [PATCH] linux-user: hijack open() for thread
 directories
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
From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Shu-Chun Weng <scw@google.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Besides /proc/self|<pid>, files under /proc/thread-self and
/proc/self|<pid>/task/<tid> also expose host information to the guest
program. This patch adds them to the hijack infrastracture. Note that
is_proc_myself() does not check if the <tid> matches the current thread
and is thus only suitable for procfs files that are identical for all
threads in the same process.

Behavior verified with guest program:

long main_thread_tid;

long gettid() {
  return syscall(SYS_gettid);
}

void print_info(const char* cxt, const char* dir) {
  char buf[1024];
  FILE* fp;

  snprintf(buf, sizeof(buf), "%s/cmdline", dir);
  fp = fopen(buf, "r");

  if (fp == NULL) {
    printf("%s: can't open %s\n", cxt, buf);
  } else {
    fgets(buf, sizeof(buf), fp);
    printf("%s %s cmd: %s\n", cxt, dir, buf);
    fclose(fp);
  }

  snprintf(buf, sizeof(buf), "%s/maps", dir);
  fp = fopen(buf, "r");

  if (fp == NULL) {
    printf("%s: can't open %s\n", cxt, buf);
  } else {
    char seen[128][128];
    int n = 0, is_new = 0;
    while(fgets(buf, sizeof(buf), fp) != NULL) {
      const char* p = strrchr(buf, ' ');
      if (p == NULL || *(p + 1) == '\n') {
        continue;
      }
      ++p;
      is_new = 1;
      for (int i = 0; i < n; ++i) {
        if (strncmp(p, seen[i], sizeof(seen[i])) == 0) {
          is_new = 0;
          break;
        }
      }
      if (is_new) {
        printf("%s %s map: %s", cxt, dir, p);
        if (n < 128) {
          strncpy(seen[n], p, sizeof(seen[n]));
          seen[n][sizeof(seen[n]) - 1] = '\0';
          ++n;
        }
      }
    }
    fclose(fp);
  }
}

void* thread_main(void* _) {
  char buf[1024];

  print_info("Child", "/proc/thread-self");

  snprintf(buf, sizeof(buf), "/proc/%ld/task/%ld", (long) getpid(), main_thread_tid);
  print_info("Child", buf);

  snprintf(buf, sizeof(buf), "/proc/%ld/task/%ld", (long) getpid(), (long) gettid());
  print_info("Child", buf);

  return NULL;
}

int main() {
  char buf[1024];
  pthread_t thread;
  int ret;

  print_info("Main", "/proc/thread-self");
  print_info("Main", "/proc/self");

  snprintf(buf, sizeof(buf), "/proc/%ld", (long) getpid());
  print_info("Main", buf);

  main_thread_tid = gettid();
  snprintf(buf, sizeof(buf), "/proc/self/task/%ld", main_thread_tid);
  print_info("Main", buf);

  snprintf(buf, sizeof(buf), "/proc/%ld/task/%ld", (long) getpid(), main_thread_tid);
  print_info("Main", buf);

  if ((ret = pthread_create(&thread, NULL, &thread_main, NULL)) < 0) {
    printf("ptherad_create failed: %s (%d)\n", strerror(ret), ret);
  }

  pthread_join(thread, NULL);
  return 0;
}

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/syscall.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8367cb138d..73fe82bcc7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6968,17 +6968,57 @@ static int open_self_auxv(void *cpu_env, int fd)
     return 0;
 }
 
+static int consume_task_directories(const char **filename)
+{
+    if (!strncmp(*filename, "task/", strlen("task/"))) {
+        *filename += strlen("task/");
+        if (**filename < '1' || **filename > '9') {
+            return 0;
+        }
+        /*
+         * Don't care about the exact tid.
+         * XXX: this allows opening files under /proc/self|<pid>/task/<n> where
+         *      <n> is not a valid thread id. Consider checking if the file
+         *      actually exists.
+         */
+        const char *p = *filename + 1;
+        while (*p >= '0' && *p <= '9') {
+            ++p;
+        }
+        if (*p == '/') {
+            *filename = p + 1;
+            return 1;
+        } else {
+            return 0;
+        }
+    }
+    return 1;
+}
+
+/*
+ * Determines if filename refer to a procfs file for the current process or any
+ * thread within the current process. This function should only be used to check
+ * for files that have identical contents in all threads, e.g. exec, maps, etc.
+ */
 static int is_proc_myself(const char *filename, const char *entry)
 {
     if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
         filename += strlen("/proc/");
         if (!strncmp(filename, "self/", strlen("self/"))) {
             filename += strlen("self/");
+            if (!consume_task_directories(&filename)) {
+                return 0;
+            }
+        } else if (!strncmp(filename, "thread-self/", strlen("thread-self/"))) {
+            filename += strlen("thread-self/");
         } else if (*filename >= '1' && *filename <= '9') {
             char myself[80];
             snprintf(myself, sizeof(myself), "%d/", getpid());
             if (!strncmp(filename, myself, strlen(myself))) {
                 filename += strlen(myself);
+                if (!consume_task_directories(&filename)) {
+                    return 0;
+                }
             } else {
                 return 0;
             }
-- 
2.23.0.rc1.153.gdeed80330f-goog


