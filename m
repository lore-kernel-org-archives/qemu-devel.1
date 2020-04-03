Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E1C2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059372078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wxm5p02I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059372078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNaw-0008VA-5V
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jKNaA-00085B-1P
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jKNa8-0001ES-Es
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:46:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58430
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jKNa8-000179-9S
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585925163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKckvpAHQV4ln32weHY6ZBYp4aHjGyUifqexfJYTH8o=;
 b=Wxm5p02IU0uHl7DxSK4fHWhWFIXfIL14LizyrzcJfqXu01T3AP45KKvczXK/tkS+b+RvX1
 UR1UXOjDsE9JXWx5duXMjCctztdEHMAZ5DoEtUXjp5N+HqcXU2eu7U9q9uu74ogx5mqvGh
 DXbLKyYznv/DHZlEosR1W3iszkjiv7I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-GbYyJsXSOaGB8Ls-YrCFGg-1; Fri, 03 Apr 2020 10:45:55 -0400
X-MC-Unique: GbYyJsXSOaGB8Ls-YrCFGg-1
Received: by mail-wr1-f69.google.com with SMTP id 91so2325864wro.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iN/CbA1yKfXyMnQx0SzzSH5BI6P5yxTNjMIXWyXOGOY=;
 b=mo1wXWHR5Hdi2AD+SyCN3Tjo/RaDyRPXIL/cpcjaMcJyUAmSt0OwuT2lKvDHuBpvrt
 ilzuXj88RR0H4OXyKLhu2imIGgwCXZWx5UW7xsofPBB4xzAJu5kCCTY/cBPILGhfBMux
 hlFlLxAaA1gSxaG4G+xhd4cW9dOPQQmboAO0zdL9mnwBJCtMfRNcBgKNQedHlAyaGP0o
 gBclC74LhVZHmtFxmg15PqSMi6agyk/UAsQ7ZYIkDZoOsLrvv86dGX3YEc35r2Nh/41Q
 7GnxNq9jtJf6ygXUb5j5QVEcFX1BHh2QteMTU7V7LL/ic3HwtzqlIRIYF+sAgkzHdydq
 jmYg==
X-Gm-Message-State: AGi0Pub1cJqcPYo6qsbxTz3DW8NuZyYztOi94geG8FULTfUhYzt/cEz1
 70w9mKfpxi1DeQXsDB78H7Co5Y7EL1RxOCU5yaW/VyL05mN0XZ+0CrXsj7Gv+BRvWSsg8S/T6o0
 9UWTBekqp7/9akb8=
X-Received: by 2002:adf:ef08:: with SMTP id e8mr9992260wro.66.1585925154482;
 Fri, 03 Apr 2020 07:45:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJQUSM+EcrNQwnOPmHznd6lP97OMO57MVRtXCwy5VT9rjOUXg+VldAWcpLpM/epVCYWtsVK9A==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr9992229wro.66.1585925154195;
 Fri, 03 Apr 2020 07:45:54 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
 by smtp.gmail.com with ESMTPSA id j68sm12524581wrj.32.2020.04.03.07.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 07:45:53 -0700 (PDT)
Date: Fri, 3 Apr 2020 10:45:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 16/22] intel_iommu: replay pasid binds after context
 cache invalidation
Message-ID: <20200403144548.GK103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-17-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-17-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Sun, Mar 29, 2020 at 09:24:55PM -0700, Liu Yi L wrote:
> This patch replays guest pasid bindings after context cache
> invalidation. This is a behavior to ensure safety. Actually,
> programmer should issue pasid cache invalidation with proper
> granularity after issuing a context cache invalidation.
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
>  hw/i386/intel_iommu.c          | 51 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/i386/intel_iommu_internal.h |  6 ++++-
>  hw/i386/trace-events           |  1 +
>  3 files changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d87f608..883aeac 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -68,6 +68,10 @@ static void vtd_address_space_refresh_all(IntelIOMMUSt=
ate *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *=
n);
> =20
>  static void vtd_pasid_cache_reset(IntelIOMMUState *s);
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> +                                 VTDPASIDCacheInfo *pc_info);
> +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> +                                  VTDBus *vtd_bus, uint16_t devfn);
> =20
>  static void vtd_panic_require_caching_mode(void)
>  {
> @@ -1853,7 +1857,10 @@ static void vtd_iommu_replay_all(IntelIOMMUState *=
s)
> =20
>  static void vtd_context_global_invalidate(IntelIOMMUState *s)
>  {
> +    VTDPASIDCacheInfo pc_info;
> +
>      trace_vtd_inv_desc_cc_global();
> +
>      /* Protects context cache */
>      vtd_iommu_lock(s);
>      s->context_cache_gen++;
> @@ -1870,6 +1877,9 @@ static void vtd_context_global_invalidate(IntelIOMM=
UState *s)
>       * VT-d emulation codes.
>       */
>      vtd_iommu_replay_all(s);
> +
> +    pc_info.flags =3D VTD_PASID_CACHE_GLOBAL;
> +    vtd_pasid_cache_sync(s, &pc_info);
>  }
> =20
>  /**
> @@ -2005,6 +2015,22 @@ static void vtd_context_device_invalidate(IntelIOM=
MUState *s,
>                   * happened.
>                   */
>                  vtd_sync_shadow_page_table(vtd_as);
> +                /*
> +                 * Per spec, context flush should also followed with PAS=
ID
> +                 * cache and iotlb flush. Regards to a device selective
> +                 * context cache invalidation:

If context entry flush should also follow another pasid cache flush,
then this is still needed?  Shouldn't the pasid flush do the same
thing again?

> +                 * if (emaulted_device)
> +                 *    modify the pasid cache gen and pasid-based iotlb g=
en
> +                 *    value (will be added in following patches)

Let's avoid using "following patches" because it'll be helpless after
merged.  Also, the pasid cache gen is gone.

> +                 * else if (assigned_device)
> +                 *    check if the device has been bound to any pasid
> +                 *    invoke pasid_unbind regards to each bound pasid
> +                 * Here, we have vtd_pasid_cache_devsi() to invalidate p=
asid
> +                 * caches, while for piotlb in QEMU, we don't have it ye=
t, so
> +                 * no handling. For assigned device, host iommu driver w=
ould
> +                 * flush piotlb when a pasid unbind is pass down to it.
> +                 */
> +                 vtd_pasid_cache_devsi(s, vtd_bus, devfn_it);
>              }
>          }
>      }
> @@ -2619,6 +2645,12 @@ static gboolean vtd_flush_pasid(gpointer key, gpoi=
nter value,
>          /* Fall through */
>      case VTD_PASID_CACHE_GLOBAL:
>          break;
> +    case VTD_PASID_CACHE_DEVSI:
> +        if (pc_info->vtd_bus !=3D vtd_bus ||
> +            pc_info->devfn =3D=3D devfn) {

Do you mean "!=3D"?

> +            return false;
> +        }
> +        break;
>      default:
>          error_report("invalid pc_info->flags");
>          abort();
> @@ -2827,6 +2859,11 @@ static void vtd_replay_guest_pasid_bindings(IntelI=
OMMUState *s,
>          walk_info.flags |=3D VTD_PASID_TABLE_DID_SEL_WALK;
>          /* loop all assigned devices */
>          break;
> +    case VTD_PASID_CACHE_DEVSI:
> +        walk_info.vtd_bus =3D pc_info->vtd_bus;
> +        walk_info.devfn =3D pc_info->devfn;
> +        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
> +        return;
>      case VTD_PASID_CACHE_FORCE_RESET:
>          /* For force reset, no need to go further replay */
>          return;
> @@ -2912,6 +2949,20 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *=
s,
>      vtd_iommu_unlock(s);
>  }
> =20
> +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> +                                  VTDBus *vtd_bus, uint16_t devfn)
> +{
> +    VTDPASIDCacheInfo pc_info;
> +
> +    trace_vtd_pasid_cache_devsi(devfn);
> +
> +    pc_info.flags =3D VTD_PASID_CACHE_DEVSI;
> +    pc_info.vtd_bus =3D vtd_bus;
> +    pc_info.devfn =3D devfn;
> +
> +    vtd_pasid_cache_sync(s, &pc_info);
> +}
> +
>  /**
>   * Caller of this function should hold iommu_lock
>   */
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index b9e48ab..9122601 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -529,14 +529,18 @@ struct VTDPASIDCacheInfo {
>  #define VTD_PASID_CACHE_GLOBAL         (1ULL << 1)
>  #define VTD_PASID_CACHE_DOMSI          (1ULL << 2)
>  #define VTD_PASID_CACHE_PASIDSI        (1ULL << 3)
> +#define VTD_PASID_CACHE_DEVSI          (1ULL << 4)
>      uint32_t flags;
>      uint16_t domain_id;
>      uint32_t pasid;
> +    VTDBus *vtd_bus;
> +    uint16_t devfn;
>  };
>  #define VTD_PASID_CACHE_INFO_MASK    (VTD_PASID_CACHE_FORCE_RESET | \
>                                        VTD_PASID_CACHE_GLOBAL  | \
>                                        VTD_PASID_CACHE_DOMSI  | \
> -                                      VTD_PASID_CACHE_PASIDSI)
> +                                      VTD_PASID_CACHE_PASIDSI | \
> +                                      VTD_PASID_CACHE_DEVSI)
>  typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
> =20
>  /* PASID Table Related Definitions */
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 60d20c1..3853fa8 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -26,6 +26,7 @@ vtd_pasid_cache_gsi(void) ""
>  vtd_pasid_cache_reset(void) ""
>  vtd_pasid_cache_dsi(uint16_t domain) "Domian slective PC invalidation do=
main 0x%"PRIx16
>  vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective PC =
invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
> +vtd_pasid_cache_devsi(uint16_t devfn) "Dev selective PC invalidation dev=
: 0x%"PRIx16
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu=
8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t=
 domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64"=
 domain 0x%"PRIx16
> --=20
> 2.7.4
>=20

--=20
Peter Xu


