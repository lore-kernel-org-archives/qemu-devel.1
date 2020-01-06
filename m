Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C19C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DBC2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfK7OGuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DBC2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTPS-0006d4-7C
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ioTOe-0006Ab-9O
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ioTOc-0000Yg-Ay
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:30:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ioTOc-0000Xz-5T
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321017;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+1ExaiqAqfQEXrhdhHvUzGCY2SKObqsetW6umjBdkI=;
 b=HfK7OGuvkFpfzxV5aZstMFlfQwsQsdPlI8orIbBQid/mWsRdbM7Wy4vfjva4TGQ+bvjYX8
 Av0Rl07wjzzf3o0YGzfXosyv9uUn1m1Dbq9ihje57Kb2WdPiAZNHovRkqGckcBzL31ZUi8
 pMHUOizmyYDRGhFYX/HsnLOHVpnwY0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-vWZuVs-kM9GfFjdAqFui8g-1; Mon, 06 Jan 2020 09:30:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 081D41800D4E
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 14:30:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2A2D858A2;
 Mon,  6 Jan 2020 14:30:11 +0000 (UTC)
Date: Mon, 6 Jan 2020 14:30:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 032/104] virtiofsd: passthrough_ll: create new files in
 caller's context
Message-ID: <20200106143011.GK2930416@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-33-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-33-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vWZuVs-kM9GfFjdAqFui8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:52PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Vivek Goyal <vgoyal@redhat.com>
>=20
> We need to create files in the caller's context. Otherwise after
> creating a file, the caller might not be able to do file operations on
> that file.
>=20
> Changed effective uid/gid to caller's uid/gid, create file and then
> switch back to uid/gid 0.
>=20
> Use syscall(setresuid, ...) otherwise glibc does some magic to change EUI=
D
> in all threads, which is not what we want.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 79 ++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 68bacb6fc5..0188cd9ad6 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c


> +static int lo_change_cred(fuse_req_t req, struct lo_cred *old)
> +{
> +    int res;
> +
> +    old->euid =3D geteuid();
> +    old->egid =3D getegid();
> +
> +    res =3D syscall(SYS_setresgid, -1, fuse_req_ctx(req)->gid, -1);

Do we need to be using  SYS_setres[u,g]id32 instead...

[quote setresgid(2)]
       The original Linux setresuid() and setresgid() system  calls
       supported  only  16-bit  user  and group IDs.  Subsequently,
       Linux 2.4 added setresuid32() and setresgid32(),  supporting
       32-bit  IDs.   The glibc setresuid() and setresgid() wrapper
       functions transparently deal with the variations across ker=E2=80=90
       nel versions.
[/quote]

> +    if (res =3D=3D -1) {
> +        return errno;
> +    }
> +
> +    res =3D syscall(SYS_setresuid, -1, fuse_req_ctx(req)->uid, -1);
> +    if (res =3D=3D -1) {
> +        int errno_save =3D errno;
> +
> +        syscall(SYS_setresgid, -1, old->egid, -1);
> +        return errno_save;
> +    }
> +
> +    return 0;
> +}
> +
> +/* Regain Privileges */
> +static void lo_restore_cred(struct lo_cred *old)
> +{
> +    int res;
> +
> +    res =3D syscall(SYS_setresuid, -1, old->euid, -1);
> +    if (res =3D=3D -1) {
> +        fuse_log(FUSE_LOG_ERR, "seteuid(%u): %m\n", old->euid);
> +        exit(1);
> +    }
> +
> +    res =3D syscall(SYS_setresgid, -1, old->egid, -1);
> +    if (res =3D=3D -1) {
> +        fuse_log(FUSE_LOG_ERR, "setegid(%u): %m\n", old->egid);
> +        exit(1);
> +    }
> +}
> +
>  static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t parent,
>                               const char *name, mode_t mode, dev_t rdev,
>                               const char *link)
> @@ -391,12 +443,21 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_i=
no_t parent,
>      int saverr;
>      struct lo_inode *dir =3D lo_inode(req, parent);
>      struct fuse_entry_param e;
> +    struct lo_cred old =3D {};
> =20
>      saverr =3D ENOMEM;
> =20
> +    saverr =3D lo_change_cred(req, &old);
> +    if (saverr) {
> +        goto out;
> +    }
> +
>      res =3D mknod_wrapper(dir->fd, name, link, mode, rdev);
> =20
>      saverr =3D errno;
> +
> +    lo_restore_cred(&old);
> +
>      if (res =3D=3D -1) {
>          goto out;
>      }
> @@ -794,26 +855,34 @@ static void lo_create(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
>      struct lo_data *lo =3D lo_data(req);
>      struct fuse_entry_param e;
>      int err;
> +    struct lo_cred old =3D {};
> =20
>      if (lo_debug(req)) {
>          fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=
=3D%s)\n",
>                   parent, name);
>      }
> =20
> +    err =3D lo_change_cred(req, &old);
> +    if (err) {
> +        goto out;
> +    }
> +
>      fd =3D openat(lo_fd(req, parent), name, (fi->flags | O_CREAT) & ~O_N=
OFOLLOW,
>                  mode);
> -    if (fd =3D=3D -1) {
> -        return (void)fuse_reply_err(req, errno);
> -    }
> +    err =3D fd =3D=3D -1 ? errno : 0;
> +    lo_restore_cred(&old);
> =20
> -    fi->fh =3D fd;
> +    if (!err) {
> +        fi->fh =3D fd;
> +        err =3D lo_do_lookup(req, parent, name, &e);
> +    }
>      if (lo->cache =3D=3D CACHE_NEVER) {
>          fi->direct_io =3D 1;
>      } else if (lo->cache =3D=3D CACHE_ALWAYS) {
>          fi->keep_cache =3D 1;
>      }
> =20
> -    err =3D lo_do_lookup(req, parent, name, &e);
> +out:
>      if (err) {
>          fuse_reply_err(req, err);
>      } else {
> --=20
> 2.23.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


