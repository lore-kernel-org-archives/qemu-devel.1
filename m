Received: from eggs.gnu.org ([2001:4830:134:3::10]:46185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5lEG-0001mH-IG
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5lEB-0005i5-Ky
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:50:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5lEB-0005gs-Fx
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EDF4EAEB2
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:49:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Apr 2018 12:49:42 +0800
Message-Id: <20180410044942.17059-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 v2] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Eric Auger reported the problem days ago that OOB broke ARM when running
with libvirt:

http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html

The problem was that the monitor dispatcher bottom half was bound to
qemu_aio_context now, which could be polled unexpectedly in block code.
We should keep the dispatchers run in iohandler_ctx just like what we
did before the Out-Of-Band series (chardev uses qio, and qio binds
everything with iohandler_ctx).

If without this change, QMP dispatcher might be run even before reaching
main loop in block IO path, for example, in a stack like (the ARM case,
"cont" command handler run even during machine init phase):

        #0  qmp_cont ()
        #1  0x00000000006bd210 in qmp_marshal_cont ()
        #2  0x0000000000ac05c4 in do_qmp_dispatch ()
        #3  0x0000000000ac07a0 in qmp_dispatch ()
        #4  0x0000000000472d60 in monitor_qmp_dispatch_one ()
        #5  0x000000000047302c in monitor_qmp_bh_dispatcher ()
        #6  0x0000000000acf374 in aio_bh_call ()
        #7  0x0000000000acf428 in aio_bh_poll ()
        #8  0x0000000000ad5110 in aio_poll ()
        #9  0x0000000000a08ab8 in blk_prw ()
        #10 0x0000000000a091c4 in blk_pread ()
        #11 0x0000000000734f94 in pflash_cfi01_realize ()
        #12 0x000000000075a3a4 in device_set_realized ()
        #13 0x00000000009a26cc in property_set_bool ()
        #14 0x00000000009a0a40 in object_property_set ()
        #15 0x00000000009a3a08 in object_property_set_qobject ()
        #16 0x00000000009a0c8c in object_property_set_bool ()
        #17 0x0000000000758f94 in qdev_init_nofail ()
        #18 0x000000000058e190 in create_one_flash ()
        #19 0x000000000058e2f4 in create_flash ()
        #20 0x00000000005902f0 in machvirt_init ()
        #21 0x00000000007635cc in machine_run_board_init ()
        #22 0x00000000006b135c in main ()

Actually the problem is more severe than that.  After we switched to the
qemu AIO handler it means the monitor dispatcher code can even be called
with nested aio_poll(), then it can be an explicit aio_poll() inside
another main loop aio_poll() which could be racy too.

Switch to use the iohandler_ctx for monitor dispatchers.

My sincere thanks to Eric Auger who offered great help during both
debugging and verifying the problem.  The ARM test was carried out by
applying this patch upon QEMU 2.12.0-rc0 and problem is gone after the
patch.

A quick test of mine shows that after this patch applied we can pass all
raw iotests even with OOB on by default.

CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Fam Zheng <famz@redhat.com>
Reported-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- enhanced commit message
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 51f4cf480f..39f8ee17ba 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4467,7 +4467,7 @@ static void monitor_iothread_init(void)
      * have assumption to be run on main loop thread.  It would be
      * nice that one day we can remove this assumption in the future.
      */
-    mon_global.qmp_dispatcher_bh = aio_bh_new(qemu_get_aio_context(),
+    mon_global.qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
                                               monitor_qmp_bh_dispatcher,
                                               NULL);
 
-- 
2.14.3
