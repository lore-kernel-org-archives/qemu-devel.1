Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D0C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE06220679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlIPZV5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE06220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54U3-0003jN-Nw
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j54TC-0002sM-HJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j54T9-0004Fj-RA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:19:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j54T9-0004CO-MK
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582276775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqmH/HpQMr0eVboqMUYU/6Hyru9X8NOkwYOoyVPJ1Bc=;
 b=hlIPZV5Qn4ff+ejqcR7nAx8PkFzSKzgAM/UrXraHX8Tn/EBLYCayLVvIh7yLgu6zqhpuRB
 SflN26vOwo9uTMw6Nx4e8d92jBJZm/p5+EmtRymBPttmCXChxJ2Pw1peXlk8P3Z5qGRIno
 Xmge+Fn3c0xbnjGYRQ+tUONPMv47Nxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-AXI1YvrUNiCXVCKcyzx0-Q-1; Fri, 21 Feb 2020 04:19:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BDD513E4;
 Fri, 21 Feb 2020 09:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D3625DA76;
 Fri, 21 Feb 2020 09:19:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 138AA11386A6; Fri, 21 Feb 2020 10:19:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 02/11] error: auto propagated local_err
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-3-vsementsov@virtuozzo.com>
Date: Fri, 21 Feb 2020 10:19:22 +0100
In-Reply-To: <20200131130118.1716-3-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Jan 2020 16:01:09 +0300")
Message-ID: <87mu9c70x1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: AXI1YvrUNiCXVCKcyzx0-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with an errp OUT parameter.
>
> It has three goals:
>
> 1. Fix issue with error_fatal and error_prepend/error_append_hint: user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
>
> 2. Fix issue with error_abort and error_propagate: when we wrap
> error_abort by local_err+error_propagate, the resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself doesn't fix the issue, but it allows us to [3.] drop
> the local_err+error_propagate pattern, which will definitely fix the
> issue) [Reported by Kevin Wolf]
>
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
>
> To achieve these goals, later patches will add invocations
> of this macro at the start of functions with either use
> error_prepend/error_append_hint (solving 1) or which use
> local_err+error_propagate to check errors, switching those
> functions to use *errp instead (solving 2 and 3).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>
> CC: Eric Blake <eblake@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Greg Kurz <groug@kaod.org>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Anthony Perard <anthony.perard@citrix.com>
> CC: Paul Durrant <paul@xen.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Stefan Berger <stefanb@linux.ibm.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> CC: qemu-block@nongnu.org
> CC: xen-devel@lists.xenproject.org
>
>  include/qapi/error.h | 83 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index d34987148d..b9452d4806 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -78,7 +78,7 @@
>   * Call a function treating errors as fatal:
>   *     foo(arg, &error_fatal);
>   *
> - * Receive an error and pass it on to the caller:
> + * Receive an error and pass it on to the caller (DEPRECATED*):
>   *     Error *err =3D NULL;
>   *     foo(arg, &err);
>   *     if (err) {
> @@ -98,6 +98,50 @@
>   *     foo(arg, errp);
>   * for readability.
>   *
> + * DEPRECATED* This pattern is deprecated now, the use ERRP_AUTO_PROPAGA=
TE macro
> + * instead (defined below).
> + * It's deprecated because of two things:
> + *
> + * 1. Issue with error_abort and error_propagate: when we wrap error_abo=
rt by
> + * local_err+error_propagate, the resulting coredump will refer to
> + * error_propagate and not to the place where error happened.
> + *
> + * 2. A lot of extra code of the same pattern
> + *
> + * How to update old code to use ERRP_AUTO_PROPAGATE?
> + *
> + * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function s=
tart,
> + * than you may safely dereference errp to check errors and do not need =
any
> + * additional local Error variables or calls to error_propagate().
> + *
> + * Example:
> + *
> + * old code
> + *
> + *     void fn(..., Error **errp) {
> + *         Error *err =3D NULL;
> + *         foo(arg, &err);
> + *         if (err) {
> + *             handle the error...
> + *             error_propagate(errp, err);
> + *             return;
> + *         }
> + *         ...
> + *     }
> + *
> + * updated code
> + *
> + *     void fn(..., Error **errp) {
> + *         ERRP_AUTO_PROPAGATE();
> + *         foo(arg, errp);
> + *         if (*errp) {
> + *             handle the error...
> + *             return;
> + *         }
> + *         ...
> + *     }
> + *
> + *
>   * Receive and accumulate multiple errors (first one wins):
>   *     Error *err =3D NULL, *local_err =3D NULL;
>   *     foo(arg, &err);

Let's explain what should be done *first*, and only then talk about the
deprecated pattern and how to convert it to current usage.

> @@ -348,6 +392,43 @@ void error_set_internal(Error **errp,
>                          ErrorClass err_class, const char *fmt, ...)
>      GCC_FMT_ATTR(6, 7);
> =20
> +typedef struct ErrorPropagator {
> +    Error *local_err;
> +    Error **errp;
> +} ErrorPropagator;
> +
> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> +{
> +    error_propagate(prop->errp, prop->local_err);
> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_clean=
up);
> +
> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function which use
> + * Error **errp parameter to report error. It's needed only in cases whe=
re we
> + * want to use error_prepend, error_append_hint or dereference *errp. It=
's
> + * still safe (but useless) in other cases.
> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to=
 a
> + * local Error object, which will be automatically propagated to the ori=
ginal
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to add information by error_prepend or
> + * error_append_hint (as, if it was error_fatal, we swapped it with a
> + * local_error to be propagated on cleanup).
> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredu=
mp
> + * to point to the place where the error happened, not to error_propagat=
e.

Tradeoff: we gain more useful backtraces, we lose message improvements
from error_prepend(), error_append_hint() and such, if any.  Makes
sense.

> + */

The comment's contents looks okay to me.  I'll want to tweak formatting
to better blend in with the rest of this file, but let's not worry about
that now.

> +#define ERRP_AUTO_PROPAGATE()                                  \
> +    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp};  \
> +    errp =3D ((errp =3D=3D NULL || *errp =3D=3D error_fatal)            =
 \
> +            ? &_auto_errp_prop.local_err : errp)
> +
>  /*
>   * Special error destination to abort on error.
>   * See error_setg() and error_propagate() for details.

*errp =3D=3D error_fatal tests *errp =3D=3D NULL, which is not what you wan=
t.
You need to test errp =3D=3D &error_fatal, just like error_handle_fatal().

Superfluous parenthesis around the first operand of ?:.

Wouldn't

   #define ERRP_AUTO_PROPAGATE()                                  \
       g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp};  \
       if (!errp || errp =3D=3D &error_fatal) {                       \
           errp =3D &_auto_errp_prop.local_err;                     \
       }

be clearer?


