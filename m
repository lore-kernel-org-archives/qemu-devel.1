Received: from eggs.gnu.org ([2001:4830:134:3::10]:47530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmncD-0000Cg-HC
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmncC-0007x6-F9
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 18:04:37 -0400
References: <20180618164504.24488-1-kwolf@redhat.com>
	<20180618164504.24488-22-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd4b2077-448f-2b62-8880-b2a3dcca586a@redhat.com>
Date: Mon, 6 Aug 2018 17:04:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180618164504.24488-22-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 21/35] block: fix QEMU crash with scsi-hd
 and drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 06/18/2018 11:44 AM, Kevin Wolf wrote:
> From: Greg Kurz <groug@kaod.org>
> 
> Removing a drive with drive_del while it is being used to run an I/O
> intensive workload can cause QEMU to crash.
> 
...
> The problem is that we should avoid making block driver graph
> changes while we have in-flight requests. Let's drain all I/O
> for this BB before calling bdrv_root_unref_child().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/block-backend.c | 5 +++++
>   1 file changed, 5 insertions(+)

Interestingly enough, git bisect is reliably pointing to this commit as 
the culprit in the changed output of iotests './check -nbd 83':

083 8s ... - output mismatch (see 083.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/083.out	2018-02-26 
11:40:31.605792220 -0600
+++ /home/eblake/qemu/tests/qemu-iotests/083.out.bad	2018-08-06 
16:57:03.411861660 -0500
@@ -41,7 +41,6 @@

  === Check disconnect after neg2 ===

-Connection closed
  read failed: Input/output error

  === Check disconnect 8 neg2 ===
@@ -54,7 +53,6 @@

  === Check disconnect before request ===

-Connection closed
  read failed: Input/output error

  === Check disconnect after request ===
@@ -116,7 +114,6 @@

  === Check disconnect after neg-classic ===

-Connection closed
  read failed: Input/output error

  === Check disconnect before neg1 ===
Failures: 083
Failed 1 of 1 tests


> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 2d1a3463e8..6b75bca317 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -767,6 +767,11 @@ void blk_remove_bs(BlockBackend *blk)
>   
>       blk_update_root_state(blk);
>   
> +    /* bdrv_root_unref_child() will cause blk->root to become stale and may
> +     * switch to a completion coroutine later on. Let's drain all I/O here
> +     * to avoid that and a potential QEMU crash.
> +     */
> +    blk_drain(blk);
>       bdrv_root_unref_child(blk->root);
>       blk->root = NULL;
>   }
> 

Test 83 sets up a client that intentionally disconnects at critical 
points in the NBD protocol exchange, to ensure that the server reacts 
sanely.  I suspect that somewhere in the NBD code, the server detects 
the disconnect and was somehow calling into blk_remove_bs() (although I 
could not quickly find the backtrace); and that prior to this patch, the 
'Connection closed' message resulted from other NBD coroutines getting a 
shot at the (now-closed) connection, while after this patch, the 
additional blk_drain() somehow tweaks things in a way that prevents the 
other NBD coroutines from printing a message.  If so, then the change in 
83 reference output is probably intentional, and we should update it.

But I'm having a hard time convincing myself that this is the case, 
particularly since I'm not even sure how to easily debug the assumptions 
I made above.

Since I'm very weak on the whole notion of what blk_drain() vs. 
blk_remove_bs() is really supposed to be doing, and could easily be 
persuaded that the change in output is a regression instead of a fix.

Thoughts?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
