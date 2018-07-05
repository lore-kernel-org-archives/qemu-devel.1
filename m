Received: from eggs.gnu.org ([2001:4830:134:3::10]:40674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7UF-0003sK-Ns
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7UE-0001qR-PE
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:52:07 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb7UE-0001q5-Gj
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:52:06 -0400
Received: by mail-oi0-x243.google.com with SMTP id y207-v6so18144330oie.13
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:52:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627073351.856-6-contrib@steffen-goertz.de>
References: <20180627073351.856-1-contrib@steffen-goertz.de>
	<20180627073351.856-6-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 17:51:44 +0100
Message-ID: <CAFEAcA-RRh3Y4vXz4h3DUaXtnoH97gW1v1bTQbLCSF=qT4KizA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 5/8] arm: Add NRF51 random number generator
 peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

On 27 June 2018 at 08:33, Steffen G=C3=B6rtz <contrib@steffen-goertz.de> wr=
ote:
> Add a model of the NRF51 random number generator peripheral.
>
> Changes since v2:
>   - Add missing 'qapi/error.h' for error_abort
>
> Changes since v1:
>   - Add implementation access size hints to MemoryRegionOps
>   - Fail on error if qcrypto_random_bytes fails
>   - Add references to Nrf51 datasheets
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> ---

Hi -- a couple of general notes about device modelling
which might apply to other devices in this series as well:

> +static void nrf51_rng_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->props =3D nrf51_rng_properties;

In general, every device that has any modifiable state needs:
 * a reset function
 * a vmstate struct that defines its state for migration

These get set up in the class init function by setting
dc->vmsd and dc->reset.

For devices that don't have any modifiable state, a comment
in the init function to say so helps to reassure readers
that the issue has been considered :-)

> +}


> +    struct {
> +        uint32_t active:1;
> +        uint32_t event_valrdy:1;
> +        uint32_t shortcut_stop_on_valrdy:1;
> +        uint32_t interrupt_enabled:1;
> +        uint32_t filter_enabled:1;
> +    } state;

Prefer to avoid bitfields.

thanks
-- PMM
