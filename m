Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E222EC10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB1D21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfZLrV5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB1D21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhvw-0002A7-BM
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr7-00057Y-E7
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr3-00034o-V2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:56052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhr3-00033d-OE
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:51:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id a6so7939040wma.5
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UM9naFb11+jXmkpkEOdz9w/7R4gvI6i+/DkJ8BktyjI=;
 b=HfZLrV5zwM+DUSo3S39wKQ/3vrwt5yp9LK/ua+6mkgHGe2YxZEBw0ZA6SQAd4nbr9u
 RNMDr3Gi6Gt5xTAYyhWG5G5EtDBvR9ookRdCC/BOsfLruNizQH6Aip0bsD1zSVLYKf6+
 7ylN0ywQKCF8ZEVBrgi6p/vbdilz0wzngsEoHXwVcBHiX6Ls7e9v/jaWCz4UjBlfw7x6
 m9l2DL3ksoaikxHu9orWknGVarwLXjrF0/2pmMuSVgGmvOsUIRKw0E0xTy0p5qC0mpmf
 EW8xZdEE4/AjYTXfErUHFCaAChrSt/760EtL7JCsn0C8sX9yshZ4Toakq1zblVzXajBh
 DAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UM9naFb11+jXmkpkEOdz9w/7R4gvI6i+/DkJ8BktyjI=;
 b=Bu5tPKKMI1+eUVxnzWGij1Gw2CTPN0JxgUzYuw2li9sUf1ZRAfg+jb5JC8txMcNb7L
 rOLx0+hAFaVrklwa1waY0x0PBMPRvW4LhWEXm6Qme5XgEKmXtTWAD2EiAqfreY791sMt
 +UEbtFLgaiRFMLdamp/2KlKfsKZeylRIXeCA/RKOKpzN0SUgYBkvzRUzfnU3Edkzb5OY
 +hi78QUxsqetTaSE/KMYYzhJVZz91Wt+QZTtAPmOmiZHcfqCjQ+AqSubMzVaH2LDVrDr
 4v7B8txqsNbtQXmR2h5RMiuAZYnI73s30+NWsZiZehIdgqnzk0tllWckswDGMY0zNP7g
 ipJw==
X-Gm-Message-State: APjAAAX/orMTUllqs2A2wZWiPXkSyh3ePPzgWQwvtXcyfabelgcDl143
 7YWNUOXaMzrR0fdkgdqghxroTyJ1
X-Google-Smtp-Source: APXvYqx2dDb8gCUwDoTJqYvP3cxw39YMy538cyDool6YeCuba7OXfqwL0LRlPF63KirE1c8ua6mF2g==
X-Received: by 2002:a05:600c:2057:: with SMTP id
 p23mr3557628wmg.17.1570035116301; 
 Wed, 02 Oct 2019 09:51:56 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.51.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:51:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/30] tests/migration: Add a test for auto converge
Date: Wed,  2 Oct 2019 18:51:24 +0200
Message-Id: <1570035113-56848-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190909131335.16848-4-yury-kotov@yandex-team.ru>
[Reorganize check_migration_status for rebase. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/migration-test.c | 157 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 221a33d..59f291c 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -240,6 +240,17 @@ static int64_t read_ram_property_int(QTestState *who, const char *property)
     return result;
 }
 
+static int64_t read_migrate_property_int(QTestState *who, const char *property)
+{
+    QDict *rsp_return;
+    int64_t result;
+
+    rsp_return = migrate_query(who);
+    result = qdict_get_try_int(rsp_return, property, 0);
+    qobject_unref(rsp_return);
+    return result;
+}
+
 static uint64_t get_migration_pass(QTestState *who)
 {
     return read_ram_property_int(who, "dirty-sync-count");
@@ -254,32 +265,46 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
 
+static bool check_migration_status(QTestState *who, const char *goal,
+                                   const char **ungoals)
+{
+    bool ready;
+    char *current_status;
+    const char **ungoal;
+
+    current_status = migrate_query_status(who);
+    ready = strcmp(current_status, goal) == 0;
+    if (!ungoals) {
+        g_assert_cmpstr(current_status, !=, "failed");
+        /*
+         * If looking for a state other than completed,
+         * completion of migration would cause the test to
+         * hang.
+         */
+        if (strcmp(goal, "completed") != 0) {
+            g_assert_cmpstr(current_status, !=, "completed");
+        }
+    } else {
+        for (ungoal = ungoals; *ungoal; ungoal++) {
+            g_assert_cmpstr(current_status, !=,  *ungoal);
+        }
+    }
+    g_free(current_status);
+    return ready;
+}
+
 static void wait_for_migration_status(QTestState *who,
                                       const char *goal,
                                       const char **ungoals)
 {
-    while (true) {
-        bool completed;
-        char *status;
-        const char **ungoal;
-
-        status = migrate_query_status(who);
-        completed = strcmp(status, goal) == 0;
-        for (ungoal = ungoals; *ungoal; ungoal++) {
-            g_assert_cmpstr(status, !=,  *ungoal);
-        }
-        g_free(status);
-        if (completed) {
-            return;
-        }
+    while (!check_migration_status(who, goal, ungoals)) {
         usleep(1000);
     }
 }
 
 static void wait_for_migration_complete(QTestState *who)
 {
-    wait_for_migration_status(who, "completed",
-                              (const char * []) { "failed", NULL });
+    wait_for_migration_status(who, "completed", NULL);
 }
 
 static void wait_for_migration_pass(QTestState *who)
@@ -450,6 +475,17 @@ static void migrate_pause(QTestState *who)
     qobject_unref(rsp);
 }
 
+static void migrate_continue(QTestState *who, const char *state)
+{
+    QDict *rsp;
+
+    rsp = wait_command(who,
+                       "{ 'execute': 'migrate-continue',"
+                       "  'arguments': { 'state': %s } }",
+                       state);
+    qobject_unref(rsp);
+}
+
 static void migrate_recover(QTestState *who, const char *uri)
 {
     QDict *rsp;
@@ -814,9 +850,7 @@ static void test_postcopy_recovery(void)
      * Wait until postcopy is really started; we can only run the
      * migrate-pause command during a postcopy
      */
-    wait_for_migration_status(from, "postcopy-active",
-                              (const char * []) { "failed",
-                                                  "completed", NULL });
+    wait_for_migration_status(from, "postcopy-active", NULL);
 
     /*
      * Manually stop the postcopy migration. This emulates a network
@@ -1210,6 +1244,89 @@ static void test_validate_uuid_dst_not_set(void)
                           false, true);
 }
 
+static void test_migrate_auto_converge(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int64_t remaining, percentage;
+
+    /*
+     * We want the test to be stable and as fast as possible.
+     * E.g., with 1Gb/s bandwith migration may pass without throttling,
+     * so we need to decrease a bandwidth.
+     */
+    const int64_t init_pct = 5, inc_pct = 50, max_pct = 95;
+    const int64_t max_bandwidth = 400000000; /* ~400Mb/s */
+    const int64_t downtime_limit = 250; /* 250ms */
+    /*
+     * We migrate through unix-socket (> 500Mb/s).
+     * Thus, expected migration speed ~= bandwidth limit (< 500Mb/s).
+     * So, we can predict expected_threshold
+     */
+    const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
+
+    if (test_migrate_start(&from, &to, uri, false, false, NULL, NULL)) {
+        return;
+    }
+
+    migrate_set_capability(from, "auto-converge", true);
+    migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
+    migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
+    migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+
+    /*
+     * Set the initial parameters so that the migration could not converge
+     * without throttling.
+     */
+    migrate_set_parameter_int(from, "downtime-limit", 1);
+    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
+
+    /* To check remaining size after precopy */
+    migrate_set_capability(from, "pause-before-switchover", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+
+    /* Wait for throttling begins */
+    percentage = 0;
+    while (percentage == 0) {
+        percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+        usleep(100);
+        g_assert_false(got_stop);
+    }
+    /* The first percentage of throttling should be equal to init_pct */
+    g_assert_cmpint(percentage, ==, init_pct);
+    /* Now, when we tested that throttling works, let it converge */
+    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
+    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
+
+    /*
+     * Wait for pre-switchover status to check last throttle percentage
+     * and remaining. These values will be zeroed later
+     */
+    wait_for_migration_status(from, "pre-switchover", NULL);
+
+    /* The final percentage of throttling shouldn't be greater than max_pct */
+    percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
+    g_assert_cmpint(percentage, <=, max_pct);
+
+    remaining = read_ram_property_int(from, "remaining");
+    g_assert_cmpint(remaining, <, expected_threshold);
+
+    migrate_continue(from, "pre-switchover");
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    g_free(uri);
+
+    test_migrate_end(from, to, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -1272,6 +1389,8 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/validate_uuid_dst_not_set",
                    test_validate_uuid_dst_not_set);
 
+    qtest_add_func("/migration/auto_converge", test_migrate_auto_converge);
+
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
1.8.3.1



