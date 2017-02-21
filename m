Received: from eggs.gnu.org ([2001:4830:134:3::10]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cg894-0000Za-2J
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cg88z-00061K-2d
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:58:10 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170220165204.1980-1-stefanha@redhat.com>
References: <20170220165204.1980-1-stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:58:00 +0100
Message-ID: <w51tw7nbykn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-options: explain disk I/O throttling
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org

On Mon 20 Feb 2017 05:52:04 PM CET, Stefan Hajnoczi wrote:
> The disk I/O throttling options have been listed for a long time but
> never explained on the QEMU man page.

> +@item bps=@var{b},bps_rd=@var{r},bps_wr=@var{w}
> +Specify bandwidth throttling limits in bytes per second, either for all request
> +types or for reads or writes only.

Perhaps for the manual page it makes sense to use them, but bps, bps_rd,
etc. are the legacy names for those options. They're internally renamed
to throttling.bps-total, throttling.bps-read, ...

> Values must be larger than the maximum
> +request size to avoid timeouts or hangs in the guest.  At minimum use 2 MB/s
> +for disks.

Is this so? throttle_compute_wait() does not use the request size at
all. The size is used to do the accounting afterwards. In other words:
requests are not throttled if they exceed the limit, they are throttled
after the limit has been exceeded by previous requests.

A low limit will certainly slow down the guest and can cause
timeouts, but I don't know if being larger or smaller than the maximum
request size is what makes the difference.

> +@item bps_max=@var{bm},bps_rd_max=@var{rm},bps_wr_max=@var{wm}
> +Specify bursts in bytes per second, either for all request types or for reads
> +or writes only.  Bursts allow the guest I/O to spike above the limit
> +temporarily.  The default burst value is 1/10th of the limit.

"The default burst value is 1/10th of the limit" is an implementation
detail that the user doesn't need to know about. What it means is that a
bps limit of 10 MB/s is implemented internally as 1MB per 100ms.

I would leave that out, it doesn't even make sense that the burst limit
is lower than the normal limit, we actually forbid that (aaa1e77ffae52).

> +@item iops=@var{i},iops_rd=@var{r},iops_wr=@var{w}
> +Specify request rate limits in requests per second, either for all request
> +types or for reads or writes only.

> +@item bps_max=@var{bm},bps_rd_max=@var{rm},bps_wr_max=@var{wm}

You meant iops_max, iops_rd_max and iops_wr_max here?

Berto
