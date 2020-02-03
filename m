Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD664C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833C82087E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdNUFxWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833C82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyc7l-0002sw-O7
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iyc6S-0002GD-6f
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iyc6M-0007yT-Nh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:49:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iyc6M-0007y2-GY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580737762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47S9O4DAxhbP6MHArnPE01W78bu5ofRMgpjC3jpOPYE=;
 b=cdNUFxWuy0y5iOkGXXmFyoNk5no7smSStLWbXrPw2j2H6Fa56eWBUuM9tUlZ5WK7wJxNic
 JhzbyB6Hux5KMF/ekaxYhG+zjPjTaTBSClnffHk2FzPBHHtSoQn8MCNovyNh8AVBag4jL2
 y0YV4WqnpQaUUSjwwwZEyR06K08dmik=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-4yO8gFD4NK6Dzqvt4PuIcQ-1; Mon, 03 Feb 2020 08:49:20 -0500
Received: by mail-qt1-f199.google.com with SMTP id b5so9965142qtt.10
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t9MarpD29wT9Bsiulce0VeIcxnM1H/T+zkL7kldMlgM=;
 b=pmQJJ85JUyVe+FVxxPacGO2KMsEjkKPl0Rwk/DJUe1VTBfub6aaTbz6CI0wbEI7wdk
 wUCAm7+en8rmDB4iKhSPnzYux875xaWCF+1tTVoX0B3UYsGfiJmAcL/c3S/WT3GjRMDq
 Sf4LO2FzHFJVThYhU4CyzEGYJIb6m5dwuer4KSJtQTGQzqxyNxvxawRA9dVKvKovlZ8G
 77ChWK7WB8gzW9Bfo7GYn7HVAfZGNBV3lbHigZjltTkxUofSP2RO6Yha+8OK4rTJVZ7o
 lt3vHDrQ3iEOi5VmG1M05todm1ffSDeGjmh5dzRmySyZVnn/pApSj1x6JPHpbtlzHHR7
 n0AA==
X-Gm-Message-State: APjAAAWHi2YOw+oSmLJNw2gOpjH10a4qDAZSsWurZTwhT5J9EyOW7n3P
 P+DzH6RK0yXS10Lg6eUzryQ4dr3H0bl05IvAk+he2qhV3PD7CCOh9ESnHBBIh47Z8iki18T29Qt
 /2OR34qEm899MXxw=
X-Received: by 2002:ac8:3735:: with SMTP id o50mr23253332qtb.252.1580737759588; 
 Mon, 03 Feb 2020 05:49:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTGRIaKD2OZQDppwksY2HGvtD8RNuVcyBOl6MB/uTtEXMEyoeWH5qk7Dt3BkMLhcY386AGQw==
X-Received: by 2002:ac8:3735:: with SMTP id o50mr23253303qtb.252.1580737759138; 
 Mon, 03 Feb 2020 05:49:19 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id h9sm9547767qtq.61.2020.02.03.05.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:49:18 -0800 (PST)
Date: Mon, 3 Feb 2020 08:49:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v13 03/10] virtio-iommu: Implement attach/detach command
Message-ID: <20200203134915.GA155875@xz-x1>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-4-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200125171955.12825-4-eric.auger@redhat.com>
X-MC-Unique: 4yO8gFD4NK6Dzqvt4PuIcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 25, 2020 at 06:19:48PM +0100, Eric Auger wrote:
> This patch implements the endpoint attach/detach to/from
> a domain.
>=20
> Domain and endpoint internal datatypes are introduced.
> Both are stored in RB trees. The domain owns a list of
> endpoints attached to it. Also helpers to get/put
> end points and domains are introduced.
>=20
> As for the IOMMU memory regions, a callback is called on
> PCI bus enumeration that initializes for a given device
> on the bus hierarchy an IOMMU memory region. The PCI bus
> hierarchy is stored locally in IOMMUPciBus and IOMMUDevice
> objects.
>=20
> At the time of the enumeration, the bus number may not be
> computed yet.
>=20
> So operations that will need to retrieve the IOMMUdevice
> and its IOMMU memory region from the bus number and devfn,
> once the bus number is garanteed to be frozen, use an array
> of IOMMUPciBus, lazily populated.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v12 -> v13:
> - squashed v12 4, 5, 6 into this patch
> - rename virtio_iommu_get_sid into virtio_iommu_get_bdf
>=20
> v11 -> v12:
> - check the device is protected by the iommu on attach
> - on detach, check the domain id the device is attached to matches
>   the one used in the detach command
> - fix mapping ref counter and destroy the domain when no end-points
>   are attached anymore
> ---
>  hw/virtio/trace-events           |   6 +
>  hw/virtio/virtio-iommu.c         | 315 ++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-iommu.h |   3 +
>  3 files changed, 322 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index f7141aa2f6..15595f8cd7 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -64,3 +64,9 @@ virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id)=
 "domain=3D%d endpoint=3D%d"
>  virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d end=
point=3D%d"
>  virtio_iommu_map(uint32_t domain_id, uint64_t virt_start, uint64_t virt_=
end, uint64_t phys_start, uint32_t flags) "domain=3D%d virt_start=3D0x%"PRI=
x64" virt_end=3D0x%"PRIx64 " phys_start=3D0x%"PRIx64" flags=3D%d"
>  virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_start, uint64_t vir=
t_end) "domain=3D%d virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
> +virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, in=
t flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
> +virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
> +virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=3D%d"
> +virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
> +virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
> +virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 9d1b997df7..e5cc94138b 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -23,6 +23,8 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio.h"
>  #include "sysemu/kvm.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "trace.h"
> =20
>  #include "standard-headers/linux/virtio_ids.h"
> @@ -30,19 +32,234 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pci.h"
> =20
>  /* Max size */
>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
> =20
> +typedef struct VirtIOIOMMUDomain {
> +    uint32_t id;
> +    GTree *mappings;
> +    QLIST_HEAD(, VirtIOIOMMUEndpoint) endpoint_list;
> +} VirtIOIOMMUDomain;
> +
> +typedef struct VirtIOIOMMUEndpoint {
> +    uint32_t id;
> +    VirtIOIOMMUDomain *domain;
> +    QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
> +} VirtIOIOMMUEndpoint;
> +
> +typedef struct VirtIOIOMMUInterval {
> +    uint64_t low;
> +    uint64_t high;
> +} VirtIOIOMMUInterval;
> +
> +static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
> +{
> +    return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
> +}
> +
> +/**
> + * The bus number is used for lookup when SID based operations occur.
> + * In that case we lazily populate the IOMMUPciBus array from the bus ha=
sh
> + * table. At the time the IOMMUPciBus is created (iommu_find_add_as), th=
e bus
> + * numbers may not be always initialized yet.
> + */
> +static IOMMUPciBus *iommu_find_iommu_pcibus(VirtIOIOMMU *s, uint8_t bus_=
num)
> +{
> +    IOMMUPciBus *iommu_pci_bus =3D s->iommu_pcibus_by_bus_num[bus_num];
> +
> +    if (!iommu_pci_bus) {
> +        GHashTableIter iter;
> +
> +        g_hash_table_iter_init(&iter, s->as_by_busptr);
> +        while (g_hash_table_iter_next(&iter, NULL, (void **)&iommu_pci_b=
us)) {
> +            if (pci_bus_num(iommu_pci_bus->bus) =3D=3D bus_num) {
> +                s->iommu_pcibus_by_bus_num[bus_num] =3D iommu_pci_bus;
> +                return iommu_pci_bus;
> +            }
> +        }
> +        return NULL;
> +    }
> +    return iommu_pci_bus;
> +}
> +
> +static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
> +{
> +    uint8_t bus_n, devfn;
> +    IOMMUPciBus *iommu_pci_bus;
> +    IOMMUDevice *dev;
> +
> +    bus_n =3D PCI_BUS_NUM(sid);
> +    iommu_pci_bus =3D iommu_find_iommu_pcibus(s, bus_n);
> +    if (iommu_pci_bus) {
> +        devfn =3D sid & PCI_DEVFN_MAX;
> +        dev =3D iommu_pci_bus->pbdev[devfn];
> +        if (dev) {
> +            return &dev->iommu_mr;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user=
_data)
> +{
> +    VirtIOIOMMUInterval *inta =3D (VirtIOIOMMUInterval *)a;
> +    VirtIOIOMMUInterval *intb =3D (VirtIOIOMMUInterval *)b;
> +
> +    if (inta->high < intb->low) {
> +        return -1;
> +    } else if (intb->high < inta->low) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint=
 *ep)
> +{
> +    QLIST_REMOVE(ep, next);
> +    g_tree_unref(ep->domain->mappings);

Here domain->mapping is unreferenced for each endpoint, while at [1]
below you only reference the domain->mappings if it's the first
endpoint.  Is that problematic?

> +    ep->domain =3D NULL;
> +}
> +
> +static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> +                                                      uint32_t ep_id)
> +{
> +    VirtIOIOMMUEndpoint *ep;
> +
> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
> +    if (ep) {
> +        return ep;
> +    }
> +    if (!virtio_iommu_mr(s, ep_id)) {
> +        return NULL;
> +    }
> +    ep =3D g_malloc0(sizeof(*ep));
> +    ep->id =3D ep_id;
> +    trace_virtio_iommu_get_endpoint(ep_id);
> +    g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
> +    return ep;
> +}
> +
> +static void virtio_iommu_put_endpoint(gpointer data)
> +{
> +    VirtIOIOMMUEndpoint *ep =3D (VirtIOIOMMUEndpoint *)data;
> +
> +    assert(!ep->domain);
> +
> +    trace_virtio_iommu_put_endpoint(ep->id);
> +    g_free(ep);
> +}
> +
> +static VirtIOIOMMUDomain *virtio_iommu_get_domain(VirtIOIOMMU *s,
> +                                                  uint32_t domain_id)
> +{
> +    VirtIOIOMMUDomain *domain;
> +
> +    domain =3D g_tree_lookup(s->domains, GUINT_TO_POINTER(domain_id));
> +    if (domain) {
> +        return domain;
> +    }
> +    domain =3D g_malloc0(sizeof(*domain));
> +    domain->id =3D domain_id;
> +    domain->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cmp,
> +                                   NULL, (GDestroyNotify)g_free,
> +                                   (GDestroyNotify)g_free);
> +    g_tree_insert(s->domains, GUINT_TO_POINTER(domain_id), domain);
> +    QLIST_INIT(&domain->endpoint_list);
> +    trace_virtio_iommu_get_domain(domain_id);
> +    return domain;
> +}
> +
> +static void virtio_iommu_put_domain(gpointer data)
> +{
> +    VirtIOIOMMUDomain *domain =3D (VirtIOIOMMUDomain *)data;
> +    VirtIOIOMMUEndpoint *iter, *tmp;
> +
> +    QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
> +        virtio_iommu_detach_endpoint_from_domain(iter);
> +    }

Do you need to destroy the domain->mappings here?  Is it leaked?

> +    trace_virtio_iommu_put_domain(domain->id);
> +    g_free(domain);
> +}
> +
> +static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
> +                                              int devfn)
> +{
> +    VirtIOIOMMU *s =3D opaque;
> +    IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, bus);
> +    static uint32_t mr_index;
> +    IOMMUDevice *sdev;
> +
> +    if (!sbus) {
> +        sbus =3D g_malloc0(sizeof(IOMMUPciBus) +
> +                         sizeof(IOMMUDevice *) * PCI_DEVFN_MAX);
> +        sbus->bus =3D bus;
> +        g_hash_table_insert(s->as_by_busptr, bus, sbus);
> +    }
> +
> +    sdev =3D sbus->pbdev[devfn];
> +    if (!sdev) {
> +        char *name =3D g_strdup_printf("%s-%d-%d",
> +                                     TYPE_VIRTIO_IOMMU_MEMORY_REGION,
> +                                     mr_index++, devfn);
> +        sdev =3D sbus->pbdev[devfn] =3D g_malloc0(sizeof(IOMMUDevice));
> +
> +        sdev->viommu =3D s;
> +        sdev->bus =3D bus;
> +        sdev->devfn =3D devfn;
> +
> +        trace_virtio_iommu_init_iommu_mr(name);
> +
> +        memory_region_init_iommu(&sdev->iommu_mr, sizeof(sdev->iommu_mr)=
,
> +                                 TYPE_VIRTIO_IOMMU_MEMORY_REGION,
> +                                 OBJECT(s), name,
> +                                 UINT64_MAX);
> +        address_space_init(&sdev->as,
> +                           MEMORY_REGION(&sdev->iommu_mr), TYPE_VIRTIO_I=
OMMU);
> +        g_free(name);
> +    }
> +    return &sdev->as;
> +}
> +
>  static int virtio_iommu_attach(VirtIOIOMMU *s,
>                                 struct virtio_iommu_req_attach *req)
>  {
>      uint32_t domain_id =3D le32_to_cpu(req->domain);
>      uint32_t ep_id =3D le32_to_cpu(req->endpoint);
> +    VirtIOIOMMUDomain *domain;
> +    VirtIOIOMMUEndpoint *ep;
> =20
>      trace_virtio_iommu_attach(domain_id, ep_id);
> =20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    ep =3D virtio_iommu_get_endpoint(s, ep_id);
> +    if (!ep) {
> +        return VIRTIO_IOMMU_S_NOENT;
> +    }
> +
> +    if (ep->domain) {
> +        VirtIOIOMMUDomain *previous_domain =3D ep->domain;
> +        /*
> +         * the device is already attached to a domain,
> +         * detach it first
> +         */
> +        virtio_iommu_detach_endpoint_from_domain(ep);
> +        if (QLIST_EMPTY(&previous_domain->endpoint_list)) {
> +            g_tree_remove(s->domains, GUINT_TO_POINTER(previous_domain->=
id));
> +        }
> +    }
> +
> +    domain =3D virtio_iommu_get_domain(s, domain_id);
> +    if (!QLIST_EMPTY(&domain->endpoint_list)) {
> +        g_tree_ref(domain->mappings);

[1]

> +    }
> +    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
> +
> +    ep->domain =3D domain;
> +
> +    return VIRTIO_IOMMU_S_OK;
>  }
> =20
>  static int virtio_iommu_detach(VirtIOIOMMU *s,
> @@ -50,10 +267,34 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
>  {
>      uint32_t domain_id =3D le32_to_cpu(req->domain);
>      uint32_t ep_id =3D le32_to_cpu(req->endpoint);
> +    VirtIOIOMMUDomain *domain;
> +    VirtIOIOMMUEndpoint *ep;
> =20
>      trace_virtio_iommu_detach(domain_id, ep_id);
> =20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
> +    if (!ep) {
> +        return VIRTIO_IOMMU_S_NOENT;
> +    }
> +
> +    domain =3D ep->domain;
> +
> +    if (!domain || domain->id !=3D domain_id) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +
> +    virtio_iommu_detach_endpoint_from_domain(ep);
> +
> +    /*
> +     * when the last EP is detached, simply remove the domain for
> +     * the domain list and destroy it. Note its mappings were already
> +     * freed by the ref count mechanism. Next operation involving
> +     * the same domain id will re-create one domain object.
> +     */
> +    if (QLIST_EMPTY(&domain->endpoint_list)) {
> +        g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
> +    }
> +    return VIRTIO_IOMMU_S_OK;
>  }
> =20
>  static int virtio_iommu_map(VirtIOIOMMU *s,
> @@ -172,6 +413,27 @@ out:
>      }
>  }
> =20
> +static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwadd=
r addr,
> +                                            IOMMUAccessFlags flag,
> +                                            int iommu_idx)
> +{
> +    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> +    uint32_t sid;
> +
> +    IOMMUTLBEntry entry =3D {
> +        .target_as =3D &address_space_memory,
> +        .iova =3D addr,
> +        .translated_addr =3D addr,
> +        .addr_mask =3D ~(hwaddr)0,
> +        .perm =3D IOMMU_NONE,
> +    };
> +
> +    sid =3D virtio_iommu_get_bdf(sdev);
> +
> +    trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
> +    return entry;
> +}
> +
>  static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t *config_=
data)
>  {
>      VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
> @@ -218,6 +480,13 @@ static const VMStateDescription vmstate_virtio_iommu=
_device =3D {
>      .unmigratable =3D 1,
>  };
> =20
> +static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data=
)
> +{
> +    guint ua =3D GPOINTER_TO_UINT(a);
> +    guint ub =3D GPOINTER_TO_UINT(b);
> +    return (ua > ub) - (ua < ub);
> +}
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -226,6 +495,8 @@ static void virtio_iommu_device_realize(DeviceState *=
dev, Error **errp)
>      virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
>                  sizeof(struct virtio_iommu_config));
> =20
> +    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_=
num));
> +
>      s->req_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
>                               virtio_iommu_handle_command);
>      s->event_vq =3D virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NU=
LL);
> @@ -244,18 +515,43 @@ static void virtio_iommu_device_realize(DeviceState=
 *dev, Error **errp)
>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
> =20
>      qemu_mutex_init(&s->mutex);
> +
> +    s->as_by_busptr =3D g_hash_table_new_full(NULL, NULL, NULL, g_free);
> +
> +    if (s->primary_bus) {
> +        pci_setup_iommu(s->primary_bus, virtio_iommu_find_add_as, s);
> +    } else {
> +        error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!")=
;
> +    }
>  }
> =20
>  static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp=
)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
> +
> +    g_tree_destroy(s->domains);
> +    g_tree_destroy(s->endpoints);
> =20
>      virtio_cleanup(vdev);
>  }
> =20
>  static void virtio_iommu_device_reset(VirtIODevice *vdev)
>  {
> +    VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
> +
>      trace_virtio_iommu_device_reset();
> +
> +    if (s->domains) {
> +        g_tree_destroy(s->domains);
> +    }
> +    if (s->endpoints) {
> +        g_tree_destroy(s->endpoints);
> +    }

Is it a must to free domians first then the endpoints here?

I see that virtio_iommu_put_domain() will unlink the domains and
endpoints, then in virtio_iommu_put_endpoint() you assert that
ep->domain is NULL.  It's fine but I'm a bit curious on why not call
virtio_iommu_detach_endpoint_from_domain() too when put the endpoint
then iiuc we don't even need this ordering constraint.  Though in
virtio_iommu_detach_endpoint_from_domain() we should also need:

  if (!ep->domain)
    return;

Otherwise it looks good to me.  Thanks,

> +    s->domains =3D g_tree_new_full((GCompareDataFunc)int_cmp,
> +                                 NULL, NULL, virtio_iommu_put_domain);
> +    s->endpoints =3D g_tree_new_full((GCompareDataFunc)int_cmp,
> +                                   NULL, NULL, virtio_iommu_put_endpoint=
);
>  }
> =20
>  static void virtio_iommu_set_status(VirtIODevice *vdev, uint8_t status)
> @@ -301,6 +597,14 @@ static void virtio_iommu_class_init(ObjectClass *kla=
ss, void *data)
>      vdc->vmsd =3D &vmstate_virtio_iommu_device;
>  }
> =20
> +static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
> +                                                  void *data)
> +{
> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate =3D virtio_iommu_translate;
> +}
> +
>  static const TypeInfo virtio_iommu_info =3D {
>      .name =3D TYPE_VIRTIO_IOMMU,
>      .parent =3D TYPE_VIRTIO_DEVICE,
> @@ -309,9 +613,16 @@ static const TypeInfo virtio_iommu_info =3D {
>      .class_init =3D virtio_iommu_class_init,
>  };
> =20
> +static const TypeInfo virtio_iommu_memory_region_info =3D {
> +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> +    .name =3D TYPE_VIRTIO_IOMMU_MEMORY_REGION,
> +    .class_init =3D virtio_iommu_memory_region_class_init,
> +};
> +
>  static void virtio_register_types(void)
>  {
>      type_register_static(&virtio_iommu_info);
> +    type_register_static(&virtio_iommu_memory_region_info);
>  }
> =20
>  type_init(virtio_register_types)
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-=
iommu.h
> index 041f2c9390..2a2c2ecf83 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -28,6 +28,8 @@
>  #define VIRTIO_IOMMU(obj) \
>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
> =20
> +#define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
> +
>  typedef struct IOMMUDevice {
>      void         *viommu;
>      PCIBus       *bus;
> @@ -48,6 +50,7 @@ typedef struct VirtIOIOMMU {
>      struct virtio_iommu_config config;
>      uint64_t features;
>      GHashTable *as_by_busptr;
> +    IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>      PCIBus *primary_bus;
>      GTree *domains;
>      QemuMutex mutex;
> --=20
> 2.20.1
>=20

--=20
Peter Xu


