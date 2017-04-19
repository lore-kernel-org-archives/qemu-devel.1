Received: from eggs.gnu.org ([2001:4830:134:3::10]:36153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0tAu-0002hy-HT
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0tAt-00067E-If
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:13:52 -0400
Date: Wed, 19 Apr 2017 19:13:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170419171335.GH5826@noname.redhat.com>
References: <20170419091757.15507-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419091757.15507-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: 109: Filter out "len" of
 failed jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 19.04.2017 um 11:17 hat Fam Zheng geschrieben:
> Mirror calculates job len from current I/O progress:
> 
>     s->common.len = s->common.offset +
>                     (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;
> 
> The final "len" of a failed mirror job in iotests 109 depends on the
> subtle timing of the completion of read and write issued in the first
> mirror iteration.  The second iteration may or may not have run when the
> I/O error happens, resulting in non-deterministic output of the
> BLOCK_JOB_COMPLETED event text.
> 
> Similar to what was done in a752e4786, filter out the field to make the
> test robust.
> 
> Tested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

This improves things a bit, but the test case is still failing for me.
It's not deterministic, so the following is just an example.

Kevin

--- /home/kwolf/source/qemu/tests/qemu-iotests/109.out  2017-04-19 19:10:27.458121955 +0200
+++ 109.out.bad 2017-04-19 19:10:49.782467425 +0200
@@ -135,7 +135,7 @@
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2560, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -195,7 +195,7 @@
 Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 65536, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 2048, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"return": []}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
