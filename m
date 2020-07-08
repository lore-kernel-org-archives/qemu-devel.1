Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E93C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A6A206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV/uYuMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A6A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJ2H-0002Qg-3n
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtJ1F-0000c5-Vs
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:58:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtJ1D-0005y7-Ho
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594249102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGBci+pSa3XDMsEU0R6TpYQd9OGtC7NZIKDzBAE5FC4=;
 b=LV/uYuMi0TRbyIBDMSj3vg174m4hKbmV46pV5eEaHl/ZBW8x+n/FCUvj45BbVpbFjKQ7/9
 BjTdcbFiTZ/XE1S7kottSgSA2TUgWZZ/D1xJRqKaVkJmvX4MtUsxisOFlbUQHL+aUIAq+Z
 XaDlPXPOkpqGOd4v7qNJM+iOJH8zAsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-feshgTw2M6eVjT3PvqF-3g-1; Wed, 08 Jul 2020 02:55:29 -0400
X-MC-Unique: feshgTw2M6eVjT3PvqF-3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9413DEC1A1;
 Wed,  8 Jul 2020 06:55:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24BC35D9F3;
 Wed,  8 Jul 2020 06:55:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A76961132FD2; Wed,  8 Jul 2020 08:55:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/3] util: support detailed error reporting for
 qemu_open
References: <20200702125612.2176194-1-berrange@redhat.com>
 <20200702125612.2176194-3-berrange@redhat.com>
Date: Wed, 08 Jul 2020 08:55:26 +0200
In-Reply-To: <20200702125612.2176194-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2020 13:56:11
 +0100")
Message-ID: <8736624hsx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 P J P <ppandit@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Create a "qemu_open_err" method which does the same as "qemu_open",
> but with a "Error **errp" for error reporting. There should be no
> behavioural difference for existing callers at this stage.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/osdep.h |  2 ++
>  util/osdep.c         | 66 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 55 insertions(+), 13 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 0d26a1b9bd..8506a978fa 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -483,6 +483,8 @@ int qemu_madvise(void *addr, size_t len, int advice);
>  int qemu_mprotect_rwx(void *addr, size_t size);
>  int qemu_mprotect_none(void *addr, size_t size);
> =20
> +/* This is preferred over qemu_open for its improved error reporting */
> +int qemu_open_err(const char *name, int flags, Error **errp, ...);
>  int qemu_open(const char *name, int flags, ...);
>  int qemu_close(int fd);
>  int qemu_unlink(const char *name);

I still think renaming qemu_open() to something like
qemu_open_with_useless_errors() is the way to go.

> diff --git a/util/osdep.c b/util/osdep.c
> index e2b7507ee2..3de8bee463 100644
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
> @@ -282,7 +283,7 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t =
len, bool exclusive)
>  /*
>   * Opens a file with FD_CLOEXEC set
>   */
> -int qemu_open(const char *name, int flags, ...)
> +static int qemu_openv(const char *name, int flags, Error **errp, va_list=
 ap)
>  {
>      int ret;
>      int mode =3D 0;
> @@ -297,24 +298,31 @@ int qemu_open(const char *name, int flags, ...)
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
> @@ -324,11 +332,7 @@ int qemu_open(const char *name, int flags, ...)
>  #endif
> =20
>      if (flags & O_CREAT) {
> -        va_list ap;
> -
> -        va_start(ap, flags);
>          mode =3D va_arg(ap, int);
> -        va_end(ap);
>      }
> =20
>  #ifdef O_CLOEXEC
> @@ -342,21 +346,57 @@ int qemu_open(const char *name, int flags, ...)
>      }
>  #endif
> =20
> +    if (ret =3D=3D -1) {
> +        const char *action =3D "open";
> +        if (flags & O_CREAT) {
> +            action =3D "create";
> +        }

I'd prefer the more concise single assignment

           const char *action =3D flags & O_CREAT ? "create" : "open";

I'd also put it right at the beginning of the function.

>  #ifdef O_DIRECT
> -    if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {
> -        int newflags =3D flags & ~O_DIRECT;
> -        ret =3D open(name, newflags, mode);
> -        if (ret !=3D -1) {
> -            close(ret);
> -            error_report("file system does not support O_DIRECT");
> -            errno =3D EINVAL;
> +        if (errno =3D=3D EINVAL && (flags & O_DIRECT)) {
> +            int newflags =3D flags & ~O_DIRECT;
> +            ret =3D open(name, newflags, mode);
> +            if (ret !=3D -1) {
> +                close(ret);
> +                error_setg(errp, "Could not %s '%s' flags 0x%x: "
> +                           "filesystem does not support O_DIRECT",
> +                           action, name, flags);
> +                errno =3D EINVAL;
> +                return -1;
> +            }
>          }
> -    }
>  #endif /* O_DIRECT */
> +        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
> +                         action, name, flags);
> +    }
> +

Swapping with PATCH 1 will reduce churn here.

> =20
>      return ret;
>  }
> =20
> +int qemu_open_err(const char *name, int flags, Error **errp, ...)
> +{
> +    va_list ap;
> +    int rv;
> +
> +    va_start(ap, errp);
> +    rv =3D qemu_openv(name, flags, errp, ap);
> +    va_end(ap);
> +
> +    return rv;
> +}
> +
> +int qemu_open(const char *name, int flags, ...)
> +{
> +    va_list ap;
> +    int rv;
> +
> +    va_start(ap, flags);
> +    rv =3D qemu_openv(name, flags, NULL, ap);
> +    va_end(ap);
> +
> +    return rv;
> +}
> +
>  int qemu_close(int fd)
>  {
>      int64_t fdset_id;

Preferably with suggested improvements:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


