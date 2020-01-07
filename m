Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E44CC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 05:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F8F20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 05:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPrzU2C9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F8F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iohJd-0001yj-0D
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 00:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iohFM-00042i-Ku
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 00:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iohFI-0004Uw-Ru
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 00:17:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iohFI-0004Q6-Eu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 00:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578374255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuGUXjXlQVU7S/OjpplK1c9Qs9X3R404mVo2lWr1FE0=;
 b=JPrzU2C9SlmcsT9VGXDcdsaCfugjLXybeIpVaPaxl3rCLDxSS0qrAdvxTXXuk/3zipvntl
 2w4JlsI3KGdadYqZfxuo4bEZN4Yoq3rUHCPXN6uToigcpcQGJNFbrw9mSEmJbr2wQXJVoh
 Lu9mltq7pgL0jqmwHmCMulSc+p8PAjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-MlB245nWNC2lrSOVfwACrw-1; Tue, 07 Jan 2020 00:17:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61A771800D4E;
 Tue,  7 Jan 2020 05:17:33 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFE995D9CA;
 Tue,  7 Jan 2020 05:17:29 +0000 (UTC)
Date: Tue, 7 Jan 2020 06:17:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
Message-ID: <20200107051728.GA4076@linux.fritz.box>
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191213160330.GD3428@localhost.localdomain>
 <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
 <20191216120701.GC6610@linux.fritz.box>
 <CAJ+F1CJjrh3LJs=YtNOkk3rYo-MpmXr3ho9pt0z7tnqm4kp96w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJjrh3LJs=YtNOkk3rYo-MpmXr3ho9pt0z7tnqm4kp96w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: MlB245nWNC2lrSOVfwACrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.01.2020 um 19:21 hat Marc-Andr=E9 Lureau geschrieben:
> > What my patch does is moving everything into a coroutine. This is wrong
> > because not everything can be run in a coroutine, so it needs to be mad=
e
> > optional (like you did with your async flag).
>=20
> "everything" is a bit too much ;) You proposal is to replace
> qmp_dispatch_bh by a coroutine version (except for OOB commands). This
> is nice because indeed, it allows to reenter the mainloop with a
> simple yield in QMP commands. It is also simpler than my "async"
> proposal, because some of the state is part of the coroutine, and
> because it doesn't allow QMP commands concurrency (beside existing
> OOB).
>=20
> Iow, coroutine (for async) + oob (for concurrency) make my proposal
> kinda obsolete. I can only regret that a simple callback-based
> solution looked simpler to me than one that mixes both threads &
> coroutines, but I don't mind if everybody likes it better :) I can
> definitely see the point for block commands, which rely on coroutines
> anyway, and qemu is already that complex in general.

Callbacks are indeed simple enough for implementing the infrastructure,
but for the users they only look simple as long as they do trivial
things. :-)

Anyway, now that you have seen my POC hack, do you agree that this
should help solving the screendump problem, too?

> > The problem isn't with completely coroutine-unaware code, though: That
> > one would just work, even if not taking advantage from the coroutine. A
> > potential problem exists with code that behaves differently when run in
> > a coroutine or outside of coroutine context (generally by checking
> > qemu_in_coroutine())), or calls of coroutine-unaware code into such
> > functions.
> >
> > Running some command handlers outside of coroutine context wouldn't be
> > hard to add to my patch (basically just a BH), but I haven't looked int=
o
> > the QAPI side of making it an option.
>=20
> Yes, I think we should have a 'coroutine': true, for commands that
> should be run with a coroutine.
>=20
> Or perhaps replace existing allow-oob with 'dispatch':
> - 'bh' (default)
> - 'coroutine'
> - 'allow-oob' (oob + bh fallback, since oob don't have coroutine - at
> this point)

If it's "at this point", then making it two separate bools would make
more sense. But I seem to remember that OOB handlers are fundamentally
not supposed to block, so coroutine support would be pointless for them
and an enum could work.

I'll defer to Markus on this one.

> Your patch looks quite good to me, but make check hangs. Have you
> looked at it?

I'm not sure if I was looking at some qemu-iotests cases or make check,
but yes, I did see a hang. My case was a QMP command that just doesn't
work correctly inside a coroutine without modifications, so requiring
'coroutine': true would fix it.

Kevin


