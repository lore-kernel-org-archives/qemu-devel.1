Received: from eggs.gnu.org ([2001:4830:134:3::10]:44879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3zqs-0001Kq-RT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3zqq-00037g-1F
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:58:02 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:13557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d3zqp-00035P-RQ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 02:57:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OP300D23Y0LN620@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 28 Apr 2017 07:57:57 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 28 Apr 2017 09:57:38 +0300
Message-id: <1493362658-8179-7-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065755eucas1p1cdd0f278a235f176e9f63c40bc64a7a9@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH RESEND V3 6/6] migration: trace postcopy total
 downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, f4bug@amsat.org, peterx@redhat.com

It's not possible to transmit it back to source host,
due to RP protocol is not expandable.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 2 ++
 migration/trace-events   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index cf2b935..35e77ba 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -388,6 +388,8 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_END);
+    /* here should be downtime receiving back operation */
+    trace_postcopy_ram_incoming_cleanup_downtime(get_postcopy_total_downtime());
     migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
 
     if (mis->postcopy_tmp_page) {
diff --git a/migration/trace-events b/migration/trace-events
index d338810..faa1b22 100644
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
