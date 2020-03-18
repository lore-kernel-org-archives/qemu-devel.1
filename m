Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA8FC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3792920768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLrUPXDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3792920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWHQ-0004qT-Ds
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEWFd-0002zG-6o
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEWFc-0003Rw-4E
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:48:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEWFc-0003Rr-0S
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584528519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQkXDpr2KGMImxFGlJS5QuSkd40srz8BwmNaRHq/0n8=;
 b=aLrUPXDDO9wgRIG/Ck0MqQO1ThlEgH8E3QhA9MkYAHO+p4OwA2dMY3XUy+AcJ84QVD1Oka
 MWKDNWLBaYucwtyDL8rcuvxOqjdgRb7sw48cDNNzYMRwqHEV1pZEJ5PmvNqAXx97qfWShT
 0IyWckkZbR5O6eRexUkGrYWBnHH99Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-mv3BS0dsPe67ppEOngEegw-1; Wed, 18 Mar 2020 06:48:38 -0400
X-MC-Unique: mv3BS0dsPe67ppEOngEegw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DEA81005513;
 Wed, 18 Mar 2020 10:48:37 +0000 (UTC)
Received: from work-vm (ovpn-115-3.ams2.redhat.com [10.36.115.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C30460BF1;
 Wed, 18 Mar 2020 10:48:29 +0000 (UTC)
Date: Wed, 18 Mar 2020 10:48:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 7/7] virtio-net: add migration support for RSS and
 hash report
Message-ID: <20200318104826.GF2850@work-vm>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-8-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200318091525.27044-8-yuri.benditovich@daynix.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: yan@daynix.com, jasowang@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yuri Benditovich (yuri.benditovich@daynix.com) wrote:
> Save and restore RSS/hash report configuration.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a0614ad4e6..0b058aae9f 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void *opaqu=
e, int version_id)
>          }
>      }
> =20
> +    if (n->rss_data.enabled) {
> +        trace_virtio_net_rss_enable(n->rss_data.hash_types,
> +                                    n->rss_data.indirections_len,
> +                                    sizeof(n->rss_data.key));
> +    } else {
> +        trace_virtio_net_rss_disable();
> +    }
>      return 0;
>  }
> =20
> @@ -3019,6 +3026,24 @@ static const VMStateDescription vmstate_virtio_net=
_has_vnet =3D {
>      },
>  };
> =20
> +static const VMStateDescription vmstate_rss =3D {
> +    .name      =3D "vmstate_rss",

You need to do something to avoid breaking migration compatibility
from/to old QEMU's and from/to QEMU's on hosts without the new virtio
features.
Probably adding a .needed =3D   here pointing to a function that
checks 'enabled' might do it.

Dave


> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_BOOL(enabled, VirtioNetRssData),
> +        VMSTATE_BOOL(redirect, VirtioNetRssData),
> +        VMSTATE_BOOL(populate_hash, VirtioNetRssData),
> +        VMSTATE_UINT32(hash_types, VirtioNetRssData),
> +        VMSTATE_UINT16(indirections_len, VirtioNetRssData),
> +        VMSTATE_UINT16(default_queue, VirtioNetRssData),
> +        VMSTATE_UINT8_ARRAY(key, VirtioNetRssData,
> +                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
> +        VMSTATE_VARRAY_UINT16_ALLOC(indirections_table, VirtioNetRssData=
,
> +                                    indirections_len, 0,
> +                                    vmstate_info_uint16, uint16_t),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_virtio_net_device =3D {
>      .name =3D "virtio-net-device",
>      .version_id =3D VIRTIO_NET_VM_VERSION,
> @@ -3067,6 +3092,7 @@ static const VMStateDescription vmstate_virtio_net_=
device =3D {
>                           vmstate_virtio_net_tx_waiting),
>          VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
>                              has_ctrl_guest_offloads),
> +        VMSTATE_STRUCT(rss_data, VirtIONet, 1, vmstate_rss, VirtioNetRss=
Data),
>          VMSTATE_END_OF_LIST()
>     },
>  };
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


