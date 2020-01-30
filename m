Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED94C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3847F2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkCU/XWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3847F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixA4U-00068n-FK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ixA3Y-0005Zw-Fx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ixA3X-0002bY-AO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:40:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ixA3X-0002aL-5u
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580391626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPRhYwjwcBxeiq1fOSZNnbpqEtmGY3cVVslWUapz0Sw=;
 b=NkCU/XWnnTa/0hnYEAhHaQ2UnY/HRu8upr6Ys0IRi7IfjvpSV3QDv2C03s5vP8suS7/Y4K
 8J3Rzh/kf1vZJGfa3HSV78GZMGlNMZ98vHYxlMrGnlUreOPS7mNESEEZldPXTKYB8Sq+MQ
 Yxy+S6Y4aqFxmGHIeYoBRAK6HGUoKRI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-_grMMwRBMC2fe08gu0X2jA-1; Thu, 30 Jan 2020 08:40:22 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so1717133wrq.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5A8psxYRP6fby1mNJYuii77IUnzd3j4ejQX2Zcm10x0=;
 b=W/yWpWkaNr5cBWNjq11QmT4eCGJetOSyG9iP8KR3lS2tpGnrwsJK4wfRjatN6EO4aZ
 ejhRmpC4IOzo/Adtg0FknkKDSM8JyHc9gKoZbEurMKX/zNgTSq9ADi+x3Pb5sfDfLPbc
 bExeMyKiylncEicSdwlLEwbK6lf3wh6S8qzESWKAYu/4z7HjM/ERRtHrXZfrZWgmcK8u
 SbpLbtIEfiU/J5E7czdtzBUxxyJOQZQhmdkjvI/oOLkQ4hZgDp6KpsX216ACwx4Nus4u
 9W2zs8pdXkd956XuQ/NOfd9O6wY7Wj6yGXEIP9Z+vEWAzOdnjQiDi/SUbK1r/B17i0ZC
 Qxtw==
X-Gm-Message-State: APjAAAV7PIIT9UyUbEq6jzre8eaYVK82Cm53M+Uuf0WXunddgu3WXRpw
 nayrlJlcni9KvhvQ77o3C3hzOE4DsgAqyYHgW44UZMmy0L0Cve6EcBJnt1bx/caaXIPyHfmu3/y
 z15Ra66QTciCzAzE=
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr5609812wrp.17.1580391621711;
 Thu, 30 Jan 2020 05:40:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJr0FRbM63RBFah6oSBv2KO/w5o+aP2KjGGEaQRsbvjDCEqyh4dDK7Z0o0F96NnQ3R7dzRVA==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr5609783wrp.17.1580391621500;
 Thu, 30 Jan 2020 05:40:21 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id e8sm7207062wrt.7.2020.01.30.05.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 05:40:20 -0800 (PST)
Date: Thu, 30 Jan 2020 08:40:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
Message-ID: <20200130084000-mutt-send-email-mst@kernel.org>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200129140702.5411-3-dplotnikov@virtuozzo.com>
X-MC-Unique: _grMMwRBMC2fe08gu0X2jA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
> The goal is to reduce the amount of requests issued by a guest on
> 1M reads/writes. This rises the performance up to 4% on that kind of
> disk access pattern.
>=20
> The maximum chunk size to be used for the guest disk accessing is
> limited with seg_max parameter, which represents the max amount of
> pices in the scatter-geather list in one guest disk request.
>=20
> Since seg_max is virqueue_size dependent, increasing the virtqueue
> size increases seg_max, which, in turn, increases the maximum size
> of data to be read/write from guest disk.
>=20
> More details in the original problem statment:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>


looks good but let's just patch each device separately.

> ---
>  hw/core/machine.c          | 3 +++
>  include/hw/virtio/virtio.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb..8bc401d8b7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,9 @@
>  #include "hw/mem/nvdimm.h"
> =20
>  GlobalProperty hw_compat_4_2[] =3D {
> +    { "virtio-blk-device", "queue-size", "128"},
> +    { "virtio-scsi-device", "virtqueue_size", "128"},
> +    { "vhost-blk-device", "virtqueue_size", "128"},
>      { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
>      { "virtio-blk-device", "seg-max-adjust", "off"},
>      { "virtio-scsi-device", "seg_max_adjust", "off"},
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index a66ea2368b..16d540e390 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -48,7 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *fe=
atures,
>  typedef struct VirtQueue VirtQueue;
> =20
>  #define VIRTQUEUE_MAX_SIZE 1024
> -#define VIRTQUEUE_DEFAULT_SIZE 128
> +#define VIRTQUEUE_DEFAULT_SIZE 256
> =20
>  typedef struct VirtQueueElement
>  {
> --=20
> 2.17.0


