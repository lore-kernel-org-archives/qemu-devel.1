Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17471C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DEE20722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZC7fju/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DEE20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEMl-0001RK-S9
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFEMC-0000uv-MO
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFEMA-0000pZ-Hv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:54:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFEMA-0000ob-9C
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584698061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlKjakBu1jeKwdJ9sq5CFtIc+iUJMl1FnBSHah6lzj8=;
 b=BZC7fju/qEV4n2iDkHv4/kTAKV28HhmPM6A2FCwsTI5+LRL1+R/Rfu8gi7bNu6teLnTqjT
 aS9eiUxGAKzQ0BNZ8VeC8aMvxNnSvpP9lKHUh8+mL6dS8rnD6SQc+TGoZiUtmvVcJTEDfv
 D9AUAE+443q+xvTpokc97vvU5CEKwJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-qI8nEs5nN--WoA_7fqgd4w-1; Fri, 20 Mar 2020 05:54:15 -0400
X-MC-Unique: qI8nEs5nN--WoA_7fqgd4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFB24149C8;
 Fri, 20 Mar 2020 09:54:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6556D94B23;
 Fri, 20 Mar 2020 09:54:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B06C11138404; Fri, 20 Mar 2020 10:54:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 02/18] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-3-peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 10:54:07 +0100
In-Reply-To: <20200309154405.13548-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 9 Mar 2020 15:43:49 +0000")
Message-ID: <87v9mz5p34.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Our current QAPI doc-comment markup allows section headers
> (introduced with a leading '=3D' or '=3D=3D') anywhere in any documentati=
on
> comment.  This works for texinfo because the texi generator simply
> prints a texinfo heading directive at that point in the output
> stream.  For rST generation, since we're assembling a tree of
> docutils nodes, this is awkward because a new section implies
> starting a new section node at the top level of the tree and
> generating text into there.
>
> New section headings in the middle of the documentation of a command
> or event would be pretty nonsensical, and in fact we only ever output
> new headings using 'freeform' doc comment blocks whose only content
> is the single line of the heading, with two exceptions, which are in
> the introductory freeform-doc-block at the top of
> qapi/qapi-schema.json.
>
> Split that doc-comment up so that the heading lines are in their own
> doc-comment.  This will allow us to tighten the specification to
> insist that heading lines are always standalone, rather than
> requiring the rST document generator to look at every line in a doc
> comment block and handle headings in odd places.
>
> This change makes no difference to the generated texi.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/qapi-schema.json | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index fe980ce4370..ff5aea59451 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -1,7 +1,9 @@
>  # -*- Mode: Python -*-
>  ##
>  # =3D Introduction
> -#
> +##
> +
> +##
>  # This document describes all commands currently supported by QMP.
>  #
>  # Most of the time their usage is exactly the same as in the user Monito=
r, this
> @@ -25,9 +27,13 @@
>  #
>  # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
>  # detailed information on the Server command and response formats.
> -#
> +##
> +
> +##
>  # =3D Stability Considerations
> -#
> +##
> +
> +##
>  # The current QMP command set (described in this file) may be useful for=
 a
>  # number of use cases, however it's limited and several commands have ba=
d
>  # defined semantics, specially with regard to command completion.

The restriction you add is tolerable.  But how does the doc generator
behave when I get it wrong?  The test case for getting it wrong is
tests/qapi-schema/doc-bad-section.json.

In current master (commit f57587c7d47b35b2d9b31def3a74d81bdb5475d7),

    $ scripts/qapi-gen.py tests/qapi-schema/doc-bad-section.json=20

produces this qapi-doc.texi:

    @c AUTOMATICALLY GENERATED, DO NOT MODIFY


    @deftp {Enum} Enum

    @subsection Produces @strong{invalid} texinfo

    @b{Values:}
    @table @asis
    @item @code{one}
    The @emph{one} @{and only@}
    @item @code{two}
    Not documented
    @end table
    @code{two} is undocumented

    @end deftp

This is invalid Texinfo:

    $ makeinfo qapi-doc.texi=20
    qapi-output-master/qapi-doc.texi:4: warning: entry for index `tp' outsi=
de of any node
    qapi-output-master/qapi-doc.texi:6: @subsection seen before @end deftp
    qapi-output-master/qapi-doc.texi:17: unmatched `@end deftp'
    [Exit 1 ]

Ignore the warning, it's due to the harmlessly lazy test case.

A developer who puts a section heading in the wrong place in the schema
gets to divine his mistake from makeinfo's error messages.  Not nice.

After your rST conversion[*], ...  Well, I tried to figure out how to
build .html from tests/qapi-schema/doc-bad-section.json, but failed.
Alright, use a heavier hammer: append that file to qapi-schema.json.
Build succeeds, and produces a qemu-qmp-ref.7 that /usr/bin/man renders
like this:

       Enum (Enum)
           =3D=3D No good here

       Values
           one    The _one_ {and only}

           two    Not documented
           two is undocumented

I consider this even worse than before.

With my "[PATCH 1/2] qapi: Reject section markup in definition
documentation", qapi-gen.py rejects it cleanly:

    tests/qapi-schema/doc-bad-section.json:5:1: unexpected '=3D' markup in
    definition documentation

I believe it won't hinder your .rST conversion work.  It might even
help.  Maybe only together with PATCH 2/2, but that's for you to decide.


[*] Fetched from
https://git.linaro.org/people/peter.maydell/qemu-arm.git
sphinx-conversions


