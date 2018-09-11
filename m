Received: from eggs.gnu.org ([2001:4830:134:3::10]:40688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze8Q-0000GN-J6
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze8P-00042l-Tq
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:34:58 -0400
Date: Tue, 11 Sep 2018 16:34:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911083449.GM19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-13-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-13-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/14] blockjob: Lie better in
 child_job_drained_poll()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

On Fri, 09/07 18:15, Kevin Wolf wrote:
> Block jobs claim in .drained_poll() that they are in a quiescent state
> as soon as job->deferred_to_main_loop is true. This is obviously wrong,
> they still have a completion BH to run. We only get away with this
> because commit 91af091f923 added an unconditional aio_poll(false) to the
> drain functions, but this is bypassing the regular drain mechanisms.
> 
> However, just removing this and telling that the job is still active
> doesn't work either: The completion callbacks themselves call drain
> functions (directly, or indirectly with bdrv_reopen), so they would
> deadlock then.
> 
> As a better lie, tell that the job is active as long as the BH is
> pending, but falsely call it quiescent from the point in the BH when the
> completion callback is called. At this point, nested drain calls won't
> deadlock because they ignore the job, and outer drains will wait for the
> job to really reach a quiescent state because the callback is already
> running.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
