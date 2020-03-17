Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE2C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4681E2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD5uT+Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4681E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIjT-0005XS-Dm
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEIia-0004Ht-JQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEIiZ-0006mA-Cr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:21:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEIiZ-0006hJ-8O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584476498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq3300QZSkIHMgL+gyrh6c0lIc2YNgJsP74br85rNtQ=;
 b=TD5uT+PfapXXidSOT9GtCqLLCG553KWEG0ghockY7sb2zCnZLwaYyOpKxlhpxu5M8daSq9
 Cp53t8aO7ABTTQo6rXo1/5ZTAtMNABjLCiyFR5sHhxVe/jl0Sf/em7VrTIb8GPsmawMHGL
 o/oBCTXkCXi4m6kND6BK3ED6C2sXVGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-Soa8w_3fOfeS-G1zuCoqLQ-1; Tue, 17 Mar 2020 16:21:36 -0400
X-MC-Unique: Soa8w_3fOfeS-G1zuCoqLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59A2A8017CC;
 Tue, 17 Mar 2020 20:21:35 +0000 (UTC)
Received: from work-vm (ovpn-114-234.ams2.redhat.com [10.36.114.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2747D6E3EE;
 Tue, 17 Mar 2020 20:21:19 +0000 (UTC)
Date: Tue, 17 Mar 2020 20:21:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200317202117.GI3369@work-vm>
References: <20200317195908.283800-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200317195908.283800-1-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> Sometimes it would be good to be able to read the pin number along
> with the IRQ number allocated.  Since we'll dump the IRQ number, no
> reason to not dump the pin information.  For example, the vfio-pci
> device will overwrite the pin with the hardware pin number.  It would
> be nice to know the pin number of one assigned device from QMP/HMP.
>=20
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> CC: Julia Suvorova <jusual@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>=20
> This helped me to debug an IRQ sharing issue, so may good to have it
> in master too.
> ---
>  hw/pci/pci.c       | 1 +
>  monitor/hmp-cmds.c | 3 ++-
>  qapi/misc.json     | 6 ++++--
>  3 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e1ed6677e1..7ebf532ac9 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1769,6 +1769,7 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevic=
e *dev, PCIBus *bus,
>      info->regions =3D qmp_query_pci_regions(dev);
>      info->qdev_id =3D g_strdup(dev->qdev.id ? dev->qdev.id : "");
> =20
> +    info->irq_pin =3D dev->config[PCI_INTERRUPT_PIN];
>      if (dev->config[PCI_INTERRUPT_PIN] !=3D 0) {
>          info->has_irq =3D true;
>          info->irq =3D dev->config[PCI_INTERRUPT_LINE];
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 58724031ea..04c86bbb03 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -680,7 +680,8 @@ static void hmp_info_pci_device(Monitor *mon, const P=
ciDeviceInfo *dev)
>      }
> =20
>      if (dev->has_irq) {
> -        monitor_printf(mon, "      IRQ %" PRId64 ".\n", dev->irq);
> +        monitor_printf(mon, "      IRQ %" PRId64 ", pin %c\n",
> +                       dev->irq, (char)('A' + dev->irq_pin - 1));

Can we trust dev->irq_pin not to be something silly and generate a
non-printable?

Dave

>      }
> =20
>      if (dev->has_pci_bridge) {
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c18fe681fb..f8d33ddb4e 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -403,6 +403,8 @@
>  #
>  # @irq: if an IRQ is assigned to the device, the IRQ number
>  #
> +# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
> +#
>  # @qdev_id: the device name of the PCI device
>  #
>  # @pci_bridge: if the device is a PCI bridge, the bridge information
> @@ -417,8 +419,8 @@
>  { 'struct': 'PciDeviceInfo',
>    'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
>             'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
> -           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInf=
o',
> -           'regions': ['PciMemoryRegion']} }
> +           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
> +           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'=
] }}
> =20
>  ##
>  # @PciInfo:
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


