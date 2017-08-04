Received: from eggs.gnu.org ([2001:4830:134:3::10]:51540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddWkI-0000Dd-Qo
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddWkF-0001MN-CJ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:10:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddWkF-0001LA-62
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:10:03 -0400
Date: Fri, 4 Aug 2017 15:09:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804070957.GJ5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-24-git-send-email-peterx@redhat.com>
	<20170803110540.GE2076@work-vm>
	<20170804070419.GI5561@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170804070419.GI5561@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 23/29] migration: new cmd
 MIG_CMD_POSTCOPY_RESUME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Fri, Aug 04, 2017 at 03:04:19PM +0800, Peter Xu wrote:
> On Thu, Aug 03, 2017 at 12:05:41PM +0100, Dr. David Alan Gilbert wrote:
> 
> [...]
> 
> > > +static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> > > +{
> > > +    /*
> > > +     * This means source VM is ready to resume the postcopy migration.
> > > +     * It's time to switch state and release the fault thread to
> > > +     * continue service page faults.
> > > +     */
> > > +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
> > > +                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > > +    qemu_sem_post(&mis->postcopy_pause_sem_fault);
> > 
> > Is it worth sanity checking that you were in RECOVER at this point?
> 
> Yeah, it never hurts.  Will do.

Not sure whether this would be good (note: I returned 0 in the if):

diff --git a/migration/savevm.c b/migration/savevm.c
index b7843c2..b34f59b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1709,6 +1709,12 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 
 static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
+    if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
+        error_report("%s: illegal resume received", __func__);
+        /* Don't fail the load, only for this. */
+        return 0;
+    }
+
     /*
      * This means source VM is ready to resume the postcopy migration.
      * It's time to switch state and release the fault thread to

Basically I just don't want to crash the dest VM (it holds hot dirty
pages) even if it receives a faulty RESUME command.

-- 
Peter Xu
