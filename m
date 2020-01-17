Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E176DC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA29820842
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA+wgWj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA29820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSTh-0000RM-Px
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1isSSe-0008IC-LM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1isSSZ-0000rQ-OP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:18:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51782
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1isSSZ-0000qg-LK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579270730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35qmtPvrRFjgXhduzB5j7ovXY4i2VhZtNdB1mTF6Ai0=;
 b=GA+wgWj2+fSji9XcSfz/1G924pHWBgasrYfzlLyGfaeSxM+4eozM/U0PgE9AEdCa+IrUnd
 laZ4+MZb7GydtKZ4NgV+OOlVagYgHsd0iVDEG9+KA/ZMlImnJtMKkVtD0fQn4rXHBoxJBb
 FrqhuGZuh0CuZy7FjUqpnh60VAq6eWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-YcGS1C0wO0yiTAf5oWf2oQ-1; Fri, 17 Jan 2020 09:18:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 401741800D48;
 Fri, 17 Jan 2020 14:18:45 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9174119481;
 Fri, 17 Jan 2020 14:18:36 +0000 (UTC)
Subject: Re: [PATCH v6 02/11] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
 <20200110194158.14190-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d15df303-7152-d1e6-47b4-4a4c7d68ccf3@redhat.com>
Date: Fri, 17 Jan 2020 08:18:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110194158.14190-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YcGS1C0wO0yiTAf5oWf2oQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 1:41 PM, Vladimir Sementsov-Ogievskiy wrote:
> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with errp OUT parameter.

s/with/with an/

> 
> It has three goals:
> 
> 1. Fix issue with error_fatal & error_prepend/error_append_hint: user

maybe s/&/and/ so it doesn't look like the C & operator.

> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
> 
> 2. Fix issue with error_abort & error_propagate: when we wrap

and again

> error_abort by local_err+error_propagate, resulting coredump will

s/,/, the/

> refer to error_propagate and not to the place where error happened.
> (the macro itself doesn't fix the issue, but it allows to [3.] drop all

s/allows/allows us/
s/all/the/

> local_err+error_propagate pattern, which will definitely fix the issue)
> [Reported by Kevin Wolf]
> 
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
> 
> To achieve these goals, we need to add invocation of the macro at start
> of functions, which needs error_prepend/error_append_hint (1.); add
> invocation of the macro at start of functions which do
> local_err+error_propagate scenario the check errors, drop local errors
> from them and just use *errp instead (2., 3.).

To achieve these goals, later patches will add invocations of this macro 
at the start of functions with either use 
error_prepend/error_append_hint (solving 1) or which use 
local_err+error_propagate to check errors, switching those functions to 
use *errp instead (solving 2 and 3).

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 

> - * Receive an error and pass it on to the caller:
> + * Receive an error and pass it on to the caller (DEPRECATED*):
>    *     Error *err = NULL;
>    *     foo(arg, &err);
>    *     if (err) {
> @@ -98,6 +98,50 @@
>    *     foo(arg, errp);
>    * for readability.
>    *
> + * DEPRECATED* This pattern is deprecated now, use ERRP_AUTO_PROPAGATE macro

s/use/use the/

> + * instead (defined below).
> + * It's deprecated because of two things:
> + *
> + * 1. Issue with error_abort & error_propagate: when we wrap error_abort by

s/&/and/

> + * local_err+error_propagate, resulting coredump will refer to error_propagate

s/,/, the/

> + * and not to the place where error happened.
> + *
> + * 2. A lot of extra code of the same pattern
> + *

> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function which use
> + * Error **errp parameter to report error. It's needed only in cases where we
> + * want to use error_prepend, error_append_hint or dereference *errp. It's
> + * still safe (but useless) in other cases.

It doesn't _have_ to be the first line to compile (we require C99+ 
compilers, which allow declarations after statements); but rather 
because it makes it easier for our Coccinelle conversion script to catch 
outliers.  But I think this text is okay, without calling out that extra 
information (maybe the commit message should mention it, though).

> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to a
> + * local Error object, which will be automatically propagated to the original
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to add information (by error_prepend or
> + * error_append_hint)
> + * (as, if it was error_fatal, we swapped it with a local_error to be
> + * propagated on cleanup).

double () () looks odd, as does the mid-sentence newline.

> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredump
> + * to point to the place where the error happened, not to error_propagate.
> + */
> +#define ERRP_AUTO_PROPAGATE()                                  \
> +    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp};  \
> +    errp = ((errp == NULL || *errp == error_fatal)             \
> +            ? &_auto_errp_prop.local_err : errp)
> +
>   /*
>    * Special error destination to abort on error.
>    * See error_setg() and error_propagate() for details.
> 

The macro itself is fine, my comments are solely on the commit message 
and comments.  Depending on how much cleanup Markus is willing to do 
rather than require a respin, you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


