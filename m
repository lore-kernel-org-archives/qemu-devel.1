Received: from eggs.gnu.org ([2001:4830:134:3::10]:55371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxu7Q-0007D5-Ei
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxu7P-0007jT-Om
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:37:56 -0400
Date: Tue, 11 Apr 2017 19:37:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170411113745.GB8507@lemon>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-10-famz@redhat.com>
	<20170411100642.GH4516@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411100642.GH4516@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 09/10] block: Use
 bdrv_coroutine_enter to start I/O coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 04/11 12:06, Kevin Wolf wrote:
> >  tests/qemu-iotests/109.out | 10 +++++-----
> 
> This one is curious. Why do we copy more data depending on how the job
> coroutine is reentered?

I did trace it and think the difference is not very important: on master, the
second iteration of the mirror_run loop gets a chance to run, and there we have:

    s->common.len = s->common.offset +
                    (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;

E.g. in the mirror job of the first updated output, iter #1 has cnt = 128
and s->sectors_in_flight = 0; iter #2 has cnt = 0, s->sectors_in_flight = 2.

I think the reason is simply that co_queue_wakeup in bdrv_coroutine_enter subtly
changed how the mirror coroutine and bdrv_co_pwritev are ordered.

Fam
