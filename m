Received: from eggs.gnu.org ([2001:4830:134:3::10]:59736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJtr-0000E7-CQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJtl-0006X6-Tc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:09:23 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqJtj-0006VA-0e
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:09:17 -0400
Received: by mail-oi0-x242.google.com with SMTP id s198-v6so8569273oih.11
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:09:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180811090836.4024-6-contrib@steffen-goertz.de>
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-6-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 16:08:52 +0100
Message-ID: <CAFEAcA-TE2Okbi2mKxs=XgRjQb1kS-bNkv6HX3VvQG9rcpm7uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] arm: Improve error propagation in
 nRF51 SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

On 11 August 2018 at 10:08, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> =
wrote:
> This patch takes care that errors that occur during
> instantiation of the cortex-m0 cpu are properly propagated.
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---
>  hw/arm/nrf51_soc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 2265d30352..88a848de8b 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -66,8 +66,17 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Er=
ror **errp)
>      }
>
>      object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "me=
mory",
> -            &err);
> -    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
> +                            &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized",
> +                             &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }

This should be squashed into the patch which had the bug in it
(one of Joel's, I think).

thanks
-- PMM
