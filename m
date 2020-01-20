Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3AAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795E921835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnGADLod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795E921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itX5c-00021a-6i
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itX4K-0000TK-7g
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itX4G-00080L-8c
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:26:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itX4G-0007zz-3T
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579526771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePKwme3r8o0yogR1atRBO9Gz8ZD1AXTKviyqw/4FHak=;
 b=AnGADLod37hDr4L8DQc8CRLqK+6ZuWd+qCDPz4iyA29Q2ZJVbtohf2tEbdTGlvi1rl2nsK
 AgTrQlOaieRMWaSuw1/2qti1ih3ps/tJX5P7RXw/akCItdUcOkk29VqCCcuX4HJxR+iRRo
 WHAf4fckzzqUPSmYJBDaDoYCm2nQ0PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-EFkOQ2-7MXuiJzKC-2q5gA-1; Mon, 20 Jan 2020 08:26:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4985F800D48;
 Mon, 20 Jan 2020 13:26:07 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BEA548;
 Mon, 20 Jan 2020 13:26:03 +0000 (UTC)
Date: Mon, 20 Jan 2020 13:26:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH 037/104] virtiofsd: passthrough_ll: add fallback for racy
 ops
Message-ID: <20200120132601.GM2827@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-38-dgilbert@redhat.com>
 <20200118162259.t5rawdrjgf6t7hjz@gabell>
MIME-Version: 1.0
In-Reply-To: <20200118162259.t5rawdrjgf6t7hjz@gabell>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EFkOQ2-7MXuiJzKC-2q5gA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Masayoshi Mizuma (msys.mizuma@gmail.com) wrote:
> On Thu, Dec 12, 2019 at 04:37:57PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >=20
> > We have two operations that cannot be done race-free on a symlink in
> > certain cases: utimes and link.
> >=20
> > Add racy fallback for these if the race-free method doesn't work.  We d=
o
> > our best to avoid races even in this case:
> >=20
> >   - get absolute path by reading /proc/self/fd/NN symlink
> >=20
> >   - lookup parent directory: after this we are safe against renames in
> >     ancestors
> >=20
> >   - lookup name in parent directory, and verify that we got to the orig=
inal
> >     inode,  if not retry the whole thing
> >=20
> > Both utimes(2) and link(2) hold i_lock on the inode across the operatio=
n,
> > so a racing rename/delete by this fuse instance is not possible, only f=
rom
> > other entities changing the filesystem.
> >=20
> > If the "norace" option is given, then disable the racy fallbacks.
> >=20
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 159 +++++++++++++++++++++++++++----
> >  1 file changed, 142 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 93e74cce21..1faae2753f 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -98,6 +98,7 @@ enum {
> >  struct lo_data {
> >      pthread_mutex_t mutex;
> >      int debug;
> > +    int norace;
> >      int writeback;
> >      int flock;
> >      int xattr;
> > @@ -124,10 +125,15 @@ static const struct fuse_opt lo_opts[] =3D {
> >      { "cache=3Dnever", offsetof(struct lo_data, cache), CACHE_NEVER },
> >      { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_NORMAL },
> >      { "cache=3Dalways", offsetof(struct lo_data, cache), CACHE_ALWAYS =
},
> > -
> > +    { "norace", offsetof(struct lo_data, norace), 1 },
> >      FUSE_OPT_END
> >  };
> > =20
> > +static void unref_inode(struct lo_data *lo, struct lo_inode *inode, ui=
nt64_t n);
> > +
> > +static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
> > +
> > +
> >  static struct lo_data *lo_data(fuse_req_t req)
> >  {
> >      return (struct lo_data *)fuse_req_userdata(req);
> > @@ -347,23 +353,127 @@ static void lo_getattr(fuse_req_t req, fuse_ino_=
t ino,
> >      fuse_reply_attr(req, &buf, lo->timeout);
> >  }
> >  > -static int utimensat_empty_nofollow(struct lo_inode *inode,
> > -                                    const struct timespec *tv)
> > +static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *ino=
de,
> > +                              char path[PATH_MAX], struct lo_inode **p=
arent)
> >  {
> > -    int res;
> >      char procname[64];
> > +    char *last;
> > +    struct stat stat;
> > +    struct lo_inode *p;
> > +    int retries =3D 2;
> > +    int res;
> > +
> > +retry:
> > +    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> > +
> > +    res =3D readlink(procname, path, PATH_MAX);
> > +    if (res < 0) {
>=20
> > +        fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink faile=
d: %m\n");
>=20
> I think it's better to use __func__ macro in case the function name is
> changed in the future.

Yes, agreed - I've changed them all

>            fuse_log(FUSE_LOG_WARNING, "%s: readlink failed: %m\n", __func=
__);
>=20
> > +        goto fail_noretry;
> > +    }
> > +
> > +    if (res >=3D PATH_MAX) {
>=20
> > +        fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink overf=
lowed\n");
>=20
>            fuse_log(FUSE_LOG_WARNING, "%s: readlink overflowed\n", __func=
__);
>=20
> > +        goto fail_noretry;
> > +    }
> > +    path[res] =3D '\0';
> > +
> > +    last =3D strrchr(path, '/');
> > +    if (last =3D=3D NULL) {
> > +        /* Shouldn't happen */
>=20
> > +        fuse_log(
> > +            FUSE_LOG_WARNING,
> > +            "lo_parent_and_name: INTERNAL ERROR: bad path read from pr=
oc\n");
>=20
>            fuse_log(
>                FUSE_LOG_WARNING,
>             "%s: INTERNAL ERROR: bad path read from proc\n", __func__);
>=20
> > +        goto fail_noretry;
> > +    }
> > +    if (last =3D=3D path) {
> > +        p =3D &lo->root;
> > +        pthread_mutex_lock(&lo->mutex);
> > +        p->refcount++;
> > +        pthread_mutex_unlock(&lo->mutex);
> > +    } else {
> > +        *last =3D '\0';
> > +        res =3D fstatat(AT_FDCWD, last =3D=3D path ? "/" : path, &stat=
, 0);
> > +        if (res =3D=3D -1) {
> > +            if (!retries) {
>=20
> > +                fuse_log(FUSE_LOG_WARNING,
> > +                         "lo_parent_and_name: failed to stat parent: %=
m\n");
>=20
>                    fuse_log(FUSE_LOG_WARNING,
>                             "%s: failed to stat parent: %m\n", __func__);
>=20
> > +            }
> > +            goto fail;
> > +        }
> > +        p =3D lo_find(lo, &stat);
> > +        if (p =3D=3D NULL) {
> > +            if (!retries) {
>=20
> > +                fuse_log(FUSE_LOG_WARNING,
> > +                         "lo_parent_and_name: failed to find parent\n"=
);
>=20
>                    fuse_log(FUSE_LOG_WARNING,
>                          "%s: failed to find parent\n", __func__);
>=20
> > +            }
> > +            goto fail;
> > +        }
> > +    }
> > +    last++;
> > +    res =3D fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
> > +    if (res =3D=3D -1) {
> > +        if (!retries) {
>=20
> > +            fuse_log(FUSE_LOG_WARNING,
> > +                     "lo_parent_and_name: failed to stat last\n");
>=20
>                fuse_log(FUSE_LOG_WARNING,
>                      "%s: failed to stat last\n", __func__);
>=20
> > +        }
> > +        goto fail_unref;
> > +    }
> > +    if (stat.st_dev !=3D inode->dev || stat.st_ino !=3D inode->ino) {
> > +        if (!retries) {
>=20
> > +            fuse_log(FUSE_LOG_WARNING,
> > +                     "lo_parent_and_name: failed to match last\n");
>=20
>                fuse_log(FUSE_LOG_WARNING,
>                         "%s: failed to match last\n", __func__);
>=20
> > +        }
> > +        goto fail_unref;
> > +    }
> > +    *parent =3D p;
> > +    memmove(path, last, strlen(last) + 1);
> > +
> > +    return 0;
> > +
> > +fail_unref:
> > +    unref_inode(lo, p, 1);
> > +fail:
> > +    if (retries) {
> > +        retries--;
> > +        goto retry;
> > +    }
> > +fail_noretry:
> > +    errno =3D EIO;
> > +    return -1;
> > +}
> > +
> > +static int utimensat_empty(struct lo_data *lo, struct lo_inode *inode,
> > +                           const struct timespec *tv)
> > +{
> > +    int res;
> > +    struct lo_inode *parent;
> > +    char path[PATH_MAX];
> > =20
> >      if (inode->is_symlink) {
> > -        res =3D utimensat(inode->fd, "", tv, AT_EMPTY_PATH | AT_SYMLIN=
K_NOFOLLOW);
> > +        res =3D utimensat(inode->fd, "", tv, AT_EMPTY_PATH);
> >          if (res =3D=3D -1 && errno =3D=3D EINVAL) {
> >              /* Sorry, no race free way to set times on symlink. */
> > -            errno =3D EPERM;
> > +            if (lo->norace) {
> > +                errno =3D EPERM;
> > +            } else {
> > +                goto fallback;
> > +            }
> >          }
> >          return res;
> >      }
> > -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> > +    sprintf(path, "/proc/self/fd/%i", inode->fd);
> > +
> > +    return utimensat(AT_FDCWD, path, tv, 0);
> > =20
> > -    return utimensat(AT_FDCWD, procname, tv, 0);
> > +fallback:
> > +    res =3D lo_parent_and_name(lo, inode, path, &parent);
> > +    if (res !=3D -1) {
> > +        res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
> > +        unref_inode(lo, parent, 1);
> > +    }
> > +
> > +    return res;
> >  }
> > =20
> >  static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
> > @@ -387,6 +497,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t i=
no, struct stat *attr,
> >  {
> >      int saverr;
> >      char procname[64];
> > +    struct lo_data *lo =3D lo_data(req);
> >      struct lo_inode *inode;
> >      int ifd;
> >      int res;
> > @@ -459,7 +570,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t i=
no, struct stat *attr,
> >          if (fi) {
> >              res =3D futimens(fd, tv);
> >          } else {
> > -            res =3D utimensat_empty_nofollow(inode, tv);
> > +            res =3D utimensat_empty(lo, inode, tv);
> >          }
> >          if (res =3D=3D -1) {
> >              goto out_err;
> > @@ -692,24 +803,38 @@ static void lo_symlink(fuse_req_t req, const char=
 *link, fuse_ino_t parent,
> >      lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
> >  }
> > =20
> > -static int linkat_empty_nofollow(struct lo_inode *inode, int dfd,
> > -                                 const char *name)
> > +static int linkat_empty_nofollow(struct lo_data *lo, struct lo_inode *=
inode,
> > +                                 int dfd, const char *name)
> >  {
> >      int res;
> > -    char procname[64];
> > +    struct lo_inode *parent;
> > +    char path[PATH_MAX];
> > =20
> >      if (inode->is_symlink) {
> >          res =3D linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
> >          if (res =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EINV=
AL)) {
> >              /* Sorry, no race free way to hard-link a symlink. */
> > -            errno =3D EPERM;
> > +            if (lo->norace) {
> > +                errno =3D EPERM;
> > +            } else {
> > +                goto fallback;
> > +            }
> >          }
> >          return res;
> >      }
> > =20
> > -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> > +    sprintf(path, "/proc/self/fd/%i", inode->fd);
> > +
> > +    return linkat(AT_FDCWD, path, dfd, name, AT_SYMLINK_FOLLOW);
> > +
> > +fallback:
> > +    res =3D lo_parent_and_name(lo, inode, path, &parent);
> > +    if (res !=3D -1) {
> > +        res =3D linkat(parent->fd, path, dfd, name, 0);
> > +        unref_inode(lo, parent, 1);
> > +    }
> > =20
> > -    return linkat(AT_FDCWD, procname, dfd, name, AT_SYMLINK_FOLLOW);
> > +    return res;
> >  }
> > =20
> >  static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
> > @@ -731,7 +856,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
 fuse_ino_t parent,
> >      e.attr_timeout =3D lo->timeout;
> >      e.entry_timeout =3D lo->timeout;
> > =20
> > -    res =3D linkat_empty_nofollow(inode, lo_fd(req, parent), name);
> > +    res =3D linkat_empty_nofollow(lo, inode, lo_fd(req, parent), name)=
;
> >      if (res =3D=3D -1) {
> >          goto out_err;
> >      }
> > @@ -1544,7 +1669,7 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_=
t ino, const char *name,
> >      }
> > =20
> >      if (inode->is_symlink) {
> > -        /* Sorry, no race free way to setxattr on symlink. */
> > +        /* Sorry, no race free way to removexattr on symlink. */

I've undone that change; since it looks bogus.

> >          saverr =3D EPERM;
> >          goto out;
> >      }
>=20
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks.

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


