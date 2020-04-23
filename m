Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A718C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A762074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE/sUegb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A762074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbCF-0003sC-U6
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbBU-0002p5-FU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbBT-0000GN-9G
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:42:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRbBS-00006L-Of
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587645745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAL26UHBjJbu+1p/klqDHfWLiWiX8rtL2kou4BdpLsM=;
 b=TE/sUegb80rQVPhZOEz8ugol3TXwc3PX8lUG3blP/YylsfH/u/RSyJYSyZOLmvPYNjXNcy
 YBbF2x/pzImvmOPh7Y31VuZ0TKOFlabQqgCt3y3Br5ssjjDmygBnZdpj9mJXk7tVMFfy6k
 YAokUknvHhkaNPfVvisjJXATK0cNQ+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-WfCySQngM1qwYWFOn98oAA-1; Thu, 23 Apr 2020 08:42:22 -0400
X-MC-Unique: WfCySQngM1qwYWFOn98oAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A780F800C78;
 Thu, 23 Apr 2020 12:42:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AAFC6084C;
 Thu, 23 Apr 2020 12:42:19 +0000 (UTC)
Date: Thu, 23 Apr 2020 14:42:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v5 1/9] block: Add flags to BlockDriver.bdrv_co_truncate()
Message-ID: <20200423124217.GA7687@linux.fritz.box>
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-2-kwolf@redhat.com>
 <f867217d-c202-5d5b-7fb4-ca68e6553265@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f867217d-c202-5d5b-7fb4-ca68e6553265@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.04.2020 um 11:41 hat Max Reitz geschrieben:
> On 22.04.20 17:21, Kevin Wolf wrote:
> > This adds a new BdrvRequestFlags parameter to the .bdrv_co_truncate()
> > driver callbacks, and a supported_truncate_flags field in
> > BlockDriverState that allows drivers to advertise support for request
> > flags in the context of truncate.
> >=20
> > For now, we always pass 0 and no drivers declare support for any flag.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > ---
> >  include/block/block_int.h   | 10 +++++++++-
> >  block/crypto.c              |  3 ++-
> >  block/file-posix.c          |  2 +-
> >  block/file-win32.c          |  2 +-
> >  block/gluster.c             |  1 +
> >  block/io.c                  |  8 +++++++-
> >  block/iscsi.c               |  2 +-
> >  block/nfs.c                 |  3 ++-
> >  block/qcow2.c               |  2 +-
> >  block/qed.c                 |  1 +
> >  block/raw-format.c          |  2 +-
> >  block/rbd.c                 |  1 +
> >  block/sheepdog.c            |  4 ++--
> >  block/ssh.c                 |  2 +-
> >  tests/test-block-iothread.c |  3 ++-
> >  15 files changed, 33 insertions(+), 13 deletions(-)
>=20
> (I know I haven=E2=80=99t complained before, so *shrug*, but I wonder now
> whether it actually makes sense to have the same BdrvRequestFlags for
> all request types.  Or why we have the same flags type for read, write,
> and zero-write already.)

Yeah, nothing this series introduces. I wonder, too, but as long as we
have enough bits to cover flags for all request types, and because we
have overlaps between the request types, it might be easier to have only
one set of flags. So it might be accidental, but I actually feel the
current state isn't bad.

Kevin

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6hjRwACgkQfwmycsiP
L9Y0IQ//R+zY+Fkwaeq7vm2qAQvZhthDBuNLTlJEionwW4hb4A0kAzWHel0j7Hvj
0q9ch3TVnclfDuxu/63sCSUAskQL0fPiLhSk8imZB1V2jldWV7hGACFVUWPjcC4V
dc/2+L6uTgCiqIGLjpSNWkxBNZEGrC/CuymXm7DhHq3lZJ3klnvxvMo5+sbehYXR
n/WOo6U9APbrEjs7kdEk/bKZNVDuPd4M0iemYBpa+qutM4X7UhS5aymcvaJE5D/F
CwIwzwb025p0Ks6vVnEeORgctAYAGeL8hxnVEIhlWYjIN+oqRR87PfM3xKMOOxh+
xNS1q9Tmc79Xlb7hoZd8K3WvKvXccYiuywudakBbGFaYbYavjCWiDWnpegqIcMZA
fA+sMkYbVw8f/Mb3uMMmAQ5UDpsIQbdjSl0BmRJWDEGrCbVkI4yPqaApq4RGEG4/
sgTPltZ91wrcpVDBQvjZ6M2b8a/JD2P7JM7+gYsOUKxzfvB03zX5Akrb+iS8k1na
n+FKx+Ui05vjvRpGw+2zQy+SHv3b910+rXmBdK8ZA1gQfwHVZ3xFkKY1Q5KBAJM6
EXF+P5QJHE7nbwTK5vQFjbKoth5Kz9N/W8JpSakmAUi0CcosMJ1a3gRyVSWYYJJL
PSPers7/FfeyqBBKmclRPttMwtD2ZGwc0kG1VxMly736AbWDrQQ=
=vJZI
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--


