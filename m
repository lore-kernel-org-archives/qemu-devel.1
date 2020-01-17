Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3080BC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0284206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BstwlQ5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0284206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS4x-0008LJ-Qq
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isS3N-0006Si-Em
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isS3K-0007kt-Ch
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isS3K-0007kJ-65
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7eTtJqEAQfvfEUt6nFk+8B15m1B+zw/i44hn/2v7NQ=;
 b=BstwlQ5wh/+7gxSJ+gPjaGDrbSWaim8hxrp6zb2p3SMuhNTAOELyrRrBlhzaaNFyikNN+I
 BHPLejIK01V7eCY4FcfkPqtouhrLezKPG/z+apWLKJJtKGHKlJQ1+TW/rSR+rRs8Cqulm2
 cJl19/MkHSt91J2jyT2IT8CvNHQRmOg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-VGvPq0FSMbil6BCR-elsXQ-1; Fri, 17 Jan 2020 08:52:42 -0500
Received: by mail-wm1-f71.google.com with SMTP id 7so1170017wmf.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZzM3gZR0JofKUoSKFb+dfja1apuSWx8c+ZWQR65GCPA=;
 b=VJtVdI0gnYDDaWM51hSL/s4qVKzJ1Fa/JdYeEnUJ7XBwTUWOYcv2nQ8dEuA3wKNlht
 +eqOJ4RXL4JD2dPIteQM6E7t5lvif8ZqQstUmJWVPFNOTRXvW9k3uNlJ621EGl7ZryFX
 QEQE6UPKbkZT30mYDz/mh5X2NeXwUAcSXmGUCNMkyqGFqoQ5IlIo1uFyWmR+07IoxEMO
 3x4SM3W4sPIkaqTOpGFRq9iQcAJ3LlX11CC3Vu+0FpdcKI15hy+tUHPGZrIiiJR46Rvd
 40yATgATdYW6HRaRz2o3JoNqUXY27ssgCsUIlNoyMX2H8eanW1Lvp08Jb3sUsOOqU6XV
 Bf3A==
X-Gm-Message-State: APjAAAWmxtRIwG08dBJGJeK63O3oBaGtTpUKZhIMIJqM9mlV3YRayYaZ
 TtJLANYAZx08jdhEnGqtlZo0cPLBQk6JAYXj5+mkguQ2ZtTHdnToJu5bG1jU5m52NnwhkQCJxBr
 +FgnYw73HxqQ/q8g=
X-Received: by 2002:a1c:4454:: with SMTP id r81mr4746655wma.117.1579269161695; 
 Fri, 17 Jan 2020 05:52:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzf43YHoqm1d+eMVEAu/7PzRGpG4n7JlXz68Gq+sd5Cr1sIES1GKm9vGWjRcxcJxl+fVBE+Bw==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr4746640wma.117.1579269161481; 
 Fri, 17 Jan 2020 05:52:41 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n10sm33547379wrt.14.2020.01.17.05.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:52:40 -0800 (PST)
Subject: Re: [PATCH 089/104] virtiofsd: prevent races with lo_dirp_put()
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-90-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c4145c2-b4a3-bacc-b68e-9c2230765c4d@redhat.com>
Date: Fri, 17 Jan 2020 14:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-90-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: VGvPq0FSMbil6BCR-elsXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:38 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Introduce lo_dirp_put() so that FUSE_RELEASEDIR does not cause
> use-after-free races with other threads that are accessing lo_dirp.
>=20
> Also make lo_releasedir() atomic to prevent FUSE_RELEASEDIR racing with
> itself.  This prevents double-frees.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 41 +++++++++++++++++++++++++++-----
>   1 file changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index eadd568435..7663e574d8 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1317,11 +1317,28 @@ static void lo_readlink(fuse_req_t req, fuse_ino_=
t ino)
>   }
>  =20
>   struct lo_dirp {
> +    gint refcount;
>       DIR *dp;
>       struct dirent *entry;
>       off_t offset;
>   };
>  =20
> +static void lo_dirp_put(struct lo_dirp **dp)
> +{
> +    struct lo_dirp *d =3D *dp;
> +
> +    if (!d) {
> +        return;
> +    }
> +    *dp =3D NULL;
> +
> +    if (g_atomic_int_dec_and_test(&d->refcount)) {
> +        closedir(d->dp);
> +        free(d);
> +    }
> +}
> +
> +/* Call lo_dirp_put() on the return value when no longer needed */
>   static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *f=
i)
>   {
>       struct lo_data *lo =3D lo_data(req);
> @@ -1329,6 +1346,9 @@ static struct lo_dirp *lo_dirp(fuse_req_t req, stru=
ct fuse_file_info *fi)
>  =20
>       pthread_mutex_lock(&lo->mutex);
>       elem =3D lo_map_get(&lo->dirp_map, fi->fh);
> +    if (elem) {
> +        g_atomic_int_inc(&elem->dirp->refcount);
> +    }
>       pthread_mutex_unlock(&lo->mutex);
>       if (!elem) {
>           return NULL;
> @@ -1364,6 +1384,7 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t i=
no,
>       d->offset =3D 0;
>       d->entry =3D NULL;
>  =20
> +    g_atomic_int_set(&d->refcount, 1); /* paired with lo_releasedir() */
>       pthread_mutex_lock(&lo->mutex);
>       fh =3D lo_add_dirp_mapping(req, d);
>       pthread_mutex_unlock(&lo->mutex);
> @@ -1397,7 +1418,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_=
t ino, size_t size,
>                             off_t offset, struct fuse_file_info *fi, int =
plus)
>   {
>       struct lo_data *lo =3D lo_data(req);
> -    struct lo_dirp *d;
> +    struct lo_dirp *d =3D NULL;
>       struct lo_inode *dinode;
>       char *buf =3D NULL;
>       char *p;
> @@ -1487,6 +1508,8 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_=
t ino, size_t size,
>  =20
>       err =3D 0;
>   error:
> +    lo_dirp_put(&d);
> +
>       /*
>        * If there's an error, we can only signal it if we haven't stored
>        * any entries yet - otherwise we'd end up with wrong lookup
> @@ -1517,22 +1540,25 @@ static void lo_releasedir(fuse_req_t req, fuse_in=
o_t ino,
>                             struct fuse_file_info *fi)
>   {
>       struct lo_data *lo =3D lo_data(req);
> +    struct lo_map_elem *elem;
>       struct lo_dirp *d;
>  =20
>       (void)ino;
>  =20
> -    d =3D lo_dirp(req, fi);
> -    if (!d) {
> +    pthread_mutex_lock(&lo->mutex);
> +    elem =3D lo_map_get(&lo->dirp_map, fi->fh);
> +    if (!elem) {
> +        pthread_mutex_unlock(&lo->mutex);
>           fuse_reply_err(req, EBADF);
>           return;
>       }
>  =20
> -    pthread_mutex_lock(&lo->mutex);
> +    d =3D elem->dirp;
>       lo_map_remove(&lo->dirp_map, fi->fh);
>       pthread_mutex_unlock(&lo->mutex);
>  =20
> -    closedir(d->dp);
> -    free(d);
> +    lo_dirp_put(&d); /* paired with lo_opendir() */
> +
>       fuse_reply_err(req, 0);
>   }
>  =20
> @@ -1743,6 +1769,9 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t =
ino, int datasync,
>       } else {
>           res =3D fsync(fd);
>       }
> +
> +    lo_dirp_put(&d);
> +
>       fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


