Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FFCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7107D2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7TsH4xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7107D2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUCz-0007uG-Hb
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMUBQ-0006XU-JX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMUBO-00016J-Qd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:40:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMUBO-00015L-EI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571650856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qbaFTQYHaKC6G5ZmcDhxlD+UXt6aA534AGHUiDHB7tg=;
 b=B7TsH4xQFKmzyxhDbfgm18o6bO1tDbNka8XYqqnCq+1TEMFZHhc1TWnTdFZE4fiCir0sOx
 jyPBLWzcJV/wyDr6Jen/zzgvHmDXKwKRKhogPatR56j9Po34XZd6tqwo5X5/8bDT5FuRoF
 k3mn2Ga5R3vl2Hof87y/P5eC0YrMZcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-pqlboy_xOAG5VbLs08ONsg-1; Mon, 21 Oct 2019 05:40:53 -0400
X-MC-Unique: pqlboy_xOAG5VbLs08ONsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F358476;
 Mon, 21 Oct 2019 09:40:52 +0000 (UTC)
Received: from localhost (ovpn-116-128.ams2.redhat.com [10.36.116.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 509605C240;
 Mon, 21 Oct 2019 09:40:49 +0000 (UTC)
Date: Mon, 21 Oct 2019 10:40:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Message-ID: <20191021094047.GF22659@stefanha-x1.localdomain>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017160953.GC1266@stefanha-x1.localdomain>
 <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
 <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
 <OSBPR01MB37835DC3A2F179AFD3A9074BE56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB37835DC3A2F179AFD3A9074BE56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 08:51:20AM +0000, misono.tomohiro@fujitsu.com wrote=
:
> > Doing unshare(CLONE_FS) after thread startup seems safe, though must be=
 careful to change the working directory to the root of
> > the mount
> > *before* starting any threads.
>=20
> I think working directry is changed in setup_sandbox() -> setup_mount_nam=
espace() -> setup_pivot_root().
> So, can we just add unshare(CLONE_FS) in fv_queue_worker()?

fv_queue_worker() is the thread pool worker function that is called for
each request.  Calling unshare(CLONE_FS) for each request is not
necessary and will reduce performance.

A thread-local variable can be used to avoid repeated calls to
unshare(CLONE_FS) from the same worker thread:

  static __thread bool clone_fs_called;

  static void fv_queue_worker(gpointer data, gpointer user_data)
  {
      ...
      if (!clone_fs_called) {
          int ret;

=09  ret =3D unshare(CLONE_FS);
=09  assert(ret =3D=3D 0); /* errors not expected according to man page */

=09  clone_fs_called =3D true;
      }

Another issue is the seccomp policy.  Since worker threads are spawned
at runtime it is necessary to add the unshare(2) syscall to the seccomp
whitelist in contrib/virtiofsd/seccomp.c.

Stefan

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2tfR8ACgkQnKSrs4Gr
c8izkQf9HxlTQy7DcT+pdpRQd6UUnU5d8j/LAJQKySzzdGOYE6xf84D/YZy2AevH
rJOFV20qZJxzDWUvlSrLD9se98SE6pcnBSTAom+RR+XOjZm4/+9pzax5Ss3vbgqK
74hv+d7rLPwNEqs/CZMzt1GaM7YyRycTGzbTosRwVfpBOO5oAcjHGjco2TelyrsF
kdjvSgTd+jTfr+KdUbB0NOX+58RpiA4Yn1MQpEctkh0wOJZdL2kSqpTiwiRu5qDm
jqPlPsIpdkCRxbvzn4bcEWfoRchgvtJ/L3CQJ1zHL14IJ3LmG5wat0Bn0tMdH/eU
Tq37p22dYRjkN3twX6S/+Tmu+PlfMQ==
=u3k2
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--


