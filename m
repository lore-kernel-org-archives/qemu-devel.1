Received: from eggs.gnu.org ([2001:4830:134:3::10]:37319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fcjJN-0004fK-VZ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fcjJK-00023o-Pq
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:27:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fcjJK-00023i-K5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 23:27:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20C3EDFE0
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 03:27:30 +0000 (UTC)
Date: Tue, 10 Jul 2018 11:27:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180710032725.GL23001@xz-mi>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180706091716.GA9761@work-vm> <20180706105658.GB2661@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180706105658.GB2661@work-vm>
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/9] migration: postcopy recovery
 unit test, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Fri, Jul 06, 2018 at 11:56:59AM +0100, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Based-on: <20180627132246.5576-1-peterx@redhat.com>
> > > 
> > > Based on the series to unbreak postcopy:
> > >   Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
> > >   Message-Id: <20180627132246.5576-1-peterx@redhat.com>
> > > 
> > > This series introduce a new postcopy recovery test.  The new test
> > > actually helped me to identify two bugs there so fix them as well
> > > before 3.0 release.
> > > 
> > > Patch 1: a trivial cleanup for existing postcopy ram load, which I
> > >          found a bit confusing during debugging the problem.
> > > 
> > > Patch 2-3: two bug fixes that address different issues.  Please see
> > >            the commit log for more information.
> > > 
> > > Patch 4-9: add the postcopy recovery unit test.
> > > 
> > > Please review.  Thanks,
> > 
> > Queued
> 
> Hi Peter,
>   There's a problem in there somewhere;  I'm getting
> an intermittent failure of the test if I run a make check -j 8    on my
> laptop.  Just running two copies of tests/migration-test in parallel
> sometimes triggers it (but not if I turn on QTEST_LOG!).
> But it's always failing with:
> 
>   ERROR:/home/dgilbert/git/migpull/tests/migration-test.c:373:migrate_recover: assertion failed: (qdict_haskey(rsp, "return"))

Hmm, so this should be a race.  I suspect it's because destination VM
hasn't reached the correct state when sending the recovery command.

Could you help to try these two tiny patches to see whether it can fix
the problem?

================

commit d875ea1a98932174e3fa202859b65df26def174d
Author: Peter Xu <peterx@redhat.com>
Date:   Tue Jul 10 11:17:24 2018 +0800

    migration: show pause/recover state on dst host

    These two states will be missing when doing "query-migrate" on
    destination VM.  Add these states so that we can get the query results
    as expected.

    Signed-off-by: Peter Xu <peterx@redhat.com>

diff --git a/migration/migration.c b/migration/migration.c
index 0404c53215..8d56d56930 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -911,6 +911,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_COLO:
         info->has_status = true;

================

commit 9fa7fc773961cd0ea0b5f70a166def0d8aebf464
Author: Peter Xu <peterx@redhat.com>
Date:   Tue Jul 10 11:18:48 2018 +0800

    tests: don't send recovery cmd until dst pauses

    Signed-off-by: Peter Xu <peterx@redhat.com>

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 96e69dab99..45558446f1 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -646,6 +646,13 @@ static void test_postcopy_recovery(void)
      */
     migrate_pause(from);

+    /*
+     * Wait for destination side to reach postcopy-paused state.  The
+     * migrate-recover command can only succeed if destination machine
+     * is in the paused state
+     */
+    wait_for_migration_status(to, "postcopy-paused");
+
     /*
      * Create a new socket to emulate a new channel that is different
      * from the broken migration channel; tell the destination to

================

Thanks!

-- 
Peter Xu
