Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938CC83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8EE206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnxfFCft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8EE206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRbU-0001Aa-Na
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTRaT-0007xV-JJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTRaT-0001dn-0i
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:51:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jTRaS-0001Xd-FE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588085511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+7/XWaa2dlapuV80Yin5hW4Ztv+jdrympu0qU8vugo=;
 b=SnxfFCftl48TDBNT7NTi97X4OO8QaQAvZcvOeZDaw7tQx8XmNNWUGjIK3L12p0+mh+Alvr
 2SiWcz3SzQ1tWuxkZCAWmW4hhlIRKuiCeFL5V4oyY9/3EoEtNhMI5WUsd3aT1M/FSB5Dhg
 ZwQuTjqeoEk9uC8/JwtGkiOreg4WSO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420---4CVAWdPx2aLiWDsC1Uvg-1; Tue, 28 Apr 2020 10:51:49 -0400
X-MC-Unique: --4CVAWdPx2aLiWDsC1Uvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350D8468
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 14:51:48 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6A9E5D710;
 Tue, 28 Apr 2020 14:51:44 +0000 (UTC)
Date: Tue, 28 Apr 2020 15:51:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200428145143.GB107541@stefanha-x1.localdomain>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200427175902.GM2923@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2020 at 06:59:02PM +0100, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
> > Currently, setup_mounts() bind-mounts the shared directory without
> > MS_REC.  This makes all submounts disappear.
> >=20
> > Pass MS_REC so that the guest can see submounts again.
>=20
> Thanks!
>=20
> > Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
>=20
> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
>=20
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 4c35c95b25..9d7f863e66 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
> >      int oldroot;
> >      int newroot;
> > =20
> > -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
> > +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
> >          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source,=
 source);
> >          exit(1);
> >      }
>=20
> Do we want MS_SLAVE to pick up future mounts that might happenf rom the
> host?

There are two separate concepts:

1. Mount namespaces.  The virtiofsd process is sandboxed and lives in
   its own mount namespace.  Therefore it does not share the mounts that
   the rest of the host system sees.

2. Propagation type.  This is related to bind mounts so that mount
   operations that happen in one bind-mounted location can also appear
   in other bind-mounted locations.

Since virtiofsd is in a separate mount namespace, does the propagation
type even have any effect?

Stefan

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6oQv8ACgkQnKSrs4Gr
c8hp/Af+L4ecOtUnrwQ5w8BALWGRS8+H4FBMpp9yQLC9GAnJ9ALCfXZ7eaA0E2Us
mPXWs6Tj8FROnIDlqxj3JxEEiSRnb3CG/HYPJE41y0EQYhkY+/ECKpdBlrmANqX/
J+I+dmQO4Ni/PqTu7wfvPSXkCJxUG4IS1vpvBNzjwcoDgDN5oDqW/jcnJc0oqGXi
BLfvoJw6hcuxDO78R9dfyXDRQe4KfdDsaPIwqZUhpy2IEBTR5++c6IeuhzmW9bvv
0cL4dL5y7jTv9/ZQmq02x8us89B/rcEGGdgmB2uN1J0xGSV1RhQK3gL1ABVMOIgh
1aHzkg47gj+f10K1jNEiT/nMm45/gQ==
=5joq
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--


