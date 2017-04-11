Received: from eggs.gnu.org ([2001:4830:134:3::10]:49294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxy0e-0002dM-CE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxy0d-0004aC-IU
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:47:12 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxy0d-0004Zs-Bv
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:47:11 -0400
Received: by mail-wr0-x22f.google.com with SMTP id z109so745155wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:47:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
References: <1491919733-21065-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 16:46:49 +0100
Message-ID: <CAFEAcA8ocA6ZAXoEKsatWvUu5XmxQv9Odb1j6ySqQqU8zR01Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] sheepdog: Fix crash in
 co_read_response()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11 April 2017 at 15:08, Kevin Wolf <kwolf@redhat.com> wrote:
> This fixes a regression introduced in commit 9d456654.
>
> aio_co_wake() can only be used to reenter a coroutine that was already
> previously entered, otherwise co->ctx is uninitialised and we access
> garbage. Using it immediately after qemu_coroutine_create() like in
> co_read_response() is wrong and causes segfaults.
>
> Replace the call with aio_co_enter(), which gets an explicit AioContext
> parameter and works even for new coroutines.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  block/sheepdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 1b71fc8..142eb4f 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -942,7 +942,7 @@ static void co_read_response(void *opaque)
>          s->co_recv = qemu_coroutine_create(aio_read_response, opaque);
>      }
>
> -    aio_co_wake(s->co_recv);
> +    aio_co_enter(s->aio_context, s->co_recv);
>  }
>
>  static void co_write_request(void *opaque)
> --
> 1.8.3.1
>

Applied, thanks.

-- PMM
