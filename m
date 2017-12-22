Received: from eggs.gnu.org ([2001:4830:134:3::10]:34521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSL5T-0005Nm-1L
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 06:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eSL5M-0004J4-Il
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 06:01:59 -0500
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9df51df9-f5bb-dc19-c58a-b06c0b656a40@virtuozzo.com>
Date: Fri, 22 Dec 2017 14:01:39 +0300
MIME-Version: 1.0
In-Reply-To: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] Raw notes from a small block layer/QAPI/something
 pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

15.12.2017 19:38, Max Reitz wrote:
> Hi everyone,
>
> Kevin, Markus, and me had a small personal meeting over the last 1.5
> days and discussed a couple of things about the block layer and its QAPI
> entanglements.
>
> Here's a rather rough sketch on what we talked about:
>
>

[...]

> =3D=3D Single block job for backup/commit/mirror (blockdev-copy) =3D=3D
>
> - Special things:
>    - mirror: Ready state and block-job-complete
>    - mirror: Always replaces some node by the target
>    - backup: copy before write and synchronous
>      (mirror/commit are copy after write and asynchronous (except
>       active-mirror))
>    - backup: Has @compressed, that may not work with mirror right now
>      (because block drivers assume you only write once)
>    - commit: Resizes target if smaller than source
>    - commit: Does not share write permissions, maybe because it doesn't
>      want to use a dirty bitmap (a unified job would just use a dirty
>      bitmap so then it could just generally share write permissions)
>    - active commit: Can read from source even if the backing chain is
>      garbage because of the ongoing commit (mirror) job
>      - block_job_add_bdrv() on nearly whole backing chain so that
>        READ_CONSISTENT is not being shared
>    - non-active commit: Write target's (base's) filename into all of
>      source's (top's) overlays as their backing filename
>
> At least some of these differences would require blockdev-copy runtime
> options.
>
> blockdev-copy runtime parameters:
> - everything blockdev-mirror has, plus
> - @compressed? -- could be done as a block filter that converts normal
>    writes to compressed writes
> - Some option to suppress node replacement
>    (in theory you could put block-job-finalize and bdrv_reopen into a
>     transaction to do that replacement yourself)
> - Some option to suppress READY event and complete automatically
>    (compatibility to backup and non-active commit)
> - Options to control the exact copying behavior (before/after write,
>    active/passive)

also, I think, for backup we need options to control the following:
- it there is a write notifier, which waits for copy, if copy fails,=20
what to do:
 =C2=A0 fail guest write or fail the backup?
- should we handle guest writes when block-job is paused (now they are=20
handled)

>    (passive before-write is impossible)
> - Option to resize target if smaller than source
>    (maybe just internal and not visible in the interface)
>    (compatibility to block-commit)
> - Several other commit thingies (like permissions) which can be
>    automatically deduced and set if the target is in source's backing
>    chain
> - Option to specify the target's filename (this is written into all
>    overlays of @to_replace as their backing filename; if omitted, the
>    filename QEMU knows will be used)
>
>



--=20
Best regards,
Vladimir
