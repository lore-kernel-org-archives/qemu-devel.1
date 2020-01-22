Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF33AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0E22467F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrBKfwv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0E22467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEvb-00059C-VP
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 07:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iuEui-0004Y9-UM
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iuEuh-0001mE-Nm
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:15:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iuEuh-0001lh-KO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579695315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snEvOLNwX+X6177qDnN765ZYN5vIhzdjZahMb9d0Zl0=;
 b=WrBKfwv85NTdIrliACn5rADUhhEyCLSmLLOKzo7UhwBiJl89jV6HQiVWwWGOi0Oeo8f3GQ
 XVtNawpPi4TUuWuOyFgVJNXQRflzyn7j+bYD/sX6TGW5ekd12qIlLfYxMirTwThYs4JnTx
 4NErxppqwCGX5tpDTkzrd78kIutmV4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-43dpAgUePGqMijbzdiyLrA-1; Wed, 22 Jan 2020 07:15:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817528010C9;
 Wed, 22 Jan 2020 12:15:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B74AA3AC;
 Wed, 22 Jan 2020 12:15:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 485F81138600; Wed, 22 Jan 2020 13:15:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-2-kwolf@redhat.com>
 <87lfq0yp9v.fsf@dusky.pond.sub.org>
 <20200122101021.GB5268@linux.fritz.box>
Date: Wed, 22 Jan 2020 13:15:06 +0100
In-Reply-To: <20200122101021.GB5268@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 22 Jan 2020 11:10:21 +0100")
Message-ID: <874kwnvgad.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 43dpAgUePGqMijbzdiyLrA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 22.01.2020 um 07:32 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > This patch adds a new 'coroutine' flag to QMP command definitions that
>> > tells the QMP dispatcher that the command handler is safe to be run in=
 a
>> > coroutine.
>>=20
>> I'm afraid I missed this question in my review of v3: when is a handler
>> *not* safe to be run in a coroutine?
>
> That's a hard one to answer fully.

You're welcome ;)

> Basically, I think the biggest problem is with calling functions that
> change their behaviour if run in a coroutine compared to running them
> outside of coroutine context. In most cases the differences like having
> a nested event loop instead of yielding are just fine, but they are
> still subtly different.
>
> I know this is vague, but I can assure you that problematic cases exist.
> I hit one of them with my initial hack that just moved everything into a
> coroutine. It was related to graph modifications and bdrv_drain and
> resulted in a hang. For the specifics, I would have to try and reproduce
> the problem again.

Interesting.

Is coroutine-incompatible command handler code necessary or accidental?

By "necessary" I mean there are (and likely always will be) commands
that need to do stuff that cannot or should not be done on coroutine
context.

"Accidental" is the opposite: coroutine-incompatibility can be regarded
as a fixable flaw.

How widespread is coroutine-incompatibility?  Common, or just a few
commands?

If coroutine-incompatibility is accidental, then your code to drop out
of coroutine context can be regarded as a temporary work-around.  Such
work-arounds receive a modest extra ugliness & complexity budget.

If coroutine-incompatibility is rare, we'll eventually want "mark the
known-bad ones with 'coroutine': false" instead of "mark the known-good
ones with 'coroutine': true".  I'm okay with marking the known-good ones
initially, and flipping only later.

Inability to recognize coroutine-incompatibility by inspection worries
me.  Can you think of ways to identify causes other than testing things
to death?


