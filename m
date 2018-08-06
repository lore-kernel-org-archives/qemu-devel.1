Received: from eggs.gnu.org ([2001:4830:134:3::10]:37009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fmi4k-0002EH-5b
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fmi4j-0008PC-5P
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:09:42 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fmi4i-0008Oy-VE
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:09:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id o18-v6so15015057wmc.0
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 09:09:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-3-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-3-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 Aug 2018 17:09:39 +0100
Message-ID: <CAJSP0QUPZziWN8U292UAXa3T2NLe3BbEAPSSnM9Pa5MAqcGrxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> +static uint64_t uicr_read(void *opaque, hwaddr offset, unsigned int size=
)
> +{
> +    Nrf51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    offset >>=3D 2;
> +
> +    return s->uicr_content[offset];
> +}
> +
> +static void uicr_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned int size)
> +{
> +    Nrf51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    offset >>=3D 2;
> +
> +    if (offset >=3D ARRAY_SIZE(s->uicr_content)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: bad read offset 0x%" HWADDR_PRIx "\n", __func__, of=
fset);
> +        return;
> +    }

There is asymmetry here: uicr_read() doesn't check offset before
indexing the array but uicr_write() does.  Either the check is
necessary or it's not.

I think this check isn't necessary since the memory region is sized
appropriately:

  memory_region_init_io(&s->uicr, NULL, &uicr_ops, s, "nrf51_soc.uicr",
          sizeof(s->uicr_content));

> +static void nrf51_nvm_reset(DeviceState *dev)
> +{
> +    Nrf51NVMState *s =3D NRF51_NVM(dev);
> +
> +    memset(s->empty_page, 0xFF, s->page_size);
> +}

Can this be done in ->realize()?  Nothing changes the contents of
empty_page, so a ->reset() function seems unnecessary.
