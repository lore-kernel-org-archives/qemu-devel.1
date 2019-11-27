Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2142068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bahhfdlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2142068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZw8O-0003B4-O3
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZw5x-0001gv-Mg
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZw5w-0006UX-9d
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:06:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZw5w-0006UE-3x
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574856415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrILFCGHJnwMVvogxicaYHFqxItfgFN5vrkccrFPrL0=;
 b=bahhfdlWi5DpAImnqVgGvojxmygpUKAMVRGYVt87D6iYTaXVpPMohMk+i4aJUDjfNHAHmI
 SY/D7G8+eVj9Nups76z08JsMTQ/kIlz6gS3sndTIn1cLXQVXbKh6vJmugiw3e37bGYGvGR
 94wzuxjSYi0vGZ/zOfAaDovpbzatzDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-9wi4a9VHMLWnt_WPV3URJg-1; Wed, 27 Nov 2019 07:06:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23A7A800C78;
 Wed, 27 Nov 2019 12:06:46 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F120C3C1D;
 Wed, 27 Nov 2019 12:06:35 +0000 (UTC)
Date: Wed, 27 Nov 2019 12:06:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 18/20] virtio-iommu: Support migration
Message-ID: <20191127120632.GH3016@work-vm>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-19-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-19-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9wi4a9VHMLWnt_WPV3URJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Auger (eric.auger@redhat.com) wrote:
> Add Migration support. We rely on recently added gtree and qlist
> migration. Besides, we have to fixup end point <-> domain link.
>=20
> Indeed each domain has a list of endpoints attached to it. And each
> endpoint has a pointer to its domain.
>=20
> Raw gtree and qlist migration cannot handle this as it re-allocates
> all the nodes while reconstructing the trees/lists.
>=20
> So in post_load we re-construct the relationship between endpoints
> and domains.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

From the migration side of things,


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/virtio/virtio-iommu.c | 127 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 117 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index c5b202fab7..4e92fc0c95 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -692,16 +692,6 @@ static void virtio_iommu_set_features(VirtIODevice *=
vdev, uint64_t val)
>      trace_virtio_iommu_set_features(dev->acked_features);
>  }
> =20
> -/*
> - * Migration is not yet supported: most of the state consists
> - * of balanced binary trees which are not yet ready for getting
> - * migrated
> - */
> -static const VMStateDescription vmstate_virtio_iommu_device =3D {
> -    .name =3D "virtio-iommu-device",
> -    .unmigratable =3D 1,
> -};
> -
>  static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data=
)
>  {
>      uint ua =3D GPOINTER_TO_UINT(a);
> @@ -778,6 +768,123 @@ static void virtio_iommu_instance_init(Object *obj)
>  {
>  }
> =20
> +#define VMSTATE_INTERVAL                               \
> +{                                                      \
> +    .name =3D "interval",                                \
> +    .version_id =3D 1,                                   \
> +    .minimum_version_id =3D 1,                           \
> +    .fields =3D (VMStateField[]) {                       \
> +        VMSTATE_UINT64(low, viommu_interval),          \
> +        VMSTATE_UINT64(high, viommu_interval),         \
> +        VMSTATE_END_OF_LIST()                          \
> +    }                                                  \
> +}
> +
> +#define VMSTATE_MAPPING                               \
> +{                                                     \
> +    .name =3D "mapping",                                \
> +    .version_id =3D 1,                                  \
> +    .minimum_version_id =3D 1,                          \
> +    .fields =3D (VMStateField[]) {                      \
> +        VMSTATE_UINT64(phys_addr, viommu_mapping),    \
> +        VMSTATE_UINT32(flags, viommu_mapping),        \
> +        VMSTATE_END_OF_LIST()                         \
> +    },                                                \
> +}
> +
> +static const VMStateDescription vmstate_interval_mapping[2] =3D {
> +    VMSTATE_MAPPING,   /* value */
> +    VMSTATE_INTERVAL   /* key   */
> +};
> +
> +static int domain_preload(void *opaque)
> +{
> +    viommu_domain *domain =3D opaque;
> +
> +    domain->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cmp,
> +                                       NULL, g_free, g_free);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_endpoint =3D {
> +    .name =3D "endpoint",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(id, viommu_endpoint),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_domain =3D {
> +    .name =3D "domain",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .pre_load =3D domain_preload,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(id, viommu_domain),
> +        VMSTATE_GTREE_V(mappings, viommu_domain, 1,
> +                        vmstate_interval_mapping,
> +                        viommu_interval, viommu_mapping),
> +        VMSTATE_QLIST_V(endpoint_list, viommu_domain, 1,
> +                        vmstate_endpoint, viommu_endpoint, next),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static gboolean reconstruct_ep_domain_link(gpointer key, gpointer value,
> +                                           gpointer data)
> +{
> +    viommu_domain *d =3D (viommu_domain *)value;
> +    viommu_endpoint *iter, *tmp;
> +    viommu_endpoint *ep =3D (viommu_endpoint *)data;
> +
> +    QLIST_FOREACH_SAFE(iter, &d->endpoint_list, next, tmp) {
> +        if (iter->id =3D=3D ep->id) {
> +            /* remove the ep */
> +            QLIST_REMOVE(iter, next);
> +            g_free(iter);
> +            /* replace it with the good one */
> +            QLIST_INSERT_HEAD(&d->endpoint_list, ep, next);
> +            /* update the domain */
> +            ep->domain =3D d;
> +            return true; /* stop the search */
> +        }
> +    }
> +    return false; /* continue the traversal */
> +}
> +
> +static gboolean fix_endpoint(gpointer key, gpointer value, gpointer data=
)
> +{
> +    VirtIOIOMMU *s =3D (VirtIOIOMMU *)data;
> +
> +    g_tree_foreach(s->domains, reconstruct_ep_domain_link, value);
> +    return false;
> +}
> +
> +static int iommu_post_load(void *opaque, int version_id)
> +{
> +    VirtIOIOMMU *s =3D opaque;
> +
> +    g_tree_foreach(s->endpoints, fix_endpoint, s);
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_iommu_device =3D {
> +    .name =3D "virtio-iommu-device",
> +    .minimum_version_id =3D 1,
> +    .version_id =3D 1,
> +    .post_load =3D iommu_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 1,
> +                                   &vmstate_domain, viommu_domain),
> +        VMSTATE_GTREE_DIRECT_KEY_V(endpoints, VirtIOIOMMU, 1,
> +                                   &vmstate_endpoint, viommu_endpoint),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +
>  static const VMStateDescription vmstate_virtio_iommu =3D {
>      .name =3D "virtio-iommu",
>      .minimum_version_id =3D 1,
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


