Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D032C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662A12070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBuPgPi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662A12070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY5rO-0001iR-Jt
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iY5qZ-0000vD-1u
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iY5qV-00019M-RA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:07:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iY5qV-00018j-Hb
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574417242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B1D+SwtVggmk3dwwOmgbNe+ZvEWx5vL7A2JAQDruqG0=;
 b=QBuPgPi/C/7/kNBJJfZSo5X7c5op3OHw5vm3iwucQ5YZq3UEabr2j5q64r2dG1cT6CAGdr
 KufVXUEKgYdmJveyH56/Vc7oo9bit81GFjB3K7oxX27dShj+ym4oZ3Egs7tfdqLXDXkq08
 GZaLU1DrPg27oEeCZKS79W/NxE6VU4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-YPkeqQ2vNtWDL-vyNSOjVQ-1; Fri, 22 Nov 2019 05:07:19 -0500
X-MC-Unique: YPkeqQ2vNtWDL-vyNSOjVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 273128018A1;
 Fri, 22 Nov 2019 10:07:18 +0000 (UTC)
Received: from localhost (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FEE46E71B;
 Fri, 22 Nov 2019 10:07:14 +0000 (UTC)
Date: Fri, 22 Nov 2019 10:07:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/4] virtiofsd: Release file locks using F_UNLCK
Message-ID: <20191122100713.GB464656@stefanha-x1.localdomain>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-2-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205543.1816-2-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
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
Cc: virtio-fs@redhat.com, miklos@szeredi.hu, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:55:40PM -0500, Vivek Goyal wrote:
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
> index bc214df0c7..028e7da273 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -936,6 +936,14 @@ static void put_shared(struct lo_data *lo, struct lo=
_inode *inode)
>  =09}
>  }
> =20
> +static void release_plock(gpointer data)

The name posix_locks_value_destroy() would be clearer because it matches
g_hash_table_new_full() terminology and the function cannot be confused
with a lock acquire/release operation.

This patch conflicts with the cleanups that are currently being made to
virtiofsd:
https://github.com/stefanha/qemu/commit/1e493175feca58a81a2d0cbdac93b92e542=
5d850#diff-ca2dea995d1e6cdb95c8a47c7cca51ceR773

Stefan

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Xs1EACgkQnKSrs4Gr
c8jESgf3bZc3dPzFuIExzraXonKWmv9lpbHO635oRtv46DMrNro6Wb0HCXKgcOqE
AHSyfGUR/+l+wEXpIC0zBvtYYlv/5zyKqLgGrqQqd9BGLbpZt/Wkm4jm2KUKnuQT
9bsrzcWtxeqGXTHB3lcYHM6pY/+luYL9b2W5VmEi26Qflr8dZvlLNFMcL+lH8MPy
barXW/5O4y0575UmaegFcQ04knNblHvkmRTxNNkG1fW5hTT9n72AyyJNzP8mnpdO
1LZWrBrJur/6xTy4OxWPDYyAzJNLT8ReYPGouPk9mkLLIqs5+NnVSX4s3ZJGLbVU
W5Y4ON+7KulyCr6/J/NFJ7BqVkNn
=U24S
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--


