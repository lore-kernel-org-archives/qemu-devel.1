Received: from eggs.gnu.org ([2001:4830:134:3::10]:36702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFwAt-0008OS-Sn
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFwAt-00067L-4Q
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:04:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFwAs-000670-Gq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 03:04:51 -0400
Received: by mail-ot1-x341.google.com with SMTP id x4so140920otg.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 00:04:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810252239320.26372@xnncv>
References: <20181022181035.20104-1-ppandit@redhat.com>
	<CAFEAcA-6djmjK_x_n5z7cnicdgu+eeJF3QJw4iaCOMDLPkEJ7w@mail.gmail.com>
	<nycvar.YSQ.7.76.1810252239320.26372@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 08:04:29 +0100
Message-ID: <CAFEAcA-Mp_ovLRzHFpUCTmd6r-bmGZ2-V3OHSxo+5Mg+zw2=aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] arm: check bit index before usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, liqsub1 <liqsub1@163.com>, Moguofang <moguofang@huawei.com>

On 25 October 2018 at 21:31, P J P <ppandit@redhat.com> wrote:
> +-- On Thu, 25 Oct 2018, Peter Maydell wrote --+
> | Hi; thanks for this patch. Looking at the SA1110 manual,
> | it says that writes to the reserved bits [31:28] are
> | ignored. So I think that rather than doing this check
> | here, we should do what the strongarm_ppc_* code in the
> | same file does -- mask off the high bits for writes to
> | the direction and state registers. Then it will not
> | be possible for high bits to be set here that cause an
> | out-of-range array access.
>
> ===
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index ec2627374d..dd8c4b1f2e 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -587,12 +587,12 @@ static void strongarm_gpio_write(void *opaque, hwaddr
> offset,
>
>      switch (offset) {
>      case GPDR:        /* GPIO Pin-Direction registers */
> -        s->dir = value;
> +        s->dir = value & 0x3fffff;
>          strongarm_gpio_handler_update(s);
>          break;
>
>      case GPSR:        /* GPIO Pin-Output Set registers */
> -        s->olevel |= value;
> +        s->olevel |= value & 0x3fffff;
>          strongarm_gpio_handler_update(s);
>          break;
> ===
>
> does this seem okay?

Yes, that's what I had in mind.

thanks
-- PMM
