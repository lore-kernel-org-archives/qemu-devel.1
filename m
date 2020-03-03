Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30045C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29662072A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 08:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Th8dI/jX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29662072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j92ed-0006YQ-3u
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 03:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j92du-00064m-5x
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j92ds-0003Ld-IU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:11:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j92ds-0003LH-Cp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 03:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583223063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCwNnUdNZwz9ymgbmW/BL4i9p3W0DN8ijycPRFiWJjI=;
 b=Th8dI/jX9kZebokqmE6vM0YJ6pzHWej1z4O6tYbWSg2B+2Kq5uKCT0t03Rfg4WXkvMca7g
 IZxT0M+LvyR7Bii1M2GCWk8PzOh3gSa2nZoz05Mcx2QQZqef5Qkab1uBukOEcG5IGJ/UuS
 gWK89sPOsc39zRsEnLHUNNSKcVprG3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-I_IDbCYRPliQ63cZbPLJ1g-1; Tue, 03 Mar 2020 03:11:01 -0500
X-MC-Unique: I_IDbCYRPliQ63cZbPLJ1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29FAF100550E;
 Tue,  3 Mar 2020 08:11:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C18D0272A0;
 Tue,  3 Mar 2020 08:10:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5146C11386A6; Tue,  3 Mar 2020 09:10:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-2-kwolf@redhat.com>
Date: Tue, 03 Mar 2020 09:10:58 +0100
In-Reply-To: <20200218154036.28562-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Tue, 18 Feb 2020 16:40:33 +0100")
Message-ID: <87tv35dfjh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> This patch adds a new 'coroutine' flag to QMP command definitions that
> tells the QMP dispatcher that the command handler is safe to be run in a
> coroutine.
>
> The documentation of the new flag pretends that this flag is already
> used as intended, which it isn't yet after this patch. We'll implement
> this in another patch in this series.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-code-gen.txt            | 11 +++++++++++
>  include/qapi/qmp/dispatch.h             |  1 +
>  tests/test-qmp-cmds.c                   |  4 ++++
>  scripts/qapi/commands.py                | 10 +++++++---
>  scripts/qapi/doc.py                     |  2 +-
>  scripts/qapi/expr.py                    | 10 ++++++++--
>  scripts/qapi/introspect.py              |  2 +-
>  scripts/qapi/schema.py                  |  9 ++++++---
>  tests/qapi-schema/test-qapi.py          |  7 ++++---
>  tests/Makefile.include                  |  1 +
>  tests/qapi-schema/oob-coroutine.err     |  2 ++
>  tests/qapi-schema/oob-coroutine.json    |  2 ++
>  tests/qapi-schema/oob-coroutine.out     |  0
>  tests/qapi-schema/qapi-schema-test.json |  1 +
>  tests/qapi-schema/qapi-schema-test.out  |  2 ++
>  15 files changed, 51 insertions(+), 13 deletions(-)
>  create mode 100644 tests/qapi-schema/oob-coroutine.err
>  create mode 100644 tests/qapi-schema/oob-coroutine.json
>  create mode 100644 tests/qapi-schema/oob-coroutine.out
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 59d6973e1e..df01bd852b 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -457,6 +457,7 @@ Syntax:
>                  '*gen': false,
>                  '*allow-oob': true,
>                  '*allow-preconfig': true,
> +                '*coroutine': true,
>                  '*if': COND,
>                  '*features': FEATURES }
> =20
> @@ -581,6 +582,16 @@ before the machine is built.  It defaults to false. =
 For example:
>  QMP is available before the machine is built only when QEMU was
>  started with --preconfig.
> =20
> +Member 'coroutine' tells the QMP dispatcher whether the command handler
> +is safe to be run in a coroutine.  It defaults to false.  If it is true,
> +the command handler is called from coroutine context and may yield while
> +waiting for an external event (such as I/O completion) in order to avoid
> +blocking the guest and other background operations.
> +
> +It is an error to specify both 'coroutine': true and 'allow-oob': true
> +for a command.  (We don't currently have a use case for both together an=
d
> +without a use case, it's not entirely clear what the semantics should be=
.)

The parenthesis is new since v4.  I like its contents.  I'm not fond of
putting complete sentences in parenthesis.  I'll drop them, if you don't
mind.

> +
>  The optional 'if' member specifies a conditional.  See "Configuring
>  the schema" below for more on this.
> =20
[...]
> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index d7a289eded..95cc006cae 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -89,10 +89,16 @@ def check_flags(expr, info):
>          if key in expr and expr[key] is not False:
>              raise QAPISemError(
>                  info, "flag '%s' may only use false value" % key)
> -    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
> +    for key in ['boxed', 'allow-oob', 'allow-preconfig', 'coroutine']:
>          if key in expr and expr[key] is not True:
>              raise QAPISemError(
>                  info, "flag '%s' may only use true value" % key)
> +    if 'allow-oob' in expr and 'coroutine' in expr:
> +        # This is not necessarily a fundamental incompatibility, but we =
don't
> +        # have a use case and the desired semantics isn't obvious. The s=
implest
> +        # solution is to forbid it until we get a use case for it.

Appreciated.  I'll word-wrap, if you don't mind.

> +        raise QAPISemError(info, "flags 'allow-oob' and 'coroutine' "
> +                                 "are incompatible")
> =20
> =20
>  def check_if(expr, info, source):
> @@ -344,7 +350,7 @@ def check_exprs(exprs):
>                         ['command'],
>                         ['data', 'returns', 'boxed', 'if', 'features',
>                          'gen', 'success-response', 'allow-oob',
> -                        'allow-preconfig'])
> +                        'allow-preconfig', 'coroutine'])
>              normalize_members(expr.get('data'))
>              check_command(expr, info)
>          elif meta =3D=3D 'event':
[...]

R-by stands.


