Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F28FC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF0020719
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeedrW1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF0020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGUeO-0004Ts-6I
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 17:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGUdS-000447-Qv
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGUdO-0008Fo-UO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:29:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGUdO-0008Fc-Od
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584998961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJMjo2Rtjqhg+0BYwUyARJEnAY+ZSx+IpHcmv33Sm2E=;
 b=aeedrW1mA3hf9HfvcL5LTTA0bwxk9KpzuKO4gVu/909eFAcp5zK7MDggEX1enhLHgSkAZc
 hfxXsA5q3SHkFlFbncqa/8tmQUsIMfFuP91tFSHhh+dW9m65HxItSfepr6xuzoX36N6aMo
 RL/iR9uvrxq0UpTiWrxa2WrPEoQvMWw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113--0yRr61XOQKr4kHHVUiamQ-1; Mon, 23 Mar 2020 17:29:20 -0400
X-MC-Unique: -0yRr61XOQKr4kHHVUiamQ-1
Received: by mail-wm1-f69.google.com with SMTP id s15so466726wmc.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 14:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7WWTe2Ledqtg2EV1DJLnUZw7ctgYMxsmuQiDXwMgqRg=;
 b=FhhCt/wHIxSbUPfh4UVXye0S3NVl4gBVNmVzPElcN/ikaV2GWcCicGApy0Q5yZxl5G
 Q7mQJHfR0E/mqnqZ9RChf5Uyw6sBrg+JWhb9dZhRdKdF/MIMFUOmPu8JO4pY8rku2l/i
 KramS2pa/4NXkWR3Jw3nV7GELhCTaQ1vlBSDFf6w/CGcxy1QQI8D5GU9JXcRis9mzB2t
 aJZRwevWqgD/alZIYMMRzeAdp1poJRzGFjnQrhpDTvyHZTSkaef4NfTJ4d27ynGig6lm
 Y4oGpCczqnpH/cfLR+h+layxnXLgQpnOAzbtrAl0cRernNFG9m1ntQAeTzKZ4WvZZivb
 Pwrg==
X-Gm-Message-State: ANhLgQ3MAKAJVWfH9vapq906GhBOTSKogxcAxoQ+58MrrhCdTf8FlXlr
 ZjB3oL3MuBOGJ1krjOibYtXr2waWSsZf4A919OtpvokyH/mdgiCvZ0fRlLlbnlphIuz3XIrEJnD
 dBHsxKpOLxW5hTOI=
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr1459707wma.122.1584998956573; 
 Mon, 23 Mar 2020 14:29:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vssZHuLhIG36CGn4z9obg1vcL570yDxmFjr9wBkFe0tlIZ4dsIUqa/D1XE8Vasz2qGwGGZBFA==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr1459672wma.122.1584998956241; 
 Mon, 23 Mar 2020 14:29:16 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id g7sm25817035wrq.21.2020.03.23.14.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 14:29:15 -0700 (PDT)
Date: Mon, 23 Mar 2020 17:29:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 07/22] intel_iommu: add set/unset_iommu_context callback
Message-ID: <20200323212911.GQ127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-8-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-8-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:04AM -0700, Liu Yi L wrote:
> This patch adds set/unset_iommu_context() impelementation in Intel
> vIOMMU. For Intel platform, pass-through modules (e.g. VFIO) could
> set HostIOMMUContext to Intel vIOMMU emulator.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c         | 70 +++++++++++++++++++++++++++++++++++++=
++----
>  include/hw/i386/intel_iommu.h | 17 +++++++++--
>  2 files changed, 80 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4b22910..8d9204f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3354,23 +3354,35 @@ static const MemoryRegionOps vtd_mem_ir_ops =3D {
>      },
>  };
> =20
> -VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int de=
vfn)
> +/**
> + * Fetch a VTDBus instance for given PCIBus. If no existing instance,
> + * allocate one.
> + */
> +static VTDBus *vtd_find_add_bus(IntelIOMMUState *s, PCIBus *bus)
>  {
>      uintptr_t key =3D (uintptr_t)bus;
>      VTDBus *vtd_bus =3D g_hash_table_lookup(s->vtd_as_by_busptr, &key);
> -    VTDAddressSpace *vtd_dev_as;
> -    char name[128];
> =20
>      if (!vtd_bus) {
>          uintptr_t *new_key =3D g_malloc(sizeof(*new_key));
>          *new_key =3D (uintptr_t)bus;
>          /* No corresponding free() */
> -        vtd_bus =3D g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *)=
 * \
> -                            PCI_DEVFN_MAX);
> +        vtd_bus =3D g_malloc0(sizeof(VTDBus) + PCI_DEVFN_MAX * \
> +                            (sizeof(VTDAddressSpace *) + \
> +                             sizeof(VTDHostIOMMUContext *)));

IIRC I commented on this before...  Shouldn't sizeof(VTDBus) be
enough?

>          vtd_bus->bus =3D bus;
>          g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
>      }
> +    return vtd_bus;
> +}
> +
> +VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int de=
vfn)
> +{
> +    VTDBus *vtd_bus;
> +    VTDAddressSpace *vtd_dev_as;
> +    char name[128];
> =20
> +    vtd_bus =3D vtd_find_add_bus(s, bus);
>      vtd_dev_as =3D vtd_bus->dev_as[devfn];
> =20
>      if (!vtd_dev_as) {
> @@ -3436,6 +3448,52 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *=
s, PCIBus *bus, int devfn)
>      return vtd_dev_as;
>  }
> =20
> +static int vtd_dev_set_iommu_context(PCIBus *bus, void *opaque,
> +                                     int devfn,
> +                                     HostIOMMUContext *host_icx)
> +{
> +    IntelIOMMUState *s =3D opaque;
> +    VTDBus *vtd_bus;
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +
> +    assert(0 <=3D devfn && devfn < PCI_DEVFN_MAX);
> +
> +    vtd_bus =3D vtd_find_add_bus(s, bus);
> +
> +    vtd_iommu_lock(s);
> +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> +
> +    if (!vtd_dev_icx) {

We can assert this directly I think, in case we accidentally set the
context twice without notice.

> +        vtd_bus->dev_icx[devfn] =3D vtd_dev_icx =3D
> +                    g_malloc0(sizeof(VTDHostIOMMUContext));
> +        vtd_dev_icx->vtd_bus =3D vtd_bus;
> +        vtd_dev_icx->devfn =3D (uint8_t)devfn;
> +        vtd_dev_icx->iommu_state =3D s;
> +        vtd_dev_icx->host_icx =3D host_icx;
> +    }
> +    vtd_iommu_unlock(s);
> +
> +    return 0;
> +}
> +
> +static void vtd_dev_unset_iommu_context(PCIBus *bus, void *opaque, int d=
evfn)
> +{
> +    IntelIOMMUState *s =3D opaque;
> +    VTDBus *vtd_bus;
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +
> +    assert(0 <=3D devfn && devfn < PCI_DEVFN_MAX);
> +
> +    vtd_bus =3D vtd_find_add_bus(s, bus);
> +
> +    vtd_iommu_lock(s);
> +
> +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> +    g_free(vtd_dev_icx);

Better set it as NULL, and can also drop vtd_dev_icx which seems
meaningless..

       g_free(vtd_bus->dev_icx[devfn]);
       vtd_bus->dev_icx[devfn] =3D NULL;

> +
> +    vtd_iommu_unlock(s);
> +}
> +
>  static uint64_t get_naturally_aligned_size(uint64_t start,
>                                             uint64_t size, int gaw)
>  {
> @@ -3731,6 +3789,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus=
, void *opaque, int devfn)
> =20
>  static PCIIOMMUOps vtd_iommu_ops =3D {
>      .get_address_space =3D vtd_host_dma_iommu,
> +    .set_iommu_context =3D vtd_dev_set_iommu_context,
> +    .unset_iommu_context =3D vtd_dev_unset_iommu_context,
>  };
> =20
>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index 3870052..9b4fc0a 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -64,6 +64,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
>  typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
>  typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
>  typedef struct VTDPASIDEntry VTDPASIDEntry;
> +typedef struct VTDHostIOMMUContext VTDHostIOMMUContext;
> =20
>  /* Context-Entry */
>  struct VTDContextEntry {
> @@ -112,10 +113,20 @@ struct VTDAddressSpace {
>      IOVATree *iova_tree;          /* Traces mapped IOVA ranges */
>  };
> =20
> +struct VTDHostIOMMUContext {
> +    VTDBus *vtd_bus;
> +    uint8_t devfn;
> +    HostIOMMUContext *host_icx;
> +    IntelIOMMUState *iommu_state;
> +};
> +
>  struct VTDBus {
> -    PCIBus* bus;=09=09/* A reference to the bus to provide translation f=
or */
> +    /* A reference to the bus to provide translation for */
> +    PCIBus *bus;
>      /* A table of VTDAddressSpace objects indexed by devfn */
> -    VTDAddressSpace *dev_as[];
> +    VTDAddressSpace *dev_as[PCI_DEVFN_MAX];
> +    /* A table of VTDHostIOMMUContext objects indexed by devfn */
> +    VTDHostIOMMUContext *dev_icx[PCI_DEVFN_MAX];
>  };
> =20
>  struct VTDIOTLBEntry {
> @@ -271,6 +282,8 @@ struct IntelIOMMUState {
>      /*
>       * Protects IOMMU states in general.  Currently it protects the
>       * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace=
.
> +     * Protect the update/usage of HostIOMMUContext pointer cached in
> +     * VTDBus->dev_icx array as array elements may be updated by hotplug

I think the context update does not need to be updated, because they
should always be with the BQL, right?

Thanks,

>       */
>      QemuMutex iommu_lock;
>  };
> --=20
> 2.7.4
>=20

--=20
Peter Xu


