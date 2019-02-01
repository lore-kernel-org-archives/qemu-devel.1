Received: from eggs.gnu.org ([209.51.188.92]:45047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpaU8-0005BT-LT
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpaU6-00010d-TL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:12:04 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpaU2-0000q7-Ob
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:12:00 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so6226717otr.10
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 07:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20190125225714.10234-1-richard.henderson@linaro.org>
	<20190125225714.10234-6-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 15:11:40 +0000
Message-ID: <CAFEAcA-vftmrAfy+tx6gLYJrBPHvqRaxKYT3rodQ8prnzi0g9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/6] linux-user: Initialize aarch64 pac keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 25 Jan 2019 at 22:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Initialize the keys to a non-zero value on process start.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +static uint64_t arm_rand64(void)
> +{
> +    int shift = 64 - clz64(RAND_MAX);
> +    int i, n = 64 / shift + (64 % shift != 0);
> +    uint64_t ret = 0;
> +
> +    for (i = 0; i < n; i++) {
> +        ret = (ret << shift) | rand();
> +    }
> +    return ret;
> +}

I'm not a huge fan of the use of rand() here, but it's what
we're using to initialize AT_RANDOM in linux-user, so I guess
it's OK here. At some point we should investigate whether
there's something better we are guaranteed to have available,
I suppose. (Coverity gripes about use of rand().)

thanks
-- PMM
