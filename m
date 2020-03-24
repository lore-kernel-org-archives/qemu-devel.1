Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D83C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C987C20719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQOo2+hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C987C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnyz-0002aj-0o
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGnyB-0001tF-Qn
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGnyA-00031q-NH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:08:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGnyA-00031D-JM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585073285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrKfyg5oMPNpy7yv6AdN5alZpEBjIbcSXjVq0DUO+j8=;
 b=fQOo2+hkWp/DcTcJFOho7llkpu0p09HtgdzhQn1mLP9HHyqS4AE6BjcgKfuWHPaIufTv+j
 a1mznKqHB5E5+Trvkm5ZjATKpCFVJf1obRWWg28Qf+hj79RVcq4nEZ1X8a3yJBKiXDv9i6
 ecn9D7c9y9I9rISyn3u1WspJQICM2Tk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-ZEaiif0ZNOGk66evOS-zsw-1; Tue, 24 Mar 2020 14:08:03 -0400
X-MC-Unique: ZEaiif0ZNOGk66evOS-zsw-1
Received: by mail-wr1-f71.google.com with SMTP id w11so9592613wrp.20
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o9VfLtJGvU0fUYHvZhFRdklkTco3oGHxaMAk7MxTBnM=;
 b=tgAYGWN8zTEMAYA/Y5gglIYwyOMsnk3JO6PC2Bk/u11TzRP6TEjZ45gpnyEAio8p7b
 LpbBA/ElMiD4csRE+PBqg+6JqnNtqYYaGUYDTsrkAzQVH8JkYBWoujErDer/cfJBLvs2
 IR3+wpabf3MQ5EWnPw+/NMSN8WUP+DaZcotNZAwpxaIofGVduB2B2qWWteiKXSGpxbk9
 itvYJkDGCH8MSdesw2tdDdaoIMSegN1cQDcG8KNZh/5D2Yk95YCJTd5v54SXz9dSovfX
 f8d3udy6jXHRUi1k3q3DJprM2FPzTkF1U5NUNYVnPnFra4pAja6/DJ+eo8gJU4F7LvJa
 ubWw==
X-Gm-Message-State: ANhLgQ2tgHqXvxebewWeHIw3vjH+aWJ6hUgls5peTL/88mWPQPsrHHDp
 sD+QD3+PL/WrKFahfftEC9ygD0R410tqw2rY6GVshmddgS4jI46YVeFqL6PI8LZoLI6nYnrCY6m
 umr9ZhYFY8v3sAQM=
X-Received: by 2002:adf:e98a:: with SMTP id h10mr27948333wrm.370.1585073282528; 
 Tue, 24 Mar 2020 11:08:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvE8lDc4aoctvV5poB+k76p6FHaiGufJuqzX/crtbLgsKOF//dAt/qo48ojBqgwBugtg6Du9g==
X-Received: by 2002:adf:e98a:: with SMTP id h10mr27948305wrm.370.1585073282349; 
 Tue, 24 Mar 2020 11:08:02 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id c18sm28384987wrx.5.2020.03.24.11.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:08:01 -0700 (PDT)
Date: Tue, 24 Mar 2020 14:07:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 16/22] intel_iommu: replay pasid binds after context
 cache invalidation
Message-ID: <20200324180755.GA127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-17-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-17-git-send-email-yi.l.liu@intel.com>
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

On Sun, Mar 22, 2020 at 05:36:13AM -0700, Liu Yi L wrote:
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
>  hw/i386/intel_iommu.c          | 68 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/i386/intel_iommu_internal.h |  6 +++-
>  hw/i386/trace-events           |  1 +
>  3 files changed, 74 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 8ec638f..1e0ccde 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -68,6 +68,10 @@ static void vtd_address_space_refresh_all(IntelIOMMUSt=
ate *s);
>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *=
n);
> =20
>  static void vtd_pasid_cache_reset(IntelIOMMUState *s);
> +static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
> +                                           uint16_t *did, bool is_dsi);
> +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> +                                  VTDBus *vtd_bus, uint16_t devfn);
> =20
>  static void vtd_panic_require_caching_mode(void)
>  {
> @@ -1865,6 +1869,8 @@ static void vtd_context_global_invalidate(IntelIOMM=
UState *s)
>       * VT-d emulation codes.
>       */
>      vtd_iommu_replay_all(s);
> +
> +    vtd_replay_guest_pasid_bindings(s, NULL, false);

I think the only uncertain thing is whether you still want to rework
the vtd_replay_guest_pasid_bindings() interface.  It'll depend on the
future discussion of previous patches.  Besides that this patch looks
good to me.

--=20
Peter Xu


