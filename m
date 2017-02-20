Received: from eggs.gnu.org ([2001:4830:134:3::10]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfrCA-00043U-QU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfrC9-0002j3-RR
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:52:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 20 Feb 2017 16:52:04 +0000
Message-Id: <20170220165204.1980-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-options: explain disk I/O throttling
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

The disk I/O throttling options have been listed for a long time but
never explained on the QEMU man page.

Suggested-by: Nini Gu <ngu@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-options.hx | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5633d39..b2254cc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -587,6 +587,31 @@ file sectors into the image file.
 conversion of plain zero writes by the OS to driver specific optimized
 zero write commands. You may even choose "unmap" if @var{discard} is set
 to "unmap" to allow a zero write to be converted to an UNMAP operation.
+@item bps=@var{b},bps_rd=@var{r},bps_wr=@var{w}
+Specify bandwidth throttling limits in bytes per second, either for all request
+types or for reads or writes only.  Values must be larger than the maximum
+request size to avoid timeouts or hangs in the guest.  At minimum use 2 MB/s
+for disks.
+@item bps_max=@var{bm},bps_rd_max=@var{rm},bps_wr_max=@var{wm}
+Specify bursts in bytes per second, either for all request types or for reads
+or writes only.  Bursts allow the guest I/O to spike above the limit
+temporarily.  The default burst value is 1/10th of the limit.
+@item iops=@var{i},iops_rd=@var{r},iops_wr=@var{w}
+Specify request rate limits in requests per second, either for all request
+types or for reads or writes only.
+@item bps_max=@var{bm},bps_rd_max=@var{rm},bps_wr_max=@var{wm}
+Specify bursts in requests per second, either for all request types or for reads
+or writes only.  Bursts allow the guest I/O to spike above the limit
+temporarily.  The default burst value is 1/10th of the limit.
+@item iops_size=@var{is}
+Let every @var{is} bytes of a request count as a new request for iops
+throttling purposes.  Use this option to prevent guests from circumventing iops
+limits by sending fewer but larger requests.
+@item group=@var{g}
+Join a throttling quota group with given name @var{g}.  All drives that are
+members of the same group are accounted for together.  Use this option to
+prevent guests from circumventing throttling limits by using many small disks
+instead of a single larger disk.
 @end table
 
 By default, the @option{cache=writeback} mode is used. It will report data
-- 
2.9.3
