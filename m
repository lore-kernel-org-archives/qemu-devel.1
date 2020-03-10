Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B638C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2732A2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 03:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCzs3aSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2732A2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBVKJ-0003Y1-Br
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 23:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jBVJa-0002pG-RO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jBVJY-0004ve-Lu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:12:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jBVJY-0004ut-I0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 23:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583809936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9f7U0jNuGprEMGx/YvJ+0kw8FAzPhzlGyE/RahfoSf0=;
 b=eCzs3aSUVer3yPhufRBx5lmhAOZ4uaVVaByNtNxNPb0Amyur9WDu5JsNx2zQT+c6HOCeQR
 1yrQD5DRGfSdZqugQONp1RD9Q24U5vI3qRHJcg/nib3vDZUv74Kon/4xWyIpfGAXrnVsYi
 +Q2ftXfna1cxsGZ9H14CdP5HnE838vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-SNkz57SpOjKoob2MnE96JA-1; Mon, 09 Mar 2020 23:12:12 -0400
X-MC-Unique: SNkz57SpOjKoob2MnE96JA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BB3E800D48;
 Tue, 10 Mar 2020 03:12:11 +0000 (UTC)
Received: from [10.72.13.250] (ovpn-13-250.pek2.redhat.com [10.72.13.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BFE95C1C3;
 Tue, 10 Mar 2020 03:12:07 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] virtio-net: block migration if RSS feature
 negotiated
To: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 mst@redhat.com
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-5-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <32451b9c-f10d-d683-24b4-29497e73ca65@redhat.com>
Date: Tue, 10 Mar 2020 11:12:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200309083438.2389-5-yuri.benditovich@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:
> Block migration for reference implementation of
> RSS feature in QEMU. When we add support for RSS
> on backend side, we'll implement migration of
> current RSS settings.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   hw/net/virtio-net.c            | 18 ++++++++++++++++++
>   include/hw/virtio/virtio-net.h |  1 +
>   2 files changed, 19 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index abc41fdb16..943d1931a2 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -37,6 +37,7 @@
>   #include "qapi/qapi-events-migration.h"
>   #include "hw/virtio/virtio-access.h"
>   #include "migration/misc.h"
> +#include "migration/blocker.h"
>   #include "standard-headers/linux/ethtool.h"
>   #include "sysemu/sysemu.h"
>   #include "trace.h"
> @@ -627,6 +628,12 @@ static void virtio_net_reset(VirtIODevice *vdev)
>       n->announce_timer.round =3D 0;
>       n->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
>  =20
> +    if (n->migration_blocker) {
> +        migrate_del_blocker(n->migration_blocker);
> +        error_free(n->migration_blocker);
> +        n->migration_blocker =3D NULL;
> +    }
> +
>       /* Flush any MAC and VLAN filter table state */
>       n->mac_table.in_use =3D 0;
>       n->mac_table.first_multi =3D 0;
> @@ -1003,6 +1010,17 @@ static void virtio_net_set_features(VirtIODevice *=
vdev, uint64_t features)
>           vhost_net_ack_features(get_vhost_net(nc->peer), features);
>       }
>  =20
> +    if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
> +        if (!n->migration_blocker) {
> +            error_setg(&n->migration_blocker, "virtio-net: RSS negotiate=
d");
> +            migrate_add_blocker(n->migration_blocker, &err);
> +            if (err) {
> +                error_report_err(err);
> +                err =3D NULL;
> +            }
> +        }
> +    }


It looks to me we should add the blocker unconditionally based on=20
virtio_host_has_feature() instead of depending the negotiated feature here.

Thanks


> +
>       if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
>           memset(n->vlans, 0, MAX_VLAN >> 3);
>       } else {
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 45670dd054..fba768ba9b 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -180,6 +180,7 @@ struct VirtIONet {
>       virtio_net_conf net_conf;
>       NICConf nic_conf;
>       DeviceState *qdev;
> +    Error *migration_blocker;
>       int multiqueue;
>       uint16_t max_queues;
>       uint16_t curr_queues;


