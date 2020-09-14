Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790FBC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31EB20756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcLwPOLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31EB20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqUn-0006Jg-Im
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHqD2-000159-Ab
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:16:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHqD0-0001nr-BO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600096557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKK9nTa02ZOIQBe5cGtPJtkprUzMiMuONLGWFOpS2pU=;
 b=YcLwPOLGm+XGY1RwBg3cYJtxz0jJE9v+cXDJbz/XUQjYUK0Dr4AsLrCoBF7PUixv6FbVih
 +OFQ6TwxWcv0Fn6f1NFdlSwvebNje8ox7Ey5aiJHDjIYKKpAYTKvOeguUBKVv/kLNfkNqU
 Z/EmMz14GcrXt03g5Qfo5AnuqAGLkFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-HKvmitNtOraFdjfL_mORWw-1; Mon, 14 Sep 2020 11:15:43 -0400
X-MC-Unique: HKvmitNtOraFdjfL_mORWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB7AADC00;
 Mon, 14 Sep 2020 15:15:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBAED5C89C;
 Mon, 14 Sep 2020 15:15:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 735ED113864A; Mon, 14 Sep 2020 17:15:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 08/13] qapi: Add a 'coroutine' flag for commands
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-9-kwolf@redhat.com>
Date: Mon, 14 Sep 2020 17:15:34 +0200
In-Reply-To: <20200909151149.490589-9-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:44 +0200")
Message-ID: <87r1r4mlt5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
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
>  docs/devel/qapi-code-gen.txt            | 12 ++++++++++++
>  include/qapi/qmp/dispatch.h             |  1 +
>  tests/test-qmp-cmds.c                   |  4 ++++
>  scripts/qapi/commands.py                | 10 +++++++---
>  scripts/qapi/doc.py                     |  2 +-
>  scripts/qapi/expr.py                    | 10 ++++++++--
>  scripts/qapi/introspect.py              |  2 +-
>  scripts/qapi/schema.py                  | 12 ++++++++----
>  tests/qapi-schema/test-qapi.py          |  7 ++++---
>  tests/qapi-schema/meson.build           |  1 +
>  tests/qapi-schema/oob-coroutine.err     |  2 ++
>  tests/qapi-schema/oob-coroutine.json    |  2 ++
>  tests/qapi-schema/oob-coroutine.out     |  0
>  tests/qapi-schema/qapi-schema-test.json |  1 +
>  tests/qapi-schema/qapi-schema-test.out  |  2 ++
>  15 files changed, 54 insertions(+), 14 deletions(-)
>  create mode 100644 tests/qapi-schema/oob-coroutine.err
>  create mode 100644 tests/qapi-schema/oob-coroutine.json
>  create mode 100644 tests/qapi-schema/oob-coroutine.out
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index f3e7ced212..36daa9b5f8 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -472,6 +472,7 @@ Syntax:
>                  '*gen': false,
>                  '*allow-oob': true,
>                  '*allow-preconfig': true,
> +                '*coroutine': true,
>                  '*if': COND,
>                  '*features': FEATURES }
> =20
> @@ -596,6 +597,17 @@ before the machine is built.  It defaults to false. =
 For example:
>  QMP is available before the machine is built only when QEMU was
>  started with --preconfig.
> =20
> +Member 'coroutine' tells the QMP dispatcher whether the command handler
> +is safe to be run in a coroutine.

We need to document what exactly makes a command handler coroutine safe
/ unsafe.  We discussed this at some length in review of PATCH v4 1/4:

    Message-ID: <874kwnvgad.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg05015.html

I'd be willing to accept a follow-up patch, if that's more convenient
for you.

>                                     It defaults to false.  If it is true,
> +the command handler is called from coroutine context and may yield while

Is it *always* called from coroutine context, or could it be called
outside coroutine context, too?  I guess the former, thanks to PATCH 10,
and as long as we diligently mark HMP commands that such call QMP
handlers, like you do in PATCH 13.

What's the worst than can happen when we neglect to mark such an HMP
command?

> +waiting for an external event (such as I/O completion) in order to avoid
> +blocking the guest and other background operations.
> +
> +It is an error to specify both 'coroutine': true and 'allow-oob': true
> +for a command.  We don't currently have a use case for both together and
> +without a use case, it's not entirely clear what the semantics should
> +be.
> +
>  The optional 'if' member specifies a conditional.  See "Configuring
>  the schema" below for more on this.
[...]


