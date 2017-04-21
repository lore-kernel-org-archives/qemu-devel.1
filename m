Received: from eggs.gnu.org ([2001:4830:134:3::10]:43263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1V68-0007u3-Nx
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1V67-0000Vg-Ka
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d1V67-0000Vb-ER
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:43:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 21 Apr 2017 10:43:11 +0100
Message-Id: <20170421094316.19361-2-stefanha@redhat.com>
In-Reply-To: <20170421094316.19361-1-stefanha@redhat.com>
References: <20170421094316.19361-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/6] qemu-options: explain disk I/O
 throttling options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

The disk I/O throttling options have been listed for a long time but
never explained on the QEMU man page.

Suggested-by: Nini Gu <ngu@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-id: 20170301115026.22621-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-options.hx | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 99af8ed..9171bd5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -635,6 +635,30 @@ file sectors into the image file.
 conversion of plain zero writes by the OS to driver specific optimized
 zero write commands. You may even choose "unmap" if @var{discard} is set
 to "unmap" to allow a zero write to be converted to an UNMAP operation.
+@item bps=@var{b},bps_rd=@var{r},bps_wr=@var{w}
+Specify bandwidth throttling limits in bytes per second, either for all request
+types or for reads or writes only.  Small values can lead to timeouts or hangs
+inside the guest.  A safe minimum for disks is 2 MB/s.
+@item bps_max=@var{bm},bps_rd_max=@var{rm},bps_wr_max=@var{wm}
+Specify bursts in bytes per second, either for all request types or for reads
+or writes only.  Bursts allow the guest I/O to spike above the limit
+temporarily.
+@item iops=@var{i},iops_rd=@var{r},iops_wr=@var{w}
+Specify request rate limits in requests per second, either for all request
+types or for reads or writes only.
+@item iops_max=@var{bm},iops_rd_max=@var{rm},iops_wr_max=@var{wm}
+Specify bursts in requests per second, either for all request types or for reads
+or writes only.  Bursts allow the guest I/O to spike above the limit
+temporarily.
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
