Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CC5C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3B3214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ami8U8M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3B3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8r7-0003Wa-5w
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is8qO-0002Jf-Md
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is8qK-0001YU-Gx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:22:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21923
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is8qK-0001YH-C6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579195323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=trKxfXxT8BkyPuFshY+B8ebvpGMGK7Me7UghOdM9Rus=;
 b=ami8U8M9cWN4fWfyyB9RbQLAcARxdxD0Oh1DIIiRuAJV5TZAp4MtgfoZVhaExsNvteAN4m
 FdLJFiuvV3swwd7CGP7KmXx0Y2cKRNZLDINOKe+63LKII48fghA0ycg7ecskMwsBxT/JOd
 3Qpcs2LmG0A4JhPb02fjEWztBstwljI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-KTQOcxmRMMCWgEXvWFRpeQ-1; Thu, 16 Jan 2020 12:22:00 -0500
X-MC-Unique: KTQOcxmRMMCWgEXvWFRpeQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 654A48D6BFB;
 Thu, 16 Jan 2020 17:21:59 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D168B28985;
 Thu, 16 Jan 2020 17:21:57 +0000 (UTC)
Date: Thu, 16 Jan 2020 17:21:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH 093/104] virtiofsd: introduce inode refcount to prevent
 use-after-free
Message-ID: <20200116172156.GA285238@stefanha-x1.localdomain>
References: <20191212163904.159893-94-dgilbert@redhat.com>
 <20200116122542.20873-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200116122542.20873-1-misono.tomohiro@jp.fujitsu.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
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
Cc: dgilbert@redhat.com, vgoyal@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 09:25:42PM +0900, Misono Tomohiro wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > If thread A is using an inode it must not be deleted by thread B when
> > processing a FUSE_FORGET request.
> >=20
> > The FUSE protocol itself already has a counter called nlookup that is
> > used in FUSE_FORGET messages.  We cannot trust this counter since the
> > untrusted client can manipulate it via FUSE_FORGET messages.
> >=20
> > Introduce a new refcount to keep inodes alive for the required lifespan=
.
> > lo_inode_put() must be called to release a reference.  FUSE's nlookup
> > counter holds exactly one reference so that the inode stays alive as
> > long as the client still wants to remember it.
> >=20
> > Note that the lo_inode->is_symlink field is moved to avoid creating a
> > hole in the struct due to struct field alignment.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 168 ++++++++++++++++++++++++++-----
> >  1 file changed, 145 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index b19c9ee328..8f4ab8351c 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -99,7 +99,13 @@ struct lo_key {
> > =20
> >  struct lo_inode {
> >      int fd;
> > -    bool is_symlink;
> > +
> > +    /*
> > +     * Atomic reference count for this object.  The nlookup field hold=
s a
> > +     * reference and release it when nlookup reaches 0.
> > +     */
> > +    gint refcount;
> > +
> >      struct lo_key key;
> > =20
> >      /*
> > @@ -118,6 +124,8 @@ struct lo_inode {
> >      fuse_ino_t fuse_ino;
> >      pthread_mutex_t plock_mutex;
> >      GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
> > +
> > +    bool is_symlink;
> >  };
> > =20
> >  struct lo_cred {
> > @@ -473,6 +481,23 @@ static ssize_t lo_add_inode_mapping(fuse_req_t req=
, struct lo_inode *inode)
> >      return elem - lo_data(req)->ino_map.elems;
> >  }
> > =20
> > +static void lo_inode_put(struct lo_data *lo, struct lo_inode **inodep)
> > +{
> > +    struct lo_inode *inode =3D *inodep;
> > +
> > +    if (!inode) {
> > +        return;
> > +    }
> > +
> > +    *inodep =3D NULL;
> > +
> > +    if (g_atomic_int_dec_and_test(&inode->refcount)) {
> > +        close(inode->fd);
> > +        free(inode);
> > +    }
> > +}
> > +
> > +/* Caller must release refcount using lo_inode_put() */
> >  static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
> >  {
> >      struct lo_data *lo =3D lo_data(req);
> > @@ -480,6 +505,9 @@ static struct lo_inode *lo_inode(fuse_req_t req, fu=
se_ino_t ino)
> > =20
> >      pthread_mutex_lock(&lo->mutex);
> >      elem =3D lo_map_get(&lo->ino_map, ino);
> > +    if (elem) {
> > +        g_atomic_int_inc(&elem->inode->refcount);
> > +    }
> >      pthread_mutex_unlock(&lo->mutex);
> > =20
> >      if (!elem) {
> > @@ -489,10 +517,23 @@ static struct lo_inode *lo_inode(fuse_req_t req, =
fuse_ino_t ino)
> >      return elem->inode;
> >  }
> > =20
> > +/*
> > + * TODO Remove this helper and force callers to hold an inode refcount=
 until
> > + * they are done with the fd.  This will be done in a later patch to m=
ake
> > + * review easier.
> > + */
> >  static int lo_fd(fuse_req_t req, fuse_ino_t ino)
> >  {
> >      struct lo_inode *inode =3D lo_inode(req, ino);
> > -    return inode ? inode->fd : -1;
> > +    int fd;
> > +
> > +    if (!inode) {
> > +        return -1;
> > +    }
> > +
> > +    fd =3D inode->fd;
> > +    lo_inode_put(lo_data(req), &inode);
> > +    return fd;
> >  }
> > =20
> >  static void lo_init(void *userdata, struct fuse_conn_info *conn)
> > @@ -547,6 +588,10 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t =
ino,
> >      fuse_reply_attr(req, &buf, lo->timeout);
> >  }
> > =20
> > +/*
> > + * Increments parent->nlookup and caller must release refcount using
> > + * lo_inode_put(&parent).
> > + */
> >  static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *ino=
de,
> >                                char path[PATH_MAX], struct lo_inode **p=
arent)
> >  {
> > @@ -584,6 +629,7 @@ retry:
> >          p =3D &lo->root;
> >          pthread_mutex_lock(&lo->mutex);
> >          p->nlookup++;
> > +        g_atomic_int_inc(&p->refcount);
> >          pthread_mutex_unlock(&lo->mutex);
> >      } else {
> >          *last =3D '\0';
>=20
> We need lo_ionde_put() in error path, right?:
> https://gitlab.com/virtio-fs/qemu/blob/virtio-fs-as-posted-2019-12-12/too=
ls/virtiofsd/passthrough_ll.c#L680

Yes, thanks for spotting this bug!  The lo_parent_and_name() code should
look like this:

  fail_unref:
      unref_inode_lolocked(lo, p, 1);
      lo_inode_put(lo, &p);
  ...

> nit: if yes, unref_inode_lolocked() is always paired with lo_inode_put().
> So how about combine them in one function? As p->nloockup and p->refcount
> are both incremented in one place (lo_find/lo_parent_and_name) in these c=
ase,
> it seems natural for me to decrement them in one function as well.

Nice idea.  I would also drop the nlookup argument - this function will
only be used with nlookup=3D1.

Stefan

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4gm7QACgkQnKSrs4Gr
c8jLhwf8DHIbmH6c0afqG45cNsziwPQ3Tf/ehkHXMasD4QDaNP/iNoUmD6Jp3osq
yvNlkvq+czQ2t1BgR7fuJNUyZkvho3sF8PmLm01esU/Qhc6CeO3g07cVOdUBTaan
fq7vHNRb8O0Cgc8SWYWHHZsxYzRepimrntqVaMAc8OkZa7iVAfJNHedknEf0coBq
5d+l9+8AeyDy4f5uY3FoTHeplIDZMSEWKDLCM1xtovqJDD02yemCRFgS/OWhGQEY
tmeSmcxYyrshGTysmbGFnzHwGzc3MObSK/hRvplfGnt+ZIFx2Qr03TetN5ulvbG6
J5iHGGUpEfUMOxDnDyFtszdV+9uF7g==
=z+Xo
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


