Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5AC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28F121783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 11:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deDbFzZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28F121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU7g8-0008IE-15
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 06:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iU7fS-0007kd-D2
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iU7fR-0008VZ-7u
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:15:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iU7fR-0008V2-4R
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 06:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573470931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDYaKnK7SHy3mXzj1wzR/3s0Wvv47sh0UUXM3G/CLiM=;
 b=deDbFzZUNuqYcwP9YjQWVm/Q/s+e1MVFgg5SqQ3SM9wzOyFyWFuoPlNx1K/iZ4iVXLgFNF
 zStDlGfW91zzWu0NpuLMqUlyMqsoJX8l1K8cc0gq7pnLXGT4m6INriMl6xenaRK1nOdJjU
 ix6H+5mLWeh6Qah2RazbzX4fDPwDQJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-XdLBLbCgP627ZTlM9Mq7cw-1; Mon, 11 Nov 2019 06:15:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5ABE801E51
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 11:15:29 +0000 (UTC)
Received: from gondolin (ovpn-117-4.ams2.redhat.com [10.36.117.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 532E65DD73;
 Mon, 11 Nov 2019 11:15:26 +0000 (UTC)
Date: Mon, 11 Nov 2019 12:15:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH 2/2] vfio-helpers: Free QEMUVFIOState in qemu_vfio_close()
Message-ID: <20191111121523.4e692f1f.cohuck@redhat.com>
In-Reply-To: <14247f68a13c7b9292b91eb7df02de9b9d248544.1573468531.git.mprivozn@redhat.com>
References: <cover.1573468531.git.mprivozn@redhat.com>
 <14247f68a13c7b9292b91eb7df02de9b9d248544.1573468531.git.mprivozn@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: XdLBLbCgP627ZTlM9Mq7cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 11:37:42 +0100
Michal Privoznik <mprivozn@redhat.com> wrote:

> The qemu_vfio_open_pci() allocates this QEMUVFIOState structure
> but free counterpart is missing. Since we already have
> qemu_vfio_close() which does cleanup of the state, it looks like
> a perfect place to free the structure too.
>=20
> =3D=3D178278=3D=3D 528 (360 direct, 168 indirect) bytes in 1 blocks are d=
efinitely lost in loss record 6,605 of 6,985
> =3D=3D178278=3D=3D    at 0x4A35476: calloc (vg_replace_malloc.c:752)
> =3D=3D178278=3D=3D    by 0x51B1158: g_malloc0 (in /usr/lib64/libglib-2.0.=
so.0.6000.6)
> =3D=3D178278=3D=3D    by 0xA68613: qemu_vfio_open_pci (vfio-helpers.c:428=
)
> =3D=3D178278=3D=3D    by 0x9779EA: nvme_init (nvme.c:606)
> =3D=3D178278=3D=3D    by 0x97830F: nvme_file_open (nvme.c:795)
> =3D=3D178278=3D=3D    by 0x8E9439: bdrv_open_driver (block.c:1293)
> =3D=3D178278=3D=3D    by 0x8E9E1C: bdrv_open_common (block.c:1553)
> =3D=3D178278=3D=3D    by 0x8ED264: bdrv_open_inherit (block.c:3083)
> =3D=3D178278=3D=3D    by 0x8ED79D: bdrv_open (block.c:3176)
> =3D=3D178278=3D=3D    by 0x5DA5C1: bds_tree_init (blockdev.c:670)
> =3D=3D178278=3D=3D    by 0x5E2B64: qmp_blockdev_add (blockdev.c:4354)
> =3D=3D178278=3D=3D    by 0x5ECB1D: configure_blockdev (vl.c:1202)
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  util/vfio-helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 813f7ec564..5ff91c1e5c 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -721,4 +721,5 @@ void qemu_vfio_close(QEMUVFIOState *s)
>      close(s->device);
>      close(s->group);
>      close(s->container);
> +    g_free(s);

Not sure if freeing the parameter passed in via a function called
'close' isn't too surprising... it's not that obvious that the caller
is also relinquishing its reference to the QEMUVFIOState; maybe rename
the function to qemu_vfio_close_and_free() or so?

[Looking at the blockdev code, it uses the pattern of first closing the
bs and then freeing it separately, which is a bit odd as the only call
to bdrv_close (which will eventually end up here for nvme) is
immediately followed by a g_free. Just something I noticed.]

>  }


