Received: from eggs.gnu.org ([209.51.188.92]:54448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goQhO-0004YB-GB
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1goQhN-0003Yd-OZ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:32:58 -0500
MIME-Version: 1.0
References: <20190125164601.130556-1-vsementsov@virtuozzo.com>
	<20190129033155.GD3264@stefanha-x1.localdomain>
	<fa3cc31b-937c-a22c-4079-2ad7d968aac5@virtuozzo.com>
In-Reply-To: <fa3cc31b-937c-a22c-4079-2ad7d968aac5@virtuozzo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 29 Jan 2019 18:32:44 +0800
Message-ID: <CAJSP0QUCeM2wHA5Z4wnBYHoE9=sLxxAqyDMZ5-i4g12v2DQEiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>

On Tue, Jan 29, 2019 at 6:24 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
> 29.01.2019 6:31, Stefan Hajnoczi wrote:
> > On Fri, Jan 25, 2019 at 07:46:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hmm. In this case we definitely will have tiny extra memory usage, but we gain beautiful
> readability.
>
> So, like this:
>
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index 5f433c7768..53de1b38bb 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h
> @@ -134,9 +134,31 @@ typedef struct QEMUIOVector {
>       struct iovec *iov;
>       int niov;
>       int nalloc;
> -    size_t size;
> +    union {
> +        struct {
> +            void *__unused_iov_base;

This could be struct iovec *iov for nalloc > 0 users.  Must resist hackiness! :)

> +            size_t size;
> +        };
> +        struct iovec local_iov;
> +    };
>   } QEMUIOVector;

That's clever and not too hacky.  Please include a comment so the
intent is clear:

  /* Save space by reusing the embedded iovec's size field as the
total size field.  Users with external iovecs don't use the embedded
iovec so this is safe. */

Stefan
