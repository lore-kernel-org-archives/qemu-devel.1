Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D18C55183
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 03:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C1E206F9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 03:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxF0cfyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C1E206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQjWR-00076H-Q6
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 23:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQjVl-0006fl-VO
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jQjVk-00065B-5b
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:23:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jQjVj-00064j-N1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 23:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587439426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7U+gUWx19ZlQQZux1S9RbsaUjtlGkbIrzzX8SH3RYc=;
 b=LxF0cfyVss75i3t+P/N47t8OlzwSwyMYwxgnaCeaGNM8+eAFqjCpMaelqsVLd8SCiD28aT
 9HV3fnlP7MSKgwL0aTsyrTtSZ79r5HXyxxIEMBiHaJnrvmxz3p7FStFNQ0iSdarn1hkQl5
 BpFw4G6noFpE9Pkh3L+LO7+YgHfrgc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-xjl8kRiUPhC-Cq0JLFmUaQ-1; Mon, 20 Apr 2020 23:23:41 -0400
X-MC-Unique: xjl8kRiUPhC-Cq0JLFmUaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27E44107ACC4;
 Tue, 21 Apr 2020 03:23:39 +0000 (UTC)
Received: from [10.72.12.74] (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 847FA9DD78;
 Tue, 21 Apr 2020 03:23:22 +0000 (UTC)
Subject: Re: [RFC v1 1/4] net: Introduce qemu_get_peer
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <33ec31c6-d0e6-0da1-407c-9efe2aa45470@redhat.com>
Date: Tue, 21 Apr 2020 11:23:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420093241.4238-2-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 23:23:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, maxime.coquelin@redhat.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, hanand@xilinx.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> This is a small function  that can get the peer from given NetClientState=
 and queue_index


Unnecessary space=C2=A0 between 'function' and 'that'.


>
> Signed-off-by: Cindy Lu <lulu@redhat.com>


Please split this patch into two parts:

1) introduce the function
2) the actual user for this fucntion


> ---
>   hw/net/vhost_net.c | 16 ++++++++++------
>   include/net/net.h  |  1 +
>   net/net.c          |  6 ++++++
>   3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 6b82803fa7..4096d64aaf 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState=
 *ncs,
>       BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(dev)));
>       VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
>       VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> +    struct vhost_net *net;
>       int r, e, i;
> +    NetClientState *peer;
>  =20
>       if (!k->set_guest_notifiers) {
>           error_report("binding does not support guest notifiers");
> @@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState=
 *ncs,
>       }
>  =20
>       for (i =3D 0; i < total_queues; i++) {
> -        struct vhost_net *net;
>  =20
> -        net =3D get_vhost_net(ncs[i].peer);
> +        peer =3D qemu_get_peer(ncs, i);
> +        net =3D get_vhost_net(peer);
>           vhost_net_set_vq_index(net, i * 2);
>  =20
>           /* Suppress the masking guest notifiers on vhost user
> @@ -335,15 +337,16 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
>       }
>  =20
>       for (i =3D 0; i < total_queues; i++) {
> -        r =3D vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
> +        peer =3D qemu_get_peer(ncs, i);
> +        r =3D vhost_net_start_one(get_vhost_net(peer), dev);
>  =20
>           if (r < 0) {
>               goto err_start;
>           }
>  =20
> -        if (ncs[i].peer->vring_enable) {
> +        if (peer->vring_enable) {
>               /* restore vring enable state */
> -            r =3D vhost_set_vring_enable(ncs[i].peer, ncs[i].peer->vring=
_enable);
> +            r =3D vhost_set_vring_enable(peer, peer->vring_enable);
>  =20
>               if (r < 0) {
>                   goto err_start;
> @@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState=
 *ncs,
>  =20
>   err_start:
>       while (--i >=3D 0) {
> -        vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
> +        peer =3D qemu_get_peer(ncs , i);
> +        vhost_net_stop_one(get_vhost_net(peer), dev);
>       }
>       e =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, false)=
;
>       if (e < 0) {
> diff --git a/include/net/net.h b/include/net/net.h
> index e175ba9677..0a74324ccd 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -175,6 +175,7 @@ void hmp_info_network(Monitor *mon, const QDict *qdic=
t);
>   void net_socket_rs_init(SocketReadState *rs,
>                           SocketReadStateFinalize *finalize,
>                           bool vnet_hdr);
> +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);
>  =20
>   /* NIC info */
>  =20
> diff --git a/net/net.c b/net/net.c
> index 84aa6d8d00..ac5080dda1 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -324,6 +324,12 @@ void *qemu_get_nic_opaque(NetClientState *nc)
>  =20
>       return nic->opaque;
>   }
> +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
> +{
> +    NetClientState *ncs  =3D  nc + queue_index;


Unnecessary space around '=3D'.

Thanks


> +    assert(ncs !=3D NULL);
> +    return ncs->peer;
> +}
>  =20
>   static void qemu_cleanup_net_client(NetClientState *nc)
>   {


