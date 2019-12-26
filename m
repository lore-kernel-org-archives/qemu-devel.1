Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D2C2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 08:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A75B2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 08:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hROpPl3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A75B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikOzJ-00079v-MP
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 03:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1ikOyj-0006jd-VE
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 03:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1ikOyh-0005b4-C0
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 03:58:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ikOyg-0005aJ-Ly
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 03:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577350721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyEldUfl33CC5C5G2OSaiXYYBEtztMOhX7jDRiN/HFM=;
 b=hROpPl3V0/cU4f8lqfg4Ej18vRHKiaEknEe1nodSkQFICpWjWpnRC3hWQ5FBbq2yVJFeeX
 oKvrwuqXaOMVO5ZqGpFshi+EvA1GiyUrUxsBzOAFaXJpoK9fJy4p3/zoFi9Q+BybcoafDl
 X2FPuHyQKZyqWRCmR755MKToHvhqCtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-e4Ia7I3vOlONDAgMvAEcxA-1; Thu, 26 Dec 2019 03:58:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B191A1804162;
 Thu, 26 Dec 2019 08:58:38 +0000 (UTC)
Received: from [10.72.12.162] (ovpn-12-162.pek2.redhat.com [10.72.12.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB1C60BEC;
 Thu, 26 Dec 2019 08:58:23 +0000 (UTC)
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
To: Yuri Benditovich <yuri.benditovich@daynix.com>, mst@redhat.com,
 qemu-devel@nongnu.org
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
Date: Thu, 26 Dec 2019 16:58:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191226043649.14481-2-yuri.benditovich@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: e4Ia7I3vOlONDAgMvAEcxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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


On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Yuri Benditovich wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> Fix leak of region reference that prevents complete
> device deletion on hot unplug.


More information is needed here, the bug said only q35 can meet this=20
issue. What makes q35 different here?


>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>   hw/virtio/virtio.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5f6c..baadec8abc 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2340,6 +2340,11 @@ void virtio_del_queue(VirtIODevice *vdev, int n)
>       vdev->vq[n].vring.num_default =3D 0;
>       vdev->vq[n].handle_output =3D NULL;
>       vdev->vq[n].handle_aio_output =3D NULL;
> +    /*
> +     * with vring.num =3D 0 the queue will be ignored
> +     * in later loops of region cache reset
> +     */


I can't get the meaning of this comment.

Thanks


> +    virtio_virtqueue_reset_region_cache(&vdev->vq[n]);
>       g_free(vdev->vq[n].used_elems);
>   }
>  =20


