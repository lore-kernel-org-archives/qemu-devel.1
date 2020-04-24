Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779AEC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4350720728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdMEixW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4350720728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxvW-00085l-8i
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxsQ-0000hh-6D
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRxsP-0006vK-IP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:56:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46118
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jRxsP-0006ru-27
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587732976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPfeiv8Eg3qK1qqCHb17WUOMOlNmOqPDQsQ9YGUtLyo=;
 b=HdMEixW/VG8HghIv7Pf60boiWM2rKgEfBDPPdLJqlzJxvgfipZ6e5hJGwO8Lw/nkpsnu+0
 6HahSjgU1tAII42pDKuuQ6yKcUonpc480NL7vW/SZXz+aOvxfoWgrVKbtEaRK5EvdmL+QL
 4PBgQYSBkESLEncYM+9zZEbfooQcXuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-bF8cqahRORilzOpj0ZKiEw-1; Fri, 24 Apr 2020 08:56:09 -0400
X-MC-Unique: bF8cqahRORilzOpj0ZKiEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F9FF460;
 Fri, 24 Apr 2020 12:56:07 +0000 (UTC)
Received: from localhost (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23CFA605CF;
 Fri, 24 Apr 2020 12:56:00 +0000 (UTC)
Date: Fri, 24 Apr 2020 13:55:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 03/36] command-line: refractor parser code
Message-ID: <20200424125559.GD189569@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <d425a6164b01693940fb505002ccebbac7b54dbb.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <d425a6164b01693940fb505002ccebbac7b54dbb.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:38PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Refactor command-line parser code so that it could be used by
> other processes as well.

How will qemu-options-wrapper.h be handled for other processes?  At the
moment qemu-parse.c cannot be reused because it includes this file for
the options list.

> diff --git a/include/qemu-parse.h b/include/qemu-parse.h
> new file mode 100644
> index 0000000000..156b238db6
> --- /dev/null
> +++ b/include/qemu-parse.h
> @@ -0,0 +1,42 @@
> +/*
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.

This code is extracted from vl.c so the copyright should be preserved
and not replaced with yours.

You can add yours for changes that have been made.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef VL_H
> +#define VL_H

#define QEMU_PARSE_H

> +
> +int drive_init_func(void *opaque, QemuOpts *opts, Error **errp);
> +
> +int device_init_func(void *opaque, QemuOpts *opts, Error **errp);

What do drive_init_func() and device_init_func() have to do with
lookup_opt()?  I wouldn't expect to see them in this header file.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6i4d8ACgkQnKSrs4Gr
c8j2twgAmxvJPzt2jtS76joOyek7mBFqYi4xPuhq+cFf6RTie64Wg3b8Rz8fKRKa
qGvv5wAKdxt+EKGSsz2a1qeEAPIwCGC4H5gsugdPQF7hGSfGKSq2sk7/eZFnB67H
veUuKcd9m6NXAZ+nwJ2VM0iJYACrBh3noyI8fwISeSf05y8Hz+CVs01qVpYlRnvP
rZ1V74+1pnsVEcMGhLRJwk9kln7aRMBytUuQOc7+N8qT5e/cJdPEfBuAyj5BWunW
z+OIe85QXcFRGO4kY0z+oRJmzw7+7nNC1v+oglruxjjeMeOIckkZBCr4Xqeij8d3
l/Ufm9rWcAyq+iKt3XMomAcd/KY6Bg==
=SALd
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--


