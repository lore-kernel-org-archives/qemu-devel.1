Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094F5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7434021655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="so/xmxZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7434021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifoAJ-0003rd-3M
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifnno-0003PL-FA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ifnnn-0007r4-6a
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:28:28 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ifnnm-0007nS-W7
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:28:27 -0500
Received: by mail-wm1-x344.google.com with SMTP id b19so196678wmj.4
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 08:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Sm58xKxe1/bt4e5DzVHHwLB3EwuQZ/BBP/mfWm0gKt4=;
 b=so/xmxZB7w7Jav4ZLQSjB3CPHcdSWuVfHx9K7rZzN55fGGl2MieXXJwqClakcS6oZg
 HiVcaTfGMiww6lrAqajHV5BYYXCevFJiXHr5X40LaM5uh87O/X72nwitvKLBmTHQHS7g
 2pvOSqHLuKLzaZW/8jxNUmjYa1lVfmSrHNK5bY3ci/JgcEdC1AXi3rcOAfk45/15TYJa
 9qdjjUnBOyotZez+5UOeXBhGRfpTFd+DGWGJg0Lz5S/PtGSCs6bNwvar4+NmISlCt5ZQ
 1sZXmAqtD7ueKh/VN5YvaMtRrgEXgzIhPGU75IkZOTZL5f1c5E/xwvcClgcZNgU1cS4q
 omSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Sm58xKxe1/bt4e5DzVHHwLB3EwuQZ/BBP/mfWm0gKt4=;
 b=QHZGCIe02d5lt3gG5bxBzo4thUIShRfQd+L4xHFZyxZDOr7pNkNqtMM8IYaY4F2oWU
 xfb7Aqiqg0SeZBmtb3F2jhhfI3g/HEAImCOLkYf6Naj9my7Pph/kgR8NTr0wZ1fn2Fit
 odlQdU6bbIcb9lnZGgl6+XYA+lyRnZWmxH5mGXlwrMWE2VA4OYWrlnI6sk+BihU7ZpFs
 9HwMOnj9YJkIbhmVev8D7uL6RNlNF01GTITjOX/J6oBJaOTZx+Mk9CAdA8TecLoyvnGI
 0AfwpBb25s87sp4CR8irmmopsAVZqynTUZeEb12Jlbhw5j70Ywvfc2zIs4sfTH45U5k9
 jt3A==
X-Gm-Message-State: APjAAAVz7RBS6WvWkK8vK/uLZ6SMTxqkZU7zsZ5lBZ5i0sYV5m5JH0D0
 AGuiu/GOi2T+g5Z6/oXwAKC5uYTZlYqQbbghRWA=
X-Google-Smtp-Source: APXvYqxRFKSWbfYjOM2S3WU2JSsr/OTbR46DQNSg4ZMhXI0NDQwUo1jg1Tty382Sakk45v6nRocPUUWeTnLGfVoSEMg=
X-Received: by 2002:a05:600c:219a:: with SMTP id
 e26mr15408405wme.42.1576254504325; 
 Fri, 13 Dec 2019 08:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191213160330.GD3428@localhost.localdomain>
In-Reply-To: <20191213160330.GD3428@localhost.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 13 Dec 2019 20:28:12 +0400
Message-ID: <CAJ+F1CLSfYPFPych4twnvOMt3qR4UnGauWq_k=VN8W5kKUze9g@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] monitor: add asynchronous command type
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Hi

On Fri, Dec 13, 2019 at 8:04 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 08.11.2019 um 16:00 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > The following series implements an internal async command solution
> > instead. By introducing a session context and a command return
> > handler, QMP handlers can:
> > - defer the return, allowing the mainloop to reenter
> > - return only to the caller (instead of the broadcast event reply)
> > - optionnally allow cancellation when the client is gone
> > - track on-going qapi command(s) per session
>
> This requires major changes to existing QMP command handlers. Did you
> consider at least optionally providing a way where instead of using the
> new async_fn, QMP already creates a coroutine in which the handler is
> executed?

Yes, but I don't see how this could be done without the basic callback
infrastructure I propose here. Also forcing existing code to be
translated to coroutine-aware is probably even more complicated.

>
> At least for some of the block layer commands, we could simply enable
> this without changing any of the code and would automatically get rid of
> blocking the guest while the command is doing I/O. If we need to
> implement .async_fn, in contrast, it would be quite a bit of boiler
> plate code for each single handler to create a coroutine for the real
> handler and to wrap all parameters in a struct.

We could have the generator do that for you eventually, and spawn the corou=
tine.

>
> I started playing a bit with this and it didn't look too bad, but we
> can't move every command handler to a coroutine without auditing it, so
> I would have had to add a new option to the QAPI schema - and at that
> point I thought that I might end up duplicating a lot of your code if I
> continued. So I'm now trying to get your opinion or advice before I
> continue with anything in that direction.

thanks for looking at this old series!

>
> > This does not introduce new QMP APIs or client visible changes, the
> > command are handled in order, and the reply still come in order (even
> > when handlers finish out of order).
> >
> > Existing qemu commands can be gradually replaced by async:true
> > variants when needed, while carefully reviewing the concurrency
> > aspects. The async:true commands marshaller helpers are splitted in
> > half, the calling and return functions. The command is called with a
> > QmpReturn context, that can return immediately or later, using the
> > generated return helper.
>
> This part would certainly become simpler with coroutines (the marshaller
> could stay unchanged).

That's not much change honestly. I am not sure sneaking a coroutine
behind its back is going to be simpler, I would need to look at it.

>
> > The screendump command is converted to an async:true version to solve
> > rhbz#1230527. The command shows basic cancellation (this could be
> > extended if needed). It could be further improved to do asynchronous
> > IO writes as well.
>
> After converting it to QIOChannel like you already do, I/O would
> automatically become asynchronous when run in a coroutine.
>
> If you don't want this yet, but only fix the BZ, I guess you could delay
> that patch until later and just have a single yield and reenter of the
> command handler coroutine like this:
>
>     co =3D qemu_coroutine_self();
>     aio_co_schedule(qemu_coroutine_get_aio_context(co), co);
>     qemu_coroutine_yield();
>

If various places of code start doing that, we are in trouble, the
stack may grow, cancellation becomes hairy.

Furthermore, in the case of screendump, IO is not necessarily within
the coroutine context. In this case, we need to wait for the QXL
device to "flush" the screen. Communicating this event back to the
coroutine isn't simpler than what I propose here.

Thanks!

--=20
Marc-Andr=C3=A9 Lureau

