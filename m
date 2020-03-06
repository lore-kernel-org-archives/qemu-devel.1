Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE392C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794D52073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtCc6G23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794D52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACFa-0003SZ-MH
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jACEk-0002eI-Fd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jACEh-0007wA-LJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:37:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jACEh-0007uO-DM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583498271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRc3/wEVrnsWDXDZIirGQ2jp4V7h8oBZ/PL8yoD87go=;
 b=CtCc6G23TrNeyY7548Q6SOWlZKFZfvl3cXqFGYZZX/8GXG6pKCAdOFiIa112i+Snv41QCc
 e1aNjsU08P0wGEUGCkoErybIXB/9RRTU5P/DV2s/lmvjDxQ5HMCyAelZr5fBDHzR+RjG+W
 +0p6A5r8qZioT3PSb25uEsHTxRwsdo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-_7d95CvdPGucnJ9ZXcs6sA-1; Fri, 06 Mar 2020 07:37:46 -0500
X-MC-Unique: _7d95CvdPGucnJ9ZXcs6sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0471C800D50;
 Fri,  6 Mar 2020 12:37:45 +0000 (UTC)
Received: from [10.3.117.177] (ovpn-117-177.phx2.redhat.com [10.3.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BAC760BEC;
 Fri,  6 Mar 2020 12:37:38 +0000 (UTC)
Subject: Re: [PATCH v8 01/10] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <41229b66-eedb-1c30-4849-a8076080117e@redhat.com>
Date: Fri, 6 Mar 2020 06:37:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306051536.27803-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 11:15 PM, Vladimir Sementsov-Ogievskiy wrote:
> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with an errp OUT parameter.

As an aid to writing imperative-style commit messages, I like to prepend 
an implicit "Apply this patch to..." before the user's text, to see if 
things still make sense.  By that construct, this paragraph might read 
better as:

Introduce a new ERRP_AUTO_PROPAGATE macro, ...

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
> ---

I have lots of grammar suggestions for the comments (and I know Markus 
is generally okay doing wording tweaks, so it may still end up different 
than my suggestions):

> +++ b/include/qapi/error.h
> @@ -15,6 +15,8 @@
>   /*
>    * Error reporting system loosely patterned after Glib's GError.
>    *
> + * = Deal with Error object =
> + *
>    * Create an error:
>    *     error_setg(&err, "situation normal, all fouled up");
>    *
> @@ -47,28 +49,88 @@
>    * reporting it (primarily useful in testsuites):
>    *     error_free_or_abort(&err);
>    *
> - * Pass an existing error to the caller:
> - *     error_propagate(errp, err);
> - * where Error **errp is a parameter, by convention the last one.
> + * = Deal with Error ** function parameter =
>    *
> - * Pass an existing error to the caller with the message modified:
> - *     error_propagate_prepend(errp, err);
> + * Function may use error system to return errors. In this case function
> + * defines Error **errp parameter, which should be the last one (except for
> + * functions which varidic argument list), which has the following API:

A function may use the error system to return errors.  In this case, the 
function defines an Error **errp parameter, by convention the last one 
(with exceptions for functions using ... or va_list).

>    *
> - * Avoid
> - *     error_propagate(errp, err);
> - *     error_prepend(errp, "Could not frobnicate '%s': ", name);
> - * because this fails to prepend when @errp is &error_fatal.
> + * Caller may pass as errp:

The caller may then pass in the following errp values:

> + * 1. &error_abort
> + *    This means abort on any error

Any error will result in abort()

> + * 2. &error_fatal
> + *    Exit with non-zero return code on error

Any error will result in exit() with a non-zero status

> + * 3. NULL
> + *    Ignore errors

Any error will be ignored

> + * 4. Another value

4. The address of a NULL-initialized Error *err

> + *    On error allocate error object and set errp

Any error will populate errp with an error object

>    *
> - * Create a new error and pass it to the caller:
> - *     error_setg(errp, "situation normal, all fouled up");
> + * Error API functions with Error ** (like error_setg) argument supports these
> + * rules, so user functions just need to use them appropriately (read below).

The following rules then implement the correct semantics desired by the 
caller.

>    *
> - * Call a function and receive an error from it:
> + * Simple pass error to the caller:

Create a new error to pass to the caller:

> + *     error_setg(errp, "Some error");

You lost the fun wording in Markus' earlier example ("situation normal, 
all fouled up").

> + *
> + * Subcall of another errp-based function, passing the error to the caller
> + *     f(..., errp);

Calling another errp-based function:

> + *
> + * == Checking success of subcall ==
> + *
> + * If function returns error code in addition to errp (which is recommended),

If a function returns a value indicating an error in addition to setting 
errp (which is recommended), then

> + * you don't need any additional code, just do:
> + *     int ret = f(..., errp);
> + *     if (ret < 0) {
> + *         ... handle error ...
> + *         return ret;
> + *     }
> + *
> + * If function returns nothing (which is not recommended API) and the only way
> + * to check success is checking errp, we must care about cases [1-3] above. We
> + * need to use macro ERRP_AUTO_PROPAGATE (see below for details) like this:

If a function returns nothing (not recommended for new code), the only 
way to check success is by consulting errp; doing this safely requires 
the use of the ERRP_AUTO_PROPAGATE macro, like this:


> + *
> + *     int our_func(..., Error **errp) {
> + *         ERRP_AUTO_PROPAGATE();
> + *         ...
> + *         subcall(..., errp);
> + *         if (*errp) {
> + *             ...
> + *             return -ERRNO;

do we want ERRNO capitalized here?

> + *         }
> + *         ...
> + *     }
> + *
> + * ERRP_AUTO_PROPAGATE cares about Error ** API, wraps original errp if needed,
> + * so that it can be safely used (including dereferencing), and auto-propagates
> + * error to original errp on function end.

ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as needed, 
so that the rest of the function can directly use errp (including 
dereferencing), where any errors will then be propagated on to the 
original errp when leaving the function.

> + *
> + * In some cases, we need to check result of subcall, but do not want to
> + * propagate the Error object to our caller. In such cases we don't need
> + * ERRP_AUTO_PROPAGATE, but just a local Error object:
> + *
> + * Receive an error and not pass it:
>    *     Error *err = NULL;
> - *     foo(arg, &err);
> + *     subcall(arg, &err);
>    *     if (err) {
>    *         handle the error...
> + *         error_free(err);
>    *     }
>    *
> + * Note, that before ERRP_AUTO_PROPAGATE introduction the pattern above (with
> + * error_propagate() instead of error_free()) was used to check and pass error
> + * to the caller. Now this is DEPRECATED* (see below).

Hmm - if we bulk-convert the entire tree, then there won't be any 
deprecated uses to be worth documenting.  But if we do keep this paragraph:

Note that older code that did not use ERRP_AUTO_PROPAGATE would instead 
need a local Err variable and the use of error_propagate() to properly 
handle all possible caller values of errp.

> + *
> + * Note also, that if you want to use error_append_hint/error_prepend or their
> + * variants, you must use ERRP_AUTO_PROPAGATE too. Otherwise, in case of
> + * error_fatal, you'll miss the chance to insert your additional information
> + * into Error object.

Note that any function that wants to modify an error object, such as by 
calling error_append_hint or error_prepend, must use 
ERRP_AUTO_PROPAGATE, in order for a caller's use of &error_fatal to see 
the additional information.

> + *
> + * In rare cases, we need to pass existing Error object to the caller by hand:
> + *     error_propagate(errp, err);
> + *
> + * Pass an existing error to the caller with the message modified:
> + *     error_propagate_prepend(errp, err);
> + *
> + *
>    * Call a function ignoring errors:
>    *     foo(arg, NULL);
>    *
> @@ -78,26 +140,6 @@
>    * Call a function treating errors as fatal:
>    *     foo(arg, &error_fatal);
>    *
> - * Receive an error and pass it on to the caller:
> - *     Error *err = NULL;
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
>    * Receive and accumulate multiple errors (first one wins):
>    *     Error *err = NULL, *local_err = NULL;
>    *     foo(arg, &err);
> @@ -114,6 +156,61 @@
>    *         handle the error...
>    *     }
>    * because this may pass a non-null err to bar().
> + *
> + * DEPRECATED*
> + *

Again, I'm not sure we need this section in the codebase if we do a bulk 
conversion.  But moving it to the commit message is still useful.

> + * The following pattern of receiving checking and passing the caller of the
> + * error by hand is deprecated now:

The following pattern of receiving, checking, and then forwarding an 
error to the caller by hand is now deprecated:

> + *
> + *     Error *err = NULL;
> + *     foo(arg, &err);
> + *     if (err) {
> + *         handle the error...
> + *         error_propagate(errp, err);
> + *     }
> + *
> + * Instead, use ERRP_AUTO_PROPAGATE macro (defined below).

Drop "(defined below)".

> + *
> + * The old pattern is deprecated because of two things:
> + *
> + * 1. Issue with error_abort and error_propagate: when we wrap error_abort by
> + * local_err+error_propagate, the resulting coredump will refer to
> + * error_propagate and not to the place where error happened.
> + *
> + * 2. A lot of extra code of the same pattern
> + *
> + * How to update old code to use ERRP_AUTO_PROPAGATE?
> + *
> + * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function start,
> + * than you may safely dereference errp to check errors and do not need any
> + * additional local Error variables or calls to error_propagate().
> + *
> + * Example:
> + *
> + * old code
> + *
> + *     void fn(..., Error **errp) {
> + *         Error *err = NULL;
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

Again, I'm thinking the above example is more useful in the commit 
message instead of permanently in the .h file.

>    */
>   
>   #ifndef ERROR_H
> @@ -322,6 +419,46 @@ void error_set_internal(Error **errp,
>                           ErrorClass err_class, const char *fmt, ...)
>       GCC_FMT_ATTR(6, 7);
>   
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
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
> +
> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function which use
> + * Error **errp parameter to report error. It's needed only in cases where we
> + * want to use error_prepend, error_append_hint or dereference *errp. It's
> + * still safe (but useless) in other cases.

This macro exists to assist with proper error handling in a function 
which uses an Error **errp parameter.  It must be used as the first line 
of a function which modifies an error (with error_prepend, 
error_append_hint, or similar) or which wants to dereference *errp.  It 
is still safe (but useless) to use in other functions.

> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to a
> + * local Error object, which will be automatically propagated to the original
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to add information by error_prepend or
> + * error_append_hint (as, if it was error_fatal, we swapped it with a
> + * local_error to be propagated on cleanup).
> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredump
> + * to point to the place where the error happened, not to error_propagate.
> + */
> +#define ERRP_AUTO_PROPAGATE() \
> +    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp}; \
> +    do { \
> +        if (!errp || errp == &error_fatal) { \
> +            errp = &_auto_errp_prop.local_err; \
> +        } \
> +    } while (0)
> +
>   /*
>    * Special error destination to abort on error.
>    * See error_setg() and error_propagate() for details.
> 

The macro itself looks correct. I'll leave it up to Markus how to handle 
the comment text, but you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


