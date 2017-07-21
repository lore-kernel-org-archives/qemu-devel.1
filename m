Received: from eggs.gnu.org ([2001:4830:134:3::10]:53525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZor-000099-3f
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZoq-0000do-9Y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:26:21 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYZoq-0000dB-3Q
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:26:20 -0400
Received: by mail-wm0-x236.google.com with SMTP id e131so17047140wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:26:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1500625265-23844-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 16:25:58 +0100
Message-ID: <CAFEAcA8BoxaBao7NbgmXFyr-rTX_VwNCyxYzxTgu2L+gPFw90A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/vpc: fix uninitialised variable
 compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 July 2017 at 09:21, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Since commit cfc87e00 "block/vpc.c: Handle write failures in
> get_image_offset()" older versions of gcc (in this case 4.7) incorrectly
> warn that "ret" can be used uninitialised in vpc_co_pwritev().
>
> Setting ret to 0 at the start of vpc_co_pwritev() prevents the warning
> in gcc 4.7 and enables compilation with -Werror to succeed.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  block/vpc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/vpc.c b/block/vpc.c
> index 10e6519..574879b 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -649,7 +649,7 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>      int64_t image_offset;
>      int64_t n_bytes;
>      int64_t bytes_done = 0;
> -    int ret;
> +    int ret = 0;
>      VHDFooter *footer =  (VHDFooter *) s->footer_buf;
>      QEMUIOVector local_qiov;
>

Thanks; applied to master as a buildfix.

-- PMM
