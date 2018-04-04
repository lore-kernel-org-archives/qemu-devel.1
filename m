Received: from eggs.gnu.org ([2001:4830:134:3::10]:56551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f3l5P-00039f-4Q
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f3l5N-0002no-Qf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 12:16:35 -0400
References: <20180404150146.23281-1-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
Date: Wed, 4 Apr 2018 18:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180404150146.23281-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>

On 2018-04-04 17:01, Stefan Hajnoczi wrote:
> Commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce
> vm_shutdown()") added a bdrv_drain_all() call.  As a side-effect of the
> drain operation the block job iterates one more time than before.  The
> 185 output no longer matches and the test is failing now.
> 
> It may be possible to avoid the superfluous block job iteration, but
> that type of patch is not suitable late in the QEMU 2.12 release cycle.
> 
> This patch simply updates the 185 output file.  The new behavior is
> correct, just not optimal, so make the test pass again.
> 
> Fixes: 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce vm_shutdown()")
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/185     | 10 ++++++----
>  tests/qemu-iotests/185.out | 12 +++++++-----
>  2 files changed, 13 insertions(+), 9 deletions(-)

On tmpfs, this isn't enough to let the test pass.  There, the active
commit job finishes before the quit is sent, resulting in this diff:

--- tests/qemu-iotests/185.out      2018-04-04 18:10:02.015935435 +0200
+++ tests/qemu-iotests/185.out.bad  2018-04-04 18:10:21.045473817 +0200
@@ -26,9 +26,9 @@

 {"return": {}}
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304,
"offset": 4194304, "speed": 65536, "type": "commit"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304,
"offset": 4194304, "speed": 65536, "type": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len":
4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}

 === Start mirror job and exit qemu ===

This seems to be independent of whether there is actually data on
TEST_IMG (the commit source), so something doesn't seem quite right with
the block job throttling here...?

Max
