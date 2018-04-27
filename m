Received: from eggs.gnu.org ([2001:4830:134:3::10]:37350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC425-0003kB-OP
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC424-0006kM-Vf
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:07:29 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC424-0006k5-QW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:07:28 -0400
Received: by mail-oi0-x244.google.com with SMTP id l1-v6so1692348oii.1
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 07:07:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309161933.8168-44-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
	<20180309161933.8168-44-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 15:07:07 +0100
Message-ID: <CAFEAcA_PbrTHtn76UfG8_cYJL0RuQ-7Ownu2_Xz4h8egnEbhKg@mail.gmail.com>
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
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 16:19, Kevin Wolf <kwolf@redhat.com> wrote:
> This adds the .bdrv_co_create driver callback to sheepdog, which enables
> image creation over QMP.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Hi; Coverity (CID 1390641) points out that the changes to
parse_redundancy_str() introduce a memory leak:

> -static int parse_redundancy_str(BDRVSheepdogState *s, const char *opt)
> +static SheepdogRedundancy *parse_redundancy_str(const char *opt)
>  {
> -    struct SheepdogRedundancy redundancy;
> +    SheepdogRedundancy *redundancy;
>      const char *n1, *n2;
>      long copy, parity;
>      char p[10];
> @@ -1947,26 +1970,27 @@ static int parse_redundancy_str(BDRVSheepdogState *s, const char *opt)
>      n2 = strtok(NULL, ":");
>
>      if (!n1) {
> -        return -EINVAL;
> +        return NULL;
>      }
>
>      ret = qemu_strtol(n1, NULL, 10, &copy);
>      if (ret < 0) {
> -        return ret;
> +        return NULL;
>      }
>
> +    redundancy = g_new0(SheepdogRedundancy, 1);

We now do a memory allocation here...

>      if (!n2) {
> -        redundancy = (SheepdogRedundancy) {
> +        *redundancy = (SheepdogRedundancy) {
>              .type               = SHEEPDOG_REDUNDANCY_TYPE_FULL,
>              .u.full.copies      = copy,
>          };
>      } else {
>          ret = qemu_strtol(n2, NULL, 10, &parity);
>          if (ret < 0) {
> -            return ret;
> +            return NULL;

...but this error-exit path does not free it.

>          }
>
> -        redundancy = (SheepdogRedundancy) {
> +        *redundancy = (SheepdogRedundancy) {
>              .type               = SHEEPDOG_REDUNDANCY_TYPE_ERASURE_CODED,
>              .u.erasure_coded    = {
>                  .data_strips    = copy,
> @@ -1975,17 +1999,19 @@ static int parse_redundancy_str(BDRVSheepdogState *s, const char *opt)
>          };
>      }
>
> -    return parse_redundancy(s, &redundancy);
> +    return redundancy;
>  }

thanks
-- PMM
