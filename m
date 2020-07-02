Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB11C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C282070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxA4cPYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C282070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqrdN-0002nO-Jh
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 01:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqrXD-00009G-UD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:13:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52366
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqrXA-0007dC-Sx
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593666795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7R0dxTeYIuLbVfvZOCuPGwnYDUnV+nGAg+SjDAAKl7M=;
 b=hxA4cPYAmMq6kcqWLPhdcbHFh+dS9/kCaYW1UhJAXfbpnGFHO5I4YsRNAyMNSQiAJbWrI9
 f9Rry/lMxxOmk7YajHWg3IZQWYxQqrE4I8XcIF8H75tXn2n/euigjB0KCS6/blxA1X7/HS
 KtGK0HcLhbt2YDrj29fDuB6WvkMi56g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-NQXX7zEYMNKc9FjZR4hwhg-1; Thu, 02 Jul 2020 01:13:13 -0400
X-MC-Unique: NQXX7zEYMNKc9FjZR4hwhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD8B41932481;
 Thu,  2 Jul 2020 05:13:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8250619C0;
 Thu,  2 Jul 2020 05:13:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2188611384A6; Thu,  2 Jul 2020 07:13:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/3] util: support detailed error reporting for qemu_open
References: <20200701160509.1523847-1-berrange@redhat.com>
 <20200701160509.1523847-3-berrange@redhat.com>
Date: Thu, 02 Jul 2020 07:13:08 +0200
In-Reply-To: <20200701160509.1523847-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 1 Jul 2020 17:05:08
 +0100")
Message-ID: <87a70i7b4r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 00:52:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 P J P <ppandit@redhat.com>
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
>  include/qemu/osdep.h |  1 +
>  util/osdep.c         | 71 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 58 insertions(+), 14 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 0d26a1b9bd..e41701a308 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -483,6 +483,7 @@ int qemu_madvise(void *addr, size_t len, int advice);
>  int qemu_mprotect_rwx(void *addr, size_t size);
>  int qemu_mprotect_none(void *addr, size_t size);
> =20
> +int qemu_open_err(const char *name, int flags, Error **errp, ...);
>  int qemu_open(const char *name, int flags, ...);
>  int qemu_close(int fd);
>  int qemu_unlink(const char *name);
> diff --git a/util/osdep.c b/util/osdep.c
> index 4bdbe81cec..450b3a5da3 100644
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
> +            error_setg(errp, "Unable to parse fdset %s", name);
>              errno =3D EINVAL;
>              return -1;
>          }
> =20
>          fd =3D monitor_fdset_get_fd(fdset_id, flags);
>          if (fd < 0) {
> +            error_setg_errno(errp, -fd, "Unable acquire FD for %s flags =
%x",
> +                             name, flags);
>              errno =3D -fd;
>              return -1;
>          }
> =20
>          dupfd =3D qemu_dup_flags(fd, flags);
>          if (dupfd =3D=3D -1) {
> +            error_setg_errno(errp, errno, "Unable dup FD for %s flags %x=
",
> +                             name, flags);
>              return -1;
>          }
> =20
>          ret =3D monitor_fdset_dup_fd_add(fdset_id, dupfd);
>          if (ret =3D=3D -1) {
>              close(dupfd);
> +            error_setg(errp, "Unable save FD for %s flags %x",
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
> @@ -340,25 +344,64 @@ int qemu_open(const char *name, int flags, ...)
>      }
>  #endif
> =20
> +    if (ret =3D=3D -1) {
> +        const char *action =3D "open";
> +        if (flags & O_CREAT) {
> +            action =3D "create";
> +        }
>  #ifdef O_DIRECT
> -    if (ret =3D=3D -1 && errno =3D=3D EINVAL && (flags & O_DIRECT)) {
> -        int newflags =3D flags & ~O_DIRECT;
> +        if (errno =3D=3D EINVAL && (flags & O_DIRECT)) {
> +            int newflags =3D flags & ~O_DIRECT;
>  # ifdef O_CLOEXEC
> -        ret =3D open(name, newflags | O_CLOEXEC, mode);
> +            ret =3D open(name, newflags | O_CLOEXEC, mode);
>  # else
> -        ret =3D open(name, newflags, mode);
> +            ret =3D open(name, newflags, mode);
>  # endif
> -        if (ret !=3D -1) {
> -            close(ret);
> -            error_report("file system does not support O_DIRECT");
> -            errno =3D EINVAL;
> +            if (ret !=3D -1) {
> +                close(ret);
> +                error_setg(errp, "Unable to %s '%s' flags 0x%x: "
> +                           "filesystem does not support O_DIRECT",
> +                           action, name, flags);
> +                if (!errp) {

If the caller ignores errors, ...

> +                    error_report("file system does not support O_DIRECT"=
);

... we report this error to stderr (but not any of the other ones).
This is weird.  I figure you do it here to reproduce the weirdness of
qemu_open() before the patch.  Goes back to

    commit a5813077aac7865f69b7ee46a594f3705429f7cd
    Author: Stefan Hajnoczi <stefanha@redhat.com>
    Date:   Thu Aug 22 11:29:03 2013 +0200

        osdep: warn if open(O_DIRECT) on fails with EINVAL

        Print a warning when opening a file O_DIRECT fails with EINVAL.  Th=
is
        saves users a lot of time trying to figure out the EINVAL error, wh=
ich
        is typical when attempting to open a file O_DIRECT on Linux tmpfs.

        Reported-by: Deepak C Shetty <deepakcs@linux.vnet.ibm.com>
        Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
        Reviewed-by: Eric Blake <eblake@redhat.com>

The message isn't phrased as a warning, though.  Should it use
warn_report()?  Stefan?

Regardless, since use of error_report() in a function that returns
errors through its Error ** parameter is an anti-pattern, this use needs
a comment.  I'd make it a TODO comment: convert all callers where the
warning is wanted to qemu_open_err(), then drop it.

> +                }
> +                errno =3D EINVAL;
> +                return -1;
> +            }
>          }
> -    }
>  #endif /* O_DIRECT */
> +        error_setg_errno(errp, errno, "Unable to %s '%s' flags 0x%x",
> +                         action, name, flags);
> +    }
> +
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

I'd rename this to qemu_open_with_bad_error_messages().

For better ones, callers can use

    if (qemu_open_err(name, flags, &err) < 0) {
        error_report_err(err);
        ...
    }

or, where the error is fatal
   =20
    qemu_open_err(name, flags, &error_fatal);

If you prefer not to rename it now, please add a comment why it should
not be used in new code, and existing uses should be converted.

If you rename, call the new one qemu_open().

> +
>  int qemu_close(int fd)
>  {
>      int64_t fdset_id;


