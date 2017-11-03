Received: from eggs.gnu.org ([2001:4830:134:3::10]:53832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAgnZ-0001cS-0K
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAgnY-0003yk-5X
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:34:33 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAgnX-0003yA-Ut
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:34:32 -0400
Received: by mail-wr0-x242.google.com with SMTP id l1so3295883wrc.3
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 11:34:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171006155422.10135-34-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
	<20171006155422.10135-34-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 18:34:10 +0000
Message-ID: <CAFEAcA_hLLSwhKZSXfq9X6i2m17g9oYHnEJ9wfcSSt_b33axPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 33/54] block: Introduce
 BdrvChildRole.update_filename
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

On 6 October 2017 at 16:54, Kevin Wolf <kwolf@redhat.com> wrote:
> There is no good reason for bdrv_drop_intermediate() to know the active
> layer above the subchain it is operating on - even more so, because
> the assumption that there is a single active layer above it is not
> generally true.
>
> In order to prepare removal of the active parameter, use a BdrvChildRole
> callback to update the backing file string in the overlay image instead
> of directly calling bdrv_change_backing_file().
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Hi. Coverity complains about this (CID1381628):

> +static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
> +                                        const char *filename, Error **errp)
> +{
> +    BlockDriverState *parent = c->opaque;
> +    int ret;
> +
> +    ret = bdrv_change_backing_file(parent, filename,
> +                                   base->drv ? base->drv->format_name : "");
> +    if (ret < 0) {
> +        error_setg_errno(errp, ret, "Could not update backing file link");

because error_setg_errno() expects a positive errno value, but
bdrv_change_backing_file() returns negative errnos.

The simple fix is to pass "-ret" here.

thanks
-- PMM
