Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69CBC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B1022429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcyJv/KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B1022429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNPa-00069a-KB
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXNOa-0005hk-OL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXNOZ-0005tz-2m
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:39:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXNOY-0005rY-Na
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574246373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbUCroYrsOKm24GkPMLY9554EhoI1BgIYaZ/M1SjEVs=;
 b=EcyJv/KR6n9LOLguXZfACmPRtJkHmMBTTokP7y+yhRxMneNsT2XrH5NwAIiM1I9ZrzGWwX
 BpfAml2fvjrRMcC+K8FTss3wJPWNef+mQqjxGxECEmBvkWdxPuUr38DuS2mKIFmsjscNRP
 T7kCjVqFMFxARAYQnufmxgpGhDdxQnY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-E0d54D4zO1-2KC04B1n2hQ-1; Wed, 20 Nov 2019 05:39:28 -0500
Received: by mail-qk1-f198.google.com with SMTP id r2so15612541qkb.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D99scMFloTcsjZULsGbtGWwWyNrbMKc2KppHYRdGzyc=;
 b=flNznNCyuJ2KatRNZHoNarCw6xUuMOzmYPuJ7IOfTnB3HIw+wxBydzerGguiVGkkBs
 e0NhokfhP+2dP+MBeld8uy8EHpw0XxU9Bf80AJ8ht95U8TWc+34a3CgOc+o8XZlu0NCT
 Nhjv4TFZrShcr02xFWk2Da4HkhxsQE0ul6wUczoFcsRzk90NLoEIuMVe1P/yRZQyCUXn
 L0MQzXLEMF9NcrgGtNWf9WIXhjt43jX6Pdx8xdVWOXHIFnI2JDgrpij/J1V9Vtmad+hE
 Gn/qAJaiNLowqAToDrHtkCAh6CHpRXkOjaKADpQIgvWrgGf4PXfiZlp2JmqNWblUWFEK
 dTdQ==
X-Gm-Message-State: APjAAAWSe4c/Yqcdgfj9odqGH7GCCXN4Ojyl1xp3hiA2QOAMA7s81rEX
 ZBfz7p4V6WEG9fx8u+ZOhbcg3WgCi0iDHt97glYmY9rAvUrs4UgHPYga5bXE5UZPf2/tpz5pkRR
 QrrWBb4dzgx/Oeq8=
X-Received: by 2002:a05:620a:64d:: with SMTP id
 a13mr1604550qka.481.1574246368107; 
 Wed, 20 Nov 2019 02:39:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoUNtm+WiGubkm0dmwmZsAIVxpu0MljQpOTLdGkLnqFrHjsO18/PTSV1DVT7uTZ5+pYDjjGQ==
X-Received: by 2002:a05:620a:64d:: with SMTP id
 a13mr1604528qka.481.1574246367778; 
 Wed, 20 Nov 2019 02:39:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id p188sm11582321qkb.94.2019.11.20.02.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:39:26 -0800 (PST)
Date: Wed, 20 Nov 2019 05:39:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 1/4] net/virtio: fix dev_unplug_pending
Message-ID: <20191120053833-mutt-send-email-mst@kernel.org>
References: <20191114141613.15804-1-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191114141613.15804-1-jfreimann@redhat.com>
X-MC-Unique: E0d54D4zO1-2KC04B1n2hQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 03:16:10PM +0100, Jens Freimann wrote:
> .dev_unplug_pending is set up by virtio-net code indepent of whether
> failover=3Don was set for the device or not. This gives a wrong result wh=
en
> we check for existing primary devices in migration code.
>=20
> Fix this by actually calling dev_unplug_pending() instead of just
> checking if the function pointer was set. When the feature was not
> negotiated dev_unplug_pending() will always return false. This prevents
> us from going into the wait-unplug state when there's no primary device
> present.
>=20
> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

This isn't really a series, is it?
Just a bunch of independent patches...

anyway:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/net/virtio-net.c | 3 +++
>  migration/savevm.c  | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 97a5113f7e..946039c0dc 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3124,6 +3124,9 @@ static bool primary_unplug_pending(void *opaque)
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIONet *n =3D VIRTIO_NET(vdev);
> =20
> +    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
> +        return false;
> +    }
>      return n->primary_dev ? n->primary_dev->pending_deleted_event : fals=
e;
>  }
> =20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 966a9c3bdb..a71b930b91 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1119,7 +1119,8 @@ int qemu_savevm_nr_failover_devices(void)
>      int n =3D 0;
> =20
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (se->vmsd && se->vmsd->dev_unplug_pending) {
> +        if (se->vmsd && se->vmsd->dev_unplug_pending &&
> +            se->vmsd->dev_unplug_pending(se->opaque)) {
>              n++;
>          }
>      }
> --=20
> 2.21.0


