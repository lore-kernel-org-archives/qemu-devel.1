Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F76C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6355A20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8XKi02f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6355A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3HK-00062X-Gu
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3DE-0007XH-Ex
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3D9-00041S-Ob
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:24:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3D9-0003zG-Gi
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585131873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hOxSZynTBTR0WNXAz2vaLRAs+Xd766XJTxkAru4Q+g=;
 b=U8XKi02f68H2wXy9ZTRuYTNlMdcqAoisqdQMYk/Zzn9lAz+eez0PgQ+4bHO8G0QNvtrCYi
 yElW+aNWO2fKzz5I/+XDN9xpdeaPZBUpNukOsJIrZ06h5mGgfLZ8lPHxkmO9D7G3npWVqL
 LFYnyuBfapuA6f1YCTlacqNVg020I/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-CUIsAstEMv2R7hxGC00Pqw-1; Wed, 25 Mar 2020 06:24:32 -0400
X-MC-Unique: CUIsAstEMv2R7hxGC00Pqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD061005F76;
 Wed, 25 Mar 2020 10:24:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE8A396F90;
 Wed, 25 Mar 2020 10:24:26 +0000 (UTC)
Message-ID: <ec1acb9d675ee94f6ca3376f776434fd6f2d7b50.camel@redhat.com>
Subject: Re: [PATCH v5 22/26] nvme: support multiple namespaces
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Wed, 25 Mar 2020 12:24:25 +0200
In-Reply-To: <20200316075541.p6hd2vkpf23vtqre@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821@eucas1p2.samsung.com>
 <20200204095208.269131-23-k.jensen@samsung.com>
 <9b15a07377d6fa16765b426d129483b23143ee6a.camel@redhat.com>
 <20200316075541.p6hd2vkpf23vtqre@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-16 at 00:55 -0700, Klaus Birkelund Jensen wrote:
> On Feb 12 14:34, Maxim Levitsky wrote:
> > On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> > > This adds support for multiple namespaces by introducing a new 'nvme-ns'
> > > device model. The nvme device creates a bus named from the device name
> > > ('id'). The nvme-ns devices then connect to this and registers
> > > themselves with the nvme device.
> > > 
> > > This changes how an nvme device is created. Example with two namespaces:
> > > 
> > >   -drive file=nvme0n1.img,if=none,id=disk1
> > >   -drive file=nvme0n2.img,if=none,id=disk2
> > >   -device nvme,serial=deadbeef,id=nvme0
> > >   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
> > >   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> > > 
> > > The drive property is kept on the nvme device to keep the change
> > > backward compatible, but the property is now optional. Specifying a
> > > drive for the nvme device will always create the namespace with nsid 1.
> > 
> > Very reasonable way to do it. 
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/Makefile.objs |   2 +-
> > >  hw/block/nvme-ns.c     | 158 +++++++++++++++++++++++++++
> > >  hw/block/nvme-ns.h     |  60 +++++++++++
> > >  hw/block/nvme.c        | 235 +++++++++++++++++++++++++----------------
> > >  hw/block/nvme.h        |  47 ++++-----
> > >  hw/block/trace-events  |   6 +-
> > >  6 files changed, 389 insertions(+), 119 deletions(-)
> > >  create mode 100644 hw/block/nvme-ns.c
> > >  create mode 100644 hw/block/nvme-ns.h
> > > 
> > > diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> > > index 28c2495a00dc..45f463462f1e 100644
> > > --- a/hw/block/Makefile.objs
> > > +++ b/hw/block/Makefile.objs
> > > @@ -7,7 +7,7 @@ common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
> > >  common-obj-$(CONFIG_XEN) += xen-block.o
> > >  common-obj-$(CONFIG_ECC) += ecc.o
> > >  common-obj-$(CONFIG_ONENAND) += onenand.o
> > > -common-obj-$(CONFIG_NVME_PCI) += nvme.o
> > > +common-obj-$(CONFIG_NVME_PCI) += nvme.o nvme-ns.o
> > >  common-obj-$(CONFIG_SWIM) += swim.o
> > >  
> > >  obj-$(CONFIG_SH4) += tc58128.o
> > > diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> > > new file mode 100644
> > > index 000000000000..0e5be44486f4
> > > --- /dev/null
> > > +++ b/hw/block/nvme-ns.c
> > > @@ -0,0 +1,158 @@
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/units.h"
> > > +#include "qemu/cutils.h"
> > > +#include "qemu/log.h"
> > > +#include "hw/block/block.h"
> > > +#include "hw/pci/msix.h"
> > 
> > Do you need this include?
> 
> No, I needed hw/pci/pci.h instead :)
I think it compiled without that include,
but including pci.h for  a pci device a a right thing
anyway.

> 
> > > +#include "sysemu/sysemu.h"
> > > +#include "sysemu/block-backend.h"
> > > +#include "qapi/error.h"
> > > +
> > > +#include "hw/qdev-properties.h"
> > > +#include "hw/qdev-core.h"
> > > +
> > > +#include "nvme.h"
> > > +#include "nvme-ns.h"
> > > +
> > > +static int nvme_ns_init(NvmeNamespace *ns)
> > > +{
> > > +    NvmeIdNs *id_ns = &ns->id_ns;
> > > +
> > > +    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> > > +    id_ns->nuse = id_ns->ncap = id_ns->nsze =
> > > +        cpu_to_le64(nvme_ns_nlbas(ns));
> > 
> > Nitpick: To be honest I don't really like that chain assignment, 
> > especially since it forces to wrap the line, but that is just my
> > personal taste.
> 
> Fixed, and also added a comment as to why they are the same.
> 
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int nvme_ns_init_blk(NvmeCtrl *n, NvmeNamespace *ns, NvmeIdCtrl *id,
> > > +    Error **errp)
> > > +{
> > > +    uint64_t perm, shared_perm;
> > > +
> > > +    Error *local_err = NULL;
> > > +    int ret;
> > > +
> > > +    perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
> > > +    shared_perm = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
> > > +        BLK_PERM_GRAPH_MOD;
> > > +
> > > +    ret = blk_set_perm(ns->blk, perm, shared_perm, &local_err);
> > > +    if (ret) {
> > > +        error_propagate_prepend(errp, local_err, "blk_set_perm: ");
> > > +        return ret;
> > > +    }
> > 
> > You should consider using blkconf_apply_backend_options.
> > Take a look at for example virtio_blk_device_realize.
> > That will give you support for read only block devices as well.
> 
> So, yeah. There is a reason for this. And I will add that as a comment,
> but I will write it here for posterity.
> 
> The problem is when the nvme-ns device starts getting more than just a
> single drive attached (I have patches ready that will add a "metadata"
> and a "state" drive). The blkconf_ functions work on a BlockConf that
> embeds a BlockBackend, so you can't have one BlockConf with multiple
> BlockBackend's. That is why I'm kinda copying the "good parts" of
> the blkconf_apply_backend_options code here.
All right. but I guess that eventually this code will need a review
from someone that knows the block layer better that I do.

> 
> > 
> > I personally only once grazed the area of block permissions,
> > so I prefer someone from the block layer to review this as well.
> > 
> > > +
> > > +    ns->size = blk_getlength(ns->blk);
> > > +    if (ns->size < 0) {
> > > +        error_setg_errno(errp, -ns->size, "blk_getlength");
> > > +        return 1;
> > > +    }
> > > +
> > > +    switch (n->conf.wce) {
> > > +    case ON_OFF_AUTO_ON:
> > > +        n->features.volatile_wc = 1;
> > > +        break;
> > > +    case ON_OFF_AUTO_OFF:
> > > +        n->features.volatile_wc = 0;
> > > +    case ON_OFF_AUTO_AUTO:
> > > +        n->features.volatile_wc = blk_enable_write_cache(ns->blk);
> > > +        break;
> > > +    default:
> > > +        abort();
> > > +    }
> > > +
> > > +    blk_set_enable_write_cache(ns->blk, n->features.volatile_wc);
> > > +
> > > +    return 0;
> > 
> > Nitpick: also I just noticed that you call the controller 'n' I didn't paid attention to this
> > before. I think something like 'ctrl' or ctl would be more readable.
> > 
> 
> Yeah, but using 'n' is done in all the existing code, so I think we
> should stick with it.
Or we can do a mass rename later when all the patches are merged.
Doesn't matter to me to be honest, it was a very minor nitpick after all.

> 
> > > +}
> > > +
> > > +static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
> > > +{
> > > +    if (!ns->blk) {
> > > +        error_setg(errp, "block backend not configured");
> > > +        return 1;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > > +{
> > > +    Error *local_err = NULL;
> > > +
> > > +    if (nvme_ns_check_constraints(ns, &local_err)) {
> > > +        error_propagate_prepend(errp, local_err,
> > > +            "nvme_ns_check_constraints: ");
> > > +        return 1;
> > > +    }
> > > +
> > > +    if (nvme_ns_init_blk(n, ns, &n->id_ctrl, &local_err)) {
> > > +        error_propagate_prepend(errp, local_err, "nvme_ns_init_blk: ");
> > > +        return 1;
> > > +    }
> > > +
> > > +    nvme_ns_init(ns);
> > > +    if (nvme_register_namespace(n, ns, &local_err)) {
> > > +        error_propagate_prepend(errp, local_err, "nvme_register_namespace: ");
> > > +        return 1;
> > > +    }
> > > +
> > > +    return 0;
> > 
> > Nitipick: to be honest I am not sure we want to expose internal function names like that in 
> > error hints are supposed to be readable to user that doesn't look at the source.
> > 
> 
> Fixed.
> 
> > > +}
> > > +
> > > +static void nvme_ns_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    NvmeNamespace *ns = NVME_NS(dev);
> > > +    BusState *s = qdev_get_parent_bus(dev);
> > > +    NvmeCtrl *n = NVME(s->parent);
> > 
> > Nitpick: Don't know if you defined this or it was like that always,
> > but I would prefer something like NVME_CTL instead.
> > 
> 
> This is also grandfathered from the nvme device.
OK, fair enough.
> 
> > > +    Error *local_err = NULL;
> > > +
> > > +    if (nvme_ns_setup(n, ns, &local_err)) {
> > > +        error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
> > > +        return;
> > > +    }
> > > +}
> > > +
> > > +static Property nvme_ns_props[] = {
> > > +    DEFINE_NVME_NS_PROPERTIES(NvmeNamespace, params),
> > 
> > If you go with my suggestion to use blkconf you will use here the
> > DEFINE_BLOCK_PROPERTIES_BASE
> > 
> 
> See my comment above about that.
> 
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void nvme_ns_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > > +
> > > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > > +
> > > +    dc->bus_type = TYPE_NVME_BUS;
> > > +    dc->realize = nvme_ns_realize;
> > > +    device_class_set_props(dc, nvme_ns_props);
> > > +    dc->desc = "virtual nvme namespace";
> > > +}
> > 
> > Looks reasonable.
> > I don't know the device/bus model in depth to be honest
> > (I learned it for few days some time ago though)
> > so a review from someone that knows this area better that I do
> > is very welcome.
> > 
> > > +
> > > +static void nvme_ns_instance_init(Object *obj)
> > > +{
> > > +    NvmeNamespace *ns = NVME_NS(obj);
> > > +    char *bootindex = g_strdup_printf("/namespace@%d,0", ns->params.nsid);
> > > +
> > > +    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
> > > +        bootindex, DEVICE(obj), &error_abort);
> > > +
> > > +    g_free(bootindex);
> > > +}
> > > +
> > > +static const TypeInfo nvme_ns_info = {
> > > +    .name = TYPE_NVME_NS,
> > > +    .parent = TYPE_DEVICE,
> > > +    .class_init = nvme_ns_class_init,
> > > +    .instance_size = sizeof(NvmeNamespace),
> > > +    .instance_init = nvme_ns_instance_init,
> > > +};
> > > +
> > > +static void nvme_ns_register_types(void)
> > > +{
> > > +    type_register_static(&nvme_ns_info);
> > > +}
> > > +
> > > +type_init(nvme_ns_register_types)
> > > diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> > > new file mode 100644
> > > index 000000000000..b564bac25f6d
> > > --- /dev/null
> > > +++ b/hw/block/nvme-ns.h
> > > @@ -0,0 +1,60 @@
> > > +#ifndef NVME_NS_H
> > > +#define NVME_NS_H
> > > +
> > > +#define TYPE_NVME_NS "nvme-ns"
> > > +#define NVME_NS(obj) \
> > > +    OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
> > > +
> > > +#define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
> > > +    DEFINE_PROP_DRIVE("drive", _state, blk), \
> > > +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> > > +
> > > +typedef struct NvmeNamespaceParams {
> > > +    uint32_t nsid;
> > > +} NvmeNamespaceParams;
> > > +
> > > +typedef struct NvmeNamespace {
> > > +    DeviceState  parent_obj;
> > > +    BlockBackend *blk;
> > > +    int32_t      bootindex;
> > > +    int64_t      size;
> > > +
> > > +    NvmeIdNs            id_ns;
> > > +    NvmeNamespaceParams params;
> > > +} NvmeNamespace;
> > > +
> > > +static inline uint32_t nvme_nsid(NvmeNamespace *ns)
> > > +{
> > > +    if (ns) {
> > > +        return ns->params.nsid;
> > > +    }
> > > +
> > > +    return -1;
> > > +}
> > 
> > To be honest I would allow user to omit nsid,
> > and in this case pick a free slot out of valid namespaces.
> > 
> > Let me explain the concept of valid/allocated/active namespaces
> > from the spec as written in my summary:
> > 
> > Valid namespaces are 1..N range of namespaces as reported in IDCTRL.NN
> > That value is static, and it should be either set to some arbitrary large value (say 256)
> > or set using qemu device parameter, and not changed dynamically as you currently do.
> > As I understand it, IDCTRL output should not change during lifetime of the controller,
> > although I didn't find exact confirmation on this in spec.
> > 
> > Allocated namespaces are not relevant to us (this is only used for namespace management)
> > (these are namespaces that exist but are not attached to the controller)
> > 
> > And then you have Active namespaces which are the namespaces the user can actually address.
> > 
> > However If I understand this correctly, currently the NVME 'bus' doesn't
> > support hotplug, thus all namespaces will be already plugged in on
> > VM startup, thus the issue doesn't really exist yet.
> > 
> > 
> > 
> 
> I added support for this. It's a nice addition and it makes the code
> much nicer.
Perfect!
> 
> > > +
> > > +static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
> > > +{
> > > +    NvmeIdNs *id_ns = &ns->id_ns;
> > > +    return id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> > > +}
> > > +
> > > +static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> > > +{
> > > +    return nvme_ns_lbaf(ns).ds;
> > > +}
> > > +
> > > +static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
> > > +{
> > > +    return 1 << nvme_ns_lbads(ns);
> > > +}
> > > +
> > > +static inline uint64_t nvme_ns_nlbas(NvmeNamespace *ns)
> > > +{
> > > +    return ns->size >> nvme_ns_lbads(ns);
> > > +}
> > > +
> > > +typedef struct NvmeCtrl NvmeCtrl;
> > > +
> > > +int nvme_ns_setup(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
> > > +
> > > +#endif /* NVME_NS_H */
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index a91c60fdc111..3a377bc56734 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -17,10 +17,11 @@
> > >  /**
> > >   * Usage: add options:
> > >   *      -drive file=<file>,if=none,id=<drive_id>
> > > - *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
> > > + *      -device nvme,serial=<serial>,id=<bus_name>, \
> > >   *              cmb_size_mb=<cmb_size_mb[optional]>, \
> > >   *              num_queues=<N[optional]>, \
> > >   *              mdts=<mdts[optional]>
> > > + *      -device nvme-ns,drive=<drive_id>,bus=bus_name,nsid=1
> > >   *
> > >   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
> > >   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> > > @@ -28,6 +29,7 @@
> > >  
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/units.h"
> > > +#include "qemu/error-report.h"
> > >  #include "hw/block/block.h"
> > >  #include "hw/pci/msix.h"
> > >  #include "hw/pci/pci.h"
> > > @@ -43,6 +45,7 @@
> > >  #include "qemu/cutils.h"
> > >  #include "trace.h"
> > >  #include "nvme.h"
> > > +#include "nvme-ns.h"
> > >  
> > >  #define NVME_SPEC_VER 0x00010300
> > >  #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
> > > @@ -85,6 +88,17 @@ static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> > >      return pci_dma_read(&n->parent_obj, addr, buf, size);
> > >  }
> > >  
> > > +static uint16_t nvme_nsid_err(NvmeCtrl *n, uint32_t nsid)
> > > +{
> > > +    if (nsid && nsid < n->num_namespaces) {
> > > +        trace_nvme_dev_err_inactive_ns(nsid, n->num_namespaces);
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > > +
> > > +    trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> > > +    return NVME_INVALID_NSID | NVME_DNR;
> > > +}
> > 
> > I don't like that function to be honest.
> > This function is called when nvme_ns returns NULL.
> > IMHO it would be better to make nvme_ns return both namespace pointer and error code instead.
> > In kernel we encode error values into the returned pointer.
> > 
> 
> I'm not sure how you want me to do this? I'm not familiar with the way
> the kernel does it.
The kernel doesn't map the first memory page, and uses the pointer values 0..4095
as error values. I don' know if qemu can do this as well, but
you can just return have a function that returns error value, and the pointer to
nvme namespace can be returned through double pointer parameter.

> 
> > 
> > > +
> > >  static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
> > >  {
> > >      return sqid < n->params.num_queues && n->sq[sqid] != NULL ? 0 : -1;
> > > @@ -889,7 +903,7 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, uint64_t slba,
> > >      uint64_t nsze = le64_to_cpu(ns->id_ns.nsze);
> > >  
> > >      if (unlikely((slba + nlb) > nsze)) {
> > > -        block_acct_invalid(blk_get_stats(n->conf.blk),
> > > +        block_acct_invalid(blk_get_stats(ns->blk),
> > >              nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
> > >          trace_nvme_dev_err_invalid_lba_range(slba, nlb, nsze);
> > >          return NVME_LBA_RANGE | NVME_DNR;
> > > @@ -924,11 +938,12 @@ static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
> > >  
> > >  static void nvme_rw_cb(NvmeRequest *req, void *opaque)
> > >  {
> > > +    NvmeNamespace *ns = req->ns;
> > >      NvmeSQueue *sq = req->sq;
> > >      NvmeCtrl *n = sq->ctrl;
> > >      NvmeCQueue *cq = n->cq[sq->cqid];
> > >  
> > > -    trace_nvme_dev_rw_cb(nvme_cid(req), req->cmd.nsid);
> > > +    trace_nvme_dev_rw_cb(nvme_cid(req), nvme_nsid(ns));
> > >  
> > >      nvme_enqueue_req_completion(cq, req);
> > >  }
> > > @@ -1011,10 +1026,11 @@ static void nvme_aio_cb(void *opaque, int ret)
> > >  
> > >  static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  {
> > > +    NvmeNamespace *ns = req->ns;
> > >      NvmeAIO *aio = g_new0(NvmeAIO, 1);
> > >  
> > >      *aio = (NvmeAIO) {
> > > -        .blk = n->conf.blk,
> > > +        .blk = ns->blk,
> > >          .req = req,
> > >      };
> > >  
> > > @@ -1038,12 +1054,12 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      req->slba = le64_to_cpu(rw->slba);
> > >      req->nlb  = le16_to_cpu(rw->nlb) + 1;
> > >  
> > > -    trace_nvme_dev_write_zeros(nvme_cid(req), le32_to_cpu(cmd->nsid),
> > > -        req->slba, req->nlb);
> > > +    trace_nvme_dev_write_zeros(nvme_cid(req), nvme_nsid(ns), req->slba,
> > > +        req->nlb);
> > >  
> > >      status = nvme_check_bounds(n, req->slba, req->nlb, req);
> > >      if (unlikely(status)) {
> > > -        block_acct_invalid(blk_get_stats(n->conf.blk), BLOCK_ACCT_WRITE);
> > > +        block_acct_invalid(blk_get_stats(ns->blk), BLOCK_ACCT_WRITE);
> > >          return status;
> > >      }
> > >  
> > > @@ -1053,7 +1069,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      aio = g_new0(NvmeAIO, 1);
> > >  
> > >      *aio = (NvmeAIO) {
> > > -        .blk = n->conf.blk,
> > > +        .blk = ns->blk,
> > >          .offset = offset,
> > >          .len = count,
> > >          .req = req,
> > > @@ -1077,22 +1093,23 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      req->nlb  = le16_to_cpu(rw->nlb) + 1;
> > >      req->slba = le64_to_cpu(rw->slba);
> > >  
> > > -    trace_nvme_dev_rw(nvme_req_is_write(req) ? "write" : "read", req->nlb,
> > > -        req->nlb << nvme_ns_lbads(req->ns), req->slba);
> > > +    trace_nvme_dev_rw(nvme_cid(req), nvme_req_is_write(req) ? "write" : "read",
> > > +        nvme_nsid(ns), req->nlb, req->nlb << nvme_ns_lbads(ns),
> > > +        req->slba);
> > >  
> > >      status = nvme_check_rw(n, req);
> > >      if (status) {
> > > -        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > > +        block_acct_invalid(blk_get_stats(ns->blk), acct);
> > >          return status;
> > >      }
> > >  
> > >      status = nvme_map(n, cmd, req);
> > >      if (status) {
> > > -        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
> > > +        block_acct_invalid(blk_get_stats(ns->blk), acct);
> > >          return status;
> > >      }
> > >  
> > > -    nvme_rw_aio(n->conf.blk, req->slba << nvme_ns_lbads(ns), req);
> > > +    nvme_rw_aio(ns->blk, req->slba << nvme_ns_lbads(ns), req);
> > >      nvme_req_set_cb(req, nvme_rw_cb, NULL);
> > >  
> > >      return NVME_NO_COMPLETE;
> > > @@ -1105,12 +1122,11 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid),
> > >          cmd->opcode);
> > >  
> > > -    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> > > -        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> > > -        return NVME_INVALID_NSID | NVME_DNR;
> > > -    }
> > > +    req->ns = nvme_ns(n, nsid);
> > >  
> > > -    req->ns = &n->namespaces[nsid - 1];
> > > +    if (unlikely(!req->ns)) {
> > > +        return nvme_nsid_err(n, nsid);
> > > +    }
> > >  
> > >      switch (cmd->opcode) {
> > >      case NVME_CMD_FLUSH:
> > > @@ -1256,18 +1272,24 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
> > >      uint64_t units_read = 0, units_written = 0, read_commands = 0,
> > >          write_commands = 0;
> > >      NvmeSmartLog smart;
> > > -    BlockAcctStats *s;
> > >  
> > >      if (nsid && nsid != 0xffffffff) {
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > >      }
> > >  
> > > -    s = blk_get_stats(n->conf.blk);
> > > +    for (int i = 1; i <= n->num_namespaces; i++) {
> > > +        NvmeNamespace *ns = nvme_ns(n, i);
> > > +        if (!ns) {
> > > +            continue;
> > > +        }
> > >  
> > > -    units_read = s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> > > -    units_written = s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> > > -    read_commands = s->nr_ops[BLOCK_ACCT_READ];
> > > -    write_commands = s->nr_ops[BLOCK_ACCT_WRITE];
> > > +        BlockAcctStats *s = blk_get_stats(ns->blk);
> > > +
> > > +        units_read += s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> > > +        units_written += s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> > > +        read_commands += s->nr_ops[BLOCK_ACCT_READ];
> > > +        write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
> > > +    }
> > 
> > Very minor nitpick: As something minor to do in the future, is to
> > report the statistics per namespace.
> 
> In NVMe v1.4 there is no namespace specific information in the
> SMART/Health log page, so this is valid for both v1.3 and v1.4.

It does seem to be supported

"This log page is used to provide SMART and general health information. The information provided is over
the life of the controller and is retained across power cycles. To request the controller log page, the
namespace identifier specified is FFFFFFFFh. The controller may also support requesting the log page on
a per namespace basis, as indicated by bit 0 of the LPA field in the Identify Controller data structure in
Figure 247."


However I read the spec, and it does look like the IO statistics are indeed per controller,
thus you are right. Spec is misleading here.


> 
> > >  
> > >      if (off > sizeof(smart)) {
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > > @@ -1477,19 +1499,25 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  
> > >  static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  {
> > > -    NvmeNamespace *ns;
> > > +    NvmeIdNs *id_ns, inactive = { 0 };
> > >      uint32_t nsid = le32_to_cpu(cmd->nsid);
> > > +    NvmeNamespace *ns = nvme_ns(n, nsid);
> > >  
> > >      trace_nvme_dev_identify_ns(nsid);
> > >  
> > > -    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> > > -        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> > > -        return NVME_INVALID_NSID | NVME_DNR;
> > > +    if (unlikely(!ns)) {
> > > +        uint16_t status = nvme_nsid_err(n, nsid);
> > > +
> > > +        if (!nvme_status_is_error(status, NVME_INVALID_FIELD)) {
> > > +            return status;
> > > +        }
> > 
> > I really don't like checking the error value like that. 
> > It would be better IMHO to have something like
> > nvme_is_valid_ns, nvme_is_active_ns or something like that.
> > 
> 
> Fixed.
> 
> > > +
> > > +        id_ns = &inactive;
> > > +    } else {
> > > +        id_ns = &ns->id_ns;
> > >      }
> > >  
> > > -    ns = &n->namespaces[nsid - 1];
> > > -
> > > -    return nvme_dma(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), cmd,
> > > +    return nvme_dma(n, (uint8_t *) id_ns, sizeof(NvmeIdNs), cmd,
> > >          DMA_DIRECTION_FROM_DEVICE, req);
> > >  }
> > >  
> > > @@ -1505,11 +1533,11 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
> > >      trace_nvme_dev_identify_ns_list(min_nsid);
> > >  
> > >      list = g_malloc0(data_len);
> > > -    for (i = 0; i < n->num_namespaces; i++) {
> > > -        if (i < min_nsid) {
> > > +    for (i = 1; i <= n->num_namespaces; i++) {
> > > +        if (i <= min_nsid || !nvme_ns(n, i)) {
> > >              continue;
> > >          }
> > > -        list[j++] = cpu_to_le32(i + 1);
> > > +        list[j++] = cpu_to_le32(i);
> > >          if (j == data_len / sizeof(uint32_t)) {
> > >              break;
> > >          }
> > 
> > The refactoring part (removing that +1) which is very nice IMHO should move
> > to one of earlier refactoring patches.
> > 
> 
> Done.
> 
> > > @@ -1539,9 +1567,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
> > >  
> > >      trace_nvme_dev_identify_ns_descr_list(nsid);
> > >  
> > > -    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> > > -        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> > > -        return NVME_INVALID_NSID | NVME_DNR;
> > > +    if (unlikely(!nvme_ns(n, nsid))) {
> > > +        return nvme_nsid_err(n, nsid);
> > >      }
> > >  
> > >      /*
> > > @@ -1681,7 +1708,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          result = cpu_to_le32(n->features.err_rec);
> > >          break;
> > >      case NVME_VOLATILE_WRITE_CACHE:
> > > -        result = blk_enable_write_cache(n->conf.blk);
> > > +        result = cpu_to_le32(n->features.volatile_wc);
> > 
> > OK, this fixes lack of endianess conversion I pointed out in patch 12.
> > >          trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
> > >          break;
> > >      case NVME_NUMBER_OF_QUEUES:
> > > @@ -1735,6 +1762,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
> > >  
> > >  static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  {
> > > +    NvmeNamespace *ns;
> > > +
> > >      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> > >      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> > >  
> > > @@ -1766,8 +1795,19 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  
> > >          break;
> > >      case NVME_VOLATILE_WRITE_CACHE:
> > > -        blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> > > +        n->features.volatile_wc = dw11;
> > > +
> > > +        for (int i = 1; i <= n->num_namespaces; i++) {
> > > +            ns = nvme_ns(n, i);
> > > +            if (!ns) {
> > > +                continue;
> > > +            }
> > > +
> > > +            blk_set_enable_write_cache(ns->blk, dw11 & 1);
> > > +        }
> > > +
> > 
> > Features are per namespace (page 79 in the spec), so this
> > is a good candidate of per namespace feature
> > 
> 
> Some features are, but the Volatile Write Cache feature is actually not.
After looking again to the spec, I confirm that.

> 
> > >          break;
> > > +
> > >      case NVME_NUMBER_OF_QUEUES:
> > >          if (n->qs_created) {
> > >              return NVME_CMD_SEQ_ERROR | NVME_DNR;
> > > @@ -1890,9 +1930,17 @@ static void nvme_process_sq(void *opaque)
> > >  
> > >  static void nvme_clear_ctrl(NvmeCtrl *n)
> > >  {
> > > +    NvmeNamespace *ns;
> > >      int i;
> > >  
> > > -    blk_drain(n->conf.blk);
> > > +    for (i = 1; i <= n->num_namespaces; i++) {
> > > +        ns = nvme_ns(n, i);
> > > +        if (!ns) {
> > > +            continue;
> > > +        }
> > > +
> > > +        blk_drain(ns->blk);
> > > +    }
> > >  
> > >      for (i = 0; i < n->params.num_queues; i++) {
> > >          if (n->sq[i] != NULL) {
> > > @@ -1915,7 +1963,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
> > >      n->outstanding_aers = 0;
> > >      n->qs_created = false;
> > >  
> > > -    blk_flush(n->conf.blk);
> > > +    for (i = 1; i <= n->num_namespaces; i++) {
> > > +        ns = nvme_ns(n, i);
> > > +        if (!ns) {
> > > +            continue;
> > > +        }
> > > +
> > > +        blk_flush(ns->blk);
> > > +    }
> > > +
> > >      n->bar.cc = 0;
> > >  }
> > >  
> > > @@ -2335,8 +2391,8 @@ static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
> > >  {
> > >      NvmeParams *params = &n->params;
> > >  
> > > -    if (!n->conf.blk) {
> > > -        error_setg(errp, "nvme: block backend not configured");
> > > +    if (!n->namespace.blk && !n->parent_obj.qdev.id) {
> > > +        error_setg(errp, "nvme: invalid 'id' parameter");
> > 
> > Nitpick: I think that usually qemu allows user to shoot him in the foot and allow to specify a device without ID,
> > to which you can't attach devices, so I think that this check is not needed.
> > You also probably mean 'missing ID'
> > 
> 
> Right. I added a deprecation warning when the drive parameter is used
> instead.
Great!
> 
> > >          return 1;
> > >      }
> > >  
> > > @@ -2353,22 +2409,10 @@ static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
> > >      return 0;
> > >  }
> > >  
> > > -static int nvme_init_blk(NvmeCtrl *n, Error **errp)
> > > -{
> > > -    blkconf_blocksizes(&n->conf);
> > > -    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
> > > -        false, errp)) {
> > > -        return 1;
> > > -    }
> > > -
> > > -    return 0;
> > > -}
> > > -
> > >  static void nvme_init_state(NvmeCtrl *n)
> > >  {
> > > -    n->num_namespaces = 1;
> > > +    n->num_namespaces = 0;
> > 
> > And to say that again since number of valid namespaces should remain static,
> > here you should just initialize this NVME_MAX_NAMESPACES, and remove the code
> > that changes IDCTRL.NN dynamically.
> > 
> 
> Done.
> 
> > 
> > >      n->reg_size = pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4);
> > > -    n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
> > >      n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
> > >      n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
> > >  
> > > @@ -2483,12 +2527,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> > >      id->cqes = (0x4 << 4) | 0x4;
> > >      id->nn = cpu_to_le32(n->num_namespaces);
> > >      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
> > > -
> > > -
> > > -    if (blk_enable_write_cache(n->conf.blk)) {
> > > -        id->vwc = 1;
> > > -    }
> > > -
> > > +    id->vwc = 1;
> > >      id->sgls = cpu_to_le32(0x1);
> > >  
> > >      strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
> > > @@ -2509,22 +2548,25 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> > >      n->bar.intmc = n->bar.intms = 0;
> > >  }
> > >  
> > > -static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > > +int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > >  {
> > > -    int64_t bs_size;
> > > -    NvmeIdNs *id_ns = &ns->id_ns;
> > > +    uint32_t nsid = nvme_nsid(ns);
> > >  
> > > -    bs_size = blk_getlength(n->conf.blk);
> > > -    if (bs_size < 0) {
> > > -        error_setg_errno(errp, -bs_size, "blk_getlength");
> > > +    if (nsid == 0 || nsid > NVME_MAX_NAMESPACES) {
> > > +        error_setg(errp, "invalid nsid");
> > >          return 1;
> > >      }
> > 
> > As I said above it would be nice to find a valid namespace slot instead
> > of erroring out when nsid == 0.
> > Also the error message can be a bit improved IMHO.
> > 
> 
> Done.
Thanks!

> 
> > >  
> > > -    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> > > -    n->ns_size = bs_size;
> > > +    if (n->namespaces[nsid - 1]) {
> > > +        error_setg(errp, "nsid must be unique");
> > > +        return 1;
> > > +    }
> > > +
> > > +    trace_nvme_dev_register_namespace(nsid);
> > >  
> > > -    id_ns->ncap = id_ns->nuse = id_ns->nsze =
> > > -        cpu_to_le64(nvme_ns_nlbas(n, ns));
> > > +    n->namespaces[nsid - 1] = ns;
> > > +    n->num_namespaces = MAX(n->num_namespaces, nsid);
> > > +    n->id_ctrl.nn = cpu_to_le32(n->num_namespaces);
> > 
> > These should be removed once you set num_namespaces to be fixed number.
> > 
> 
> Done.
> 
> > >  
> > >      return 0;
> > >  }
> > > @@ -2532,30 +2574,31 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
> > >  static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> > >  {
> > >      NvmeCtrl *n = NVME(pci_dev);
> > > +    NvmeNamespace *ns;
> > >      Error *local_err = NULL;
> > > -    int i;
> > >  
> > >      if (nvme_check_constraints(n, &local_err)) {
> > >          error_propagate_prepend(errp, local_err, "nvme_check_constraints: ");
> > >          return;
> > >      }
> > >  
> > > +    qbus_create_inplace(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS,
> > > +        &pci_dev->qdev, n->parent_obj.qdev.id);
> > > +
> > >      nvme_init_state(n);
> > > -
> > > -    if (nvme_init_blk(n, &local_err)) {
> > > -        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
> > > -        return;
> > > -    }
> > > -
> > > -    for (i = 0; i < n->num_namespaces; i++) {
> > > -        if (nvme_init_namespace(n, &n->namespaces[i], &local_err)) {
> > > -            error_propagate_prepend(errp, local_err, "nvme_init_namespace: ");
> > > -            return;
> > > -        }
> > > -    }
> > > -
> > >      nvme_init_pci(n, pci_dev);
> > >      nvme_init_ctrl(n);
> > > +
> > > +    /* setup a namespace if the controller drive property was given */
> > > +    if (n->namespace.blk) {
> > > +        ns = &n->namespace;
> > > +        ns->params.nsid = 1;
> > > +
> > > +        if (nvme_ns_setup(n, ns, &local_err)) {
> > > +            error_propagate_prepend(errp, local_err, "nvme_ns_setup: ");
> > > +            return;
> > > +        }
> > > +    }
> > >  }
> > >  
> > >  static void nvme_exit(PCIDevice *pci_dev)
> > > @@ -2576,7 +2619,8 @@ static void nvme_exit(PCIDevice *pci_dev)
> > >  }
> > >  
> > >  static Property nvme_props[] = {
> > > -    DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
> > > +    DEFINE_BLOCK_PROPERTIES_BASE(NvmeCtrl, conf), \
> > > +    DEFINE_PROP_DRIVE("drive", NvmeCtrl, namespace.blk), \
> > >      DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > > @@ -2608,26 +2652,35 @@ static void nvme_instance_init(Object *obj)
> > >  {
> > >      NvmeCtrl *s = NVME(obj);
> > >  
> > > -    device_add_bootindex_property(obj, &s->conf.bootindex,
> > > -                                  "bootindex", "/namespace@1,0",
> > > -                                  DEVICE(obj), &error_abort);
> > > +    if (s->namespace.blk) {
> > > +        device_add_bootindex_property(obj, &s->conf.bootindex,
> > > +                                      "bootindex", "/namespace@1,0",
> > > +                                      DEVICE(obj), &error_abort);
> > > +    }
> > >  }
> > >  
> > >  static const TypeInfo nvme_info = {
> > >      .name          = TYPE_NVME,
> > >      .parent        = TYPE_PCI_DEVICE,
> > >      .instance_size = sizeof(NvmeCtrl),
> > > -    .class_init    = nvme_class_init,
> > >      .instance_init = nvme_instance_init,
> > > +    .class_init    = nvme_class_init,
> > >      .interfaces = (InterfaceInfo[]) {
> > >          { INTERFACE_PCIE_DEVICE },
> > >          { }
> > >      },
> > >  };
> > >  
> > > +static const TypeInfo nvme_bus_info = {
> > > +    .name = TYPE_NVME_BUS,
> > > +    .parent = TYPE_BUS,
> > > +    .instance_size = sizeof(NvmeBus),
> > > +};
> > > +
> > >  static void nvme_register_types(void)
> > >  {
> > >      type_register_static(&nvme_info);
> > > +    type_register_static(&nvme_bus_info);
> > >  }
> > >  
> > >  type_init(nvme_register_types)
> > > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > > index 3319f8edd7e1..c3cef0f024da 100644
> > > --- a/hw/block/nvme.h
> > > +++ b/hw/block/nvme.h
> > > @@ -2,6 +2,9 @@
> > >  #define HW_NVME_H
> > >  
> > >  #include "block/nvme.h"
> > > +#include "nvme-ns.h"
> > > +
> > > +#define NVME_MAX_NAMESPACES 256
> > >  
> > >  #define DEFINE_NVME_PROPERTIES(_state, _props) \
> > >      DEFINE_PROP_STRING("serial", _state, _props.serial), \
> > > @@ -108,26 +111,6 @@ typedef struct NvmeCQueue {
> > >      QTAILQ_HEAD(, NvmeRequest) req_list;
> > >  } NvmeCQueue;
> > >  
> > > -typedef struct NvmeNamespace {
> > > -    NvmeIdNs        id_ns;
> > > -} NvmeNamespace;
> > > -
> > > -static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
> > > -{
> > > -    NvmeIdNs *id_ns = &ns->id_ns;
> > > -    return id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
> > > -}
> > > -
> > > -static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
> > > -{
> > > -    return nvme_ns_lbaf(ns).ds;
> > > -}
> > > -
> > > -static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
> > > -{
> > > -    return 1 << nvme_ns_lbads(ns);
> > > -}
> > > -
> > >  typedef enum NvmeAIOOp {
> > >      NVME_AIO_OPC_NONE         = 0x0,
> > >      NVME_AIO_OPC_FLUSH        = 0x1,
> > > @@ -182,6 +165,13 @@ static inline bool nvme_req_is_write(NvmeRequest *req)
> > >      }
> > >  }
> > >  
> > > +#define TYPE_NVME_BUS "nvme-bus"
> > > +#define NVME_BUS(obj) OBJECT_CHECK(NvmeBus, (obj), TYPE_NVME_BUS)
> > > +
> > > +typedef struct NvmeBus {
> > > +    BusState parent_bus;
> > > +} NvmeBus;
> > > +
> > >  #define TYPE_NVME "nvme"
> > >  #define NVME(obj) \
> > >          OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
> > > @@ -191,8 +181,9 @@ typedef struct NvmeCtrl {
> > >      MemoryRegion iomem;
> > >      MemoryRegion ctrl_mem;
> > >      NvmeBar      bar;
> > > -    BlockConf    conf;
> > >      NvmeParams   params;
> > > +    NvmeBus      bus;
> > > +    BlockConf    conf;
> > >  
> > >      bool        qs_created;
> > >      uint32_t    page_size;
> > > @@ -203,7 +194,6 @@ typedef struct NvmeCtrl {
> > >      uint32_t    reg_size;
> > >      uint32_t    num_namespaces;
> > >      uint32_t    max_q_ents;
> > > -    uint64_t    ns_size;
> > >      uint8_t     outstanding_aers;
> > >      uint32_t    cmbsz;
> > >      uint32_t    cmbloc;
> > > @@ -219,7 +209,8 @@ typedef struct NvmeCtrl {
> > >      QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
> > >      int         aer_queued;
> > >  
> > > -    NvmeNamespace   *namespaces;
> > > +    NvmeNamespace   namespace;
> > > +    NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES];
> > >      NvmeSQueue      **sq;
> > >      NvmeCQueue      **cq;
> > >      NvmeSQueue      admin_sq;
> > > @@ -228,9 +219,13 @@ typedef struct NvmeCtrl {
> > >      NvmeFeatureVal  features;
> > >  } NvmeCtrl;
> > >  
> > > -static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> > > +static inline NvmeNamespace *nvme_ns(NvmeCtrl *n, uint32_t nsid)
> > >  {
> > > -    return n->ns_size >> nvme_ns_lbads(ns);
> > > +    if (!nsid || nsid > n->num_namespaces) {
> > > +        return NULL;
> > > +    }
> > > +
> > > +    return n->namespaces[nsid - 1];
> > >  }
> > >  
> > >  static inline uint16_t nvme_cid(NvmeRequest *req)
> > > @@ -253,4 +248,6 @@ static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
> > >      return req->sq->ctrl;
> > >  }
> > >  
> > > +int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp);
> > > +
> > >  #endif /* HW_NVME_H */
> > > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > > index 81d69e15fc32..aaf1fcda7923 100644
> > > --- a/hw/block/trace-events
> > > +++ b/hw/block/trace-events
> > > @@ -29,6 +29,7 @@ hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t secs, int t
> > >  
> > >  # nvme.c
> > >  # nvme traces for successful events
> > > +nvme_dev_register_namespace(uint32_t nsid) "nsid %"PRIu32""
> > >  nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
> > >  nvme_dev_irq_pin(void) "pulsing IRQ pin"
> > >  nvme_dev_irq_masked(void) "IRQ is masked"
> > > @@ -38,7 +39,7 @@ nvme_dev_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) "cid %"P
> > >  nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count
> > > %"PRIu64" opc \"%s\" req %p"
> > >  nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
> > >  nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
> > > -nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
> > > +nvme_dev_rw(uint16_t cid, const char *verb, uint32_t nsid, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" %s nsid %"PRIu32" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
> > >  nvme_dev_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
> > >  nvme_dev_write_zeros(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
> > >  nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16",
> > > qflags=%"PRIu16""
> > > @@ -94,7 +95,8 @@ nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or no
> > >  nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
> > >  nvme_dev_err_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred"
> > >  nvme_dev_err_invalid_prp(void) "invalid PRP"
> > > -nvme_dev_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not within 1-%u"
> > > +nvme_dev_err_invalid_ns(uint32_t nsid, uint32_t nn) "nsid %"PRIu32" nn %"PRIu32""
> > > +nvme_dev_err_inactive_ns(uint32_t nsid, uint32_t nn) "nsid %"PRIu32" nn %"PRIu32""
> > >  nvme_dev_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
> > >  nvme_dev_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
> > >  nvme_dev_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
> > 
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 
> > 
> 
> 






