Received: from eggs.gnu.org ([2001:4830:134:3::10]:39463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gL7DD-0005yK-JB
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gL7D7-0005Yy-8a
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:52:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <fc16b42c-5825-b9f8-5127-4c8a6d8b173b@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-7-vsementsov@virtuozzo.com>
	<w514lcudz3y.fsf@maestria.local.igalia.com>
	<e1d4fa92-9f84-080c-04e3-4fc9b683c11d@virtuozzo.com>
	<w511s7ydxzz.fsf@maestria.local.igalia.com>
	<fc16b42c-5825-b9f8-5127-4c8a6d8b173b@virtuozzo.com>
Date: Fri, 09 Nov 2018 14:51:42 +0100
Message-ID: <w511s7uwe8h.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/7] qcow2: aio support for
 compressed cluster read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

On Tue 06 Nov 2018 05:24:36 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>> Is there any reason why some parts of the QEMU code use qemu_blockalign
>> and others qemu_try_blockalign() ? From what I can see it seems to be up
>> to whoever wrote it...
>
> As I understand, the good reason to use _try_ versions, is when we are
> allocating some size, taken from user input, so it may be
> unpredictable large (hm, or just any really large allocation), so, I
> use try_malloc for compressed size, which may be very large in somehow
> corrupted image.

Ah right, the value of the compressed size field can be up to 8192
sectors, or 4MB.

I realized that you should add the coroutine_fn annotation to
qcow2_co_preadv_compressed(). Other than that the patch looks good so,
with that changed,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
