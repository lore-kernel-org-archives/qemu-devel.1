Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72CDC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A5A20752
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BirGP8t2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A5A20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsYN-0006q7-L3
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCsXk-0006F6-Uj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCsXi-0000Z4-Me
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:12:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCsXi-0000Xd-Cb
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584137553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7MI7aSwivWssxNYivoviN3OE8T8Fzktb7IMA/XCMX0=;
 b=BirGP8t2qFYkzTCNJIwAYpKFllhm5DbJi5bN94kKAfm4NMQHbnyoTzWW2gurLcRPUvH9vX
 qvgfy/bIdcku/iFbeSEcI2EliPrE/VwgpzBVJZBcAAf/D9pgOhFmHovHFVBjHNWp/qnPMO
 CypmZfwwcVaAkWp3DCqcvXmt8N/0x1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-SFU6UCOJNk2-BXzvkJRsvg-1; Fri, 13 Mar 2020 18:12:27 -0400
X-MC-Unique: SFU6UCOJNk2-BXzvkJRsvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9E5F8010D9;
 Fri, 13 Mar 2020 22:12:25 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5E278D553;
 Fri, 13 Mar 2020 22:12:18 +0000 (UTC)
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <45515658-7dfe-34bd-54a7-0486c176610d@redhat.com>
Date: Fri, 13 Mar 2020 17:12:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87blozex9v.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 4:54 PM, Markus Armbruster wrote:

> 
> I append my hacked up version of auto-propagated-errp.cocci.  It
> produces the same patch as yours for the complete tree.
> 
> 
> 
> // Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
> //

> //
> // Usage example:
> // spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
> //  --macro-file scripts/cocci-macro-file.h --in-place \
> //  --no-show-diff --max-width 80 FILES...
> //
> // Note: --max-width 80 is needed because coccinelle default is less
> // than 80, and without this parameter coccinelle may reindent some
> // lines which fit into 80 characters but not to coccinelle default,
> // which in turn produces extra patch hunks for no reason.

Do we really need this note?  And/or should we update other Coccinelle 
script examples to mention --max-width?

> 
> // Switch unusual Error ** parameter names to errp
> // (this is necessary to use ERRP_AUTO_PROPAGATE).
> //
> // Disable optional_qualifier to skip functions with
> // "Error *const *errp" parameter.
> //
> // Skip functions with "assert(_errp && *_errp)" statement, because
> // that signals unusual semantics, and the parameter name may well
> // serve a purpose. (like nbd_iter_channel_error()).
> //
> // Skip util/error.c to not touch, for example, error_propagate() and
> // error_propagate_prepend().
> @ depends on !(file in "util/error.c") disable optional_qualifier@

The comments are definitely helpful.

> identifier fn;
> identifier _errp != errp;
> @@
> 
>   fn(...,
> -   Error **_errp
> +   Error **errp
>      ,...)
>   {
> (
>       ... when != assert(_errp && *_errp)
> &
>       <...
> -    _errp
> +    errp
>       ...>
> )
>   }
> 
> // Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
> // necessary
> //
> // Note, that without "when any" the final "..." does not mach
> // something matched by previous pattern, i.e. the rule will not match
> // double error_prepend in control flow like in
> // vfio_set_irq_signaling().

How likely are we that this comment might go stale over time?  But I'm 
not opposed to it.

> //
> // Note, "exists" says that we want apply rule even if it matches not
> // on all possible control flows (otherwise, it will not match

s/matches not on/does not match on/

> // standard pattern when error_propagate() call is in if branch).
> @ disable optional_qualifier exists@
> identifier fn, local_err;
> symbol errp;
> @@
> 
>   fn(..., Error **errp, ...)
>   {
> +   ERRP_AUTO_PROPAGATE();
>      ...  when != ERRP_AUTO_PROPAGATE();
> (
> (
>      error_append_hint(errp, ...);
> |
>      error_prepend(errp, ...);
> |
>      error_vprepend(errp, ...);
> )
>      ... when any
> |
>      Error *local_err = NULL;
>      ...
> (
>      error_propagate_prepend(errp, local_err, ...);
> |
>      error_propagate(errp, local_err);
> )
>      ...
> )
>   }
> 
> 
> // Match functions with propagation of local error to errp.
> // We want to refer these functions in several following rules, but I
> // don't know a proper way to inherit a function, not just its name
> // (to not match another functions with same name in following rules).
> // Not-proper way is as follows: rename errp parameter in functions
> // header and match it in following rules. Rename it back after all
> // transformations.
> //
> // The simplest case of propagation scheme is single definition of
> // local_err with at most one error_propagate_prepend or
> // error_propagate on each control-flow. Still, we want to match more
> // complex schemes too. We'll warn them with help of further rules.

We'll warn for those with the help of further rules.

> @rule1 disable optional_qualifier exists@
> identifier fn, local_err;
> symbol errp;
> @@
> 
>   fn(..., Error **
> -    errp
> +    ____
>      , ...)
>   {
>       ...
>       Error *local_err = NULL;
>       ...
> (
>       error_propagate_prepend(errp, local_err, ...);
> |
>       error_propagate(errp, local_err);
> )
>       ...
>   }
> 
> 
> // Warn several Error * definitions.

// Warn when there are several Error * definitions.


> @check1 disable optional_qualifier exists@
> identifier fn, _errp, local_err, local_err2;
> position p1, p2;
> @@
> 
>   fn(..., Error **_errp, ...)
>   {
>       ...
>       Error *local_err = NULL;@p1
>       ... when any
>       Error *local_err2 = NULL;@p2
>       ... when any
>   }
> 
> @ script:python @
> fn << check1.fn;
> p1 << check1.p1;
> p2 << check1.p2;
> @@
> 
> print('Warning: function {} has several definitions of '
>        'Error * local variable: at {}:{} and then at {}:{}'.format(
>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
> 
> // Warn several propagations in control flow.

// Warn when several propagations are in the control flow.

> @check2 disable optional_qualifier exists@
> identifier fn, _errp;
> position p1, p2;
> @@
> 
>   fn(..., Error **_errp, ...)
>   {
>       ...
> (
>       error_propagate_prepend(_errp, ...);@p1
> |
>       error_propagate(_errp, ...);@p1
> )
>       ...
> (
>       error_propagate_prepend(_errp, ...);@p2
> |
>       error_propagate(_errp, ...);@p2
> )
>       ... when any
>   }
> 
> @ script:python @
> fn << check2.fn;
> p1 << check2.p1;
> p2 << check2.p2;
> @@
> 
> print('Warning: function {} propagates to errp several times in '
>        'one control flow: at {}:{} and then at {}:{}'.format(
>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
> 
> // Convert special case with goto separately.
> // I tried merging this into the following rule the obvious way, but
> // it made Coccinelle hang on block.c
> //
> // Note interesting thing: if we don't do it here, and try to fixup
> // "out: }" things later after all transformations (the rule will be
> // the same, just without error_propagate() call), coccinelle fails to
> // match this "out: }".
> @ disable optional_qualifier@
> identifier fn, rule1.local_err, out;
> symbol errp;
> @@
> 
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    goto out;
> +    return;
>       ...>
> - out:
> -    error_propagate(errp, local_err);
>   }
> 
> // Convert most of local_err related stuff.
> //
> // Note, that we update everything related to matched by rule1

either 'related to' or 'matched by', but not both.

> // function name and local_err name. We may match something not
> // related to the pattern matched by rule1. For example, local_err may
> // be defined with the same name in different blocks inside one
> // function, and in one block follow the propagation pattern and in
> // other block doesn't. Or we may have several functions with the same
> // name (for different configurations).
> //
> // Note also that errp-cleaning functions
> //   error_free_errp
> //   error_report_errp
> //   error_reportf_errp
> //   warn_report_errp
> //   warn_reportf_errp
> // are not yet implemented. They must call corresponding Error* -
> // freeing function and then set *errp to NULL, to avoid further
> // propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).

Do we need this part of the patch if we aren't using it?  Or can it be 
added incrementally later when we actually do have those functions added?

> // For example, error_free_errp may look like this:
> //
> //    void error_free_errp(Error **errp)
> //    {
> //        error_free(*errp);
> //        *errp = NULL;
> //    }
> @ disable optional_qualifier exists@
> identifier fn, rule1.local_err;
> expression list args;
> symbol errp;
> @@
> 
>   fn(..., Error ** ____, ...)
>   {
>       <...
> (
> -    Error *local_err = NULL;
> |
> 
> // Convert error clearing functions
> (
> -    error_free(local_err);
> +    error_free_errp(errp);
> |
> -    error_report_err(local_err);
> +    error_report_errp(errp);
> |
> -    error_reportf_err(local_err, args);
> +    error_reportf_errp(errp, args);
> |
> -    warn_report_err(local_err);
> +    warn_report_errp(errp);
> |
> -    warn_reportf_err(local_err, args);
> +    warn_reportf_errp(errp, args);
> )
> ?-    local_err = NULL;
> 
> |
> -    error_propagate_prepend(errp, local_err, args);
> +    error_prepend(errp, args);
> |
> -    error_propagate(errp, local_err);
> |
> -    &local_err
> +    errp
> )
>       ...>
>   }
> 
> // Convert remaining local_err usage. For example, different kinds of
> // error checking in if conditionals. We can't merge this into
> // previous hunk, as this conflicts with other substitutions in it (at
> // least with "- local_err = NULL").
> @ disable optional_qualifier@
> identifier fn, rule1.local_err;
> symbol errp;
> @@
> 
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    local_err
> +    *errp
>       ...>
>   }
> 
> // Always use the same pattern for checking error
> @ disable optional_qualifier@
> identifier fn;
> symbol errp;
> @@
> 
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    *errp != NULL
> +    *errp
>       ...>
>   }
> 
> // Revert temporary ___ identifier.
> @ disable optional_qualifier@
> identifier fn;
> @@
> 
>   fn(..., Error **
> -   ____
> +   errp
>      , ...)
>   {
>       ...
>   }
> 
> 

Ultimately, the proof is in the pudding - if we are happy with the 
conversion and the warnings produced by this script, and the amount of 
manual touchup to address those warnings, then I'm happy to accept the 
script even if I didn't fully check what it does (here, I'm trusting 
what Vladimir and Markus have been doing in their back-and-forth 
refinements of the script).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


