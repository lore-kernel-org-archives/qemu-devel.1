Received: from eggs.gnu.org ([2001:4830:134:3::10]:40211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih67-00006z-6f
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih66-0000UZ-7w
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih66-0000T7-1R
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:42 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:50 +0000
Message-Id: <20170228124056.5074-22-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 21/27] postcopy: Mask fault addresses to huge
 page boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Currently the fault address received by userfault is rounded to
the host page boundary and a host page is requested from the source.
Use the current RAMBlock page size instead of the general host page
size so that for RAMBlocks backed by huge pages we request the whole
huge page.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170224182844.32452-11-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4c736d2..03cbd6e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -403,7 +403,6 @@ static void *postcopy_ram_fault_thread(void *opaque)
     MigrationIncomingState *mis = opaque;
     struct uffd_msg msg;
     int ret;
-    size_t hostpagesize = getpagesize();
     RAMBlock *rb = NULL;
     RAMBlock *last_rb = NULL; /* last RAMBlock we sent part of */
 
@@ -470,7 +469,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
             break;
         }
 
-        rb_offset &= ~(hostpagesize - 1);
+        rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
         trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset);
@@ -482,11 +481,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
         if (rb != last_rb) {
             last_rb = rb;
             migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
-                                     rb_offset, hostpagesize);
+                                     rb_offset, qemu_ram_pagesize(rb));
         } else {
             /* Save some space */
             migrate_send_rp_req_pages(mis, NULL,
-                                     rb_offset, hostpagesize);
+                                     rb_offset, qemu_ram_pagesize(rb));
         }
     }
     trace_postcopy_ram_fault_thread_exit();
-- 
2.9.3
