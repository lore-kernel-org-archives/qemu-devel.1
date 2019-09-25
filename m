Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFADDC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B351421D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B351421D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1OZ-0001sG-LK
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1GZ-0004A4-Vo
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1GY-0002M1-QC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:59:11 -0400
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:48074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1GY-0002LD-KG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:59:10 -0400
Received: from player779.ha.ovh.net (unknown [10.109.159.132])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id AB2AD1E1153
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:59:08 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id D8EA8A1778E8;
 Wed, 25 Sep 2019 06:58:57 +0000 (UTC)
Subject: Re: [PATCH 08/20] spapr: Replace spapr_vio_qirq() helper with
 spapr_vio_irq_pulse() helper
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-9-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fb4b950e-b0c3-3910-4964-836fb1f88301@kaod.org>
Date: Wed, 25 Sep 2019 08:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-9-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1169810006418099160
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.113
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/2019 08:45, David Gibson wrote:
> Every caller of spapr_vio_qirq() immediately calls qemu_irq_pulse() wit=
h
> the result, so we might as well just fold that into the helper.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/char/spapr_vty.c        | 3 +--
>  hw/net/spapr_llan.c        | 3 +--
>  hw/ppc/spapr_vio.c         | 3 +--
>  include/hw/ppc/spapr_vio.h | 5 +++--
>  4 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index 087c93e4fa..8f4d9fe472 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -5,7 +5,6 @@
>  #include "cpu.h"
>  #include "migration/vmstate.h"
>  #include "chardev/char-fe.h"
> -#include "hw/irq.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_vio.h"
>  #include "hw/qdev-properties.h"
> @@ -37,7 +36,7 @@ static void vty_receive(void *opaque, const uint8_t *=
buf, int size)
> =20
>      if ((dev->in =3D=3D dev->out) && size) {
>          /* toggle line to simulate edge interrupt */
> -        qemu_irq_pulse(spapr_vio_qirq(&dev->sdev));
> +        spapr_vio_irq_pulse(&dev->sdev);
>      }
>      for (i =3D 0; i < size; i++) {
>          if (dev->in - dev->out >=3D VTERM_BUFSIZE) {
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 701e6e1514..3d96884d66 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -27,7 +27,6 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/irq.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "net/net.h"
> @@ -267,7 +266,7 @@ static ssize_t spapr_vlan_receive(NetClientState *n=
c, const uint8_t *buf,
>      }
> =20
>      if (sdev->signal_state & 1) {
> -        qemu_irq_pulse(spapr_vio_qirq(sdev));
> +        spapr_vio_irq_pulse(sdev);
>      }
> =20
>      return size;
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 0803649658..554de9930d 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -23,7 +23,6 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> -#include "hw/irq.h"
>  #include "qemu/log.h"
>  #include "hw/loader.h"
>  #include "elf.h"
> @@ -294,7 +293,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t=
 *crq)
>      dev->crq.qnext =3D (dev->crq.qnext + 16) % dev->crq.qsize;
> =20
>      if (dev->signal_state & 1) {
> -        qemu_irq_pulse(spapr_vio_qirq(dev));
> +        spapr_vio_irq_pulse(dev);
>      }
> =20
>      return 0;
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index 875be28cdd..72762ed16b 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -24,6 +24,7 @@
> =20
>  #include "hw/ppc/spapr.h"
>  #include "sysemu/dma.h"
> +#include "hw/irq.h"
> =20
>  #define TYPE_VIO_SPAPR_DEVICE "vio-spapr-device"
>  #define VIO_SPAPR_DEVICE(obj) \
> @@ -84,11 +85,11 @@ extern SpaprVioDevice *spapr_vio_find_by_reg(SpaprV=
ioBus *bus, uint32_t reg);
>  void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt);
>  extern gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
> =20
> -static inline qemu_irq spapr_vio_qirq(SpaprVioDevice *dev)
> +static inline void spapr_vio_irq_pulse(SpaprVioDevice *dev)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> =20
> -    return spapr_qirq(spapr, dev->irq);
> +    qemu_irq_pulse(spapr_qirq(spapr, dev->irq));
>  }
> =20
>  static inline bool spapr_vio_dma_valid(SpaprVioDevice *dev, uint64_t t=
addr,
>=20


