Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3039C33CB6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9F52465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7geMwkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9F52465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuH7d-0002Vo-EW
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iuH6Q-0001ac-1A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iuH6O-00082k-Is
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:35:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iuH6O-00082D-Ei
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579703727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFTw2DiE1LSAyA+PYDOMuZUDFdVcCho7fLoC2xgKH4E=;
 b=i7geMwkja3TfDsf5l/iC4dDucLhgs+j/gEWmXy0xK1pVamWHrWF117YTJF5ZBN3xveTCse
 DVqebQIeD0+0eCdS6p0RLgMwYnNWG2HF7uxEVv0hvE/clvBgEeSkfFZ3MHzvWCm9xn+iL7
 PDIAbtui6vM6ItvLloS1kRLqy+fl/so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-Tz5HUDmeNZGymbLYVskG1w-1; Wed, 22 Jan 2020 09:35:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD1861005510;
 Wed, 22 Jan 2020 14:35:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-57.ams2.redhat.com [10.36.117.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50F545DA75;
 Wed, 22 Jan 2020 14:35:20 +0000 (UTC)
Date: Wed, 22 Jan 2020 15:35:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 1/4] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200122143518.GA14997@linux.fritz.box>
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-2-kwolf@redhat.com>
 <87lfq0yp9v.fsf@dusky.pond.sub.org>
 <20200122101021.GB5268@linux.fritz.box>
 <874kwnvgad.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874kwnvgad.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Tz5HUDmeNZGymbLYVskG1w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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

Am 22.01.2020 um 13:15 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 22.01.2020 um 07:32 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>=20
> >> > This patch adds a new 'coroutine' flag to QMP command definitions th=
at
> >> > tells the QMP dispatcher that the command handler is safe to be run =
in a
> >> > coroutine.
> >>=20
> >> I'm afraid I missed this question in my review of v3: when is a handle=
r
> >> *not* safe to be run in a coroutine?
> >
> > That's a hard one to answer fully.
>=20
> You're welcome ;)
>=20
> > Basically, I think the biggest problem is with calling functions that
> > change their behaviour if run in a coroutine compared to running them
> > outside of coroutine context. In most cases the differences like having
> > a nested event loop instead of yielding are just fine, but they are
> > still subtly different.
> >
> > I know this is vague, but I can assure you that problematic cases exist=
.
> > I hit one of them with my initial hack that just moved everything into =
a
> > coroutine. It was related to graph modifications and bdrv_drain and
> > resulted in a hang. For the specifics, I would have to try and reproduc=
e
> > the problem again.
>=20
> Interesting.
>=20
> Is coroutine-incompatible command handler code necessary or accidental?
>=20
> By "necessary" I mean there are (and likely always will be) commands
> that need to do stuff that cannot or should not be done on coroutine
> context.
>=20
> "Accidental" is the opposite: coroutine-incompatibility can be regarded
> as a fixable flaw.

I expect it's mostly accidental, but maybe not all of it.

bdrv_drain() is an example of a function that has a problem with running
inside a coroutine: If you schedule another coroutine to run, it will
only run after the currently active coroutine yields. However,
bdrv_drain() doesn't yield, but runs a nested event loop, so this can
lead to deadlocks.

For this reason, bdrv_drain() has code to drop out of coroutine context,
so that you can call it from a coroutine anyway:

    /* Calling bdrv_drain() from a BH ensures the current coroutine yields =
and
     * other coroutines run if they were queued by aio_co_enter(). */

Now, after reading this, I think the problem in the QMP handler I
observerd was that it called some parts of the drain code without
dropping out of coroutine context first. Well possible that it was the
exact deadlock described by this comment.

(Even in bdrv_drain() it might not be strictly necessary. Maybe it's
possible to redesign bdrv_drain() so that it doesn't have a nested event
loop, but can somehow rely on the normal main loop. Touching it is
scary, though, so I'd rather not unless we have a good reason.)

> How widespread is coroutine-incompatibility?  Common, or just a few
> commands?

Answering this would require a massive code audit. Way out of scope for
this series. This is the reason why I decided to just make it optional
instead of trying to find and fix the cases that would need a fix if we
enabled coroutine handlers unconditionally.

> If coroutine-incompatibility is accidental, then your code to drop out
> of coroutine context can be regarded as a temporary work-around.  Such
> work-arounds receive a modest extra ugliness & complexity budget.
>=20
> If coroutine-incompatibility is rare, we'll eventually want "mark the
> known-bad ones with 'coroutine': false" instead of "mark the known-good
> ones with 'coroutine': true".  I'm okay with marking the known-good ones
> initially, and flipping only later.
>=20
> Inability to recognize coroutine-incompatibility by inspection worries
> me.  Can you think of ways to identify causes other than testing things
> to death?

I think it is possible to recognise by inspection, it would just be a
massive effort. Maybe a way to start it could be adding something like a
non_coroutine_fn marker to functions that we know don't want to be
called from coroutine context, and propagating it to their callers.

I guess I would start by looking for nested event loops (AIO_WAIT_WHILE
or BDRV_POLL_WHILE), and then you would have to decide for each whether
it could run into problems. I can't promise this will cover everything,
but it would at least cover the case known from bdrv_drain.

Kevin


