Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E92C35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 08:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F5A20656
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 08:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjDLdlxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F5A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5n4y-0007Cd-5p
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 03:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j5n3R-0006I3-2i
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 03:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j5n3O-0001Wf-6f
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 03:56:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35747
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j5n3O-0001TC-2g
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 03:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582448156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iD8dLw9qomGN6w1NHtW9KjOAj02GgFIgkJJercvcAPE=;
 b=KjDLdlxfXvwc3NYqxAbTKaOj+76Zbo0+4gfqcZ9oSBPNMzDkPueGM04J4ykkveF9boxTR7
 cMZ4SPDg1XBg4e5Nh4RTJxJUGzWltiRhchxgxnhCyD2HC5FiG4ghhAos+IvlQKlBkWK3RS
 3gZtkqIKU2FzXuZWnceff43ItAXMTRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-HNaFP9EAOsGTkhIbjq0DfQ-1; Sun, 23 Feb 2020 03:55:49 -0500
X-MC-Unique: HNaFP9EAOsGTkhIbjq0DfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1281A1007269;
 Sun, 23 Feb 2020 08:55:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC231001902;
 Sun, 23 Feb 2020 08:55:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F0F7411386A6; Sun, 23 Feb 2020 09:55:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v7 03/11] scripts: add coccinelle script to use auto
 propagated errp
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-4-vsementsov@virtuozzo.com>
Date: Sun, 23 Feb 2020 09:55:36 +0100
In-Reply-To: <20200131130118.1716-4-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Jan 2020 16:01:10 +0300")
Message-ID: <87v9nxwulz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, armbru@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
> does corresponding changes in code (look for details in
> include/qapi/error.h)
>
> Usage example:
> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
>  include/qapi/error.h                          |   3 +
>  scripts/coccinelle/auto-propagated-errp.cocci | 158 ++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index b9452d4806..79f8e95214 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -141,6 +141,9 @@
>   *         ...
>   *     }
>   *
> + * For mass conversion use script
> + *   scripts/coccinelle/auto-propagated-errp.cocci
> + *
>   *
>   * Receive and accumulate multiple errors (first one wins):
>   *     Error *err =3D NULL, *local_err =3D NULL;

Extra blank line.

> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/cocc=
inelle/auto-propagated-errp.cocci
> new file mode 100644
> index 0000000000..fb03c871cb
> --- /dev/null
> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
> @@ -0,0 +1,158 @@
> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
> +//
> +// Copyright (c) 2020 Virtuozzo International GmbH.
> +//
> +// This program is free software; you can redistribute it and/or modify
> +// it under the terms of the GNU General Public License as published by
> +// the Free Software Foundation; either version 2 of the License, or
> +// (at your option) any later version.
> +//
> +// This program is distributed in the hope that it will be useful,
> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +// GNU General Public License for more details.
> +//
> +// You should have received a copy of the GNU General Public License
> +// along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +//
> +// Usage example:
> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
> +//  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
> +
> +@rule0@
> +// Add invocation to errp-functions where necessary
> +// We should skip functions with "Error *const *errp"
> +// parameter, but how to do it with coccinelle?
> +// I don't know, so, I skip them by function name regex.
> +// It's safe: if we did not skip some functions with
> +// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
> +// will fail to compile, because of const violation.

Not skipping a function we should skip fails to compile.

What about skipping a function we should not skip?

> +identifier fn !~ "error_append_.*_hint";
> +identifier local_err, ERRP;

A few of our coccinelle scripts use ALL_CAPS for meta-variables.  Most
don't.  Either is fine with me.  Mixing the two styles feels a bit
confusing, though.

> +@@
> +
> + fn(..., Error **ERRP, ...)
> + {
> ++   ERRP_AUTO_PROPAGATE();
> +    <+...
> +        when !=3D ERRP_AUTO_PROPAGATE();
> +(
> +    error_append_hint(ERRP, ...);
> +|
> +    error_prepend(ERRP, ...);
> +|
> +    Error *local_err =3D NULL;
> +)
> +    ...+>
> + }

Misses error_vprepend().  Currently harmless, but as long as we commit
the script, we better make it as robust as we reasonably can.

The previous patch explains this Coccinelle script's intent:

  To achieve these goals, later patches will add invocations
  of this macro at the start of functions with either use
  error_prepend/error_append_hint (solving 1) or which use
  local_err+error_propagate to check errors, switching those
  functions to use *errp instead (solving 2 and 3).

This rule matches "use error_prepend/error_append_hint" directly.  It
appears to use presence of a local Error * variable as proxy for "use
local_err+error_propagate to check errors".  Hmm.

We obviously have such a variable when we use "local_err+error_propagate
to check errors".  But we could also have such variables without use of
error_propagate().  In fact, error.h documents such use:

 * Call a function and receive an error from it:
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *     }

where "handle the error" frees it.

I figure such uses typically occur in functions without an Error **errp
parameter.  This rule doesn't apply then.  But they could occur even in
functions with such a parameter.  Consider:

    void foo(Error **errp)
    {
        Error *err =3D NULL;

        bar(&err);
        if (err) {
            error_free(err);
            error_setg(errp, "completely different error");
        }
    }

Reasonable enough when bar() gives us an error that's misleading in this
context, isn't it?

The script transforms it like this:

    void foo(Error **errp)
    {
   -    Error *err =3D NULL;
   +    ERRP_AUTO_PROPAGATE();

   -    bar(&err);
   -    if (err) {
   -        error_free(err);
   +    bar(errp);
   +    if (*errp) {
   +        error_free_errp(errp);
            error_setg(errp, "completely different error");
        }
    }

Unwanted.

Now, if this script applied in just a few dozen places, we could rely on
eyeballing its output to catch unwanted transformations.  Since it
applies in so many more, I don't feel comfortable relying on reviewer
eyeballs.

Can we make rule0 directly match error_propagate(errp, local_err)
somehow?

Another observation: the rule does not match error_reportf_err() and
warn_reportf_err().  These combine error_prepend(),
error_report()/warn_report() and error_free(), for convenience.  Don't
their users need ERRP_AUTO_PROPAGATE() just like error_prepend()'s
users?

> +
> +@@
> +// Switch unusual (Error **) parameter names to errp
> +// (this is necessary to use ERRP_AUTO_PROPAGATE).

Please put your rule comments right before the rule, i.e. before the
@-line introducing metavariable declarations, not after.  Same
elsewhere.

> +identifier rule0.fn;
> +identifier rule0.ERRP !=3D errp;
> +@@
> +
> + fn(...,
> +-   Error **ERRP
> ++   Error **errp
> +    ,...)
> + {
> +     <...
> +-    ERRP
> ++    errp
> +     ...>
> + }

This normalizes errp parameter naming.  It matches exactly when rule0
matches (and inserts ERRP_AUTO_PROPAGATE()) and the Error ** parameter
is unusual.  Good.

> +
> +@rule1@
> +// We want to patch error propagation in functions regardless of
> +// whether the function already uses ERRP_AUTO_PROPAGATE prior to
> +// applying rule0, hence this one does not inherit from it.

I'm not sure I get this comment.  Let's see what the rule does.

> +identifier fn !~ "error_append_.*_hint";
> +identifier local_err;
> +symbol errp;
> +@@
> +
> + fn(..., Error **errp, ...)
> + {
> +     <...
> +-    Error *local_err =3D NULL;
> +     ...>
> + }

rule1 matches like rule0, except the Error ** parameter match is
tightened from any C identifier to the C identifier errp, and the
function body match tightened from "either use
error_prepend/error_append_hint or which use local_err+error_propagate
to check errors" to just the latter.

I figure tightening the Error ** parameter match has no effect, because
we already normalized the parameter name.

So rule1 deletes variable local_err where rule0 applied.  Correct?

> +
> +@@
> +// Handle pattern with goto, otherwise we'll finish up
> +// with labels at function end which will not compile.
> +identifier rule1.fn, rule1.local_err;
> +identifier OUT;
> +@@
> +
> + fn(...)
> + {
> +     <...
> +-    goto OUT;
> ++    return;
> +     ...>
> +- OUT:
> +-    error_propagate(errp, local_err);
> + }

This is one special case of error_propagate() deletion.  It additionally
gets rid of a goto we no longer want.  For the general case, see below.

The rule applies only where rule1 just deleted the variable.  Thus, the
two rules work in tandem.  Makes sense.

> +
> +@@
> +identifier rule1.fn, rule1.local_err;

This rule also works in tandem with rule1.

> +expression list args; // to reindent error_propagate_prepend

What is the comment trying to tell me?

> +@@
> +
> + fn(...)
> + {
> +     <...
> +(
> +-    error_free(local_err);
> +-    local_err =3D NULL;
> ++    error_free_errp(errp);

Reminder:

    static inline void error_free_errp(Error **errp)
    {
        assert(errp && *errp);
        error_free(*errp);
        *errp =3D NULL;
    }

Now let's examine the actual change.

The assertion's first half trivially holds, ERRP_AUTO_PROPAGATE()
ensures it.

The second half is new.  We now crash when we haven't set an error.  Why
is this safe?  Note that error_free(local_err) does nothing when
!local_err.

The zapping of the variable pointing to the Error just freed is
unchanged.

> +|
> +-    error_free(local_err);
> ++    error_free_errp(errp);

Here, the zapping is new.  Zapping dangling pointers is obviously safe.
Needed, or else the automatic error_propagate() due to
ERRP_AUTO_PROPAGATE() would propagate the dangling pointer.

> +|
> +-    error_report_err(local_err);
> ++    error_report_errp(errp);

The only difference to the previous case is that we also report the
error.

The previous case has a buddy that additionally matches *errp =3D NULL.
Why not this one?

> +|
> +-    warn_report_err(local_err);
> ++    warn_report_errp(errp);

Likewise.

What about error_reportf_err(), warn_reportf_err()?

Up to here, this rule transforms the various forms of error_free().
Next: error_propagate().

> +|
> +-    error_propagate_prepend(errp, local_err, args);
> ++    error_prepend(errp, args);
> +|
> +-    error_propagate(errp, local_err);

rule0's adding of ERRP_AUTO_PROPAGATE() made error_propagate()
redundant.

This is the general case of error_propagate() deletion.

I'd put the plain error_propagate() first, variations second, like you
do with error_free().

If neither of these two patterns match on a path from
ERRP_AUTO_PROPAGATE() to return, we effectively insert error_propagate()
where it wasn't before.  Does nothing when the local error is null
there.  Bug fix when it isn't: it's at least a memory leak, and quite
possibly worse.

Identifying these bug fixes would be nice, but I don't have practical
ideas on how to do that.

Can we explain this in the commit message?

> +)
> +     ...>
> + }
> +
> +@@
> +identifier rule1.fn, rule1.local_err;
> +@@
> +
> + fn(...)
> + {
> +     <...
> +(
> +-    &local_err
> ++    errp
> +|
> +-    local_err
> ++    *errp
> +)
> +     ...>
> + }

Also in tandem with rule1, fixes up uses of local_err.  Good.

> +
> +@@
> +identifier rule1.fn;
> +@@
> +
> + fn(...)
> + {
> +     <...
> +- *errp !=3D NULL
> ++ *errp
> +     ...>
> + }

Still in tandem with rule1, normalizes style.  Good.


