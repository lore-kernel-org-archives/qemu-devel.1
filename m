Received: from eggs.gnu.org ([209.51.188.92]:43247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtWLV-00016m-7T
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtWLR-0004aT-Az
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:35:23 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1ea995a3-38d1-61b9-6868-f007172a2341@virtuozzo.com>
References: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51o97m8ltv.fsf@maestria.local.igalia.com>
	<41e29129-196d-1b24-03ae-373b7d357725@virtuozzo.com>
	<w51sgwuv2ok.fsf@maestria.local.igalia.com>
	<6b3c82fb-b4a2-7802-1737-a34e22130114@virtuozzo.com>
	<w51mun2uxts.fsf@maestria.local.igalia.com>
	<1ea995a3-38d1-61b9-6868-f007172a2341@virtuozzo.com>
Date: Tue, 12 Feb 2019 12:35:13 +0100
Message-ID: <w51mun18cjy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 1/1] Stream block job
 involves copy-on-read filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Mon 11 Feb 2019 05:58:05 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>>> The problem is in the concept of "base" node. The code written in
>>> manner that base is not changed during block job. However, job don't
>>> own base and there is no guarantee that it will not change during
>>> the job.
>> 
>> But if that's the case then we have a problem already, because 'base'
>> is a member of StreamBlockJob and is used in the existing
>> stream_run() code.
>
> I think it should be possible to reproduce, using block-commit (which
> already has filter) with block-stream in parallel, we'll try.

It's not possible to run block-stream and block-commit in parallel on
the same nodes. See iotest 030 for a few examples.

So unless there's a bug it should be safe.

>> So if there's a way to make 'base' disappear during the job (how?)
>> then we could protect it with block_job_add_bdrv().
>
> I'm not sure this is correct. What is the reason for stream to own
> base? It's not really interested in it.

stream does not need to write or modify base, but it does need to keep a
reference to it in order to now where to stop copying data.

As I said earlier base is a member of StreamBlockJob, so it should not
disappear during the job.

Berto
