Received: from eggs.gnu.org ([2001:4830:134:3::10]:56500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fZvge-0001E9-R5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fZvga-0005NY-Tn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:04:00 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:36894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fZvga-0005Ls-Mv
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:03:56 -0400
Received: from player793.ha.ovh.net (unknown [10.109.108.28])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0407F13CA94
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 12:03:54 +0200 (CEST)
References: <20180619140729.21949-1-clg@kaod.org>
	<20180619140729.21949-2-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <eb1ad8ca-89f7-b059-3a3c-412375871113@kaod.org>
Date: Mon, 2 Jul 2018 12:03:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180619140729.21949-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState *qdev)
>      }
>  }
>  
> +/* TODO : poor VIO device indexing ... */
> +static uint32_t vio_index;

I think we could also use (dev->reg & 0xff) as an index for 
the VIO devices.

The unit address of the virtual IOA is simply allocated using 
an increment of bus->next_reg, next_reg being initialized at
0x71000000.

I did not see any restrictions in the PAPR specs or in QEMU 
that would break the above.

C.


>  static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
>  {
>      sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> @@ -476,10 +479,18 @@ static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
>      }
>  
>      if (!dev->irq) {
> -        dev->irq = spapr_irq_findone(spapr, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> +        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +            dev->irq = spapr_irq_findone(spapr, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                return;
> +            }
> +        } else {
> +            dev->irq = SPAPR_IRQ_VIO + vio_index++;
> +            if (dev->irq == SPAPR_IRQ_PCI_LSI) {
> +                error_setg(errp, "Too many VIO devices");
> +                return;
> +            }

 
