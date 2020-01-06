Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95779C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6002E2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7LKe3uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6002E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXka-0001U3-3J
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ioXci-0007Av-Ab
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ioXcg-00087l-P5
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ioXcg-00083h-Kn
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 14:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578337263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=au/pglmVqc0kAc3cUMqBnW5dy0fhlG/MrR+MRT7YGsc=;
 b=C7LKe3ucJnEx8vUV4HrOxGZt93eHcpWoxdx5uwy5ZWm1Trqd/x0TitsUG3v0uuSI/nxb5M
 74uLSDxhRG1y64iPvsp8T/Te/9kBgdJ6g72q8KHplxhPoIRwAophk9j5CdJeIIPfJvttdg
 cTA99Qzr0d259ZOSfbSF0luVCgUCCAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-5bkmoIheMWu0NfQKt2NATQ-1; Mon, 06 Jan 2020 14:00:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7963E10054E3
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 19:00:47 +0000 (UTC)
Received: from work-vm (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14C2E10016EB;
 Mon,  6 Jan 2020 19:00:43 +0000 (UTC)
Date: Mon, 6 Jan 2020 19:00:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 032/104] virtiofsd: passthrough_ll: create new files in
 caller's context
Message-ID: <20200106190041.GO2798@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-33-dgilbert@redhat.com>
 <20200106143011.GK2930416@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200106143011.GK2930416@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 5bkmoIheMWu0NfQKt2NATQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:37:52PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: Vivek Goyal <vgoyal@redhat.com>
> >=20
> > We need to create files in the caller's context. Otherwise after
> > creating a file, the caller might not be able to do file operations on
> > that file.
> >=20
> > Changed effective uid/gid to caller's uid/gid, create file and then
> > switch back to uid/gid 0.
> >=20
> > Use syscall(setresuid, ...) otherwise glibc does some magic to change E=
UID
> > in all threads, which is not what we want.
> >=20
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 79 ++++++++++++++++++++++++++++++--
> >  1 file changed, 74 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
> > index 68bacb6fc5..0188cd9ad6 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
>=20
>=20
> > +static int lo_change_cred(fuse_req_t req, struct lo_cred *old)
> > +{
> > +    int res;
> > +
> > +    old->euid =3D geteuid();
> > +    old->egid =3D getegid();
> > +
> > +    res =3D syscall(SYS_setresgid, -1, fuse_req_ctx(req)->gid, -1);
>=20
> Do we need to be using  SYS_setres[u,g]id32 instead...
>=20
> [quote setresgid(2)]
>        The original Linux setresuid() and setresgid() system  calls
>        supported  only  16-bit  user  and group IDs.  Subsequently,
>        Linux 2.4 added setresuid32() and setresgid32(),  supporting
>        32-bit  IDs.   The glibc setresuid() and setresgid() wrapper
>        functions transparently deal with the variations across ker=E2=80=
=90
>        nel versions.
> [/quote]

OK, updated.

Dave

> > +    if (res =3D=3D -1) {
> > +        return errno;
> > +    }
> > +
> > +    res =3D syscall(SYS_setresuid, -1, fuse_req_ctx(req)->uid, -1);
> > +    if (res =3D=3D -1) {
> > +        int errno_save =3D errno;
> > +
> > +        syscall(SYS_setresgid, -1, old->egid, -1);
> > +        return errno_save;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +/* Regain Privileges */
> > +static void lo_restore_cred(struct lo_cred *old)
> > +{
> > +    int res;
> > +
> > +    res =3D syscall(SYS_setresuid, -1, old->euid, -1);
> > +    if (res =3D=3D -1) {
> > +        fuse_log(FUSE_LOG_ERR, "seteuid(%u): %m\n", old->euid);
> > +        exit(1);
> > +    }
> > +
> > +    res =3D syscall(SYS_setresgid, -1, old->egid, -1);
> > +    if (res =3D=3D -1) {
> > +        fuse_log(FUSE_LOG_ERR, "setegid(%u): %m\n", old->egid);
> > +        exit(1);
> > +    }
> > +}
> > +
> >  static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t parent,
> >                               const char *name, mode_t mode, dev_t rdev=
,
> >                               const char *link)
> > @@ -391,12 +443,21 @@ static void lo_mknod_symlink(fuse_req_t req, fuse=
_ino_t parent,
> >      int saverr;
> >      struct lo_inode *dir =3D lo_inode(req, parent);
> >      struct fuse_entry_param e;
> > +    struct lo_cred old =3D {};
> > =20
> >      saverr =3D ENOMEM;
> > =20
> > +    saverr =3D lo_change_cred(req, &old);
> > +    if (saverr) {
> > +        goto out;
> > +    }
> > +
> >      res =3D mknod_wrapper(dir->fd, name, link, mode, rdev);
> > =20
> >      saverr =3D errno;
> > +
> > +    lo_restore_cred(&old);
> > +
> >      if (res =3D=3D -1) {
> >          goto out;
> >      }
> > @@ -794,26 +855,34 @@ static void lo_create(fuse_req_t req, fuse_ino_t =
parent, const char *name,
> >      struct lo_data *lo =3D lo_data(req);
> >      struct fuse_entry_param e;
> >      int err;
> > +    struct lo_cred old =3D {};
> > =20
> >      if (lo_debug(req)) {
> >          fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=
=3D%s)\n",
> >                   parent, name);
> >      }
> > =20
> > +    err =3D lo_change_cred(req, &old);
> > +    if (err) {
> > +        goto out;
> > +    }
> > +
> >      fd =3D openat(lo_fd(req, parent), name, (fi->flags | O_CREAT) & ~O=
_NOFOLLOW,
> >                  mode);
> > -    if (fd =3D=3D -1) {
> > -        return (void)fuse_reply_err(req, errno);
> > -    }
> > +    err =3D fd =3D=3D -1 ? errno : 0;
> > +    lo_restore_cred(&old);
> > =20
> > -    fi->fh =3D fd;
> > +    if (!err) {
> > +        fi->fh =3D fd;
> > +        err =3D lo_do_lookup(req, parent, name, &e);
> > +    }
> >      if (lo->cache =3D=3D CACHE_NEVER) {
> >          fi->direct_io =3D 1;
> >      } else if (lo->cache =3D=3D CACHE_ALWAYS) {
> >          fi->keep_cache =3D 1;
> >      }
> > =20
> > -    err =3D lo_do_lookup(req, parent, name, &e);
> > +out:
> >      if (err) {
> >          fuse_reply_err(req, err);
> >      } else {
> > --=20
> > 2.23.0
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


