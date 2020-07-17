Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F6C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEFA20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuJW8WcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEFA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwN7C-0003RE-6F
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6I-0002G4-ST
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6H-0001BW-2E
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594979776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=xj1GTexbJRsxeq+sR2SiUApnw/+FUi/MCXCrVa0427w=;
 b=HuJW8WcHG4O5YqN7rGUESgWwnAZTfxhdq8FZmpsF9A5jEpAC65RL28W6sxeQXvrG09BvYG
 lZ9DVTRlRUq8Ux3xLrlXcHQvekden0FWjFA4z+wSk1rBtA7pRz0/NM4oytsprzWPSZWUuu
 rSXtjYMeaXMuMB2z/6WLFdQRp1Ie9Ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-bGybhaoGNiKv4JJfGgRuaw-1; Fri, 17 Jul 2020 05:56:13 -0400
X-MC-Unique: bGybhaoGNiKv4JJfGgRuaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F36E106B24B;
 Fri, 17 Jul 2020 09:56:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 925615C240;
 Fri, 17 Jul 2020 09:56:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 3/6] fuzz: Expect the cmdline in a freeable GString
Date: Fri, 17 Jul 2020 11:56:02 +0200
Message-Id: <20200717095605.27589-4-thuth@redhat.com>
In-Reply-To: <20200717095605.27589-1-thuth@redhat.com>
References: <20200717095605.27589-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

In the initial FuzzTarget, get_init_cmdline returned a char *. With this
API, we had no guarantee about where the string came from. For example,
i440fx-qtest-reboot-fuzz simply returned a pointer to a string literal,
while the QOS-based targets build the arguments out in a GString an
return the gchar *str pointer. Since we did not try to free the cmdline,
we have a leak for any targets that do not simply return string
literals. Clean up this mess by forcing fuzz-targets to return
a GString, that we can free.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200714174616.20709-1-alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/fuzz.c        | 13 ++++++-------
 tests/qtest/fuzz/fuzz.h        |  6 +++---
 tests/qtest/fuzz/i440fx_fuzz.c |  4 ++--
 tests/qtest/fuzz/qos_fuzz.c    |  6 +++---
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 0b66e43409..6bc17ef313 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -199,16 +199,15 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     }
 
     /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
-    const char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
-    init_cmdline = g_strdup_printf("%s -qtest /dev/null -qtest-log %s",
-                                   init_cmdline,
-                                   getenv("QTEST_LOG") ? "/dev/fd/2"
-                                                       : "/dev/null");
-
+    GString *cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
+    g_string_append_printf(cmd_line,
+                           " -qtest /dev/null -qtest-log %s",
+                           getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null");
 
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
-    wordexp(init_cmdline, &result, 0);
+    wordexp(cmd_line->str, &result, 0);
+    g_string_free(cmd_line, true);
 
     qemu_init(result.we_wordc, result.we_wordv, NULL);
 
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 72d5710f6c..9ca3d107c5 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -50,10 +50,10 @@ typedef struct FuzzTarget {
 
 
     /*
-     * returns the arg-list that is passed to qemu/softmmu init()
-     * Cannot be NULL
+     * Returns the arguments that are passed to qemu/softmmu init(). Freed by
+     * the caller.
      */
-    const char* (*get_init_cmdline)(struct FuzzTarget *);
+    GString *(*get_init_cmdline)(struct FuzzTarget *);
 
     /*
      * will run once, prior to running qemu/softmmu init.
diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index e2f31e56f9..bf966d478b 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -158,9 +158,9 @@ static void i440fx_fuzz_qos_fork(QTestState *s,
 
 static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
                                        " -m 0 -display none";
-static const char *i440fx_argv(FuzzTarget *t)
+static GString *i440fx_argv(FuzzTarget *t)
 {
-    return i440fx_qtest_argv;
+    return g_string_new(i440fx_qtest_argv);
 }
 
 static void fork_init(void)
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index 0c68f5361f..d52f3ebd83 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -66,7 +66,7 @@ void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
     return allocate_objects(qts, current_path + 1, p_alloc);
 }
 
-static const char *qos_build_main_args(void)
+static GString *qos_build_main_args(void)
 {
     char **path = fuzz_path_vec;
     QOSGraphNode *test_node;
@@ -88,7 +88,7 @@ static const char *qos_build_main_args(void)
     /* Prepend the arguments that we need */
     g_string_prepend(cmd_line,
             TARGET_NAME " -display none -machine accel=qtest -m 64 ");
-    return cmd_line->str;
+    return cmd_line;
 }
 
 /*
@@ -189,7 +189,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     g_free(path_str);
 }
 
-static const char *qos_get_cmdline(FuzzTarget *t)
+static GString *qos_get_cmdline(FuzzTarget *t)
 {
     /*
      * Set a global variable that we use to identify the qos_path for our
-- 
2.18.1


