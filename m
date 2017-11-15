Received: from eggs.gnu.org ([2001:4830:134:3::10]:34994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eF3ZG-0001yC-Pz
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eF3ZG-0003Ce-0Z
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:41:50 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eF3ZF-0003CI-Pg
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 14:41:49 -0500
Received: by mail-wm0-x241.google.com with SMTP id r68so5271907wmr.3
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 11:41:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106165500.30278-1-kwolf@redhat.com>
References: <20171106165500.30278-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Nov 2017 19:41:28 +0000
Message-ID: <CAFEAcA9dJAhVzA6Ez6sBjH1LPsNpJCTvM4ez14gQ+k1aesO7UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block: Fix error path in
 bdrv_backing_update_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2017 at 16:55, Kevin Wolf <kwolf@redhat.com> wrote:
> error_setg_errno() takes a positive errno code.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block.c b/block.c
> index 684cb018da..f6415547fe 100644
> --- a/block.c
> +++ b/block.c
> @@ -998,7 +998,7 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
>      ret = bdrv_change_backing_file(parent, filename,
>                                     base->drv ? base->drv->format_name : "");
>      if (ret < 0) {
> -        error_setg_errno(errp, ret, "Could not update backing file link");
> +        error_setg_errno(errp, -ret, "Could not update backing file link");
>      }
>
>      if (!(orig_flags & BDRV_O_RDWR)) {
> --
> 2.13.6

Just noticed going through coverity warnings that this didn't
make it into rc1 -- could we get it in for rc2, please?

thanks
-- PMM
