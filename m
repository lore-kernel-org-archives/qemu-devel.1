Received: from eggs.gnu.org ([2001:4830:134:3::10]:57523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpEuS-0003IM-73
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpEuR-0000lX-Cn
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:37:32 -0400
Date: Mon, 13 Aug 2018 17:37:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813153722.GK4323@localhost.localdomain>
References: <cover.1533219143.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] throttle: Race condition fixes and
 test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 02.08.2018 um 16:50 hat Alberto Garcia geschrieben:
> Hi all,
> 
> here are the patches that I promised yesterday.
> 
> I was originally thinking to propose this for the v3.0 release, but
> after debugging and fixing the problem I think that it's not
> essential (details below).
> 
> The important patch is the second one. The first and the third are
> just test cases and the last is an alternative solution for the bug
> that Stefan fixed in 6fccbb475bc6effc313ee9481726a1748b6dae57.
> 
> There are details in the patches themselves, but here's an explanation
> of the problem: consider a scenario with two drives A and B that are
> part of the same throttle group. Both of them have throttled requests
> and they're waiting for a timer that is set on drive A.
> 
>     (timer here) -->  [A]  ---  req1, req2
>                       [B]  ---  req3
> 
> If we drain drive [A] (e.g. by disabling its I/O limits) then its
> queue is restarted. req1 is processed immediately, and before
> finishing it calls schedule_next_request(). This follows the
> round-robin algorithm, selects req3 and puts a timer in [B].
> 
> But we're still not done with draining [A], and now we have a
> BDRV_POLL_WHILE() loop at the end of bdrv_do_drained_begin() waiting
> for req2 to finish. That won't happen until the timer in [B] fires and
> req3 is done. If there are more drives in the group and more requests
> in the queue this can take a while. That's why disabling a drive's I/O
> limits can be noticeably slow: we disabled the I/O limits but they're
> still being enforced in practice.
> 
> The QEMU I/O tests run in qtest mode (with QEMU_CLOCK_VIRTUAL). The
> clock must be advanced manually, which means that the scenario that I
> just described hangs QEMU because BDRV_POLL_WHILE() loops forever (you
> can reproduce this with patch 3). In a real world scenario this only
> results in the aforementioned slowdown (probably negligible in
> practice), which is not a critical thing, and that's why I think it's
> safe to keep the current code for QEMU 3.
> 
> I think that's all. Questions and commend are welcome.

Thanks, applied to the block branch.

Kevin
