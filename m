Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509AC2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 15:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6743820643
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 15:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu3vECvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6743820643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijliM-00037t-Hu
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 10:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1ijlhe-0002fh-0s
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 10:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1ijlhb-0004j8-9d
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 10:02:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1ijlha-0004iz-UP
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 10:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577199745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXFVEfTmxNZqOpRjYAj8P2Bhs5ns+pEc9yCEEYGA6/g=;
 b=Iu3vECvdPvBEeuIRQl6M3rdMnpyKL9qcPPtyWlqzF5hmQw27LJwU3vSvBQoFajAgjyJ5/6
 9sdgbe5dbdAoumlHhKg2EIWupneAyFwPiUUtrb3kSZATPJ4PeZP6k1WJVt6mGmiaITDIhN
 ptcZDcvzC+dVe1V2Cn6xo0BQdiMElmc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-fi61eUxhOYGA2QRoVa8J8Q-1; Tue, 24 Dec 2019 10:02:23 -0500
Received: by mail-wr1-f69.google.com with SMTP id b13so9633707wrx.22
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2019 07:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5UD/7SyVyjVxiZ85bDpW3fbSVGYem3h0OZ46s2GQtTk=;
 b=K4/Xvx1x5WMVMxkrpi5VRfz7mAvTx08JGjUljwB5fAsrDbaR3TEiiljuX4Rpox4YAR
 q7ChNKbpRzTl+zz43E+CPO3Ac6UPkTEMzKcJHEJUISTYvPr/i2ngXu57xXJen7d6Husk
 NYDa8/0qKVw/1NyBTBVlBFvDRdSUDh7buW45cSjX4lkiblC21Bp5fMvU1kDOe9hF9/YK
 2dcJC8nbQiaiGmsJO48qs5oKM++P19JTt+7UgpIpRX4VM7HW7JEtbuBvBGLl91qOGpfm
 Rdn8/P9Q/Xdyhd6lLkzFjV/ozb6hRnSfC4ar3fruPSJFR2dhaRwEaCRKEYQm7oJ9C7/k
 TLyw==
X-Gm-Message-State: APjAAAVsHYqb0pK6gVH4LQylo2GekW5nELaMXxCx2ddK8IxyUIhPU9rG
 CyuiXQr1CzcFc34grw/GPGAq6LE0NnLsbULtQVHk1hhjP35YxN4PEwzl8rr0rUAVvFmQalmLdRM
 AJE+Rx7CbGEf131Q=
X-Received: by 2002:a5d:5308:: with SMTP id e8mr35726209wrv.77.1577199741997; 
 Tue, 24 Dec 2019 07:02:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqya+8hQ2IjSgtFOfNZ9Nb6ECr40034KXEZtOZaZxrtRx0b8z3feoCzQN6X01WQRWFGt2BRiag==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr35726181wrv.77.1577199741812; 
 Tue, 24 Dec 2019 07:02:21 -0800 (PST)
Received: from steredhat ([95.235.120.92])
 by smtp.gmail.com with ESMTPSA id r6sm24556749wrq.92.2019.12.24.07.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2019 07:02:20 -0800 (PST)
Date: Tue, 24 Dec 2019 16:02:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1] virtio-mmio: update queue size on guest write
Message-ID: <20191224150218.mv3ysfgfooe5samh@steredhat>
References: <20191224081446.17003-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191224081446.17003-1-dplotnikov@virtuozzo.com>
X-MC-Unique: fi61eUxhOYGA2QRoVa8J8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 24, 2019 at 11:14:46AM +0300, Denis Plotnikov wrote:
> Some guests read back queue size after writing it.
> Always update the on size write otherwise they might be confused.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/virtio/virtio-mmio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

When I reviewed the Michael's patch for pci transport, I planned to do
the same but I postponed for several reason.

Thanks for doing that!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 94d934c44b..1e40a74869 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -295,8 +295,9 @@ static void virtio_mmio_write(void *opaque, hwaddr of=
fset, uint64_t value,
>          break;
>      case VIRTIO_MMIO_QUEUE_NUM:
>          trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
> +        virtio_queue_set_num(vdev, vdev->queue_sel, value);
> +
>          if (proxy->legacy) {
> -            virtio_queue_set_num(vdev, vdev->queue_sel, value);
>              virtio_queue_update_rings(vdev, vdev->queue_sel);
>          } else {
>              proxy->vqs[vdev->queue_sel].num =3D value;
> --=20
> 2.17.0
>=20
>=20


