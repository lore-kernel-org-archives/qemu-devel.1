Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB5C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D9021A4A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Kp4EVkKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D9021A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7HHA-00082u-Cc
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 06:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i7HFa-0006VG-Nk
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i7HFY-00076K-IB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:50:25 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:51946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i7HFY-00074R-67
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:50:24 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 74B752E14A8;
 Mon,  9 Sep 2019 13:50:22 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 yJWxZKsfdC-oLCuBHZi; Mon, 09 Sep 2019 13:50:22 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1568026222; bh=ZA+KSTtJuA+3wVOCSnI+J08UhfBeQ9DNSGk7sqqTmVA=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=Kp4EVkKtlssWdlkSIul18ROShi20eYtGdsvbnjPfxqDkKZnoYTAYJXQjTv13RxOHm
 euBAf1YjCCA8/VwFNJBoGslhFf+qjVEObjq3Syzv8BWw6gzi6MvTo+XV2Rpd55yfvX
 7QFvO6xoEn/kfWvniAC8VDgv1yuXAjzlcYM34l2c=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:c41:6db7:e9d4:e9e0])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 Skp3BT4RoZ-oLD0D4b4; Mon, 09 Sep 2019 13:50:21 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>,
 Thomas Huth <thuth@redhat.com>
Date: Mon,  9 Sep 2019 13:49:48 +0300
Message-Id: <20190909104948.30253-4-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909104948.30253-1-yury-kotov@yandex-team.ru>
References: <20190909104948.30253-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
Subject: [Qemu-devel] [PATCH v6 3/3] tests/migration: Add a test for auto
 converge
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 120 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 11 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index a9f81cc185..7064b341e7 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -240,6 +240,17 @@ static int64_t read_ram_property_int(QTestState *who=
, const char *property)
     return result;
 }
=20
+static int64_t read_migrate_property_int(QTestState *who, const char *pr=
operty)
+{
+    QDict *rsp_return;
+    int64_t result;
+
+    rsp_return =3D migrate_query(who);
+    result =3D qdict_get_try_int(rsp_return, property, 0);
+    qobject_unref(rsp_return);
+    return result;
+}
+
 static uint64_t get_migration_pass(QTestState *who)
 {
     return read_ram_property_int(who, "dirty-sync-count");
@@ -254,20 +265,22 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
=20
+static bool check_migration_status(QTestState *who, const char *status)
+{
+    bool completed;
+    char *current_status;
+
+    current_status =3D migrate_query_status(who);
+    completed =3D strcmp(current_status, status) =3D=3D 0;
+    g_assert_cmpstr(current_status, !=3D, "failed");
+    g_free(current_status);
+    return completed;
+}
+
 static void wait_for_migration_status(QTestState *who,
                                       const char *goal)
 {
-    while (true) {
-        bool completed;
-        char *status;
-
-        status =3D migrate_query_status(who);
-        completed =3D strcmp(status, goal) =3D=3D 0;
-        g_assert_cmpstr(status, !=3D,  "failed");
-        g_free(status);
-        if (completed) {
-            return;
-        }
+    while (!check_migration_status(who, goal)) {
         usleep(1000);
     }
 }
@@ -1125,6 +1138,90 @@ static void test_migrate_fd_proto(void)
     test_migrate_end(from, to, true);
 }
=20
+static void test_migrate_auto_converge(void)
+{
+    char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int64_t remaining, percentage;
+
+    /*
+     * We want the test to be stable and as fast as possible.
+     * E.g., with 1Gb/s bandwith migration may pass without throttling,
+     * so we need to decrease a bandwidth.
+     */
+    const int64_t init_pct =3D 5, inc_pct =3D 50, max_pct =3D 95;
+    const int64_t max_bandwidth =3D 400000000; /* ~400Mb/s */
+    const int64_t downtime_limit =3D 250; /* 250ms */
+    /*
+     * We migrate through unix-socket (> 500Mb/s).
+     * Thus, expected migration speed ~=3D bandwidth limit (< 500Mb/s).
+     * So, we can predict expected_threshold
+     */
+    const int64_t expected_threshold =3D max_bandwidth * downtime_limit =
/ 1000;
+
+    if (test_migrate_start(&from, &to, uri, false, false)) {
+        return;
+    }
+
+    migrate_set_capability(from, "auto-converge", true);
+    migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
+    migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
+    migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+
+    /*
+     * Set the initial parameters so that the migration could not conver=
ge
+     * without throttling.
+     */
+    migrate_set_parameter_int(from, "downtime-limit", 1);
+    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100=
Mb/s */
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
+    percentage =3D 0;
+    while (percentage =3D=3D 0) {
+        percentage =3D read_migrate_property_int(from, "cpu-throttle-per=
centage");
+        usleep(100);
+        g_assert_false(got_stop);
+    }
+    /* The first percentage of throttling should be equal to init_pct */
+    g_assert_cmpint(percentage, =3D=3D, init_pct);
+    /* Now, when we tested that throttling works, let it converge */
+    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
+    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
+
+    /*
+     * Wait for pre-switchover status to check last throttle percentage
+     * and remaining. These values will be zeroed later
+     */
+    wait_for_migration_status(from, "pre-switchover");
+
+    /* The final percentage of throttling shouldn't be greater than max_=
pct */
+    percentage =3D read_migrate_property_int(from, "cpu-throttle-percent=
age");
+    g_assert_cmpint(percentage, <=3D, max_pct);
+
+    remaining =3D read_ram_property_int(from, "remaining");
+    g_assert_cmpint(remaining, <, expected_threshold);
+
+    wait_command(from, "{ 'execute': 'migrate-continue' , 'arguments':"
+                       "  { 'state': 'pre-switchover' } }");
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
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1180,6 +1277,7 @@ int main(int argc, char **argv)
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
     qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
+    qtest_add_func("/migration/auto_converge", test_migrate_auto_converg=
e);
=20
     ret =3D g_test_run();
=20
--=20
2.23.0


