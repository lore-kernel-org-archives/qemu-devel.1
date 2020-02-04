Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A9C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31AA20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHrfZhlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31AA20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywsR-0002yQ-2s
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iywrb-0002Wx-Qv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iywra-0005Th-GR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:59:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iywra-0005No-8T
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580817569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDNEZQzYiUKwXPaaLP4HmbHLRnMYBVJDkDKtX+3H2cI=;
 b=aHrfZhlUGm7Brw1dq8E2bR0Orldo+yPOHJGxwGAWQ4Kw/GdG9PaEFSqQ0SpGohmCL1nF/v
 3d4hKaUsdENCPdBMArpPDn17D4FsStOLUCHhB5VpYqasNrrARGlBLBsDDNJQBDQjKN+rvE
 ta8969NNL3qMy9LtOlxr+VEB0mJw1oM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-h9DYTZlEN2OoU7O1EIywTw-1; Tue, 04 Feb 2020 06:59:25 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so1253413wmk.6
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 03:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cPwzpdZ/w8DVC1W0uzHYQjniov6gtsVaZm+k/wQ51ZM=;
 b=I9LxKrS7+PZW2lMQTnML8buGmTfK6TxFEPjGtZnsY0IsVS2iOtSjg7l9FQLCPZf60S
 XMt61PPlVFwOjNC4eVDo48/31n1pVePfSwCtKW2clyYOX6N6xWmsVLRF2AMMja+3rsZB
 dJmTnSF5YRkFkzl3ldfge58uo6oqDGVLOznG8qtoBghPCJdOBTsDm9zEajJp7qB0DF+r
 UVdacZpC/aBTIlOXEaW/x45K8acwWn2TFuBUB0ya58KFGypq54xONsB7QSyV27qFrOaQ
 sYWzZWaTUQ6b18noQ5JCXd5n3JZp2wpEq3liXwhSERrD7oJKtXrgkojRcBOnMiCv79dO
 nMKw==
X-Gm-Message-State: APjAAAXsNKTYTPMOayVku2LZdPSYSUOPqDf1sjHTsOr20o1Gg4emvK+j
 qpgXko/OYZLBTzdlu9lsIxShbNlTqI+fleivTGTdaG88CIg/6nMECi0oEVZdtsOzFFK0metE+kk
 0cmjVUZUDPdlxFyQ=
X-Received: by 2002:a05:600c:10d2:: with SMTP id
 l18mr5418033wmd.122.1580817564495; 
 Tue, 04 Feb 2020 03:59:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXF6lIKYYJu1S/y75oYB20jH8nr5rr5t8UoZ3Kodue0nmHhbIdLcDHH2DmH2uugV6TuY6juQ==
X-Received: by 2002:a05:600c:10d2:: with SMTP id
 l18mr5418016wmd.122.1580817564215; 
 Tue, 04 Feb 2020 03:59:24 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id i16sm3817622wmb.36.2020.02.04.03.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 03:59:23 -0800 (PST)
Subject: Re: [PATCH 1/4] virtiofsd: Remove fuse_req_getgroups
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
References: <20200204110501.10731-1-dgilbert@redhat.com>
 <20200204110501.10731-2-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dde1a9da-770a-5731-8651-68e9acbf3349@redhat.com>
Date: Tue, 4 Feb 2020 12:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204110501.10731-2-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: h9DYTZlEN2OoU7O1EIywTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 12:04 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Remove fuse_req_getgroups that's unused in virtiofsd; it came in
> from libfuse but we don't actually use it.  It was called from
> fuse_getgroups which we previously removed (but had left it's header
> in).
>=20
> Coverity had complained about null termination in it, but removing
> it is the easiest answer.

:)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Fixes: Coverity CID: 1413117 (String not null terminated)
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   tools/virtiofsd/fuse.h          | 20 ---------
>   tools/virtiofsd/fuse_lowlevel.c | 77 ---------------------------------
>   tools/virtiofsd/fuse_lowlevel.h | 21 ---------
>   3 files changed, 118 deletions(-)
>=20
> diff --git a/tools/virtiofsd/fuse.h b/tools/virtiofsd/fuse.h
> index 7a4c713559..aba13fef2d 100644
> --- a/tools/virtiofsd/fuse.h
> +++ b/tools/virtiofsd/fuse.h
> @@ -1006,26 +1006,6 @@ void fuse_exit(struct fuse *f);
>    */
>   struct fuse_context *fuse_get_context(void);
>  =20
> -/**
> - * Get the current supplementary group IDs for the current request
> - *
> - * Similar to the getgroups(2) system call, except the return value is
> - * always the total number of group IDs, even if it is larger than the
> - * specified size.
> - *
> - * The current fuse kernel module in linux (as of 2.6.30) doesn't pass
> - * the group list to userspace, hence this function needs to parse
> - * "/proc/$TID/task/$TID/status" to get the group IDs.
> - *
> - * This feature may not be supported on all operating systems.  In
> - * such a case this function will return -ENOSYS.
> - *
> - * @param size size of given array
> - * @param list array of group IDs to be filled in
> - * @return the total number of supplementary group IDs or -errno on fail=
ure
> - */
> -int fuse_getgroups(int size, gid_t list[]);
> -
>   /**
>    * Check if the current request has already been interrupted
>    *
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index de2e2e0c65..01c418aade 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2667,83 +2667,6 @@ int fuse_lowlevel_is_virtio(struct fuse_session *s=
e)
>       return !!se->virtio_dev;
>   }
>  =20
> -#ifdef linux
> -int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
> -{
> -    char *buf;
> -    size_t bufsize =3D 1024;
> -    char path[128];
> -    int ret;
> -    int fd;
> -    unsigned long pid =3D req->ctx.pid;
> -    char *s;
> -
> -    sprintf(path, "/proc/%lu/task/%lu/status", pid, pid);
> -
> -retry:
> -    buf =3D malloc(bufsize);
> -    if (buf =3D=3D NULL) {
> -        return -ENOMEM;
> -    }
> -
> -    ret =3D -EIO;
> -    fd =3D open(path, O_RDONLY);
> -    if (fd =3D=3D -1) {
> -        goto out_free;
> -    }
> -
> -    ret =3D read(fd, buf, bufsize);
> -    close(fd);
> -    if (ret < 0) {
> -        ret =3D -EIO;
> -        goto out_free;
> -    }
> -
> -    if ((size_t)ret =3D=3D bufsize) {
> -        free(buf);
> -        bufsize *=3D 4;
> -        goto retry;
> -    }
> -
> -    ret =3D -EIO;
> -    s =3D strstr(buf, "\nGroups:");
> -    if (s =3D=3D NULL) {
> -        goto out_free;
> -    }
> -
> -    s +=3D 8;
> -    ret =3D 0;
> -    while (1) {
> -        char *end;
> -        unsigned long val =3D strtoul(s, &end, 0);
> -        if (end =3D=3D s) {
> -            break;
> -        }
> -
> -        s =3D end;
> -        if (ret < size) {
> -            list[ret] =3D val;
> -        }
> -        ret++;
> -    }
> -
> -out_free:
> -    free(buf);
> -    return ret;
> -}
> -#else /* linux */
> -/*
> - * This is currently not implemented on other than Linux...
> - */
> -int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
> -{
> -    (void)req;
> -    (void)size;
> -    (void)list;
> -    return -ENOSYS;
> -}
> -#endif
> -
>   void fuse_session_exit(struct fuse_session *se)
>   {
>       se->exited =3D 1;
> diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowle=
vel.h
> index 138041e5f1..8f6d705b5c 100644
> --- a/tools/virtiofsd/fuse_lowlevel.h
> +++ b/tools/virtiofsd/fuse_lowlevel.h
> @@ -1704,27 +1704,6 @@ void *fuse_req_userdata(fuse_req_t req);
>    */
>   const struct fuse_ctx *fuse_req_ctx(fuse_req_t req);
>  =20
> -/**
> - * Get the current supplementary group IDs for the specified request
> - *
> - * Similar to the getgroups(2) system call, except the return value is
> - * always the total number of group IDs, even if it is larger than the
> - * specified size.
> - *
> - * The current fuse kernel module in linux (as of 2.6.30) doesn't pass
> - * the group list to userspace, hence this function needs to parse
> - * "/proc/$TID/task/$TID/status" to get the group IDs.
> - *
> - * This feature may not be supported on all operating systems.  In
> - * such a case this function will return -ENOSYS.
> - *
> - * @param req request handle
> - * @param size size of given array
> - * @param list array of group IDs to be filled in
> - * @return the total number of supplementary group IDs or -errno on fail=
ure
> - */
> -int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[]);
> -
>   /**
>    * Callback function for an interrupt
>    *
>=20


