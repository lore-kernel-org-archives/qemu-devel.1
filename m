Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE558C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A3F20724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/eiWlo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A3F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKNR-0005XV-L3
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFKMB-0004Br-Pv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFKM8-0002jm-N7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:18:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59319)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFKM8-0002jN-Ii
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584721124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZUMLUevxFLH08VSvN87F8sn7tYw+p30q0xUrtvYmJs=;
 b=I/eiWlo0j098uX2hwF8ZE9NJVwNIeFnbJd0Lnf18U7aFi+xg2LZ19gQkaqAIP2H17pUUnH
 sgU6+HIu55/xi2daqGw/KnmSI6aB5ma09WOsJ9IPJBjbQJgZNijg/uE7n2ejc3cu2qt36s
 ThrtcBKaGRTu7GZ/Z9DLIwpDPNb9Mic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Xolm4TDuP8a2gNAOB2VUiA-1; Fri, 20 Mar 2020 12:18:42 -0400
X-MC-Unique: Xolm4TDuP8a2gNAOB2VUiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D996DB3B;
 Fri, 20 Mar 2020 16:18:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84CE4F6E6;
 Fri, 20 Mar 2020 16:18:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 52A841138404; Fri, 20 Mar 2020 17:18:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v10 2/9] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
References: <20200317151625.20797-1-vsementsov@virtuozzo.com>
 <20200317151625.20797-3-vsementsov@virtuozzo.com>
Date: Fri, 20 Mar 2020 17:18:32 +0100
In-Reply-To: <20200317151625.20797-3-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Mar 2020 18:16:18 +0300")
Message-ID: <875zezyp7r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
>  --max-width 80 FILES...
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: xen-devel@lists.xenproject.org
>
>  scripts/coccinelle/auto-propagated-errp.cocci | 336 ++++++++++++++++++
>  include/qapi/error.h                          |   3 +
>  MAINTAINERS                                   |   1 +
>  3 files changed, 340 insertions(+)
>  create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>
> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/cocc=
inelle/auto-propagated-errp.cocci
> new file mode 100644
> index 0000000000..5188b07006
> --- /dev/null
> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
> @@ -0,0 +1,336 @@
> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
> +//
> +// Copyright (c) 2020 Virtuozzo International GmbH.
> +//
> +// This program is free software; you can redistribute it and/or
> +// modify it under the terms of the GNU General Public License as
> +// published by the Free Software Foundation; either version 2 of the
> +// License, or (at your option) any later version.
> +//
> +// This program is distributed in the hope that it will be useful,
> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +// GNU General Public License for more details.
> +//
> +// You should have received a copy of the GNU General Public License
> +// along with this program.  If not, see
> +// <http://www.gnu.org/licenses/>.
> +//
> +// Usage example:
> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
> +//  --macro-file scripts/cocci-macro-file.h --in-place \
> +//  --no-show-diff --max-width 80 FILES...
> +//
> +// Note: --max-width 80 is needed because coccinelle default is less
> +// than 80, and without this parameter coccinelle may reindent some
> +// lines which fit into 80 characters but not to coccinelle default,
> +// which in turn produces extra patch hunks for no reason.
> +
> +// Switch unusual Error ** parameter names to errp
> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
> +//
> +// Disable optional_qualifier to skip functions with
> +// "Error *const *errp" parameter.
> +//
> +// Skip functions with "assert(_errp && *_errp)" statement, because
> +// that signals unusual semantics, and the parameter name may well
> +// serve a purpose. (like nbd_iter_channel_error()).
> +//
> +// Skip util/error.c to not touch, for example, error_propagate() and
> +// error_propagate_prepend().
> +@ depends on !(file in "util/error.c") disable optional_qualifier@
> +identifier fn;
> +identifier _errp !=3D errp;
> +@@
> +
> + fn(...,
> +-   Error **_errp
> ++   Error **errp
> +    ,...)
> + {
> +(
> +     ... when !=3D assert(_errp && *_errp)
> +&
> +     <...
> +-    _errp
> ++    errp
> +     ...>
> +)
> + }
> +
> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
> +// necessary
> +//
> +// Note, that without "when any" the final "..." does not mach
> +// something matched by previous pattern, i.e. the rule will not match
> +// double error_prepend in control flow like in
> +// vfio_set_irq_signaling().
> +//
> +// Note, "exists" says that we want apply rule even if it does not
> +// match on all possible control flows (otherwise, it will not match
> +// standard pattern when error_propagate() call is in if branch).
> +@ disable optional_qualifier exists@
> +identifier fn, local_err;
> +symbol errp;
> +@@
> +
> + fn(..., Error **errp, ...)
> + {
> ++   ERRP_AUTO_PROPAGATE();
> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
> +(
> +(
> +    error_append_hint(errp, ...);
> +|
> +    error_prepend(errp, ...);
> +|
> +    error_vprepend(errp, ...);
> +)
> +    ... when any
> +|
> +    Error *local_err =3D NULL;
> +    ...
> +(
> +    error_propagate_prepend(errp, local_err, ...);
> +|
> +    error_propagate(errp, local_err);
> +)
> +    ...
> +)
> + }
> +
> +// Warn when several Error * definitions are in the control flow.
> +// This rule is not chained to rule1 and less restrictive, to cover more
> +// functions to warn (even those we are not going to convert).
> +//
> +// Note, that even with one (or zero) Error * definition in the each
> +// control flow we may have several (in total) Error * definitions in
> +// the function. This case deserves attention too, but I don't see
> +// simple way to match with help of coccinelle.
> +@check1 disable optional_qualifier exists@
> +identifier fn, _errp, local_err, local_err2;
> +position p1, p2;
> +@@
> +
> + fn(..., Error **_errp, ...)
> + {
> +     ...
> +     Error *local_err =3D NULL;@p1
> +     ... when any
> +     Error *local_err2 =3D NULL;@p2
> +     ... when any
> + }
> +
> +@ script:python @
> +fn << check1.fn;
> +p1 << check1.p1;
> +p2 << check1.p2;
> +@@
> +
> +print('Warning: function {} has several definitions of '
> +      'Error * local variable: at {}:{} and then at {}:{}'.format(
> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
> +
> +// Warn when several propagations are in the control flow.
> +@check2 disable optional_qualifier exists@
> +identifier fn, _errp;
> +position p1, p2;
> +@@
> +
> + fn(..., Error **_errp, ...)
> + {
> +     ...
> +(
> +     error_propagate_prepend(_errp, ...);@p1
> +|
> +     error_propagate(_errp, ...);@p1
> +)
> +     ...
> +(
> +     error_propagate_prepend(_errp, ...);@p2
> +|
> +     error_propagate(_errp, ...);@p2
> +)
> +     ... when any
> + }
> +
> +@ script:python @
> +fn << check2.fn;
> +p1 << check2.p1;
> +p2 << check2.p2;
> +@@
> +
> +print('Warning: function {} propagates to errp several times in '
> +      'one control flow: at {}:{} and then at {}:{}'.format(
> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
> +
> +// Match functions with propagation of local error to errp.
> +// We want to refer these functions in several following rules, but I
> +// don't know a proper way to inherit a function, not just its name
> +// (to not match another functions with same name in following rules).
> +// Not-proper way is as follows: rename errp parameter in functions
> +// header and match it in following rules. Rename it back after all
> +// transformations.
> +//
> +// The common case is a single definition of local_err with at most one
> +// error_propagate_prepend() or error_propagate() on each control-flow
> +// path. Functions with multiple definitions or propagates we want to
> +// examine manually. Later rules emit warnings to guide us to them.

"Later rules" is no longer correct.  Suggest "Rules check1 and check2".

> +//
> +// Note that we match not only this "common case", but any function,
> +// which has the "common cose" on at least one control-flow path.

I appreciate this note.

Typo: s/cose/case/

> +@rule1 disable optional_qualifier exists@
> +identifier fn, local_err;
> +symbol errp;
> +@@
> +
> + fn(..., Error **
> +-    errp
> ++    ____
> +    , ...)
> + {
> +     ...
> +     Error *local_err =3D NULL;
> +     ...
> +(
> +     error_propagate_prepend(errp, local_err, ...);
> +|
> +     error_propagate(errp, local_err);
> +)
> +     ...
> + }
> +
> +// Convert special case with goto separately.
> +// I tried merging this into the following rule the obvious way, but
> +// it made Coccinelle hang on block.c
> +//
> +// Note interesting thing: if we don't do it here, and try to fixup
> +// "out: }" things later after all transformations (the rule will be
> +// the same, just without error_propagate() call), coccinelle fails to
> +// match this "out: }".
> +@ disable optional_qualifier@
> +identifier rule1.fn, rule1.local_err, out;
> +symbol errp;
> +@@
> +
> + fn(..., Error ** ____, ...)
> + {
> +     <...
> +-    goto out;
> ++    return;
> +     ...>
> +- out:
> +-    error_propagate(errp, local_err);
> + }
> +
> +// Convert most of local_err related stuff.
> +//
> +// Note, that we inherit rule1.fn and rule1.local_err names, not
> +// objects themselves. We may match something not related to the
> +// pattern matched by rule1. For example, local_err may be defined with
> +// the same name in different blocks inside one function, and in one
> +// block follow the propagation pattern and in other block doesn't.
> +//
> +// Note also that errp-cleaning functions
> +//   error_free_errp
> +//   error_report_errp
> +//   error_reportf_errp
> +//   warn_report_errp
> +//   warn_reportf_errp
> +// are not yet implemented. They must call corresponding Error* -
> +// freeing function and then set *errp to NULL, to avoid further
> +// propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
> +// For example, error_free_errp may look like this:
> +//
> +//    void error_free_errp(Error **errp)
> +//    {
> +//        error_free(*errp);
> +//        *errp =3D NULL;
> +//    }
> +@ disable optional_qualifier exists@
> +identifier rule1.fn, rule1.local_err;
> +expression list args;
> +symbol errp;
> +@@
> +
> + fn(..., Error ** ____, ...)
> + {
> +     <...
> +(
> +-    Error *local_err =3D NULL;
> +|
> +
> +// Convert error clearing functions
> +(
> +-    error_free(local_err);
> ++    error_free_errp(errp);
> +|
> +-    error_report_err(local_err);
> ++    error_report_errp(errp);
> +|
> +-    error_reportf_err(local_err, args);
> ++    error_reportf_errp(errp, args);
> +|
> +-    warn_report_err(local_err);
> ++    warn_report_errp(errp);
> +|
> +-    warn_reportf_err(local_err, args);
> ++    warn_reportf_errp(errp, args);
> +)
> +?-    local_err =3D NULL;
> +
> +|
> +-    error_propagate_prepend(errp, local_err, args);
> ++    error_prepend(errp, args);
> +|
> +-    error_propagate(errp, local_err);
> +|
> +-    &local_err
> ++    errp
> +)
> +     ...>
> + }
> +
> +// Convert remaining local_err usage. For example, different kinds of
> +// error checking in if conditionals. We can't merge this into
> +// previous hunk, as this conflicts with other substitutions in it (at
> +// least with "- local_err =3D NULL").
> +@ disable optional_qualifier@
> +identifier rule1.fn, rule1.local_err;
> +symbol errp;
> +@@
> +
> + fn(..., Error ** ____, ...)
> + {
> +     <...
> +-    local_err
> ++    *errp
> +     ...>
> + }
> +
> +// Always use the same pattern for checking error
> +@ disable optional_qualifier@
> +identifier rule1.fn;
> +symbol errp;
> +@@
> +
> + fn(..., Error ** ____, ...)
> + {
> +     <...
> +-    *errp !=3D NULL
> ++    *errp
> +     ...>
> + }
> +
> +// Revert temporary ___ identifier.
> +@ disable optional_qualifier@
> +identifier rule1.fn;
> +@@
> +
> + fn(..., Error **
> +-   ____
> ++   errp
> +    , ...)
> + {
> +     ...
> + }
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 30140d9bfe..56c133520d 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -214,6 +214,9 @@
>   *         }
>   *         ...
>   *     }
> + *
> + * For mass-conversion use script
> + *   scripts/coccinelle/auto-propagated-errp.cocci
>   */
> =20
>  #ifndef ERROR_H
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32867bc636..8b77127c35 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2016,6 +2016,7 @@ F: include/qemu/error-report.h
>  F: qapi/error.json
>  F: util/error.c
>  F: util/qemu-error.c
> +F: scripts/coccinelle/*err*.cocci
> =20
>  GDB stub
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>

With the minor comment issues addressed:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


