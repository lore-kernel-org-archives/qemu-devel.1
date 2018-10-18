Received: from eggs.gnu.org ([2001:4830:134:3::10]:40501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD82V-0001TH-9k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gD82P-0007pY-9U
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:08:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gD82P-0007pQ-47
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 09:08:29 -0400
Received: by mail-ot1-x344.google.com with SMTP id l58so29670386otd.6
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 06:08:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018130434.23237-4-philmd@redhat.com>
References: <20181018130434.23237-1-philmd@redhat.com>
	<20181018130434.23237-4-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 14:08:07 +0100
Message-ID: <CAFEAcA-p21K3nbCUL0Hi=cBhqpPmQaHUXrUpEFuWFL+thgJoSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, QEMU Developers <qemu-devel@nongnu.org>, Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>

On 18 October 2018 at 14:04, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Use TYPE_PVPANIC definition, split in 2 patches]
> ---
> Peng: I hope this is now more obvious how you could reuse the pvpanic dev=
ice.
>
>  hw/misc/pvpanic.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index 4f552e1533..b81c5fa633 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -2,10 +2,12 @@
>   * QEMU simulated pvpanic device.
>   *
>   * Copyright Fujitsu, Corp. 2013
> + * Copyright (c) 2018 ZTE Ltd.
>   *
>   * Authors:
>   *     Wen Congyang <wency@cn.fujitsu.com>
>   *     Hu Tao <hutao@cn.fujitsu.com>
> + *     Peng Hao <peng.hao2@zte.com.cn>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
> @@ -47,7 +49,10 @@ static void handle_event(int event)
>
>  typedef struct PVPanicState {
>      /*< private >*/
> -    ISADevice isadev;
> +    union {
> +        ISADevice isadev;
> +        SysBusDevice busdev;
> +    };

This field is the parent-type for the QOM object, so I don't
think it makes sense for it to be a union. Any one QOM object
should have a single distinct parent type. (There are other
examples of "some more or less similar device has ISA and
SysBus or PCI and SysBus variations" which should provide
some models to copy from.

thanks
-- PMM
