Received: from eggs.gnu.org ([2001:4830:134:3::10]:49887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dB6r1-0006Em-1X
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dB6qx-000093-3S
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:51:35 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170511144208.24075-8-pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-8-pbonzini@redhat.com>
Date: Wed, 17 May 2017 23:50:50 +0200
Message-ID: <w51inkzgnk5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 07/18] throttle-groups: only
 start one coroutine from drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On Thu 11 May 2017 04:41:57 PM CEST, Paolo Bonzini wrote:
> Starting all waiting coroutines from bdrv_drain_all is unnecessary;
> throttle_group_co_io_limits_intercept calls schedule_next_request as
> soon as the coroutine restarts, which in turn will restart the next
> request if possible.
>
> If we only start the first request and let the coroutines dance from
> there the code is simpler and there is more reuse between
> throttle_group_config, throttle_group_restart_blk and timer_cb.  The
> next patch will benefit from this.
>
> We also stop accessing from throttle_group_restart_blk the
> blkp->throttled_reqs CoQueues even when there was no
> attached throttling group.  This worked but is not pretty.
>
> The only thing that can interrupt the dance is the QEMU_CLOCK_VIRTUAL
> timer when switching from one block device to the next, because the
> timer is set to "now + 1" but QEMU_CLOCK_VIRTUAL might not be running.
> Set that timer to point in the present ("now") rather than the future
> and things work.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
