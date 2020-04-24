Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51CC55194
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BD320776
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+sJPsmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BD320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxNp-0005ve-6t
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxMs-0004mA-NA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxMr-0006yC-VA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:23:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jRxMr-0006pW-EX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587731019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcVsxGcgXx7A6ZhTXDf1tAfwoUEvLV3TtbJmLK5AwMI=;
 b=b+sJPsmok1YZxvZxSIg9ztiSgc7j/0HmuSGFwtYeiaJrNdVPjwNRuCrvh9xHjTrir+Ebj6
 j5c7eNt/Sz4M11QCU71eqmGxfhyE/0NcWdzYOUZJcWm+/tK3bb6C2Jepl0EavxDMjzO2+p
 TicOEUzrI8L0sqD7Fa1EPSs3z8iHjc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-PR_3oo61N-SDlrMPkYWMEw-1; Fri, 24 Apr 2020 08:23:37 -0400
X-MC-Unique: PR_3oo61N-SDlrMPkYWMEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8817419057DA;
 Fri, 24 Apr 2020 12:23:35 +0000 (UTC)
Received: from localhost (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73CE1605E0;
 Fri, 24 Apr 2020 12:23:28 +0000 (UTC)
Date: Fri, 24 Apr 2020 13:23:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/3] block: Add blk_new_with_bs() helper
Message-ID: <20200424122327.GE188259@stefanha-x1.localdomain>
References: <20200423221707.477404-1-eblake@redhat.com>
 <20200423221707.477404-2-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200423221707.477404-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, mreitz@redhat.com, Liu Yuan <namei.unix@gmail.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 05:17:05PM -0500, Eric Blake wrote:
> There are several callers that need to create a new block backend from
> an existing BDS; make the task slightly easier with a common helper
> routine.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/sysemu/block-backend.h |  2 ++
>  block/block-backend.c          | 23 +++++++++++++++++++++++
>  block/crypto.c                 |  8 +++-----
>  block/parallels.c              |  7 +++----
>  block/qcow.c                   |  7 +++----
>  block/qcow2.c                  | 15 ++++++---------
>  block/qed.c                    |  7 +++----
>  block/sheepdog.c               |  9 ++++-----
>  block/vdi.c                    |  7 +++----
>  block/vhdx.c                   |  7 +++----
>  block/vmdk.c                   |  9 ++++-----
>  block/vpc.c                    |  7 +++----
>  blockdev.c                     |  8 +++-----
>  blockjob.c                     |  7 ++-----
>  14 files changed, 65 insertions(+), 58 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6i2j4ACgkQnKSrs4Gr
c8gRIwf/QrnuU48tqV5gVDwvCAvsgYLOvYPFdA3RzGYyqLfU+awh158S9bfHIlJ2
33tLGNXBhWWqvIX5odfBq6I4NbNDqM9hgT6pylB86dCxaQzXPwn2ZRqI9L/BOMrr
EDEk0Mkz8CcXzHMI77s+9y1Ec5qZU/6RnyJgIiVIvaOsL6cEqRjGDgRCzm4DcThE
ifGbmn/a2kZPkkZnWizA8HDwkVXgXLBgFpS8k0IfVxllS618YbqkNlB7UYhFnGGs
z33dnPtgiOnorkXb9JUFGCkhUvEWW9tE1FJIpH+TZutSdpTLVI1SEgg7tQonzRoP
+b+GTqHzy8CGsuYTV3lz2ZGl+/QCQQ==
=4EmP
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--


