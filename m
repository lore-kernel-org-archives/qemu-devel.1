Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26082C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CB72072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUrBhPWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CB72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzxhv-0006Wy-8n
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 03:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jzxhH-00063h-C3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:37:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jzxhD-0005Ef-Kf
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595835434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3B4knPh5KPYMIcH2phZe4XtKh/EXdW/hKaE4opSFTs0=;
 b=DUrBhPWVsQx6eohjEL8TJPqUPgV5oo/OqIxKAWMV8pidfTSkAriqpC1CZMwLW+04Ma4+/N
 Bpr/Rc10nrhTl9Zo560H/B2jIl3++GMW5n/RxDiXUSLgyzGdAojE09+fLNf12NXQU7GXud
 jYS2xIbEW5SEZPnspEQY5TMoJ7QOXlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-hJ8vu6F9Oai-Ngtecl_oAQ-1; Mon, 27 Jul 2020 03:37:12 -0400
X-MC-Unique: hJ8vu6F9Oai-Ngtecl_oAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DCDF58;
 Mon, 27 Jul 2020 07:37:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5A385D9E8;
 Mon, 27 Jul 2020 07:37:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E5DE1138648; Mon, 27 Jul 2020 09:37:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/4] util: introduce qemu_open and qemu_create with
 error reporting
References: <20200724132510.3250311-1-berrange@redhat.com>
 <20200724132510.3250311-3-berrange@redhat.com>
Date: Mon, 27 Jul 2020 09:37:09 +0200
In-Reply-To: <20200724132510.3250311-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 24 Jul 2020 14:25:08
 +0100")
Message-ID: <87blk176je.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This introduces two new helper metohds

Typo metohds.

Suggest to be a bit more explicit on why we want to replace qemu_open(),
perhaps like this:

  qemu_open_old() works like open(): set errno and return -1 on failure.
  It has even more failure modes, though.  Reporting the error clearly
  to users is basically impossible for many of them.

  Our standard cure for "errno is too coarse" is the Error object.
  Introduce two new helper methods:

>
>   int qemu_open(const char *name, int flags, Error **errp);
>   int qemu_create(const char *name, int flags, mode_t mode, Error **errp)=
;
>
> Note that with this design we no longer require or even accept the
> O_CREAT flag. Avoiding overloading the two distinct operations
> means we can avoid variable arguments which would prevent 'errp' from
> being the last argument. It also gives us a guarantee that the 'mode' is
> given when creating files, avoiding a latent security bug.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/osdep.h |  6 ++++
>  util/osdep.c         | 78 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 71 insertions(+), 13 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 3a16e58932..ca24ebe211 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -494,7 +494,13 @@ int qemu_madvise(void *addr, size_t len, int advice)=
;
>  int qemu_mprotect_rwx(void *addr, size_t size);
>  int qemu_mprotect_none(void *addr, size_t size);
> =20
> +/*
> + * Don't introduce new usage of this function, prefer the following
> + * qemu_open/qemu_create that take a "Error **errp"
> + */
>  int qemu_open_old(const char *name, int flags, ...);
> +int qemu_open(const char *name, int flags, Error **errp);
> +int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
>  int qemu_close(int fd);
>  int qemu_unlink(const char *name);
>  #ifndef _WIN32
> diff --git a/util/osdep.c b/util/osdep.c
> index 9df1b6adec..5c0f4684b1 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
> =20
>  /* Needed early for CONFIG_BSD etc. */
> =20
> @@ -282,10 +283,10 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_=
t len, bool exclusive)
>  /*
>   * Opens a file with FD_CLOEXEC set
>   */
> -int qemu_open_old(const char *name, int flags, ...)
> +static int
> +qemu_open_internal(const char *name, int flags, mode_t mode, Error **err=
p)
>  {
>      int ret;
> -    int mode =3D 0;
> =20
>  #ifndef _WIN32
>      const char *fdset_id_str;
> @@ -297,24 +298,31 @@ int qemu_open_old(const char *name, int flags, ...)
> =20
>          fdset_id =3D qemu_parse_fdset(fdset_id_str);
>          if (fdset_id =3D=3D -1) {
> +            error_setg(errp, "Could not parse fdset %s", name);
>              errno =3D EINVAL;
>              return -1;
>          }
> =20
>          fd =3D monitor_fdset_get_fd(fdset_id, flags);
>          if (fd < 0) {
> +            error_setg_errno(errp, -fd, "Could not acquire FD for %s fla=
gs %x",
> +                             name, flags);
>              errno =3D -fd;
>              return -1;
>          }
> =20
>          dupfd =3D qemu_dup_flags(fd, flags);
>          if (dupfd =3D=3D -1) {
> +            error_setg_errno(errp, errno, "Could not dup FD for %s flags=
 %x",
> +                             name, flags);
>              return -1;
>          }
> =20
>          ret =3D monitor_fdset_dup_fd_add(fdset_id, dupfd);
>          if (ret =3D=3D -1) {
>              close(dupfd);
> +            error_setg(errp, "Could not save FD for %s flags %x",
> +                       name, flags);
>              errno =3D EINVAL;
>              return -1;
>          }
> @@ -323,22 +331,66 @@ int qemu_open_old(const char *name, int flags, ...)
>      }
>  #endif
> =20
> -    if (flags & O_CREAT) {
> -        va_list ap;
> -
> -        va_start(ap, flags);
> -        mode =3D va_arg(ap, int);
> -        va_end(ap);
> -    }
> -
>  #ifdef O_CLOEXEC
> -    ret =3D open(name, flags | O_CLOEXEC, mode);
> -#else
> +    flags |=3D O_CLOEXEC;
> +#endif /* O_CLOEXEC */
> +
>      ret =3D open(name, flags, mode);
> +
> +#ifndef O_CLOEXEC
>      if (ret >=3D 0) {
>          qemu_set_cloexec(ret);
>      }
> -#endif
> +#endif /* ! O_CLOEXEC */
> +
> +    if (ret =3D=3D -1) {
> +        const char *action =3D "open";
> +        if (flags & O_CREAT) {
> +            action =3D "create";
> +        }

I'd prefer

           const char *action =3D flags & O_CREAT ? "create" : "open";

Could even be inlined into the call.  Matter of taste.

> +        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
> +                         action, name, flags);
> +    }
> +
> +
> +    return ret;
> +}
> +
> +
> +int qemu_open(const char *name, int flags, Error **errp)
> +{
> +    if (flags & O_CREAT) {
> +        error_setg(errp,
> +                   "Invalid O_CREAT flag passed to qemu_open, use qemu_c=
reate");
> +        return -1;
> +    }

Programming error, hence assert(!(flags & O_CREAT)).

> +    return qemu_open_internal(name, flags, 0, errp);
> +}
> +
> +
> +int qemu_create(const char *name, int flags, mode_t mode, Error **errp)
> +{
> +    if (flags & O_CREAT) {
> +        error_setg(errp, "Redundant O_CREAT flag passed to qemu_create")=
;
> +        return -1;
> +    }

Likewise.

> +    return qemu_open_internal(name, flags | O_CREAT, mode, errp);
> +}
> +
> +
> +int qemu_open_old(const char *name, int flags, ...)
> +{
> +    va_list ap;
> +    mode_t mode =3D 0;
> +    int ret;
> +
> +    va_start(ap, flags);
> +    if (flags & O_CREAT) {
> +        mode =3D va_arg(ap, int);
> +    }
> +    va_end(ap);
> +
> +    ret =3D qemu_open_internal(name, flags, mode, NULL);
> =20
>  #ifdef O_DIRECT
>      if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {

Other than that, the patch looks good to me.


