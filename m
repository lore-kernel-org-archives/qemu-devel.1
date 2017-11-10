Received: from eggs.gnu.org ([2001:4830:134:3::10]:38805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCzaU-0005hs-Al
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 22:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCzaT-0006tZ-33
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 22:02:34 -0500
Date: Fri, 10 Nov 2017 11:02:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171110030223.GA7303@lemon>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<w518tff4dvi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w518tff4dvi.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] segfault in parallel blockjobs
 (iotest 30)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, 11/09 17:26, Alberto Garcia wrote:
> On Wed 08 Nov 2017 03:45:38 PM CET, Alberto Garcia wrote:
> 
> > I'm thinking that perhaps we should add the pause point directly to
> > block_job_defer_to_main_loop(), to prevent any block job from running
> > the exit function when it's paused.
> 
> I was trying this and unfortunately this breaks the mirror job at least
> (reproduced with a simple block-commit on the topmost node, which uses
> commit_active_start() -> mirror_start_job()).
> 
> So what happens is that mirror_run() always calls bdrv_drained_begin()
> before returning, pausing the block job. The closing bdrv_drained_end()
> call is at the end of mirror_exit(), already in the main loop.
> 
> So the mirror job is always calling block_job_defer_to_main_loop() and
> mirror_exit() when the job is paused.
> 

FWIW, I think Max's report on 194 failures is related:

https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01822.html

so perhaps it's worth testing his patch too:

https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01835.html

Fam
