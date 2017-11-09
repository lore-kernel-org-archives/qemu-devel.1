Received: from eggs.gnu.org ([2001:4830:134:3::10]:59008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCpfE-0000dl-Vl
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCpfB-0006Qr-RN
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:26:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w51inekzv59.fsf@maestria.local.igalia.com>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
Date: Thu, 09 Nov 2017 17:26:41 +0100
Message-ID: <w518tff4dvi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Fam Zheng <famz@redhat.com>

On Wed 08 Nov 2017 03:45:38 PM CET, Alberto Garcia wrote:

> I'm thinking that perhaps we should add the pause point directly to
> block_job_defer_to_main_loop(), to prevent any block job from running
> the exit function when it's paused.

I was trying this and unfortunately this breaks the mirror job at least
(reproduced with a simple block-commit on the topmost node, which uses
commit_active_start() -> mirror_start_job()).

So what happens is that mirror_run() always calls bdrv_drained_begin()
before returning, pausing the block job. The closing bdrv_drained_end()
call is at the end of mirror_exit(), already in the main loop.

So the mirror job is always calling block_job_defer_to_main_loop() and
mirror_exit() when the job is paused.

Berto
