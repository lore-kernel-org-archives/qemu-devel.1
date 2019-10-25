Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07944CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0D221929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCW3fI6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0D221929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNz8I-0000wz-QJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNz6q-0007nn-6O
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNz6o-0003g2-9M
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:54:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNz6o-0003fl-4L
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572008065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TA7eD7IsYsIbUSWGqggYr4KjVZNHikVmaz0w8tPv9Kw=;
 b=fCW3fI6coDq/miVIkZxcT8hyqGVnN1cb+U1I66hmvM1Cg6Wnhk3zW3/eBF3CsIu1qVRTgV
 sI0LA+kbO58egfM0/3M+A5o7Lc4vUHTUG96B48i+MVlhnc3WwaKc7bWxQ/a2W3ciU9bh2N
 E+lK7Txjh3OmaJ7dsbPsbrReT9/qwcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-XiMq8M6GMkOYlfHoOCwHIQ-1; Fri, 25 Oct 2019 08:54:22 -0400
X-MC-Unique: XiMq8M6GMkOYlfHoOCwHIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A9FA476;
 Fri, 25 Oct 2019 12:54:21 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E96DE60BEC;
 Fri, 25 Oct 2019 12:54:17 +0000 (UTC)
Date: Fri, 25 Oct 2019 14:54:16 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Message-ID: <20191025125416.GE13314@stefanha-x1.localdomain>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017160953.GC1266@stefanha-x1.localdomain>
 <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
 <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
 <OSBPR01MB37835DC3A2F179AFD3A9074BE56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
 <20191021094047.GF22659@stefanha-x1.localdomain>
 <OSBPR01MB3783A810FEC4C2F3AE7248BAE56B0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB3783A810FEC4C2F3AE7248BAE56B0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 'Miklos Szeredi' <mszeredi@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 11:42:50AM +0000, misono.tomohiro@fujitsu.com wrote=
:
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > Sent: Monday, October 21, 2019 6:41 PM
> > To: Misono, Tomohiro/=E5=91=B3=E6=9B=BD=E9=87=8E =E6=99=BA=E7=A4=BC <mi=
sono.tomohiro@fujitsu.com>
> > Cc: 'Miklos Szeredi' <mszeredi@redhat.com>; virtio-fs@redhat.com; qemu-=
devel@nongnu.org
> > Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr opera=
tion
> >=20
> > On Fri, Oct 18, 2019 at 08:51:20AM +0000, misono.tomohiro@fujitsu.com w=
rote:
> > > > Doing unshare(CLONE_FS) after thread startup seems safe, though mus=
t
> > > > be careful to change the working directory to the root of the mount
> > > > *before* starting any threads.
> > >
> > > I think working directry is changed in setup_sandbox() -> setup_mount=
_namespace() -> setup_pivot_root().
> > > So, can we just add unshare(CLONE_FS) in fv_queue_worker()?
> >=20
> > fv_queue_worker() is the thread pool worker function that is called for=
 each request.  Calling unshare(CLONE_FS) for each request
> > is not necessary and will reduce performance.
> >=20
> > A thread-local variable can be used to avoid repeated calls to
> > unshare(CLONE_FS) from the same worker thread:
> >=20
> >   static __thread bool clone_fs_called;
> >=20
> >   static void fv_queue_worker(gpointer data, gpointer user_data)
> >   {
> >       ...
> >       if (!clone_fs_called) {
> >           int ret;
> >=20
> > =09  ret =3D unshare(CLONE_FS);
> > =09  assert(ret =3D=3D 0); /* errors not expected according to man page=
 */
> >=20
> > =09  clone_fs_called =3D true;
> >       }
> >=20
> > Another issue is the seccomp policy.  Since worker threads are spawned =
at runtime it is necessary to add the unshare(2) syscall
> > to the seccomp whitelist in contrib/virtiofsd/seccomp.c.
> >=20
>=20
> Thanks for suggesting.
>=20
> I tried above code with fchdir() + ...xattr() + fchdir() in lo_...xattr
> and it solves all the problem about xattr I see.
>=20
> However, it seems the fix causes some performance issue in stress test
> as ACL check issues getxattr() and a lot of fchdir() happens. So, I may
> try to combine the old method for regular file and this method for specia=
l
> files.

Sounds good.

Stefan

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2y8HgACgkQnKSrs4Gr
c8irAAf+IexIlrCWNTmr7Bw95qqxQoiZwpMbrxoILzqDtHcZnzUIbCOaKov0rKRD
DzH+m/McH7o3+7yFOUhDuQN8TEkwZTA7WUChLQviRJXIw2ynn13XT7ZQx8XPcbfo
BkI4OE+pHunCyoRtWVgzt/oWo7Vrt+Y5x+gyHQBJPbkq9CWLHGpAgBdZ0c+CAEgS
FHjztRKeNJJ2Xoag52vOk0FvVHw1MxmvMevf+zdUHVTV6eu20VJpX0BRyXnAJoq9
XsHc57N3IJrpKr/YQzfzwCpZ21R/GNuyW5c7tv/X9Lp+PWdypSAAByM+lU/jTvXR
3p9F1uNOujEe7zZhetbREjRnBoYYsw==
=ckH9
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--


