Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C88C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A716F20828
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/jr86fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A716F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ielHf-0005nh-Qt
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ielGa-0005BC-5Q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ielGW-00083U-Sq
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:33:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ielGW-00082R-Od
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576006427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZTfpCN1lANcpp5nvsLp60HOaf9LAi3l8OM391BbYxQ=;
 b=G/jr86fo1ApdKCIdB/s6MR5HA0DlB4PWpGB4lB9SBKmUY6A7rXUnrOL4S0JiG5P0g/i6r1
 0tXKC4RL/q0D2rYcT6MZu3ujfZoRAI1oL1Vz+T0CgnA2PEsRFm7F3BbvgyZbq9CoBT0qtV
 95Yi8/TwvuqodvHcEKcvd0YoGfwqR/Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-zmPRnRnmPO2TGTlPM7V6Pg-1; Tue, 10 Dec 2019 14:33:46 -0500
Received: by mail-qt1-f197.google.com with SMTP id e8so2673897qtg.9
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HjCoFxij4to5Ve/wYhzyT1FW8VAPKljzlAY7EGytemQ=;
 b=CBhJaMl4qAilZrmpcCIgEm2jzwjm9EAkIKpuLTvo/M/ASUMjlKmJ3zkiajMldq2aZj
 GLin1Yz6yBlcQwcLYReLGQwNDlyYvL+x/d08dJAJfRsWdjXIeCfrrOsauRGufHzg9fT8
 97Z/u5k2uLZ9WVlpEhjWRqugt9KiVLDYu8wfmVKTuoKCLTqRb6C695YFZ3LZz8zUHSAi
 MqCDkrASSPSoilfWgC4kUh+e93DGjNW8u1g+NPXiLJf1Hhm/t4Z4WucgtMbiUM53VtqO
 SE4WbaPSvb8JwkWaHBZ1qE5ySm4QjCyVIsaQwDZbvZ88D8XndjAP4wnSfaQKfq3/amHh
 WsFg==
X-Gm-Message-State: APjAAAUoD9dqLLys9/5ehKWJ2GVOsbsffIw+uxAp7bukoxZcKc10Qk2x
 XCU4lTkTp9BSKjfnNr03Qa/UQ0YNAU6/fDdNlSzmq+mL9OCrw2YHIOyRW+VxCzU+MTIBGpqanz4
 VmlRwN1qtRBIG6Ts=
X-Received: by 2002:a37:2781:: with SMTP id
 n123mr33410476qkn.163.1576006424634; 
 Tue, 10 Dec 2019 11:33:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUpY7qEI3NwfUVy0bVrzBDs7lJUbjkNm195s1S9gWnyC3hxFQvgyaqMy8lgnpaALvL/73MwA==
X-Received: by 2002:a37:2781:: with SMTP id
 n123mr33410449qkn.163.1576006424308; 
 Tue, 10 Dec 2019 11:33:44 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id k50sm1482555qtc.90.2019.12.10.11.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 11:33:43 -0800 (PST)
Date: Tue, 10 Dec 2019 14:33:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 08/20] virtio-iommu: Implement translate
Message-ID: <20191210193342.GJ3352@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-9-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-9-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: zmPRnRnmPO2TGTlPM7V6Pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:31PM +0100, Eric Auger wrote:
> This patch implements the translate callback
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v10 -> v11:
> - take into account the new value struct and use
>   g_tree_lookup_extended
> - switched to error_report_once
>=20
> v6 -> v7:
> - implemented bypass-mode
>=20
> v5 -> v6:
> - replace error_report by qemu_log_mask
>=20
> v4 -> v5:
> - check the device domain is not NULL
> - s/printf/error_report
> - set flags to IOMMU_NONE in case of all translation faults
> ---
>  hw/virtio/trace-events   |  1 +
>  hw/virtio/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index f25359cee2..de7cbb3c8f 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -72,3 +72,4 @@ virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoi=
nt=3D%d"
>  virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=3D%d"
>  virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
> +virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint3=
2_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index f0a56833a2..a83666557b 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -412,19 +412,80 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMe=
moryRegion *mr, hwaddr addr,
>                                              int iommu_idx)
>  {
>      IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> +    viommu_interval interval, *mapping_key;
> +    viommu_mapping *mapping_value;
> +    VirtIOIOMMU *s =3D sdev->viommu;
> +    viommu_endpoint *ep;
> +    bool bypass_allowed;
>      uint32_t sid;
> +    bool found;
> +
> +    interval.low =3D addr;
> +    interval.high =3D addr + 1;
> =20
>      IOMMUTLBEntry entry =3D {
>          .target_as =3D &address_space_memory,
>          .iova =3D addr,
>          .translated_addr =3D addr,
> -        .addr_mask =3D ~(hwaddr)0,
> +        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
>          .perm =3D IOMMU_NONE,
>      };
> =20
> +    bypass_allowed =3D virtio_has_feature(s->acked_features,
> +                                        VIRTIO_IOMMU_F_BYPASS);
> +

Would it be easier to check bypass_allowed here once and then drop the
latter [1] and [2] check?

>      sid =3D virtio_iommu_get_sid(sdev);
> =20
>      trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
> +    qemu_mutex_lock(&s->mutex);
> +
> +    ep =3D g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
> +    if (!ep) {
> +        if (!bypass_allowed) {

[1]

> +            error_report_once("%s sid=3D%d is not known!!", __func__, si=
d);
> +        } else {
> +            entry.perm =3D flag;
> +        }
> +        goto unlock;
> +    }
> +
> +    if (!ep->domain) {
> +        if (!bypass_allowed) {

[2]

> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s %02x:%02x.%01x not attached to any domain\=
n",
> +                          __func__, PCI_BUS_NUM(sid),
> +                          PCI_SLOT(sid), PCI_FUNC(sid));
> +        } else {
> +            entry.perm =3D flag;
> +        }
> +        goto unlock;
> +    }
> +
> +    found =3D g_tree_lookup_extended(ep->domain->mappings, (gpointer)(&i=
nterval),
> +                                   (void **)&mapping_key,
> +                                   (void **)&mapping_value);
> +    if (!found) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s no mapping for 0x%"PRIx64" for sid=3D%d\n",
> +                      __func__, addr, sid);

I would still suggest that we use the same logging interface (either
error_report_once() or qemu_log_mask(), not use them randomly).

> +        goto unlock;
> +    }
> +
> +    if (((flag & IOMMU_RO) &&
> +            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
> +        ((flag & IOMMU_WO) &&
> +            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Permission error on 0x%"PRIx64"(%d): allowed=3D%d=
\n",
> +                      addr, flag, mapping_value->flags);

(Btw, IIUC this may not be a guest error. Say, what if the device is
 simply broken?)

> +        goto unlock;
> +    }
> +    entry.translated_addr =3D addr - mapping_key->low + mapping_value->p=
hys_addr;
> +    entry.perm =3D flag;
> +    trace_virtio_iommu_translate_out(addr, entry.translated_addr, sid);
> +
> +unlock:
> +    qemu_mutex_unlock(&s->mutex);
>      return entry;
>  }
> =20
> --=20
> 2.20.1
>=20

--=20
Peter Xu


