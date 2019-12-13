Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F14C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5F52073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS3YkTfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5F52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifici-0003b9-LQ
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifibk-0002Y1-4h
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifibi-0008NX-1p
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:55:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifibh-0008Mf-TG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umbKmLlbP+IyYkIag221k6ZK8r+fM4dy+W1BoauK6TY=;
 b=aS3YkTfHKbUwd1vwwyS+VUNY1GQRKaTzHMU48q/Oro93DiwXwlIzSe6MlEmFp8lTJRjjtH
 oEI6YXJw5YxE0a4h+rr47J0RQ3jNzYyhvgDxaDgMWAsqcAM66n7XVmnP5vgbvvv+TCDoq2
 svElQQex7ZtuK8j+cObBUqV5y/ZRYWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-5eOMEey3NgaUQCqgFmxhWA-1; Fri, 13 Dec 2019 05:55:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 733ADDB61
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 10:55:34 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 345D71001B00;
 Fri, 13 Dec 2019 10:55:28 +0000 (UTC)
Date: Fri, 13 Dec 2019 10:55:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-fs: fix MSI-X nvectors calculation
Message-ID: <20191213105526.GB7302@work-vm>
References: <20191209110759.35227-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191209110759.35227-1-stefanha@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 5eOMEey3NgaUQCqgFmxhWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, Vivek Goyal <vgoyal@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> The following MSI-X vectors are required:
>  * VIRTIO Configuration Change
>  * hiprio virtqueue
>  * requests virtqueues
>=20
> Fix the calculation to reserve enough MSI-X vectors.  Otherwise guest
> drivers fall back to a sub-optional configuration where all virtqueues
> share a single vector.
>=20
> This change does not break live migration compatibility since
> vhost-user-fs-pci devices are not migratable yet.
>=20
> Reported-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Queued for virtiofs

> ---
>  hw/virtio/vhost-user-fs-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.=
c
> index 933a3f265b..e3a649d4a6 100644
> --- a/hw/virtio/vhost-user-fs-pci.c
> +++ b/hw/virtio/vhost-user-fs-pci.c
> @@ -40,7 +40,8 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> =20
>      if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 1;
> +        /* Also reserve config change and hiprio queue vectors */
> +        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 2;
>      }
> =20
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> --=20
> 2.23.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


