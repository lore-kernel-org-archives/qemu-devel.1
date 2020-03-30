Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D6C2D0EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14FE20776
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjoyYSPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14FE20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqHp-0007vX-UU
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jIqGy-0007Nr-5d
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jIqGx-0007QP-38
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:59:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jIqGw-0007MQ-RK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585558794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1nAxrbQD/+dgcRCWpiBzRcuEvJtBwecxcKi+yldxcg=;
 b=hjoyYSPYXWFtJ3ZPW2bZhZaTbMQCWUcc2dbhc1lgXqrcjb3i2Y9a0/BaXmPvTooOXQD+Wb
 8YmGjLAbwmABtuOVnXX+aIl/o/M5oQBwrOPA5MtkM3dRzZsG5h798I//eAM3qtDwCVqZMQ
 csgWuwNbf6cvrYYonitY+X81KdoNfwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-khgARi1JPjKfDNR6_6ILWg-1; Mon, 30 Mar 2020 04:59:50 -0400
X-MC-Unique: khgARi1JPjKfDNR6_6ILWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA4151B18BC0;
 Mon, 30 Mar 2020 08:59:48 +0000 (UTC)
Received: from localhost (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E92296F88;
 Mon, 30 Mar 2020 08:59:44 +0000 (UTC)
Date: Mon, 30 Mar 2020 09:59:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v4 1/2] virtio-blk: delete vqs on the error path in
 realize()
Message-ID: <20200330085943.GC73285@stefanha-x1.localdomain>
References: <20200328005705.29898-1-pannengyuan@huawei.com>
 <20200328005705.29898-2-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200328005705.29898-2-pannengyuan@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2020 at 08:57:04AM +0800, Pan Nengyuan wrote:
> virtio_vqs forgot to free on the error path in realize(). Fix that.
>=20
> The asan stack:
> Direct leak of 14336 byte(s) in 1 object(s) allocated from:
>     #0 0x7f58b93fd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7f58b858249d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x5562cc627f49 in virtio_add_queue /mnt/sdb/qemu/hw/virtio/virtio.=
c:2413
>     #3 0x5562cc4b524a in virtio_blk_device_realize /mnt/sdb/qemu/hw/block=
/virtio-blk.c:1202
>     #4 0x5562cc613050 in virtio_device_realize /mnt/sdb/qemu/hw/virtio/vi=
rtio.c:3615
>     #5 0x5562ccb7a568 in device_set_realized /mnt/sdb/qemu/hw/core/qdev.c=
:891
>     #6 0x5562cd39cd45 in property_set_bool /mnt/sdb/qemu/qom/object.c:223=
8
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2->v1:
> - Fix incorrect free in v1, it will cause a uaf.
> ---
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> ---
>  hw/block/virtio-blk.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6BtP8ACgkQnKSrs4Gr
c8gESgf/RCCIDVrVFRCVHyrLXBti0JX3+VS+aJx1JpcUPBKYC6rR2ipjQafU73Od
EtS94d8NL/+tNLRvz+B/6L1+qjynJXx2fDC37Yosbs6MhF53C6kP7jR3K/koaFi1
UPdMO1tkT6F1h4f45eFLFGC9o8eUn9zsKn5PKYGUwJsNHekS75xPW89rwN96HA6z
q4ky52h3UhufGwG1q9+/y7l/vsQGO22iYoT0kdLEZvFHBjDqIO+iYVGmuROy19G/
sh7S6vMKnpDnbChnNOMtHedk+efKjbmrOyb3WbxAlxNaPWJqy/iuVEq45ce+OZMu
Q2hg0nQMj8RhAP2mNSsyU9oyWn4KFA==
=6IOZ
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--


