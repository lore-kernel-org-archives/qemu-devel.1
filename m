Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E7C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9C42089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9C42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCODd-0006dJ-13
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iCO6q-0001O4-5o
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iCO6p-0006I0-16
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iCO6o-0006HU-PI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:10:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DD4130917AA;
 Mon, 23 Sep 2019 13:10:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-213.ams2.redhat.com
 [10.36.117.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA2BF601A2;
 Mon, 23 Sep 2019 13:10:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	quintela@redhat.com,
	peterx@redhat.com
Subject: [PATCH 1/2] tests/migration: Fail on unexpected migration states
Date: Mon, 23 Sep 2019 14:10:21 +0100
Message-Id: <20190923131022.15498-2-dgilbert@redhat.com>
In-Reply-To: <20190923131022.15498-1-dgilbert@redhat.com>
References: <20190923131022.15498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 23 Sep 2019 13:10:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: thuth@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We've got various places where we wait for a migration to enter
a given state; but if we enter an unexpected state we tend to fail
in odd ways; add a mechanism for explicitly testing for any state
which we shouldn't be in.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 258aa064d4..9c62ee5331 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -255,15 +255,19 @@ static void read_blocktime(QTestState *who)
 }
=20
 static void wait_for_migration_status(QTestState *who,
-                                      const char *goal)
+                                      const char *goal,
+                                      const char **ungoals)
 {
     while (true) {
         bool completed;
         char *status;
+        const char **ungoal;
=20
         status =3D migrate_query_status(who);
         completed =3D strcmp(status, goal) =3D=3D 0;
-        g_assert_cmpstr(status, !=3D,  "failed");
+        for (ungoal =3D ungoals; *ungoal; ungoal++) {
+            g_assert_cmpstr(status, !=3D,  *ungoal);
+        }
         g_free(status);
         if (completed) {
             return;
@@ -274,7 +278,8 @@ static void wait_for_migration_status(QTestState *who=
,
=20
 static void wait_for_migration_complete(QTestState *who)
 {
-    wait_for_migration_status(who, "completed");
+    wait_for_migration_status(who, "completed",
+                              (const char * []) { "failed", NULL });
 }
=20
 static void wait_for_migration_pass(QTestState *who)
@@ -809,7 +814,9 @@ static void test_postcopy_recovery(void)
      * Wait until postcopy is really started; we can only run the
      * migrate-pause command during a postcopy
      */
-    wait_for_migration_status(from, "postcopy-active");
+    wait_for_migration_status(from, "postcopy-active",
+                              (const char * []) { "failed",
+                                                  "completed", NULL });
=20
     /*
      * Manually stop the postcopy migration. This emulates a network
@@ -822,7 +829,9 @@ static void test_postcopy_recovery(void)
      * migrate-recover command can only succeed if destination machine
      * is in the paused state
      */
-    wait_for_migration_status(to, "postcopy-paused");
+    wait_for_migration_status(to, "postcopy-paused",
+                              (const char * []) { "failed", "active",
+                                                  "completed", NULL });
=20
     /*
      * Create a new socket to emulate a new channel that is different
@@ -836,7 +845,9 @@ static void test_postcopy_recovery(void)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    wait_for_migration_status(from, "postcopy-paused");
+    wait_for_migration_status(from, "postcopy-paused",
+                              (const char * []) { "failed", "active",
+                                                  "completed", NULL });
     migrate(from, uri, "{'resume': true}");
     g_free(uri);
=20
--=20
2.21.0


