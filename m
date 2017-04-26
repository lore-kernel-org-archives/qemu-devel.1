Received: from eggs.gnu.org ([2001:4830:134:3::10]:60661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3FA2-0001xT-Gu
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3F9x-0002uS-UZ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:42 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:32442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d3F9x-0002tk-P6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OP00073M3J17280@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:06:37 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 26 Apr 2017 08:06:20 +0300
Message-id: <1493183181-21962-7-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
References: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170426050635eucas1p2084a21b1deaaa891c278bbb610eb421a@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH V3 6/6] migration: trace postcopy total downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: a.perevalov@samsung.com, i.maximets@samsung.com, f4bug@amsat.org, peterx@redhat.com, qemu-devel@nongnu.org

It's not possible to transmit it back to source host,
due to RP protocol is not expandable.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 2 ++
 migration/trace-events   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 03c2be7..46a42d4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -390,6 +390,8 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_END);
+    /* here should be downtime receiving back operation */
+    trace_postcopy_ram_incoming_cleanup_downtime(get_postcopy_total_downtime());
     migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
 
     if (mis->postcopy_tmp_page) {
diff --git a/migration/trace-events b/migration/trace-events
index 19e7dc5..25521d4 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -194,6 +194,7 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
+postcopy_ram_incoming_cleanup_downtime(uint64_t total) "total downtime %" PRIu64
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
-- 
1.9.1
