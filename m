Received: from eggs.gnu.org ([2001:4830:134:3::10]:60579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db29x-0007MA-BN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db29t-00004v-Er
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:06:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db29t-0008VH-52
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:06:13 -0400
Date: Fri, 28 Jul 2017 18:06:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170728100607.GA29971@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 00/29] Migration: postcopy failure recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jul 28, 2017 at 04:06:09PM +0800, Peter Xu wrote:
> As we all know that postcopy migration has a potential risk to lost
> the VM if the network is broken during the migration. This series
> tries to solve the problem by allowing the migration to pause at the
> failure point, and do recovery after the link is reconnected.
> 
> There was existing work on this issue from Md Haris Iqbal:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03468.html
> 
> This series is a totally re-work of the issue, based on Alexey
> Perevalov's recved bitmap v8 series:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06401.html
> 
> Two new status are added to support the migration (used on both
> sides):
> 
>   MIGRATION_STATUS_POSTCOPY_PAUSED
>   MIGRATION_STATUS_POSTCOPY_RECOVER
> 
> The MIGRATION_STATUS_POSTCOPY_PAUSED state will be set when the
> network failure is detected. It is a phase that we'll be in for a long
> time as long as the failure is detected, and we'll be there until a
> recovery is triggered.  In this state, all the threads (on source:
> send thread, return-path thread; destination: ram-load thread,
> page-fault thread) will be halted.
> 
> The MIGRATION_STATUS_POSTCOPY_RECOVER state is short. If we triggered
> a recovery, both source/destination VM will jump into this stage, do
> whatever it needs to prepare the recovery (e.g., currently the most
> important thing is to synchronize the dirty bitmap, please see commit
> messages for more information). After the preparation is ready, the
> source will do the final handshake with destination, then both sides
> will switch back to MIGRATION_STATUS_POSTCOPY_ACTIVE again.
> 
> New commands/messages are defined as well to satisfy the need:
> 
> MIG_CMD_RECV_BITMAP & MIG_RP_MSG_RECV_BITMAP are introduced for
> delivering received bitmaps
> 
> MIG_CMD_RESUME & MIG_RP_MSG_RESUME_ACK are introduced to do the final
> handshake of postcopy recovery.
> 
> Here's some more details on how the whole failure/recovery routine is
> happened:
> 
> - start migration
> - ... (switch from precopy to postcopy)
> - both sides are in "postcopy-active" state
> - ... (failure happened, e.g., network unplugged)
> - both sides switch to "postcopy-paused" state
>   - all the migration threads are stopped on both sides
> - ... (both VMs hanged)
> - ... (user triggers recovery using "migrate -r -d tcp:HOST:PORT" on
>   source side, "-r" means "recover")
> - both sides switch to "postcopy-recover" state
>   - on source: send-thread, return-path-thread will be waked up
>   - on dest: ram-load-thread waked up, fault-thread still paused
> - source calls new savevmhandler hook resume_prepare() (currently,
>   only ram is providing the hook):
>   - ram_resume_prepare(): for each ramblock, fetch recved bitmap by:
>     - src sends MIG_CMD_RECV_BITMAP to dst
>     - dst replies MIG_RP_MSG_RECV_BITMAP to src, with bitmap data
>       - src uses the recved bitmap to rebuild dirty bitmap
> - source do final handshake with destination
>   - src sends MIG_CMD_RESUME to dst, telling "src is ready"
>     - when dst receives the command, fault thread will be waked up,
>       meanwhile, dst switch back to "postcopy-active"
>   - dst sends MIG_RP_MSG_RESUME_ACK to src, telling "dst is ready"
>     - when src receives the ack, state switch to "postcopy-active"
> - postcopy migration continued
> 
> Testing:
> 
> As I said, it's still an extremely simple test. I used socat to create
> a socket bridge:
> 
>   socat tcp-listen:6666 tcp-connect:localhost:5555 &
> 
> Then do the migration via the bridge. I emulated the network failure
> by killing the socat process (bridge down), then tries to recover the
> migration using the other channel (default dst channel). It looks
> like:
> 
>         port:6666    +------------------+
>         +----------> | socat bridge [1] |-------+
>         |            +------------------+       |
>         |         (Original channel)            |
>         |                                       | port: 5555
>      +---------+  (Recovery channel)            +--->+---------+
>      | src VM  |------------------------------------>| dst VM  |
>      +---------+                                     +---------+
> 
> Known issues/notes:
> 
> - currently destination listening port still cannot change. E.g., the
>   recovery should be using the same port on destination for
>   simplicity. (on source, we can specify new URL)
> 
> - the patch: "migration: let dst listen on port always" is still
>   hacky, it just kept the incoming accept open forever for now...
> 
> - some migration numbers might still be inaccurate, like total
>   migration time, etc. (But I don't really think that matters much
>   now)
> 
> - the patches are very lightly tested.
> 
> - Dave reported one problem that may hang destination main loop thread
>   (one vcpu thread holds the BQL) and the rest. I haven't encountered
>   it yet, but it does not mean this series can survive with it.
> 
> - other potential issues that I may have forgotten or unnoticed...
> 
> Anyway, the work is still in preliminary stage. Any suggestions and
> comments are greatly welcomed.  Thanks.

I pushed the series to github in case needed:

https://github.com/xzpeter/qemu/tree/postcopy-recovery-support

Thanks!

-- 
Peter Xu
