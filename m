Received: from eggs.gnu.org ([2001:4830:134:3::10]:60577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dekPT-0003iv-Sq
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dekPP-0000wU-0U
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:57:39 -0400
Date: Mon, 7 Aug 2017 17:57:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807155717.GI6578@localhost.localdomain>
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807141630.105066-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

Am 07.08.2017 um 16:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 185 iotest is broken.
> 
> How to test:
> > i=0; while ./check -qcow2 -nocache 185; do ((i+=1)); echo N = $i; \
>   done; echo N = $i
> 
> finished for me like this:
> 
> 185 2s ... - output mismatch (see 185.out.bad)
> --- /work/src/qemu/master/tests/qemu-iotests/185.out    2017-07-14 \
>     15:14:29.520343805 +0300
> +++ 185.out.bad 2017-08-07 16:51:02.231922900 +0300
> @@ -37,7 +37,7 @@
>  {"return": {}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>      "event": "SHUTDOWN", "data": {"guest": false}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>     "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>         "len": 4194304, "offset": 4194304, "speed": 65536, "type": \
>             "mirror"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>     "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>         "len": 0, "offset": 0, "speed": 65536, "type": "mirror"}}
> 
>  === Start backup job and exit qemu ===
> 
> Failures: 185
> Failed 1 of 1 tests
> N = 8
> 
> It doesn't seems logical to expect the constant offset on cancel,
> so let filter it out.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I'm quoting 185:

# Note that the reference output intentionally includes the 'offset' field in
# BLOCK_JOB_CANCELLED events for all of the following block jobs. They are
# predictable and any change in the offsets would hint at a bug in the job
# throttling code.
#
# In order to achieve these predictable offsets, all of the following tests
# use speed=65536. Each job will perform exactly one iteration before it has
# to sleep at least for a second, which is plenty of time for the 'quit' QMP
# command to be received (after receiving the command, the rest runs
# synchronously, so jobs can arbitrarily continue or complete).
#
# The buffer size for commit and streaming is 512k (waiting for 8 seconds after
# the first request), for active commit and mirror it's large enough to cover
# the full 4M, and for backup it's the qcow2 cluster size, which we know is
# 64k. As all of these are at least as large as the speed, we are sure that the
# offset doesn't advance after the first iteration before qemu exits.

So before we change the expected output, can we explain why the offsets
aren't predictable, even if throttling is used and contrary to what the
comment says? Should we sleep a little before issuing 'quit'?

(By the way, I couldn't reproduce in N = 128 attempts, so it doesn't
look like I can look into what's happening in detail, except with code
review.)

Kevin
