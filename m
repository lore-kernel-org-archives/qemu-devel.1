Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1350BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF68420719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILuIGB2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF68420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnrV-0000Vf-Py
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGnqk-0008Ps-Op
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGnqi-0007QE-Pe
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:00:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGnqi-0007Pz-KH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585072824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWe4YHBsSJyTtbnQlK43zz717HZb5au2X+W6trTiG8o=;
 b=ILuIGB2vc/RYWKr07Zb6o/GkBEQ/i4lIULcHpGUYsR3dXFwnrlNvdvyF8CcniqNlPz3lez
 4RFm1PzzGtx7nrdksIi0JYltU0z5CFAOvreoSAoUFF0jWBc8f+CYMEZ678mYurCABa8ubt
 RDN02cZewKtPyrmLjyV+wkfMId+n3S0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-W_r9dX3eNZKjzy-DEoXEqA-1; Tue, 24 Mar 2020 14:00:22 -0400
X-MC-Unique: W_r9dX3eNZKjzy-DEoXEqA-1
Received: by mail-wr1-f72.google.com with SMTP id w12so2957757wrl.23
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nb4bEMPfjRxTaIrjTk0Rhq1s2Rfj5iijs2kFV+3ZVgU=;
 b=b2HkWeKLQ9SBT1PRbQHjMI/EH6yNDz7IDpejmmdAm8JkOj2zBzNtZ22oIUEhE7vKPG
 50oRc+6Q8PnJZJnOkZS+lQLPrWOjVSwqBrWPWywYdNIYoMswyEH2NXtSI2GgehVr7Mb0
 mzF2cr0PUCwr8OmYJHx9v+UuIyXpolEUrL4au8EMySvQ1SNrDIDYSzWnhxtOMd7FmTCt
 btob20L8/4yfe843b+wzNKUV9qkKj+hryo9NA2HnhFI5Q3Z3Xd8I63kxZDPjLr26stlc
 w8uH5ZAN1+GRALNsKeY1CExCa42U6KQD1e47q2/970kilAYnSjVnpYUpX0BjqrtibugH
 5/dw==
X-Gm-Message-State: ANhLgQ0BAcP4enDPandZ6XBMpZo+yuzQapZ0kn6e0x4Em0ZXQbGw1YHI
 PT1oeNtm+AUCtKxK0I0gPAVKn3DZwVZ7WSicx4ZC7ZNQZwL3nRTCNt4K9Ox52hud7FZe7LtVZF1
 aJbCGRdhLdtyOHMI=
X-Received: by 2002:a7b:c449:: with SMTP id l9mr6617261wmi.167.1585072820655; 
 Tue, 24 Mar 2020 11:00:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtzefn+uaUs6t0CBbyqQmHaSA1SUyoHri8KmFoikwAFzi+Gqvoh5Wnr/WwKUufupDoPsPj+Rw==
X-Received: by 2002:a7b:c449:: with SMTP id l9mr6617220wmi.167.1585072820379; 
 Tue, 24 Mar 2020 11:00:20 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u8sm29031276wrn.69.2020.03.24.11.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:00:19 -0700 (PDT)
Date: Tue, 24 Mar 2020 14:00:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 15/22] intel_iommu: replay guest pasid bindings to host
Message-ID: <20200324180013.GZ127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-16-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-16-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 Richard Henderson <rth@twiddle.net>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:12AM -0700, Liu Yi L wrote:
> This patch adds guest pasid bindings replay for domain
> selective pasid cache invalidation(dsi) and global pasid
> cache invalidation by walking guest pasid table.
>=20
> Reason:
> Guest OS may flush the pasid cache with a larger granularity.
> e.g. guest does a svm_bind() but flush the pasid cache with
> global or domain selective pasid cache invalidation instead
> of pasid selective(psi) pasid cache invalidation. Regards to
> such case, it works in host. Per spec, a global or domain
> selective pasid cache invalidation should be able to cover
> what a pasid selective invalidation does. The only concern
> is performance deduction since dsi and global cache invalidation
> will flush more than psi. To align with native, vIOMMU needs
> emulator needs to do replay for the two invalidation granularity
> to reflect the latest pasid bindings in guest pasid table.

This is actually related to my question in the other patch on whether
the replay can and should also work for the PSI case too.  I'm still
confused on why the guest cannot use a PSI for a newly created PASID
entry for one device?

>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c          | 128 +++++++++++++++++++++++++++++++++++=
+++++-
>  hw/i386/intel_iommu_internal.h |   1 +
>  2 files changed, 127 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 0423c83..8ec638f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2717,6 +2717,130 @@ static VTDPASIDAddressSpace *vtd_add_find_pasid_a=
s(IntelIOMMUState *s,
>      return vtd_pasid_as;
>  }
> =20
> +/**
> + * Constant information used during pasid table walk
> +   @vtd_bus, @devfn: device info
> + * @flags: indicates if it is domain selective walk
> + * @did: domain ID of the pasid table walk
> + */
> +typedef struct {
> +    VTDBus *vtd_bus;
> +    uint16_t devfn;
> +#define VTD_PASID_TABLE_DID_SEL_WALK   (1ULL << 0);
> +    uint32_t flags;
> +    uint16_t did;
> +} vtd_pasid_table_walk_info;

So this is going to be similar to VTDPASIDCacheInfo as I mentioned.
Maybe you can use a shared object for both?

> +
> +/**
> + * Caller of this function should hold iommu_lock.
> + */
> +static bool vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
> +                                        dma_addr_t pt_base,
> +                                        int start,
> +                                        int end,
> +                                        vtd_pasid_table_walk_info *info)
> +{
> +    VTDPASIDEntry pe;
> +    int pasid =3D start;
> +    int pasid_next;
> +    VTDPASIDAddressSpace *vtd_pasid_as;
> +    VTDPASIDCacheEntry *pc_entry;
> +
> +    while (pasid < end) {
> +        pasid_next =3D pasid + 1;
> +
> +        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
> +            && vtd_pe_present(&pe)) {
> +            vtd_pasid_as =3D vtd_add_find_pasid_as(s,
> +                                       info->vtd_bus, info->devfn, pasid=
);

For this chunk:

> +            pc_entry =3D &vtd_pasid_as->pasid_cache_entry;
> +            if (s->pasid_cache_gen =3D=3D pc_entry->pasid_cache_gen) {
> +                vtd_update_pe_in_cache(s, vtd_pasid_as, &pe);
> +            } else {
> +                vtd_fill_in_pe_in_cache(s, vtd_pasid_as, &pe);
> +            }

We already got &pe, then would it be easier to simply call:

               vtd_update_pe_in_cache(s, vtd_pasid_as, &pe);

?

Since IIUC the cache_gen is only helpful to avoid looking up the &pe.
And the vtd_pasid_entry_compare() check should be even more solid than
the cache_gen.

> +        }
> +        pasid =3D pasid_next;
> +    }
> +    return true;
> +}
> +
> +/*
> + * Currently, VT-d scalable mode pasid table is a two level table,
> + * this function aims to loop a range of PASIDs in a given pasid
> + * table to identify the pasid config in guest.
> + * Caller of this function should hold iommu_lock.
> + */
> +static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
> +                                    dma_addr_t pdt_base,
> +                                    int start,
> +                                    int end,
> +                                    vtd_pasid_table_walk_info *info)
> +{
> +    VTDPASIDDirEntry pdire;
> +    int pasid =3D start;
> +    int pasid_next;
> +    dma_addr_t pt_base;
> +
> +    while (pasid < end) {
> +        pasid_next =3D pasid + VTD_PASID_TBL_ENTRY_NUM;
> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
> +            && vtd_pdire_present(&pdire)) {
> +            pt_base =3D pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
> +            if (!vtd_sm_pasid_table_walk_one(s,
> +                              pt_base, pasid, pasid_next, info)) {

vtd_sm_pasid_table_walk_one() never returns false.  Remove this check?
Maybe also let vtd_sm_pasid_table_walk_one() to return nothing.

> +                break;
> +            }
> +        }
> +        pasid =3D pasid_next;
> +    }
> +}
> +
> +/**
> + * This function replay the guest pasid bindings to hots by
> + * walking the guest PASID table. This ensures host will have
> + * latest guest pasid bindings.
> + */
> +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
> +                                            uint16_t *did,
> +                                            bool is_dsi)
> +{
> +    VTDContextEntry ce;
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +    int bus_n, devfn;
> +    vtd_pasid_table_walk_info info;
> +
> +    if (is_dsi) {
> +        info.flags =3D VTD_PASID_TABLE_DID_SEL_WALK;
> +        info.did =3D *did;
> +    }
> +
> +    /*
> +     * In this replay, only needs to care about the devices which
> +     * are backed by host IOMMU. For such devices, their vtd_dev_icx
> +     * instances are in the s->vtd_dev_icx_list. For devices which
> +     * are not backed byhost IOMMU, it is not necessary to replay
> +     * the bindings since their cache could be re-created in the future
> +     * DMA address transaltion.
> +     */
> +    vtd_iommu_lock(s);
> +    QLIST_FOREACH(vtd_dev_icx, &s->vtd_dev_icx_list, next) {
> +        bus_n =3D pci_bus_num(vtd_dev_icx->vtd_bus->bus);
> +        devfn =3D vtd_dev_icx->devfn;
> +
> +        if (!vtd_dev_to_context_entry(s, bus_n, devfn, &ce)) {
> +            info.vtd_bus =3D vtd_dev_icx->vtd_bus;
> +            info.devfn =3D devfn;
> +            vtd_sm_pasid_table_walk(s,
> +                                    VTD_CE_GET_PASID_DIR_TABLE(&ce),
> +                                    0,
> +                                    VTD_MAX_HPASID,
> +                                    &info);
> +        }
> +    }
> +    vtd_iommu_unlock(s);
> +}
> +
>  static int vtd_pasid_cache_dsi(IntelIOMMUState *s, uint16_t domain_id)
>  {
>      VTDPASIDCacheInfo pc_info;
> @@ -2735,7 +2859,6 @@ static int vtd_pasid_cache_dsi(IntelIOMMUState *s, =
uint16_t domain_id)
>      vtd_iommu_unlock(s);
> =20
>      /*
> -     * TODO:
>       * Domain selective PASID cache invalidation flushes
>       * all the pasid caches within a domain. To be safe,
>       * after invalidating the pasid caches, emulator needs
> @@ -2743,6 +2866,7 @@ static int vtd_pasid_cache_dsi(IntelIOMMUState *s, =
uint16_t domain_id)
>       * dir and pasid table. e.g. When the guest setup a new
>       * PASID entry then send a PASID DSI.
>       */
> +    vtd_replay_guest_pasid_bindings(s, &domain_id, true);
>      return 0;
>  }
> =20
> @@ -2881,13 +3005,13 @@ static int vtd_pasid_cache_gsi(IntelIOMMUState *s=
)
>      vtd_iommu_unlock(s);
> =20
>      /*
> -     * TODO:
>       * Global PASID cache invalidation flushes all
>       * the pasid caches. To be safe, after invalidating
>       * the pasid caches, emulator needs to replay the
>       * pasid bindings by walking guest pasid dir and
>       * pasid table.
>       */
> +    vtd_replay_guest_pasid_bindings(s, NULL, false);
>      return 0;
>  }
> =20
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 4451acf..b0a324c 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -554,6 +554,7 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
>  #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>  #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MA=
SK)
>  #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Di=
sable */
> +#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
> =20
>  /* PASID Granular Translation Type Mask */
>  #define VTD_PASID_ENTRY_P              1ULL
> --=20
> 2.7.4
>=20

--=20
Peter Xu


