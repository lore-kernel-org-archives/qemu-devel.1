Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A441C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9810208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC/CRZr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9810208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9sTg-0004aS-Sw
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9sSo-0003aF-BL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9sSn-0003aq-3S
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:31:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9sSm-0003aM-UO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583422264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNQYWIBAXDxJksDEudQ2/sffMTH5Kxxu53PDCtHnJN8=;
 b=bC/CRZr9EMZheXwzlOdtoLT7uxcqUIJ9GOl+eJnzbxt69ciG0homHp2M58Wt5X10oWtrNT
 ohDm5pw7kLFopvx6Xz0Cbds+P9i31zvNhvhyMK3CUbJ1aj8UNQDEGIIUuXJU1o/iOC2D07
 86bHsicukMGN++7aYg8x7ujSJkPhMkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-_NEhvAyiNfm4gAUyLTl2uA-1; Thu, 05 Mar 2020 10:31:02 -0500
X-MC-Unique: _NEhvAyiNfm4gAUyLTl2uA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BA60190B2A2;
 Thu,  5 Mar 2020 15:31:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76C3C1BC6D;
 Thu,  5 Mar 2020 15:30:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F37F211386A6; Thu,  5 Mar 2020 16:30:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-2-kwolf@redhat.com>
 <87lfq0yp9v.fsf@dusky.pond.sub.org>
 <20200122101021.GB5268@linux.fritz.box>
Date: Thu, 05 Mar 2020 16:30:56 +0100
In-Reply-To: <20200122101021.GB5268@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 22 Jan 2020 11:10:21 +0100")
Message-ID: <87h7z2ddjj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
>
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

I'm afraid it's even more complicated.

Monitors (HMP and QMP) run in the main loop.  Before this patch, HMP and
QMP commands run start to finish, one after the other.

After this patch, QMP commands may elect to yield.  QMP commands still
run one after the other (the shared dispatcher ensures this even when we
have multiple QMP monitors).

However, *HMP* commands can now run interleaved with a coroutine-enabled
QMP command, i.e. between a yield and its re-enter.

Consider an HMP screendump running in the middle of a coroutine-enabled
QMP screendump, using Marc-Andr=C3=A9's patch.  As far as I can tell, it
works, because:

1. HMP does not run in a coroutine.  If it did, and both dumps dumped
the same @con, then it would overwrite con->screndump_co.  If we ever
decide to make HMP coroutine-capable so it doesn't block the main loop,
this will become unsafe in a nasty way.

2. graphic_hw_update() is safe to call even while another
graphic_hw_update() runs.  qxl_render_update() appears to ensure that
with the help of qxl->ssd.lock.

3. There is no 3[*].

My point is: this is a non-trivial argument.  Whether a QMP command
handler is safe to run in a coroutine depends on how it interacts with
all the stuff that can run interleaved with it.  Typically includes
itself via its HMP buddy.


[*] I'm less confident in 3. than in 1. and 2.


