Received: from eggs.gnu.org ([2001:4830:134:3::10]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fkXoV-0001YY-PF
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fkXoS-0001D0-Ic
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:47:59 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180704145410.794-1-stefanha@redhat.com>
References: <20180704145410.794-1-stefanha@redhat.com>
Date: Tue, 31 Jul 2018 18:47:53 +0200
Message-ID: <w51muu7uzba.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix hang when group
 member leaves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed 04 Jul 2018 04:54:10 PM CEST, Stefan Hajnoczi wrote:
> Throttle groups consist of members sharing one throttling state
> (including bps/iops limits).  Round-robin scheduling is used to ensure
> fairness.  If a group member already has a timer pending then other
> groups members do not schedule their own timers.  The next group
> member will have its turn when the existing timer expires.
>
> A hang may occur when a group member leaves while it had a timer
> scheduled.

Ok, I can reproduce this if I run fio with iodepth=1.

We're draining the BDS before removing it from a throttle group, and
therefore there cannot be any pending requests.

So the problem seems to be that when throttle_co_drain_begin() runs the
pending requests from a member using throttle_group_co_restart_queue(),
it simply uses qemu_co_queue_next() and doesn't touch the timer at all.

So it can happen that there's a request in the queue waiting for a
timer, and after that call the request is gone but the timer remains.

The current patch is perhaps not worth touching at this point (we're
about to release QEMU 3.0), but I think that a better solution would be
to either

a) cancel the existing timer and reset tg->any_timer_armed on the given
   tgm after throttle_group_co_restart_queue() and before
   schedule_next_request() if the queue is empty.

b) force the existing timer to run immediately instead of calling
   throttle_group_co_restart_queue(). Seems cleaner, but I haven't tried
   this one yet.

I'll explore them a bit and send a patch.

Berto
