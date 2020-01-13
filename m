Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84353C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E43220678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJZ0h/G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E43220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir28V-00060K-R5
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ir27I-0004UY-10
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ir27G-00085Y-SB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:58:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ir27G-000854-OS
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578931138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d2DB6Vw59jcUww/La6U6X4TFwN5pQkvC8xVqfvWM8V4=;
 b=eJZ0h/G7eU2Yq0ZOTlXuJcHjIVrq3r1YSXnvK0OQQrpHCHLunBXNn4kJFWE5aC5cKrd5Om
 NUXOhno8/vwS0bMfHWTddWsAAYhfCws/6LQ25adcXNRSJoS5fobs1v12zcKiIBXW8M2FR0
 GevR8YicX6M6XuB/a+Bzi3v0+SPrpAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-r-1EcwUSNbS0DUvBjSc7FA-1; Mon, 13 Jan 2020 10:58:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E5FDB20;
 Mon, 13 Jan 2020 15:58:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39E065C1B0;
 Mon, 13 Jan 2020 15:58:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02D3B1138600; Mon, 13 Jan 2020 16:58:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191213160330.GD3428@localhost.localdomain>
 <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
 <20191216120701.GC6610@linux.fritz.box>
 <CAJ+F1CJjrh3LJs=YtNOkk3rYo-MpmXr3ho9pt0z7tnqm4kp96w@mail.gmail.com>
 <20200107051728.GA4076@linux.fritz.box>
 <CAJ+F1CLocmL-9d06jsbfUFq1peV7w-Ho30vKnp7cVVk8jfXVnw@mail.gmail.com>
Date: Mon, 13 Jan 2020 16:58:49 +0100
In-Reply-To: <CAJ+F1CLocmL-9d06jsbfUFq1peV7w-Ho30vKnp7cVVk8jfXVnw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 7 Jan 2020
 16:11:01 +0400")
Message-ID: <87h80zwdom.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: r-1EcwUSNbS0DUvBjSc7FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jan 7, 2020 at 9:17 AM Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 06.01.2020 um 19:21 hat Marc-Andr=C3=A9 Lureau geschrieben:
>> > > What my patch does is moving everything into a coroutine. This is wr=
ong
>> > > because not everything can be run in a coroutine, so it needs to be =
made
>> > > optional (like you did with your async flag).
>> >
>> > "everything" is a bit too much ;) You proposal is to replace
>> > qmp_dispatch_bh by a coroutine version (except for OOB commands). This
>> > is nice because indeed, it allows to reenter the mainloop with a
>> > simple yield in QMP commands. It is also simpler than my "async"
>> > proposal, because some of the state is part of the coroutine, and
>> > because it doesn't allow QMP commands concurrency (beside existing
>> > OOB).
>> >
>> > Iow, coroutine (for async) + oob (for concurrency) make my proposal
>> > kinda obsolete. I can only regret that a simple callback-based
>> > solution looked simpler to me than one that mixes both threads &
>> > coroutines, but I don't mind if everybody likes it better :) I can
>> > definitely see the point for block commands, which rely on coroutines
>> > anyway, and qemu is already that complex in general.
>>
>> Callbacks are indeed simple enough for implementing the infrastructure,
>> but for the users they only look simple as long as they do trivial
>> things. :-)
>>
>> Anyway, now that you have seen my POC hack, do you agree that this
>> should help solving the screendump problem, too?
>
> Yes, and I will work on it as soon as you have a working patch series
> or branch :)
>
>>
>> > > The problem isn't with completely coroutine-unaware code, though: Th=
at
>> > > one would just work, even if not taking advantage from the coroutine=
. A
>> > > potential problem exists with code that behaves differently when run=
 in
>> > > a coroutine or outside of coroutine context (generally by checking
>> > > qemu_in_coroutine())), or calls of coroutine-unaware code into such
>> > > functions.
>> > >
>> > > Running some command handlers outside of coroutine context wouldn't =
be
>> > > hard to add to my patch (basically just a BH), but I haven't looked =
into
>> > > the QAPI side of making it an option.
>> >
>> > Yes, I think we should have a 'coroutine': true, for commands that
>> > should be run with a coroutine.
>> >
>> > Or perhaps replace existing allow-oob with 'dispatch':
>> > - 'bh' (default)
>> > - 'coroutine'
>> > - 'allow-oob' (oob + bh fallback, since oob don't have coroutine - at
>> > this point)
>>
>> If it's "at this point", then making it two separate bools would make
>> more sense. But I seem to remember that OOB handlers are fundamentally
>> not supposed to block, so coroutine support would be pointless for them
>> and an enum could work.
>
> I think so too
>
>>
>> I'll defer to Markus on this one.
>
> Yup, Markus should take a look at your proposal and give some
> guidance. And hopefully, it won't take >2y.

Is it "[PATCH 0/4] qmp: Optionally run handlers in coroutines"?

[...]


