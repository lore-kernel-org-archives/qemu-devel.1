Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6C8C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150DB2070E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+/u1fOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150DB2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFtV-0004T6-5z
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:14:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iVFs2-0002vj-S1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iVFs0-0003f2-G9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:13:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iVFs0-0003eu-7c
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573740790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afQY2mkX8raKtVeJCB1KgS8X6yBGBW6wYCPBWbNcnTE=;
 b=D+/u1fOlmgd40T7h1gHOyV3OM+SJQeg0GchGdGLaaBUORteluOGSJ3VarlieNeLEG7feVt
 CdUfdfRPUHeNF5+QpQYlhEnvE2QdF5NTakWQ6+3SsqREEqREfxS1vowC/Q7Bkh+RLUh34e
 xEJMCFCI7NkP2oF4noz0ld4462JNSrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-PfnrM7a8P8Oq-BabfTi5ng-1; Thu, 14 Nov 2019 09:13:07 -0500
X-MC-Unique: PfnrM7a8P8Oq-BabfTi5ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D747801E7E;
 Thu, 14 Nov 2019 14:13:06 +0000 (UTC)
Received: from localhost (unknown [10.33.36.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BEFF5C1C3;
 Thu, 14 Nov 2019 14:13:02 +0000 (UTC)
Date: Thu, 14 Nov 2019 14:13:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 17/30] virtiofsd: Add main virtio loop
Message-ID: <20191114141301.GA592348@stefanha-x1.localdomain>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191021105832.36574-18-dgilbert@redhat.com>
 <CAJ+F1CKmujLfL=n-UPLeps7BcQ=WcibHzsCWt+Pff3zLbSwvYA@mail.gmail.com>
 <20191022110725.GF2815@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191022110725.GF2815@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 piaojun@huawei.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 12:07:25PM +0100, Dr. David Alan Gilbert wrote:
> * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > On Mon, Oct 21, 2019 at 1:26 PM Dr. David Alan Gilbert (git)
> > <dgilbert@redhat.com> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >
> > > Processes incoming requests on the vhost-user fd.
> >=20
> > Is there a reason to avoid using glib & its main loop?
>=20
> Not particularly;  would it actually work out any easier?
> Is there an easy way to get the glib loop to check something like
> the fuse_session_exited at each iteration.
>=20
> I probably didn't originally because I wasn't sure if this code
> was going back into libfuse or staying here; and libfuse doesn't
> use glib.

I tried to convert this to glib a few months ago, but stopped because
libvhost-user-glib.c is difficult to use from multiple threads.  If I
remember correctly we'd need to change it quite a bit to make
multi-threaded vhost-user device backends possible and I gave up.

Stefan

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3NYO0ACgkQnKSrs4Gr
c8hDuAgAjJwzyJqJM9lRE+R5g8bALa61fL/3aAVvsUliWfSujkZrJtazf9Pq1vnK
PT202+GIZTchNF1J6GM6/MyeEpsJeHbyMNbSqR31IXn/0NpP9iRRotxqLFcGaYam
Nz+HyX+Gwnv9N69AaOMGVYtwgQ3MFlNr7Dy1iScHrrCVcroIfjaJ5U3/pbBshugq
R81h8ueT6UtRGs9TlHPW/FCK7JvEj7NUfys1W8CE4ijaQTCzxg9/ZR9mcVf/B1eV
HCf+CTVlhP3/HxsWW4N2ILeHL5GUE+SvP2Rqpy6lDompnZ3GR8xpdWXThmEGinsm
3cd0ioqP13aImRq1ka2xlkteqyAzjw==
=ZbTj
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


