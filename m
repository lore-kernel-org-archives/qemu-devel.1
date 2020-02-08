Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E0C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 15:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53FF82082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLESKx9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FF82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Rao-0007Rr-Gp
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 10:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j0RaA-0006kg-14
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j0Ra8-0004LM-Oq
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:59:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j0Ra8-0004KP-JL
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:59:40 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so2135652oty.6
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jNvPf8krr/omFfKguqhpZTL6tItHI8anHXtXlxjM9VU=;
 b=jLESKx9Z4EVKT8y37d4nJF+Hi+DATILUDhlQ+xmH6Hj6gAUxr10CGKjojkz2hhvqFn
 SBWaLxT2Y2P40R+0pFV0toUvIcTWBd+tgvbGJsIQCKRWWx20O/GRJN1RN7ggcXuNpHMh
 1sPkmNR/Tdr5TNA0NC8oV0fZzSS0WqQdk0qYWVPuBeqztN5WN5a+qSIKglumyXA0fKSX
 XTRQBTC4bqpcPkB+y9XMRN5KQjAJkOBlhjeloMJBuyQaxv4CZIe/vjFr2IsWqnZU2/Tp
 E2vmvYPuKnLmQfKLKBX8hn3LzXNe9q+A/X2UUM7Tghr2X3PHioB655ocfi0etPU3+Hy8
 BzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jNvPf8krr/omFfKguqhpZTL6tItHI8anHXtXlxjM9VU=;
 b=Uv6xmeUXZBaXXdBMB9eMwgcQucGihtuP9v/RBbPQVCmBX+LXJBgFlIbNqqdXOKzbq2
 EvU0vJ1l1d/8rV59eeYv9mkRrgnhFgCV1bJfdVfOeTYiCy1vbTRmuvhJVNvlv50ZTUk+
 8nTtq0Mba8BrKAvSwhxTU9i4Jasvbqop842iXfKr+jVyisqlr90KTAkh3PC7Oc+6hcwC
 6uyVwkpdp89c8yfmDToKW5OWIg7zrcoqIWqtiXk/kmfBEIaTiONYjHKboBAo+cvJW8ci
 MepUTmXB3tfn09+cxmIyOqSiLQEKYBq3i52GutxzivvQq6VtEYV7PF5littuelWnp2px
 ZoQg==
X-Gm-Message-State: APjAAAXYuU9Y92i0oH/QLE2fFevZSe6KnQ9SxzNWMWe7tdnrrIM0TLyY
 y7ShF3mHwQrznRb2F4eZ3HImjMJ3+gZ8web+Iio2MA==
X-Google-Smtp-Source: APXvYqxO5GHiaQlbp4LHZAEw0Hfvv/sspH02FcnwSm9POhTdp2y/EBmQhFqFMyjtUjl6EiGUSGVD7+lSoj+ZdhheTSY=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr3432197otq.97.1581173979715; 
 Sat, 08 Feb 2020 06:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <877e0ynxhx.fsf@dusky.pond.sub.org>
 <CAFEAcA-owBQMnvY5Asa4m4DUF-hBqRTmu8C7fktfvMRE2HZfgg@mail.gmail.com>
 <87blq9jhb5.fsf@dusky.pond.sub.org>
In-Reply-To: <87blq9jhb5.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Feb 2020 14:59:28 +0000
Message-ID: <CAFEAcA_WX1e1AWA=uryJLLMGNH7LMkr+iq+cMVnv9yneGSsECg@mail.gmail.com>
Subject: Re: [PATCH 00/29] Convert QAPI doc comments to generate rST instead
 of texinfo
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 14:16, Markus Armbruster <armbru@redhat.com> wrote:
> I understand the difficulty of parsing rST (Paolo called it "the Perl of
> markup languages" for a reason).  What I don't yet understand is (1) why
> we need to recognize the document structure of doc comments, and (2) why
> we can do that by recognizing '=' markup, but ignore the native rST
> document structure markup.

I think we're completely at cross purposes here, so there's
something I've not managed to communicate clearly.

We don't need to recognize the document structure of doc
comments, indeed my implementation does not -- it just
throws a doc comment at the rST parser to handle.

We *do* need to recognize the structure *of the document*
(ie that it does have a thing with a heading "Block devices"
that contains another thing with a heading "Background jobs"
that in turn contains documentation for JobType, JobStatus....)
so that when we're building up our tree of docutils node
objects we know when we need to create a new 'section'
node and give it a title 'Block devices' and which of
the various section nodes in the tree should have all
the nodes that make up the documentation of 'JobType'
added to it.

In order to achieve this separation (don't care about
document structure inside lumps of rST, but do want to
know what the overall section/subsection structure of
the document is), this patchset pulls the identification
of the document structure (heading/subheadings) completely
out of being something you might find in the middle of
a doc comment, and makes them their own
special kind of markup:

##
# = This is a heading
##

(In my head I find I'm thinking of this as "not actually
a doc comment", which is probably where some of my
lack of clarity is coming from, since syntactically
speaking and from the point of view of qapi/parser.py
that is a sort of doc comment.)

I suppose that there's an argument that the identification
of headings and subheadings should really be done in
qapi/parser.py, so that instead of

        vis = QAPISchemaGenRSTVisitor(self)
        vis.visit_begin(schema)
        for doc in schema.docs:
            if doc.symbol:
                vis.symbol(doc, schema.lookup_entity(doc.symbol))
            else:
                vis.freeform(doc)

you would have something more like

        vis = QAPISchemaGenRSTVisitor(self)
        vis.visit_begin(schema)
        for doc in schema.docs:
            if doc.symbol:
                vis.symbol(doc, schema.lookup_entity(doc.symbol))
            else if doc.is_section_header:
                vis.start_new_section(doc)
            else:
                vis.freeform(doc)

(with the identification of headers and pulling out of
what level of nesting this header is and what its text
is done in parser.py)

thanks
-- PMM

