Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B705C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB01D2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISNmGHa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB01D2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsKBB-0003Tk-43
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 02:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsKAI-0002gA-Vb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 01:59:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsKAG-0007G3-GT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 01:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594015179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDj94LFWNXNG6l5HKQRtxvGkWU+Qk9Sz8iHMo0NKMBQ=;
 b=ISNmGHa3JUFGEK70SPIyJZbFPRljRpkKSeIU20TeOucGHMRl0UGdoLvdb8/KJRjjfy0rHa
 +wF2LxtYA/ivBI0NjWtbFg8X+gXXFTyK4AuSSaq5kmO7gzFxBvoi6aRbexg9mylwx8EYG9
 +TI+PKlqTvGOhH0Vo8NPsrIHDkuFT/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-XTMDI9ctPZSmrUKS_wxtNA-1; Mon, 06 Jul 2020 01:59:35 -0400
X-MC-Unique: XTMDI9ctPZSmrUKS_wxtNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0977805EE6;
 Mon,  6 Jul 2020 05:59:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9102960BF3;
 Mon,  6 Jul 2020 05:59:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 19C101138648; Mon,  6 Jul 2020 07:59:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v11 1/8] error: auto propagated local_err
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
 <20200703090816.3295-2-vsementsov@virtuozzo.com>
Date: Mon, 06 Jul 2020 07:59:25 +0200
In-Reply-To: <20200703090816.3295-2-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 3 Jul 2020 12:08:09 +0300")
Message-ID: <87o8otgp4y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 groug@kaod.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
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
> Reviewed-by: Paul Durrant <paul@xen.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: xen-devel@lists.xenproject.org
>
>  include/qapi/error.h | 205 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 172 insertions(+), 33 deletions(-)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 5ceb3ace06..b54aedbfd7 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -39,7 +39,7 @@
>   *   =E2=80=A2 pointer-valued functions return non-null / null pointer, =
and
>   *   =E2=80=A2 integer-valued functions return non-negative / negative.
>   *
> - * How to:
> + * =3D Deal with Error object =3D
>   *
>   * Create an error:
>   *     error_setg(errp, "situation normal, all fouled up");
> @@ -73,28 +73,91 @@
>   * reporting it (primarily useful in testsuites):
>   *     error_free_or_abort(&err);
>   *
> - * Pass an existing error to the caller:
> - *     error_propagate(errp, err);
> - * where Error **errp is a parameter, by convention the last one.
> + * =3D Deal with Error ** function parameter =3D
>   *
> - * Pass an existing error to the caller with the message modified:
> - *     error_propagate_prepend(errp, err);
> + * A function may use the error system to return errors. In this case, t=
he
> + * function defines an Error **errp parameter, by convention the last on=
e (with
> + * exceptions for functions using ... or va_list).
>   *
> - * Avoid
> - *     error_propagate(errp, err);
> - *     error_prepend(errp, "Could not frobnicate '%s': ", name);
> - * because this fails to prepend when @errp is &error_fatal.
> + * The caller may then pass in the following errp values:
> + *
> + * 1. &error_abort
> + *    Any error will result in abort().
> + * 2. &error_fatal
> + *    Any error will result in exit() with a non-zero status.
> + * 3. NULL
> + *    No error reporting through errp parameter.
> + * 4. The address of a NULL-initialized Error *err
> + *    Any error will populate errp with an error object.

The rebase onto my "error: Document Error API usage rules" rendered this
this partly redundant.  I'll try my hand at a proper merge, then ask you
to check it.

Should I fail to complete this in time for the soft freeze, we can merge
the thing as is.  Comment improvements are fair game until -rc1 or so.

>   *
> - * Create a new error and pass it to the caller:
> + * The following rules then implement the correct semantics desired by t=
he
> + * caller.
> + *
> + * Create a new error to pass to the caller:
>   *     error_setg(errp, "situation normal, all fouled up");
>   *
> - * Call a function and receive an error from it:
> + * Calling another errp-based function:
> + *     f(..., errp);
> + *
> + * =3D=3D Checking success of subcall =3D=3D
> + *
> + * If a function returns a value indicating an error in addition to sett=
ing
> + * errp (which is recommended), then you don't need any additional code,=
 just
> + * do:
> + *
> + *     int ret =3D f(..., errp);
> + *     if (ret < 0) {
> + *         ... handle error ...
> + *         return ret;
> + *     }
> + *
> + * If a function returns nothing (not recommended for new code), the onl=
y way

Also when a function returns something, but there is no distinct error
value.  Example: object_property_get_int().

I shouldn't criticize comments without suggesting improvements.  But
since I'm going to mess with this text anyway to merge your work with my
prior work, I take it easy and only note what I think needs work.  I'll
then try to address all that in or on top of my merge.

> + * to check success is by consulting errp; doing this safely requires th=
e use
> + * of the ERRP_AUTO_PROPAGATE macro, like this:

"Requires" is inaccurate.  Using a local variable with error_propagate()
also works (there's even an example right below).  We prefer
ERRP_AUTO_PROPAGATE(), because it's more readable and improves the
debugging experience.

> + *
> + *     int our_func(..., Error **errp) {

A function's opening brace goes on its own line.  More of the same below.

> + *         ERRP_AUTO_PROPAGATE();
> + *         ...
> + *         subcall(..., errp);
> + *         if (*errp) {
> + *             ...
> + *             return -EINVAL;
> + *         }
> + *         ...
> + *     }
> + *
> + * ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as neede=
d, so
> + * that the rest of the function can directly use errp (including
> + * dereferencing), where any errors will then be propagated on to the or=
iginal
> + * errp when leaving the function.
> + *
> + * In some cases, we need to check result of subcall, but do not want to
> + * propagate the Error object to our caller. In such cases we don't need
> + * ERRP_AUTO_PROPAGATE, but just a local Error object:
> + *
> + * Receive an error and not pass it:
>   *     Error *err =3D NULL;
> - *     foo(arg, &err);
> + *     subcall(arg, &err);
>   *     if (err) {
>   *         handle the error...
> + *         error_free(err);
>   *     }
>   *
> + * Note that older code that did not use ERRP_AUTO_PROPAGATE would inste=
ad need
> + * a local Error * variable and the use of error_propagate() to properly=
 handle
> + * all possible caller values of errp. Now this is DEPRECATED* (see belo=
w).

I'd prefer not to shout DEPRECATED.

> + *
> + * Note that any function that wants to modify an error object, such as =
by
> + * calling error_append_hint or error_prepend, must use ERRP_AUTO_PROPAG=
ATE, in
> + * order for a caller's use of &error_fatal to see the additional inform=
ation.

"Must" should be reserved for situations where failure to adhere is
categorically wrong.

While we *want* people to use ERRP_AUTO_PROPAGATE() with
error_append_hint() and error_prepend(), failure to do so need not be
wrong.

Apropos error_append_hint(), the "Show errp instead of &err where &err
is actually unusual" part of my "error: Improve examples in error.h's
big comment" now feels premature to me.  E.g.

    * Create an error and add additional explanation:
  - *     error_setg(&err, "invalid quark");
  - *     error_append_hint(&err, "Valid quarks are up, down, strange, "
  + *     error_setg(errp, "invalid quark");
  + *     error_append_hint(errp, "Valid quarks are up, down, strange, "
    *                       "charm, top, bottom.\n");

is actually bad advice until ERRP_AUTO_PROPAGATE() turns it into good
advice.  I think I'll drop it from my commit, then see how I like the
comment with yours applied.

> + *
> + * In rare cases, we need to pass existing Error object to the caller by=
 hand:
> + *     error_propagate(errp, err);

Out of curiosity: can you describe such a case?

> + *
> + * Pass an existing error to the caller with the message modified:
> + *     error_propagate_prepend(errp, err);
> + *
> + *
>   * Call a function ignoring errors:
>   *     foo(arg, NULL);
>   *
> @@ -104,26 +167,6 @@
>   * Call a function treating errors as fatal:
>   *     foo(arg, &error_fatal);
>   *
> - * Receive an error and pass it on to the caller:
> - *     Error *err =3D NULL;
> - *     foo(arg, &err);
> - *     if (err) {
> - *         handle the error...
> - *         error_propagate(errp, err);
> - *     }
> - * where Error **errp is a parameter, by convention the last one.
> - *
> - * Do *not* "optimize" this to
> - *     foo(arg, errp);
> - *     if (*errp) { // WRONG!
> - *         handle the error...
> - *     }
> - * because errp may be NULL!
> - *
> - * But when all you do with the error is pass it on, please use
> - *     foo(arg, errp);
> - * for readability.
> - *
>   * Receive and accumulate multiple errors (first one wins):
>   *     Error *err =3D NULL, *local_err =3D NULL;
>   *     foo(arg, &err);
> @@ -151,6 +194,61 @@
>   *         error_setg(&err, ...); // WRONG!
>   *     }
>   * because this may pass a non-null err to error_setg().
> + *
> + * DEPRECATED*
> + *
> + * The following pattern of receiving, checking, and then forwarding an =
error
> + * to the caller by hand is now deprecated:
> + *
> + *     Error *err =3D NULL;
> + *     foo(arg, &err);
> + *     if (err) {
> + *         handle the error...
> + *         error_propagate(errp, err);
> + *     }
> + *
> + * Instead, use ERRP_AUTO_PROPAGATE macro.
> + *
> + * The old pattern is deprecated because of two things:
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

This is another spot where we need to merge your work with mine
properly.  When foo() returns a distinct error value, then checking that
is even better:

          void fn(..., Error **errp)
          {
              if (!foo(arg, errp)) {
                  handle the error...
                  return;
              }
              ...
          }

>   */
> =20
>  #ifndef ERROR_H
> @@ -359,6 +457,47 @@ void error_set_internal(Error **errp,
>                          ErrorClass err_class, const char *fmt, ...)
>      GCC_FMT_ATTR(6, 7);
> =20

The ERRP_AUTO_PROPAGATE stuff starts rather abruptly.  I'm afraid an
unprepared reader will get what's going on only at
G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(), or even at #define
ERRP_AUTO_PROPAGATE().

Let's move the typedef, helper function and macro invocation behind the
definition of ERRP_AUTO_PROPAGATE(), similar to how we declare each
error_FOO_internal() helper function right after the macro that needs
it.

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

No other definition comment in this file repeats the name being defined.
Let's keep the comment style locally consistent.

> + * This macro exists to assist with proper error handling in a function =
which
> + * uses an Error **errp parameter.  It must be used as the first line of=
 a
> + * function which modifies an error (with error_prepend, error_append_hi=
nt, or
> + * similar) or which wants to dereference *errp.  It is still safe (but
> + * useless) to use in other functions.
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
> + */
> +#define ERRP_AUTO_PROPAGATE() \
> +    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp}; \
> +    do { \
> +        if (!errp || errp =3D=3D &error_fatal) { \
> +            errp =3D &_auto_errp_prop.local_err; \
> +        } \
> +    } while (0)
> +

Let's align the backslashes for consistency with nearby macros:

   #define ERRP_AUTO_PROPAGATE()                                   \
       g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp};   \
       do {                                                        \
           if (!errp || errp =3D=3D &error_fatal) {                    \
               errp =3D &_auto_errp_prop.local_err;                  \
           }                                                       \
       } while (0)

>  /*
>   * Special error destination to abort on error.
>   * See error_setg() and error_propagate() for details.


