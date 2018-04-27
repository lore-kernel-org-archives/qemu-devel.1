Received: from eggs.gnu.org ([2001:4830:134:3::10]:36783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC40D-0002Wp-6u
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC40C-0005sF-AL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:05:33 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:35705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC40B-0005s2-Mw
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:05:32 -0400
Received: by mail-oi0-x22e.google.com with SMTP id a6-v6so1672348oia.2
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 07:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309161933.8168-44-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
	<20180309161933.8168-44-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 15:05:10 +0100
Message-ID: <CAFEAcA-pzvuk7kgQHz-Xa3ub4RXxm_bsN4ipKdomjcAmxBMFtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 43/56] sheepdog: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 9 March 2018 at 16:19, Kevin Wolf <kwolf@redhat.com> wrote:
> This adds the .bdrv_co_create driver callback to sheepdog, which enables
> image creation over QMP.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Hi; Coverity (CID 1390614) thinks there's a resource leak in this function:

> +static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
> +                                          Error **errp)
> +{
> +    BlockdevCreateOptions *create_options = NULL;
> +    QDict *qdict, *location_qdict;
> +    QObject *crumpled;
> +    Visitor *v;
> +    const char *redundancy;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    redundancy = qemu_opt_get_del(opts, BLOCK_OPT_REDUNDANCY);

qemu_opt_get_del() returns either NULL or memory which
the caller must free with g_free()...


> +    ret = sd_co_create(create_options, errp);
> +fail:
> +    qapi_free_BlockdevCreateOptions(create_options);
> +    QDECREF(qdict);
> +    return ret;

...but the exit path from this function doesn't free it.

> +}

thanks
-- PMM
