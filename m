Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCAEC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DB224758
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIbP93ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DB224758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9Bi-0004p7-SL
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1is9Af-0003o7-MI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1is9Ac-0005mv-2J
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:43:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1is9Ab-0005mc-TG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579196581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXTLZ9lkCR7S/BctUQH3szo+owmSBBe5xeQGLiOaZJ4=;
 b=SIbP93otWcBqpdVMblN0vhZ7wz2Zlwo4AhEJ9UbLuXYK2zz0kQ+Fnx7zU+w30D+3w7SbB+
 OlfDCP1qv3ZZ2kaQUnZ8GNtZik+MFbGxdfglRBhCqnqOpEUTTp3nUgqY3smehychk+FTB7
 sQZXnN1AAJvTC5F27AA97LIDJW4pT/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-RNMFKORnMBWnFzEOIFEaPQ-1; Thu, 16 Jan 2020 12:42:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB8DC107ACC5;
 Thu, 16 Jan 2020 17:42:56 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A8D2101F942;
 Thu, 16 Jan 2020 17:42:50 +0000 (UTC)
Date: Thu, 16 Jan 2020 17:42:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 093/104] virtiofsd: introduce inode refcount to prevent
 use-after-free
Message-ID: <20200116174248.GK3108@work-vm>
References: <20191212163904.159893-94-dgilbert@redhat.com>
 <20200116122542.20873-1-misono.tomohiro@jp.fujitsu.com>
 <20200116172156.GA285238@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200116172156.GA285238@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: RNMFKORnMBWnFzEOIFEaPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>, vgoyal@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Thu, Jan 16, 2020 at 09:25:42PM +0900, Misono Tomohiro wrote:
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > >=20
> > > If thread A is using an inode it must not be deleted by thread B when
> > > processing a FUSE_FORGET request.
> > >=20
> > > The FUSE protocol itself already has a counter called nlookup that is
> > > used in FUSE_FORGET messages.  We cannot trust this counter since the
> > > untrusted client can manipulate it via FUSE_FORGET messages.
> > >=20
> > > Introduce a new refcount to keep inodes alive for the required lifesp=
an.
> > > lo_inode_put() must be called to release a reference.  FUSE's nlookup
> > > counter holds exactly one reference so that the inode stays alive as
> > > long as the client still wants to remember it.
> > >=20
> > > Note that the lo_inode->is_symlink field is moved to avoid creating a
> > > hole in the struct due to struct field alignment.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  tools/virtiofsd/passthrough_ll.c | 168 ++++++++++++++++++++++++++---=
--
> > >  1 file changed, 145 insertions(+), 23 deletions(-)
> > >=20
> > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
> > > index b19c9ee328..8f4ab8351c 100644
> > > --- a/tools/virtiofsd/passthrough_ll.c
> > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > @@ -99,7 +99,13 @@ struct lo_key {
> > > =20
> > >  struct lo_inode {
> > >      int fd;
> > > -    bool is_symlink;
> > > +
> > > +    /*
> > > +     * Atomic reference count for this object.  The nlookup field ho=
lds a
> > > +     * reference and release it when nlookup reaches 0.
> > > +     */
> > > +    gint refcount;
> > > +
> > >      struct lo_key key;
> > > =20
> > >      /*
> > > @@ -118,6 +124,8 @@ struct lo_inode {
> > >      fuse_ino_t fuse_ino;
> > >      pthread_mutex_t plock_mutex;
> > >      GHashTable *posix_locks; /* protected by lo_inode->plock_mutex *=
/
> > > +
> > > +    bool is_symlink;
> > >  };
> > > =20
> > >  struct lo_cred {
> > > @@ -473,6 +481,23 @@ static ssize_t lo_add_inode_mapping(fuse_req_t r=
eq, struct lo_inode *inode)
> > >      return elem - lo_data(req)->ino_map.elems;
> > >  }
> > > =20
> > > +static void lo_inode_put(struct lo_data *lo, struct lo_inode **inode=
p)
> > > +{
> > > +    struct lo_inode *inode =3D *inodep;
> > > +
> > > +    if (!inode) {
> > > +        return;
> > > +    }
> > > +
> > > +    *inodep =3D NULL;
> > > +
> > > +    if (g_atomic_int_dec_and_test(&inode->refcount)) {
> > > +        close(inode->fd);
> > > +        free(inode);
> > > +    }
> > > +}
> > > +
> > > +/* Caller must release refcount using lo_inode_put() */
> > >  static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
> > >  {
> > >      struct lo_data *lo =3D lo_data(req);
> > > @@ -480,6 +505,9 @@ static struct lo_inode *lo_inode(fuse_req_t req, =
fuse_ino_t ino)
> > > =20
> > >      pthread_mutex_lock(&lo->mutex);
> > >      elem =3D lo_map_get(&lo->ino_map, ino);
> > > +    if (elem) {
> > > +        g_atomic_int_inc(&elem->inode->refcount);
> > > +    }
> > >      pthread_mutex_unlock(&lo->mutex);
> > > =20
> > >      if (!elem) {
> > > @@ -489,10 +517,23 @@ static struct lo_inode *lo_inode(fuse_req_t req=
, fuse_ino_t ino)
> > >      return elem->inode;
> > >  }
> > > =20
> > > +/*
> > > + * TODO Remove this helper and force callers to hold an inode refcou=
nt until
> > > + * they are done with the fd.  This will be done in a later patch to=
 make
> > > + * review easier.
> > > + */
> > >  static int lo_fd(fuse_req_t req, fuse_ino_t ino)
> > >  {
> > >      struct lo_inode *inode =3D lo_inode(req, ino);
> > > -    return inode ? inode->fd : -1;
> > > +    int fd;
> > > +
> > > +    if (!inode) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    fd =3D inode->fd;
> > > +    lo_inode_put(lo_data(req), &inode);
> > > +    return fd;
> > >  }
> > > =20
> > >  static void lo_init(void *userdata, struct fuse_conn_info *conn)
> > > @@ -547,6 +588,10 @@ static void lo_getattr(fuse_req_t req, fuse_ino_=
t ino,
> > >      fuse_reply_attr(req, &buf, lo->timeout);
> > >  }
> > > =20
> > > +/*
> > > + * Increments parent->nlookup and caller must release refcount using
> > > + * lo_inode_put(&parent).
> > > + */
> > >  static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *i=
node,
> > >                                char path[PATH_MAX], struct lo_inode *=
*parent)
> > >  {
> > > @@ -584,6 +629,7 @@ retry:
> > >          p =3D &lo->root;
> > >          pthread_mutex_lock(&lo->mutex);
> > >          p->nlookup++;
> > > +        g_atomic_int_inc(&p->refcount);
> > >          pthread_mutex_unlock(&lo->mutex);
> > >      } else {
> > >          *last =3D '\0';
> >=20
> > We need lo_ionde_put() in error path, right?:
> > https://gitlab.com/virtio-fs/qemu/blob/virtio-fs-as-posted-2019-12-12/t=
ools/virtiofsd/passthrough_ll.c#L680
>=20
> Yes, thanks for spotting this bug!  The lo_parent_and_name() code should
> look like this:
>=20
>   fail_unref:
>       unref_inode_lolocked(lo, p, 1);
>       lo_inode_put(lo, &p);
>   ...

I've merged that one in.

> > nit: if yes, unref_inode_lolocked() is always paired with lo_inode_put(=
).
> > So how about combine them in one function? As p->nloockup and p->refcou=
nt
> > are both incremented in one place (lo_find/lo_parent_and_name) in these=
 case,
> > it seems natural for me to decrement them in one function as well.
>=20
> Nice idea.  I would also drop the nlookup argument - this function will
> only be used with nlookup=3D1.

I'll leave that to you if you want to send a patch on top.

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


