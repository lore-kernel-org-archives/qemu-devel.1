Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46402077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUAJGK4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46402077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMH9-0007JS-US
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ieMGX-0006ri-OJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ieMGV-0006Lb-5j
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:52:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ieMGU-0006Jo-IZ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575910325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFs18uhLXzYzrJiONDCXu9JISpGM0P3G9lut/Qq+XFg=;
 b=aUAJGK4VbSHu8b3HwFivPgXiH8TKzwAAMk5IZJOlbcFqn1lggPuu7jsySaVhtp/o1lSmoy
 M9eCymmBxikbU6lFuKMaskq5qa+E+82rhHxNyADvMW7f+OUaGrSku1UKe1feR7tVft/wDs
 lykabJEdH7ffiN2Q10TY385o8Drn0YM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-IxYA98aCMHClsnxsV_5cQg-1; Mon, 09 Dec 2019 11:52:04 -0500
Received: by mail-qv1-f70.google.com with SMTP id n11so4963734qvp.15
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 08:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=snZsO0rVNAScbDY8sMhuJWyGpf1QC4xmqvlfyr6jphA=;
 b=pU9JQv+LWtOsTu0HjyVoBdUZQH/KCb/O4ElzCjOJb4sdAp7B5sIxw8/zgiSQTFK/BB
 6LktHvN3xp3aNfR2trBqymdprVs+9YtLfx7CYpHnEtl3Vz6DEQDAm+D6rnYdgn9i0zC9
 hsep3uixgUxwukVUzlZRcmtFQZ+Ap8Wgi7JsuIy/KDOyc0LZTrRWdiNIV1972y4QNSC2
 uK2f2c6fMyZRKb5pFTR3FzZR8NwfiIqCHBpWJWgdIj8PfTX44fMzY4QNOYo69kGRf46v
 QIjPClNwuslbzHTuPMS69KpjYFxkoBrMKOkUr7YubiXx8goUHQ7Ca45bAgEg7J1JDHwN
 Y+8g==
X-Gm-Message-State: APjAAAWYam+4aaVim3Z5rqos+lOMXeE0Gofif35sApZfDHO92XQ8k4WY
 WmdRGhUxvFjEwsC7sT1PPDnmad0Yr65XB/7n/I6T/0BFvh6TpJMqRvzlIqL3VvfYPM3xTSpaHSv
 S0b6bm/OIHRAPenk=
X-Received: by 2002:ad4:41c3:: with SMTP id a3mr5046245qvq.187.1575910323682; 
 Mon, 09 Dec 2019 08:52:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqx63nVTP4ZG754/meUH337QMHlNccMS/Ap0efxJhYibe9u9NOIDdDVof9qmrqOp0GRLCnnwyQ==
X-Received: by 2002:ad4:41c3:: with SMTP id a3mr5046217qvq.187.1575910323427; 
 Mon, 09 Dec 2019 08:52:03 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id e123sm11437qkf.80.2019.12.09.08.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 08:52:02 -0800 (PST)
Date: Mon, 9 Dec 2019 11:51:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v2 3/3] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
Message-ID: <20191209115132-mutt-send-email-mst@kernel.org>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <1575444716-17632-3-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1575444716-17632-3-git-send-email-pannengyuan@huawei.com>
X-MC-Unique: IxYA98aCMHClsnxsV_5cQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: liyiting@huawei.com, Laurent Vivier <lvivier@redhat.com>,
 zhang.zhanghailiang@huawei.com, Amit Shah <amit@kernel.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Headers are wrong for this one: charset=3D"y" confuses git am.


On Wed, Dec 04, 2019 at 03:31:56PM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> ivqs/ovqs/c_ivq/c_ovq is forgot to cleanup in
> virtio_serial_device_unrealize, the memory leak stack is as bellow:
>=20
> Direct leak of 1290240 byte(s) in 180 object(s) allocated from:
>     #0 0x7fc9bfc27560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
>     #1 0x7fc9bed6f015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
>     #2 0x5650e02b83e7 in virtio_add_queue hw/virtio/virtio.c:2327
>     #3 0x5650e02847b5 in virtio_serial_device_realize hw/char/virtio-seri=
al-bus.c:1089
>     #4 0x5650e02b56a7 in virtio_device_realize hw/virtio/virtio.c:3504
>     #5 0x5650e03bf031 in device_set_realized hw/core/qdev.c:876
>     #6 0x5650e0531efd in property_set_bool qom/object.c:2080
>     #7 0x5650e053650e in object_property_set_qobject qom/qom-qobject.c:26
>     #8 0x5650e0533e14 in object_property_set_bool qom/object.c:1338
>     #9 0x5650e04c0e37 in virtio_pci_realize hw/virtio/virtio-pci.c:1801
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: "Marc-Andr=E9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
> Changes v2 to v1:
> - use virtio_delete_queue to cleanup vq through a vq pointer (suggested b=
y
>   Michael S. Tsirkin)
> ---
>  hw/char/virtio-serial-bus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 3325904..e1cbce3 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -1126,9 +1126,17 @@ static void virtio_serial_device_unrealize(DeviceS=
tate *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIOSerial *vser =3D VIRTIO_SERIAL(dev);
> +    int i;
> =20
>      QLIST_REMOVE(vser, next);
> =20
> +    virtio_delete_queue(vser->c_ivq);
> +    virtio_delete_queue(vser->c_ovq);
> +    for (i =3D 0; i < vser->bus.max_nr_ports; i++) {
> +        virtio_delete_queue(vser->ivqs[i]);
> +        virtio_delete_queue(vser->ovqs[i]);
> +    }
> +
>      g_free(vser->ivqs);
>      g_free(vser->ovqs);
>      g_free(vser->ports_map);
> --=20
> 2.7.2.windows.1
>=20


