Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12064C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19C22072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDI2ZInH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19C22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX0x-0006qp-Tx
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ioX0L-0006No-L7
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ioX0K-0000ba-BJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:21:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ioX0K-0000at-5c
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:21:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so16335769wmb.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 10:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Wh/AfT3rdeowzeEbb/qa7yG6eyu9IKsfDsMrBquHvbU=;
 b=UDI2ZInHYR0BCGcVe6sXzOF9cBt6YlKQGxoPM0aEuAaIHBfYd2T2NKkkCqmFdGwJ0T
 Dd5imlU/cC57rrQAd56HA7h1HMgjB9hwBl8a83PryrxkQdUlRDnkuuO2DqOaqt7BIXJP
 C5xsndInfAcSEsQ57tmJibreHaALs86dIOkho8G2La8h9olEuSNnKe8loMJbyo6b3BTY
 WGePohFLaK0dkQ0E7et5bLJDCNOo62OlUJEh82hsLhUnMESNVqPS5XpLqdEA4ecNj8EH
 +eoJDzHFxoqE58qlhiohkM3zI/RvnWnHnXCVMRP4zUZtdMeXvUz2OJ+/bCJPAy1UbVxO
 w2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Wh/AfT3rdeowzeEbb/qa7yG6eyu9IKsfDsMrBquHvbU=;
 b=f7OeU8w0+uVPiUu8c6qZDvk6RnLlVhvyB0lL5ZveAiuLCdUFn+Y9CaQz7wNV5IMk75
 DiqWtqa5QeP7/yyxSNMQCjNuWL7CyKHom/GxitGirETZjBd4B4QQa+YP4uYc6xUkPGee
 5sxJMD8OUV2kyH0pEB+q+e8kvpXuslVnfzR+G/A6CZwJg1wfPr1CJ3lVMWAXMNISAauz
 PchLB8pCyqX9s3xbByJA1gLDsbVRqOPDoeOW0qvOKWrWPZISv9Zr/ECeD7KOTXel3RWJ
 Dq4EXqhOHW7yLEJp3rKNvBwPoyKwgPMDWWAugp3KT/c35SVDg7fW7HSkPUdSJk6/bW+W
 ugqg==
X-Gm-Message-State: APjAAAVCgN0pWGJf5ZYVoy1hvbkXUECNJID9sYBc5S96RhJmFaLywETJ
 HtYL8k362y6SgMVeB9zAz7m4TMu8lZOLzhhq9wg=
X-Google-Smtp-Source: APXvYqztA3iwLJe7DwkmLsQ9RsKmWJWJK8wQa1MOIz+M+n7kKfWQm4+bjNvxn3SRXslkM9PSovW7lfpLY3MVrVkfDCs=
X-Received: by 2002:a05:600c:2059:: with SMTP id
 p25mr36828432wmg.161.1578334886964; 
 Mon, 06 Jan 2020 10:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191213160330.GD3428@localhost.localdomain>
 <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
 <20191216120701.GC6610@linux.fritz.box>
In-Reply-To: <20191216120701.GC6610@linux.fritz.box>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Jan 2020 22:21:13 +0400
Message-ID: <CAJ+F1CJjrh3LJs=YtNOkk3rYo-MpmXr3ho9pt0z7tnqm4kp96w@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Hi Kevin,

On Mon, Dec 16, 2019 at 4:07 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 13.12.2019 um 17:28 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > On Fri, Dec 13, 2019 at 8:04 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 08.11.2019 um 16:00 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > > > The following series implements an internal async command solution
> > > > instead. By introducing a session context and a command return
> > > > handler, QMP handlers can:
> > > > - defer the return, allowing the mainloop to reenter
> > > > - return only to the caller (instead of the broadcast event reply)
> > > > - optionnally allow cancellation when the client is gone
> > > > - track on-going qapi command(s) per session
> > >
> > > This requires major changes to existing QMP command handlers. Did you
> > > consider at least optionally providing a way where instead of using t=
he
> > > new async_fn, QMP already creates a coroutine in which the handler is
> > > executed?
> >
> > Yes, but I don't see how this could be done without the basic callback
> > infrastructure I propose here. Also forcing existing code to be
> > translated to coroutine-aware is probably even more complicated.
>
> I'll attach what I hacked up last week after discussing a problem with
> Markus and Max. As you probably expected, screendump isn't really my
> main motivation to look into this. The specific command we discussed was
> block_resize, which can potentially block the monitor for a while, but
> I'm sure that many more block commands have the same problem.

Thanks, that helps me to understand your proposal (I had something
more complicated in mind)

> What my patch does is moving everything into a coroutine. This is wrong
> because not everything can be run in a coroutine, so it needs to be made
> optional (like you did with your async flag).

"everything" is a bit too much ;) You proposal is to replace
qmp_dispatch_bh by a coroutine version (except for OOB commands). This
is nice because indeed, it allows to reenter the mainloop with a
simple yield in QMP commands. It is also simpler than my "async"
proposal, because some of the state is part of the coroutine, and
because it doesn't allow QMP commands concurrency (beside existing
OOB).

Iow, coroutine (for async) + oob (for concurrency) make my proposal
kinda obsolete. I can only regret that a simple callback-based
solution looked simpler to me than one that mixes both threads &
coroutines, but I don't mind if everybody likes it better :) I can
definitely see the point for block commands, which rely on coroutines
anyway, and qemu is already that complex in general.

>
> The problem isn't with completely coroutine-unaware code, though: That
> one would just work, even if not taking advantage from the coroutine. A
> potential problem exists with code that behaves differently when run in
> a coroutine or outside of coroutine context (generally by checking
> qemu_in_coroutine())), or calls of coroutine-unaware code into such
> functions.
>
> Running some command handlers outside of coroutine context wouldn't be
> hard to add to my patch (basically just a BH), but I haven't looked into
> the QAPI side of making it an option.

Yes, I think we should have a 'coroutine': true, for commands that
should be run with a coroutine.

Or perhaps replace existing allow-oob with 'dispatch':
- 'bh' (default)
- 'coroutine'
- 'allow-oob' (oob + bh fallback, since oob don't have coroutine - at
this point)

Your patch looks quite good to me, but make check hangs. Have you looked at=
 it?

--=20
Marc-Andr=C3=A9 Lureau

