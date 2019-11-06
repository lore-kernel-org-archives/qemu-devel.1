Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA3C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79EE217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLHmy4Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79EE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSHAE-0003l9-L5
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSH9U-0003Gq-2d
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSH9S-00088G-Qj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:58:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSH9S-00087m-Ma
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573030733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IMRPZAP7xoJvUhnu19LytPAqzn70+qmL1AMQVFgqTyw=;
 b=ZLHmy4BbhAs8FHPOUT5MayEOHrCrQ/47pgyvHQDwMdKbW6eH16U7Mozv08yFPQeicHGMdU
 6HQrVdOkT6rdRjRWZOdiAh1+vb4jvBrfWm6Ts9eLGkajRed18rSx1X3ye4sTyCuyZy6y+f
 thX31MLt25114KKiAq9T296UPQ3IeMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-CiKUFwDsPtS5NO851EK4yw-1; Wed, 06 Nov 2019 03:58:50 -0500
X-MC-Unique: CiKUFwDsPtS5NO851EK4yw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5350D477;
 Wed,  6 Nov 2019 08:58:49 +0000 (UTC)
Received: from localhost (ovpn-116-171.ams2.redhat.com [10.36.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45335D9CD;
 Wed,  6 Nov 2019 08:58:43 +0000 (UTC)
Date: Wed, 6 Nov 2019 09:58:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Subject: Re: [PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if F_CONFIG_WCE is
 advertised
Message-ID: <20191106085842.GD189998@stefanha-x1.localdomain>
References: <1572978137-189218-1-git-send-email-wrfsh@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <1572978137-189218-1-git-send-email-wrfsh@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
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
Cc: yc-core@yandex-team.ru, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2019 at 09:22:17PM +0300, Evgeny Yakovlev wrote:
> Virtio spec 1.1 (and earlier), 5.2.5.2 Driver Requirements: Device
> Initialization:
>=20
> "Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it if
> they offer VIRTIO_BLK_F_CONFIG_WCE"
>=20
> Currently F_CONFIG_WCE and F_WCE are not connected to each other.
> Qemu will advertise F_CONFIG_WCE if config-wce argument is
> set for virtio-blk device. And F_WCE is advertised only if
> underlying block backend actually has it's caching enabled.
>=20
> Fix this by advertising F_WCE if F_CONFIG_WCE is also advertised.
>=20
> To preserve backwards compatibility with newer machine types make this
> behaviour governed by "x-enable-wce-if-config-wce" virtio-blk-device
> property and introduce hw_compat_4_2 with new property being off by
> default for all machine types <=3D 4.2 (but don't introduce 4.3
> machine type itself yet).
>=20
> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
> ---
>  hw/arm/virt.c                  | 1 +
>  hw/block/virtio-blk.c          | 6 +++++-
>  hw/core/machine.c              | 5 +++++
>  hw/i386/pc_piix.c              | 1 +
>  hw/i386/pc_q35.c               | 1 +
>  hw/ppc/spapr.c                 | 2 +-
>  hw/s390x/s390-virtio-ccw.c     | 1 +
>  include/hw/boards.h            | 3 +++
>  include/hw/virtio/virtio-blk.h | 1 +
>  9 files changed, 19 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Ci0IACgkQnKSrs4Gr
c8hnhwf+LPSnn1rp+aPohz6qdZyXxdT68QkQa4mj4PXh1oHJbTlHwkca9A7apZRX
BXv/rFLXG14NimhjCFSgRY5S69k7QhODFfdBXf7DfKzeNCNS9d1EtKTH9XhhEqyV
zfoBENya3GsxYnTZZbN8a4woN4LRJGv3IfSZ2M2MUj9FRUXCGv1YElEwBH4Ls6+i
C1y7a5UQIBU7EW6ZoK4y35x7CaidEXRn8lAv43EOyECTCJ5zsc1k6SCw6JTLyaPH
toymGI+k8xN8F7VWYyKyX1aHj4EVvDofxIjmKJW41O56kJHPXi/F/Eum6YlUFYOO
ymKXrrlggkxk5atMOCZat3OTd8m5rA==
=q/jW
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--


