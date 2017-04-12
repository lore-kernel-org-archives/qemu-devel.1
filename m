Received: from eggs.gnu.org ([2001:4830:134:3::10]:51058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyIAh-0005EL-JG
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyIAg-0001DY-6c
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:18:55 -0400
Date: Wed, 12 Apr 2017 15:18:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170412131831.GE4955@noname.str.redhat.com>
References: <20170411145050.31290-1-mreitz@redhat.com>
	<20170411145849.GO4516@noname.str.redhat.com>
	<ec159701-4d77-7dfa-2909-b544391cf513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec159701-4d77-7dfa-2909-b544391cf513@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/io: Comment out permission
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, dgilbert@redhat.com, quintela@redhat.com

Am 11.04.2017 um 17:07 hat Laurent Vivier geschrieben:
> On 11/04/2017 16:58, Kevin Wolf wrote:
> > Am 11.04.2017 um 16:50 hat Max Reitz geschrieben:
> >> In case of block migration, there may be writes to BlockBackends that do
> >> not have the write permission taken. Before this issue is fixed (which
> >> is not going to happen in 2.9), we therefore cannot assert that this is
> >> the case.
> >>
> >> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> > 
> > I tested block migration (migrate -b). Leaving postcopy migration, which
> > is apparently also broken, to Laurent.
> > 
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > Tested-by: Kevin Wolf <kwolf@redhat.com>
> 
> With postcopy migration
> 
> Tested-by: Laurent Vivier <lvivier@redhat.com>

I think the following is the real fix for postcopy migration, in case
someone wants to give it a test before I send it as a proper patch (the
bug is a result of duplicating code between precopy/postcopy migration
instead of sharing it - commit d35ff5e6 only updated one of both).

Kevin


diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..43fa9bf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1623,6 +1623,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         error_report_err(local_err);
     }
 
+    /* If we get an error here, just don't restart the VM yet. */
+    blk_resume_after_migration(&local_err);
+    if (local_err) {
+        error_free(local_err);
+        local_err = NULL;
+        autostart = false;
+    }
+
     trace_loadvm_postcopy_handle_run_cpu_sync();
     cpu_synchronize_all_post_init();
