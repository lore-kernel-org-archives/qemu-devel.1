Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13006C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E09206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E09206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOd0f-0007nT-1X
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOczw-00076k-0y
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOczu-000304-IT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:02:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOczq-0002yf-Rn; Wed, 15 Apr 2020 04:02:11 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1DDE5BF603;
 Wed, 15 Apr 2020 08:02:09 +0000 (UTC)
Date: Wed, 15 Apr 2020 10:02:05 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 45/48] nvme: support multiple namespaces
Message-ID: <20200415080205.v4cxl7a2bub3yqau@apples.localdomain>
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-46-its@irrelevant.dk>
 <dbde592f-1205-a483-c03e-62153ad348d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbde592f-1205-a483-c03e-62153ad348d8@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 15 09:38, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/15/20 7:51 AM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > This adds support for multiple namespaces by introducing a new 'nvme-=
ns'
> > device model. The nvme device creates a bus named from the device nam=
e
> > ('id'). The nvme-ns devices then connect to this and registers
> > themselves with the nvme device.
> >=20
> > This changes how an nvme device is created. Example with two namespac=
es:
> >=20
> >    -drive file=3Dnvme0n1.img,if=3Dnone,id=3Ddisk1
> >    -drive file=3Dnvme0n2.img,if=3Dnone,id=3Ddisk2
> >    -device nvme,serial=3Ddeadbeef,id=3Dnvme0
> >    -device nvme-ns,drive=3Ddisk1,bus=3Dnvme0,nsid=3D1
> >    -device nvme-ns,drive=3Ddisk2,bus=3Dnvme0,nsid=3D2
> >=20
> > The drive property is kept on the nvme device to keep the change
> > backward compatible, but the property is now optional. Specifying a
> > drive for the nvme device will always create the namespace with nsid =
1.
> >=20
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> > ---
> >   hw/block/Makefile.objs |   2 +-
> >   hw/block/nvme-ns.c     | 157 +++++++++++++++++++++++++++
> >   hw/block/nvme-ns.h     |  60 +++++++++++
> >   hw/block/nvme.c        | 233 +++++++++++++++++++++++++++-----------=
---
> >   hw/block/nvme.h        |  47 ++++-----
> >   hw/block/trace-events  |   8 +-
> >   6 files changed, 396 insertions(+), 111 deletions(-)
> >   create mode 100644 hw/block/nvme-ns.c
> >   create mode 100644 hw/block/nvme-ns.h
> >=20
> > diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> > index 4b4a2b338dc4..d9141d6a4b9b 100644
> > --- a/hw/block/Makefile.objs
> > +++ b/hw/block/Makefile.objs
> > @@ -7,7 +7,7 @@ common-obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
> >   common-obj-$(CONFIG_XEN) +=3D xen-block.o
> >   common-obj-$(CONFIG_ECC) +=3D ecc.o
> >   common-obj-$(CONFIG_ONENAND) +=3D onenand.o
> > -common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
> > +common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o nvme-ns.o
> >   common-obj-$(CONFIG_SWIM) +=3D swim.o
> >   common-obj-$(CONFIG_SH4) +=3D tc58128.o
> > diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> > new file mode 100644
> > index 000000000000..bd64d4a94632
> > --- /dev/null
> > +++ b/hw/block/nvme-ns.c
> > @@ -0,0 +1,157 @@
>=20
> Missing copyright + license.
>=20

Fixed.

> > +
> > +    switch (n->conf.wce) {
> > +    case ON_OFF_AUTO_ON:
> > +        n->features.volatile_wc =3D 1;
> > +        break;
> > +    case ON_OFF_AUTO_OFF:
> > +        n->features.volatile_wc =3D 0;
>=20
> Missing 'break'?
>=20

Ouch. Fixed.

> > +    case ON_OFF_AUTO_AUTO:
> > +        n->features.volatile_wc =3D blk_enable_write_cache(ns->blk);
> > +        break;
> > +    default:
> > +        abort();
> > +    }
> > +
> > +    blk_set_enable_write_cache(ns->blk, n->features.volatile_wc);
> > +
> > +    return 0;
> > +}
> > +
> > +static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp=
)
> > +{
> > +    if (!ns->blk) {
> > +        error_setg(errp, "block backend not configured");
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > +{
> > +    if (nvme_ns_check_constraints(ns, errp)) {
> > +        return -1;
> > +    }
> > +
> > +    if (nvme_ns_init_blk(n, ns, &n->id_ctrl, errp)) {
> > +        return -1;
> > +    }
> > +
> > +    nvme_ns_init(ns);
> > +    if (nvme_register_namespace(n, ns, errp)) {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void nvme_ns_realize(DeviceState *dev, Error **errp)
> > +{
> > +    NvmeNamespace *ns =3D NVME_NS(dev);
> > +    BusState *s =3D qdev_get_parent_bus(dev);
> > +    NvmeCtrl *n =3D NVME(s->parent);
> > +    Error *local_err =3D NULL;
> > +
> > +    if (nvme_ns_setup(n, ns, &local_err)) {
> > +        error_propagate_prepend(errp, local_err,
> > +                                "could not setup namespace: ");
> > +        return;
> > +    }
> > +}
> > +
> > +static Property nvme_ns_props[] =3D {
> > +    DEFINE_NVME_NS_PROPERTIES(NvmeNamespace, params),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void nvme_ns_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > +
> > +    dc->bus_type =3D TYPE_NVME_BUS;
> > +    dc->realize =3D nvme_ns_realize;
> > +    device_class_set_props(dc, nvme_ns_props);
> > +    dc->desc =3D "virtual nvme namespace";
>=20
> "Virtual NVMe namespace"?
>=20

Fixed.

> > +}
> > +
> > +static void nvme_ns_instance_init(Object *obj)
> > +{
> > +    NvmeNamespace *ns =3D NVME_NS(obj);
> > +    char *bootindex =3D g_strdup_printf("/namespace@%d,0", ns->param=
s.nsid);
> > +
> > +    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
> > +                                  bootindex, DEVICE(obj), &error_abo=
rt);
> > +
> > +    g_free(bootindex);
> > +}
> > +
> > +static const TypeInfo nvme_ns_info =3D {
> > +    .name =3D TYPE_NVME_NS,
> > +    .parent =3D TYPE_DEVICE,
> > +    .class_init =3D nvme_ns_class_init,
> > +    .instance_size =3D sizeof(NvmeNamespace),
> > +    .instance_init =3D nvme_ns_instance_init,
> > +};
> > +
> > +static void nvme_ns_register_types(void)
> > +{
> > +    type_register_static(&nvme_ns_info);
> > +}
> > +
> > +type_init(nvme_ns_register_types)
> > diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> > new file mode 100644
> > index 000000000000..3c3651d485d0
> > --- /dev/null
> > +++ b/hw/block/nvme-ns.h
> > @@ -0,0 +1,60 @@
>=20
> Missing copyright + license.
>=20

Fixed.

> > +#ifndef NVME_NS_H
> > +#define NVME_NS_H
> > +
> > +#define TYPE_NVME_NS "nvme-ns"
> > +#define NVME_NS(obj) \
> > +    OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
> > +
> > +#define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
> > +    DEFINE_PROP_DRIVE("drive", _state, blk), \
> > +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> > +
> > +typedef struct NvmeNamespaceParams {
> > +    uint32_t nsid;
> > +} NvmeNamespaceParams;
> > +
> > +typedef struct NvmeNamespace {
> > +    DeviceState  parent_obj;
> > +    BlockBackend *blk;
> > +    int32_t      bootindex;
> > +    int64_t      size;
> > +
> > +    NvmeIdNs            id_ns;
> > +    NvmeNamespaceParams params;
> > +} NvmeNamespace;
> > +
> > +static inline uint32_t nvme_nsid(NvmeNamespace *ns)
> > +{
> > +    if (ns) {
> > +        return ns->params.nsid;
> > +    }
> > +
> > +    return -1;
>=20
> This case doesn't seem possible.
>=20
> Maybe:
>=20
>       assert(ns);
>       return ns->params.nsid;
>=20

I have some later patches where this might happen in certain traces.
That's why I'm using a sentinel value. But I will see if I can clean it
up instead.

> > @@ -2607,26 +2666,28 @@ static int nvme_init_namespace(NvmeCtrl *n, N=
vmeNamespace *ns, Error **errp)
> >   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >   {
> >       NvmeCtrl *n =3D NVME(pci_dev);
> > -    int i;
> > +    NvmeNamespace *ns;
> >       if (nvme_check_constraints(n, errp)) {
> >           return;
> >       }
> > +    qbus_create_inplace(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS,
> > +                        &pci_dev->qdev, n->parent_obj.qdev.id);
> > +
> >       nvme_init_state(n);
> > +    nvme_init_pci(n, pci_dev);
> > +    nvme_init_ctrl(n);
>=20
> Argh you move these functions again... Why not put them in the correct =
place
> when you refactor nvme_realize()?
>=20

"Argh" :) Yeah, I will do an effort to make this better!


