Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D09C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB92D2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuOU8KFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB92D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqF6q-0005ZP-5c
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqF67-00058o-PD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:10:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqF65-0000Yy-VL
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593519045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oO895TD+D0loGlQe8os3O2+2rsClnUIkuSeHCovNRA=;
 b=TuOU8KFLbbmh3QMMCznhBwRifDv0RRLYwSPRqyKgb6FnQlB7Zno+7TX2PJCXmfOxQinA+e
 xdVXV7fkxtZ6TfAUMXk+v0763Mla40lpU4f7CsCjDmWXoKk7iwO2HDQ2AlSUdpBtdV5LV3
 PxAQCU7KL/UwuPQziS7AelkxByMMNCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-GBLN1LjFMPC6j7oBQ7hhMA-1; Tue, 30 Jun 2020 08:10:43 -0400
X-MC-Unique: GBLN1LjFMPC6j7oBQ7hhMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1987987950B
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:10:42 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0344174193;
 Tue, 30 Jun 2020 12:10:38 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:10:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200630121037.GC91444@stefanha-x1.localdomain>
References: <20200629102758.421552-1-cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629102758.421552-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 12:27:58PM +0200, Cornelia Huck wrote:
> virtio-fs devices are only specified for virtio-1, so it is unclear
> how a legacy or transitional device should behave.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---

I thought that the following already forced VIRTIO 1.0 because it
doesn't advertize Legacy or Transitional devices:

  static const VirtioPCIDeviceTypeInfo vhost_user_fs_pci_info =3D {
      .base_name             =3D TYPE_VHOST_USER_FS_PCI,
      .non_transitional_name =3D "vhost-user-fs-pci",
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      .instance_size =3D sizeof(VHostUserFSPCI),
      .instance_init =3D vhost_user_fs_pci_instance_init,
      .class_init    =3D vhost_user_fs_pci_class_init,
  };

Do you have a guest that sees this VIRTIO 1.0 device and still fails to
negotiate the VERSION_1 feature bit?

> diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.=
c
> index e11c889d82b3..244205edf765 100644
> --- a/hw/virtio/vhost-user-fs-pci.c
> +++ b/hw/virtio/vhost-user-fs-pci.c
> @@ -44,6 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
>          vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 2;
>      }
> =20
> +    virtio_pci_force_virtio_1(vpci_dev);

Can this be moved to virtio_pci_types_register() so that it
automatically happens for .non_transitional_name devices?

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77K70ACgkQnKSrs4Gr
c8iVYwf/UxKwc+6oMPifZTDIcw8xqDE9fCUd/ujG7dwZbe5ekcnkOiI2qDY+F2bu
ayZIuuE62wAE/JdAlI3zbf49dv+JqU+a6iYbmeSAx9R9yURBzVuQK4j0x+z+JCbA
BIdwFgDUnUPcNvSBda7HTNwdExID7lZ/7VhANKpqtE3akDZaCB3K6zdCCJY1y4Eq
tc+zJWnDstQNP3DA8EqCb9kbBF/JYcFaLmodSLu/8c4bHM0GO1sL7eyYPu8jnfWx
Cl+KXtEJq8TTdFeG+i3VrvFXZyM3jY0xqUt9vDYXvBZfAlqcVWFTM+MWF0W4ZKw8
kSrpgd8d7FoN/8MXpm4hToepIPQ6rA==
=+FL0
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--


