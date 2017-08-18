Received: from eggs.gnu.org ([2001:4830:134:3::10]:42494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dihHr-0007oM-Px
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dihHl-0007RH-VR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:26:07 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170815130502.8736-1-stefanha@redhat.com>
References: <20170815130502.8736-1-stefanha@redhat.com>
Date: Fri, 18 Aug 2017 15:25:59 +0200
Message-ID: <w51o9rd57o8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10] qemu-iotests: step clock after
 each test iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Tue 15 Aug 2017 03:05:02 PM CEST, Stefan Hajnoczi wrote:
> The 093 throttling test submits twice as many requests as the throttle
> limit in order to ensure that we reach the limit.  The remaining
> requests are left in-flight at the end of each test iteration.
>
> Commit 452589b6b47e8dc6353df257fc803dfc1383bed8 ("vl.c/exit: pause cpus
> before closing block devices") exposed a hang in 093.  This happens
> because requests are still in flight when QEMU terminates but
> QEMU_CLOCK_VIRTUAL time is frozen.  bdrv_drain_all() hangs forever since
> throttled requests cannot complete.
>
> Step the clock at the end of each test iteration so in-flight requests
> actually finish.  This solves the hang and is cleaner than leaving tests
> in-flight.
>
> Note that this could also be "fixed" by disabling throttling when drives
> are closed in QEMU.  That approach has two issues:
>
> 1. We must drain requests before disabling throttling, so the hang
>    cannot be easily avoided!
>
> 2. Any time QEMU disables throttling internally there is a chance that
>    malicious users can abuse the code path to bypass throttling limits.
>
> Therefore it makes more sense to fix the test case than to modify QEMU.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
