Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B56DC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B852073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZieiqZhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B852073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSCM-000888-Ta
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isS9P-0005hO-4Z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isS9N-0004iO-Nm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:59:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isS9N-0004i0-JG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzB1RIQ/lUNDHRd0+2BDiQtQqEzSUGjRXo4yhZW4rV8=;
 b=ZieiqZhPujUuRWQ4gLLcQrdC9biF5QcBnKBQbZhh1QHmZ8ZzW0hbEHnMPYW2gd2sGDqz1u
 EI+dzxq1MgTW71hKGLdVM7mz+wFWPwCkGcp2TUEUJXNCzC4o4KRqGagOOCGeNzQfxU6jFd
 /NU4oRlkK+RMmyHZp8OaAJQtqPLMswk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-5Zhi-BigMISR2kMNkTvNag-1; Fri, 17 Jan 2020 08:58:59 -0500
Received: by mail-wm1-f72.google.com with SMTP id t16so2297658wmt.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BfpUXc/9hUikSKkEYEvic3CEQR4WqX0Pa6KAzpRWJ3M=;
 b=KiKMm5BxIxF/bCTn3YpkxKTZsd4N8BiSxMXnnDgq5ojuZAO80w0PimeS+kRDvvt0Iq
 oqMFb2wYpPWJBvBBLCGiK50dlC6WocNmat1Dircfhn5rgECAK9GvYyvkSAvwWqpSrxDW
 kEwuNhYec0X0LQPEyiR14pzcUrQyD072KZt4iXEfSJIp0cbSgVuG58WHRCq3O9Yn6WOv
 bzaGfg1XkB98+IND/v30/wiUj6Prf87XefigYmRTtK7PnNEGk18V6DzJeMn2u4h0FqM/
 N7eLicuFkXI5sTLA1ZGkliW7uvfLFvbpQ85W4uI6aP8c5MZt+9LDc3pxn2gCFr4t/Zyw
 JFjA==
X-Gm-Message-State: APjAAAVie2unKmyIb0QPVcaBnuVqbTy4R0ziH6+waIW6F39A6ANzieRO
 buw1kArgGW3ST6dEXXqHopF5oI+QpCi2qpPCz18MqEOLZZivxQb90n722AHde59hpN89Ld8QMcC
 HyTcVMFHjFT5wxC4=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3251699wrs.106.1579269538537; 
 Fri, 17 Jan 2020 05:58:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhGt8ZNuR715J9NltGsVL4Zn0Y1tmhvIjmztnKFWZVQUl/QZDFixTKveV3K3yo0bzv3/6SJA==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3251661wrs.106.1579269538179; 
 Fri, 17 Jan 2020 05:58:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id i5sm34751971wrv.34.2020.01.17.05.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:58:57 -0800 (PST)
Subject: Re: [PATCH 035/104] virtiofsd: passthrough_ll: add dirp_map to hide
 lo_dirp pointers
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-36-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ba0a0624-04df-0211-5ff6-2f7f94fe8e68@redhat.com>
Date: Fri, 17 Jan 2020 14:58:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-36-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: 5Zhi-BigMISR2kMNkTvNag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:37 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Do not expose lo_dirp pointers to clients.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 103 +++++++++++++++++++++++--------
>   1 file changed, 76 insertions(+), 27 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index fd1d88bddf..face8910b0 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -56,27 +56,10 @@
>   #include "passthrough_helpers.h"
>  =20
>   #define HAVE_POSIX_FALLOCATE 1
> -/*
> - * We are re-using pointers to our `struct lo_inode`
> - * elements as inodes. This means that we must be able to
> - * store uintptr_t values in a fuse_ino_t variable. The following
> - * incantation checks this condition at compile time.
> - */
> -#if defined(__GNUC__) &&                                      \
> -    (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 6) && \
> -    !defined __cplusplus
> -_Static_assert(sizeof(fuse_ino_t) >=3D sizeof(uintptr_t),
> -               "fuse_ino_t too small to hold uintptr_t values!");
> -#else
> -struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct {
> -    unsigned _uintptr_to_must_hold_fuse_ino_t
> -        : ((sizeof(fuse_ino_t) >=3D sizeof(uintptr_t)) ? 1 : -1);
> -};
> -#endif
> -
>   struct lo_map_elem {
>       union {
>           struct lo_inode *inode;
> +        struct lo_dirp *dirp;
>           ssize_t freelist;
>       };
>       bool in_use;
> @@ -123,6 +106,7 @@ struct lo_data {
>       int timeout_set;
>       struct lo_inode root; /* protected by lo->mutex */
>       struct lo_map ino_map; /* protected by lo->mutex */
> +    struct lo_map dirp_map; /* protected by lo->mutex */
>   };
>  =20
>   static const struct fuse_opt lo_opts[] =3D {
> @@ -252,6 +236,20 @@ static void lo_map_remove(struct lo_map *map, size_t=
 key)
>       map->freelist =3D key;
>   }
>  =20
> +/* Assumes lo->mutex is held */
> +static ssize_t lo_add_dirp_mapping(fuse_req_t req, struct lo_dirp *dirp)
> +{
> +    struct lo_map_elem *elem;
> +
> +    elem =3D lo_map_alloc_elem(&lo_data(req)->dirp_map);
> +    if (!elem) {
> +        return -1;
> +    }
> +
> +    elem->dirp =3D dirp;
> +    return elem - lo_data(req)->dirp_map.elems;
> +}
> +
>   /* Assumes lo->mutex is held */
>   static ssize_t lo_add_inode_mapping(fuse_req_t req, struct lo_inode *in=
ode)
>   {
> @@ -844,9 +842,19 @@ struct lo_dirp {
>       off_t offset;
>   };
>  =20
> -static struct lo_dirp *lo_dirp(struct fuse_file_info *fi)
> +static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *fi=
)
>   {
> -    return (struct lo_dirp *)(uintptr_t)fi->fh;
> +    struct lo_data *lo =3D lo_data(req);
> +    struct lo_map_elem *elem;
> +
> +    pthread_mutex_lock(&lo->mutex);
> +    elem =3D lo_map_get(&lo->dirp_map, fi->fh);
> +    pthread_mutex_unlock(&lo->mutex);
> +    if (!elem) {
> +        return NULL;
> +    }
> +
> +    return elem->dirp;
>   }
>  =20
>   static void lo_opendir(fuse_req_t req, fuse_ino_t ino,
> @@ -856,6 +864,7 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino=
,
>       struct lo_data *lo =3D lo_data(req);
>       struct lo_dirp *d;
>       int fd;
> +    ssize_t fh;
>  =20
>       d =3D calloc(1, sizeof(struct lo_dirp));
>       if (d =3D=3D NULL) {
> @@ -875,7 +884,14 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t in=
o,
>       d->offset =3D 0;
>       d->entry =3D NULL;
>  =20
> -    fi->fh =3D (uintptr_t)d;
> +    pthread_mutex_lock(&lo->mutex);
> +    fh =3D lo_add_dirp_mapping(req, d);
> +    pthread_mutex_unlock(&lo->mutex);
> +    if (fh =3D=3D -1) {
> +        goto out_err;
> +    }
> +
> +    fi->fh =3D fh;
>       if (lo->cache =3D=3D CACHE_ALWAYS) {
>           fi->keep_cache =3D 1;
>       }
> @@ -886,6 +902,9 @@ out_errno:
>       error =3D errno;
>   out_err:
>       if (d) {
> +        if (d->dp) {
> +            closedir(d->dp);
> +        }
>           if (fd !=3D -1) {
>               close(fd);
>           }
> @@ -903,17 +922,21 @@ static int is_dot_or_dotdot(const char *name)
>   static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
>                             off_t offset, struct fuse_file_info *fi, int =
plus)
>   {
> -    struct lo_dirp *d =3D lo_dirp(fi);
> -    char *buf;
> +    struct lo_dirp *d;
> +    char *buf =3D NULL;
>       char *p;
>       size_t rem =3D size;
> -    int err;
> +    int err =3D ENOMEM;
>  =20
>       (void)ino;
>  =20
> +    d =3D lo_dirp(req, fi);
> +    if (!d) {
> +        goto error;
> +    }
> +
>       buf =3D calloc(1, size);
>       if (!buf) {
> -        err =3D ENOMEM;
>           goto error;
>       }
>       p =3D buf;
> @@ -1011,8 +1034,21 @@ static void lo_readdirplus(fuse_req_t req, fuse_in=
o_t ino, size_t size,
>   static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
>                             struct fuse_file_info *fi)
>   {
> -    struct lo_dirp *d =3D lo_dirp(fi);
> +    struct lo_data *lo =3D lo_data(req);
> +    struct lo_dirp *d;
> +
>       (void)ino;
> +
> +    d =3D lo_dirp(req, fi);
> +    if (!d) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
> +    pthread_mutex_lock(&lo->mutex);
> +    lo_map_remove(&lo->dirp_map, fi->fh);
> +    pthread_mutex_unlock(&lo->mutex);
> +
>       closedir(d->dp);
>       free(d);
>       fuse_reply_err(req, 0);
> @@ -1064,8 +1100,18 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t=
 ino, int datasync,
>                           struct fuse_file_info *fi)
>   {
>       int res;
> -    int fd =3D dirfd(lo_dirp(fi)->dp);
> +    struct lo_dirp *d;
> +    int fd;
> +
>       (void)ino;
> +
> +    d =3D lo_dirp(req, fi);
> +    if (!d) {
> +        fuse_reply_err(req, EBADF);
> +        return;
> +    }
> +
> +    fd =3D dirfd(d->dp);
>       if (datasync) {
>           res =3D fdatasync(fd);
>       } else {
> @@ -1597,6 +1643,8 @@ int main(int argc, char *argv[])
>       root_elem =3D lo_map_reserve(&lo.ino_map, lo.root.fuse_ino);
>       root_elem->inode =3D &lo.root;
>  =20
> +    lo_map_init(&lo.dirp_map);
> +
>       if (fuse_parse_cmdline(&args, &opts) !=3D 0) {
>           return 1;
>       }
> @@ -1693,6 +1741,7 @@ err_out2:
>   err_out1:
>       fuse_opt_free_args(&args);
>  =20
> +    lo_map_destroy(&lo.dirp_map);
>       lo_map_destroy(&lo.ino_map);
>  =20
>       if (lo.root.fd >=3D 0) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


