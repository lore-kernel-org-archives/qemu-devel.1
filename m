Received: from eggs.gnu.org ([2001:4830:134:3::10]:35188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4Vf-0000G7-Bx
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG4Ve-00015z-FS
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:26:35 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG4Ve-00015c-A9
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:26:34 -0400
Received: by mail-oi0-x241.google.com with SMTP id k17-v6so28691533oih.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:26:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309161933.8168-31-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
	<20180309161933.8168-31-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 16:26:13 +0100
Message-ID: <CAFEAcA9F3whtO-T9Em7Tg87=_ukSKS+DGEcWjVS_drnKGPui4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 30/56] file-posix: Support .bdrv_co_create
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

On 9 March 2018 at 16:19, Kevin Wolf <kwolf@redhat.com> wrote:
> This adds the .bdrv_co_create driver callback to file, which enables
> image creation over QMP.
> +static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
> +                                           Error **errp)
> +{
> +    BlockdevCreateOptions options;
> +    int64_t total_size = 0;
> +    bool nocow = false;
> +    PreallocMode prealloc;
> +    char *buf = NULL;
> +    Error *local_err = NULL;
> +
> +    /* Skip file: protocol prefix */
> +    strstart(filename, "file:", &filename);

This isn't new, but the code-motion causes Coverity to notice
(CID 1390569) that this strstart() return value isn't checked (which
we apparently do in 98 of the other 100 callsites). The "doesn't
begin with 'file:'" case can't happen given the BlockDriver struct
definition, though, so I've marked the warning as false-positive.
I mention it just in case you think it's worth adding an
"assert(filename);" here (and similarly in file-win32.c).

thanks
-- PMM
