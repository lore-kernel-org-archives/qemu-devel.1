Received: from eggs.gnu.org ([2001:4830:134:3::10]:39476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31xY-00030a-8U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31xX-00080p-By
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:00:56 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d31xX-0007z0-6c
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:00:55 -0400
Received: by mail-wr0-x233.google.com with SMTP id l50so36670469wrc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:00:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411122632.14050-11-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
	<20170411122632.14050-11-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 16:00:33 +0100
Message-ID: <CAFEAcA81QghtjkwCP=KywhMx-ruxnXSRHVZ6oHpX3e5mnwZNBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 10/11] block: Fix bdrv_co_flush early return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 April 2017 at 13:26, Fam Zheng <famz@redhat.com> wrote:
> bdrv_inc_in_flight and bdrv_dec_in_flight are mandatory for
> BDRV_POLL_WHILE to work, even for the shortcut case where flush is
> unnecessary. Move the if block to below bdrv_dec_in_flight, and BTW fix
> the variable declaration position.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/block/io.c b/block/io.c
> index 00e45ca..bae6947 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2278,16 +2278,17 @@ static void coroutine_fn bdrv_flush_co_entry(void *opaque)
>
>  int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>  {
> -    int ret;
> -
> -    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
> -        bdrv_is_sg(bs)) {
> -        return 0;
> -    }
> +    int current_gen;
> +    int ret = 0;
>
>      bdrv_inc_in_flight(bs);
>
> -    int current_gen = bs->write_gen;
> +    if (!bs || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
> +        bdrv_is_sg(bs)) {
> +        goto early_exit;
> +    }

Coverity points out that there's a problem here -- we call
bdrv_inc_in_flight(bs), which assumes bs is not NULL, before
we do the test for whether bs is NULL.

Presumably the NULL check needs to be pulled up earlier in
the function?

thanks
-- PMM
