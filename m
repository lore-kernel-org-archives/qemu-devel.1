Received: from eggs.gnu.org ([2001:4830:134:3::10]:44206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT2fr-0001zl-R2
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT2fm-0002dl-Pu
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:06:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT2fm-0002c4-LX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:06:38 -0400
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
	<20180613094727.11326-2-mark.cave-ayland@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51d6368f-8a13-0daf-dcc2-78303af152ad@redhat.com>
Date: Wed, 13 Jun 2018 12:06:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180613094727.11326-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/mips/jazz: create ESP device
 directly via qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, hpoussin@reactos.org, famz@redhat.com

On 13/06/2018 11:47, Mark Cave-Ayland wrote:
> +    dev =3D qdev_create(NULL, TYPE_ESP);
> +    sysbus_esp =3D ESP_STATE(dev);
> +    esp =3D &sysbus_esp->esp;
> +    esp->dma_memory_read =3D rc4030_dma_read;
> +    esp->dma_memory_write =3D rc4030_dma_write;
> +    esp->dma_opaque =3D dmas[0];

Poking at the functions here is a bit ugly, and it's the last user of
rc4030_dma_{read,write}.  It would be nicer if ESP could get a memory
region like it's done a bit above for the NIC.  I guess it's not a big
deal, but perhaps there could be a TODO comment.

I'm mostly mentioning this because Herv=C3=A9 is copied and because SPARC=
 DMA
has the same issue of using function pointers instead of an IOMMU memory
region...

Thanks,

Paolo

> +    sysbus_esp->it_shift =3D 0;
> +    /* XXX for now until rc4030 has been changed to use DMA enable sig=
nal */
> +    esp->dma_enabled =3D 1;
> +    qdev_init_nofail(dev);
> +
> +    sysbus =3D SYS_BUS_DEVICE(dev);
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 5));
> +    sysbus_mmio_map(sysbus, 0, 0x80002000);
> +
