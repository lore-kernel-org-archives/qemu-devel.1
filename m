Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BBC2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6YbJyzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BBC2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9qN-00032j-Ra
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jA9pi-0002aV-BA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jA9pg-0002n0-QK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:03:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jA9pg-0002k2-Ho
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:03:52 -0500
Received: by mail-wm1-x343.google.com with SMTP id a25so9042969wmm.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CJ2+nPUOjOF4/0Ry1zzEOHnYhL+QGpxItOR8riPLmxM=;
 b=Y6YbJyzZQ980TcQDpja4zgy8yG2dmT7pJfDYkTFaikcEs/kTgqkWjb7P+YHvrSZoyo
 BOcMcrym7P0tmggeh9r3uVMJns6m/ipbru2gRKyEd56g6OlcwnyciDqRT54lsmno3s16
 fSVD50HbtipZ3+IcrD6BeyE6zbSvQMWbjjTJ1gQbp4cnwSS7gZVRKJ0UiHobkFC1JwXt
 hAyPYC/zAN7EJmlG6gxBGLyAzANE57vUycLbcQ/slw5tRM09GmUxtZfgckF9NTqWVHK1
 F+f0ycnX266NQF64DLu2lApnWZO/DO0J2zWyedm2n0K6S0QYsL7fwibxvEbnCURHj7GJ
 96eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CJ2+nPUOjOF4/0Ry1zzEOHnYhL+QGpxItOR8riPLmxM=;
 b=LEshgNDNPdNqtiZcRmPLX/E02me22QqMBAZcUmAwaPjYMItkDK1gzrRTgTh8lbwlH6
 MQI2KaqFm5BGgF7O56pDUquiXSGJPz7FPYH/fVsgq5y1jTB9HLSLuOediyjfkJ4/j/k0
 VkNahPUhv9qNshTV9R7GSMFTxu0EGP6w+klZ0Ll4cIyKVQkENsTLSkvxb1pjpLgWRuJ1
 Oi4wzfEeaO3okzKFJG4FUyx7BCPx8KPi74+WoMxLsCloqoWc6s9edkG/sX7GZD8AD8ul
 K5LjLgsXAOuvqbqQz07CzTxAWf64xE7bc5UzuWHGUAla30lLnzvtV5YY2j57z65j9Qyx
 BONQ==
X-Gm-Message-State: ANhLgQ13bFl9uQIdnEG0uZTEner0GwQ+FxT/wr+pVAWLyBKCXBdF9ntH
 i89lA4mVhQuTV/bsv36Rc7Ua49z2vmvOHz9h05Q=
X-Google-Smtp-Source: ADFU+vsOIdQg3q/mfbMPuGpRxs6fPQirvnRKc92qA5b6PBNqUIrrRHfggd3FtGxZ+1c/sPu8bi1dwC6Fw2sxUP6dAmI=
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr3267061wma.4.1583489030806;
 Fri, 06 Mar 2020 02:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org> <20200221100700.GA5254@linux.fritz.box>
 <87pne751g9.fsf@dusky.pond.sub.org>
 <CAJ+F1CKbZiVk0DCQxMojxu8FyEskg5Cw32B08Vi9emaEMw79fQ@mail.gmail.com>
 <87imjm96qy.fsf@dusky.pond.sub.org> <20200302153626.GD4965@linux.fritz.box>
 <875zflevh1.fsf@dusky.pond.sub.org>
 <CAJ+F1CK=15RH6VOTEyogp3xht-DQj2zQvwrukXNZKPBCUCX1aA@mail.gmail.com>
 <87sgil7u0c.fsf@dusky.pond.sub.org>
In-Reply-To: <87sgil7u0c.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 6 Mar 2020 11:03:37 +0100
Message-ID: <CAJ+F1CKxbReSyR+fXzSuHWOXXs_DP1gdnhCOzqKJ2eqLERrzNQ@mail.gmail.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 David Alan Gilbert <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Mar 6, 2020 at 9:44 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Tue, Mar 3, 2020 at 8:41 AM Markus Armbruster <armbru@redhat.com> wr=
ote:
> [...]
> >> >> Let's take a step back.
> >> >>
> >> >> The actual problem is to find the coroutine in graphic_hw_update_do=
ne(),
> >> >> so you can wake it.
> >> >>
> >> >> Your solution stores the coroutine in the QemuConsole, because that=
's
> >> >> readily available in graphic_hw_update_done().
> >> >>
> >> >> However, it really, really doesn't belong there, it belongs to the
> >> >> monitor.  Works anyway only because QMP commands execute one after =
the
> >> >> other.
>
> As discussed in the "[PATCH v4 1/4] qapi: Add a 'coroutine' flag for
> commands" sub-thread, HMP commands may execute interleaved.  Your code
> still works, because it only ever abuses QemuConsole with QMP.  But it's
> brittle.
>
> Looks like we'll change HMP not to run interleaved.  That adds a belt to
> the suspenders.  You might argue that's robust enough.
>
> But it's not just the brittleness I dislike.  Storing per-monitor-
> command data in QemuConsole is ugly as sin.  Arguing that it works
> because commands are strictly serialized, and that burying one more
> dependence on such serialization deep in command code won't make the
> situation appreciably worse, doesn't change the fact that QemuConsole
> has no business holding per-monitor-command data.

It is data (the monitor coroutine) associated with an event handler
(graphic-update).

Someone has to hold the handler/data, and the console seems appropriate.

We could abstract this a bit, for ex, having a GHookList, but as long
as there is only one handler, it's unnecessary.

>
> >> >>
> >> >> Kevin suggested using a CoQueue to avoid this unspoken dependency. =
 You
> >> >> object, because it could make readers assume multiple screendump
> >> >> commands could run concurrently, which is not the case.
> >> >>
> >> >> Alright, let's KISS: since there's just one main loop, there's just=
 one
> >> >> coroutine: @qmp_dispatcher_co.  Let's use that, so the dependency o=
n
> >> >> "one command after the other" is explicit and obvious.
> >> >
> >> > Ugh... If you choose that this is the way to go, please add an asser=
tion
> >> > at least that we are indeed in qmp_dispatcher_co before yielding.
> >>
> >> No objection.
> >>
> >> To apply the QMP coroutine infrastructure for 5.0, I need a user.  We
> >> have two: block_resize from Kevin, and screendump from Marc-Andr=C3=A9=
.
> >> Neither is quite ready, yet.  I'll wait for a respin of either one.
> >>
> >
> > Is this the change you expect?
> >
> > diff --git a/ui/console.c b/ui/console.c
> > index 57df3a5439..d6a8bf0cee 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -167,7 +167,7 @@ struct QemuConsole {
> >      QEMUFIFO out_fifo;
> >      uint8_t out_fifo_buf[16];
> >      QEMUTimer *kbd_timer;
> > -    Coroutine *screendump_co;
> > +    bool wake_qmp_dispatcher_on_update;
> >
> >      QTAILQ_ENTRY(QemuConsole) next;
> >  };
>
> No, because it still stores per-command data in QemuConsole.  You need
> to, because...
>
> > @@ -263,8 +263,8 @@ static void gui_setup_refresh(DisplayState *ds)
> >
> >  void graphic_hw_update_done(QemuConsole *con)
> >  {
> > -    if (con && con->screendump_co) {
> > -        aio_co_wake(con->screendump_co);
> > +    if (con->wake_qmp_dispatcher_on_update) {
> > +        aio_co_wake(qmp_dispatcher_co);
>
> ... you may call aio_co_wake() only while @qmp_dispatcher_co is waiting
> for it after yielding ...
>
> >      }
> >  }
> >
> > @@ -376,12 +376,15 @@ void qmp_screendump(const char *filename, bool
> > has_device, const char *device,
> >      }
> >
> >      if (qemu_in_coroutine()) {
> > -        assert(!con->screendump_co);
> > -        con->screendump_co =3D qemu_coroutine_self();
> > +        /*
> > +         * The coroutine code is generic, but we are supposed to be on
> > +         * the QMP dispatcher coroutine, and we will resume only that =
now.
> > +         */
> > +        assert(qemu_coroutine_self() =3D=3D qmp_dispatcher_co);
> > +        con->wake_qmp_dispatcher_on_update =3D true;
> >          aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >                                  graphic_hw_update_bh, con);
> >          qemu_coroutine_yield();
>
> ... here.  I missed that need when I suggested to use
> @qmp_dispatcher_co.  Sorry.
>
> > -        con->screendump_co =3D NULL;
> > +        con->wake_qmp_dispatcher_on_update =3D false;
> >      }
>
> Have a look at qxl, the only provider of asynchronous .gfx_update().
> The actual work is done in qxl-render.c.  qxl_render_update(),
> qxl_render_update_area_bh(), qxl_render_update_area_unlocked(),
> qxl_render_update_area_done() cooperate carefully to support multiple
> updates in flight.
>
> I guess that's necessary because we also call graphic_hw_update() from
> display code such as ui/vnc.c and ui/spice-display.c.
>
> Before your patch, none of these users waits for an asynchronous update
> to complete, as far as I can tell.  Afterwards, QMP screendump does.
> Whether more users should I can't tell.  Gerd, can you?
>
> Your patch communicates completion to screendump by making
> graphic_hw_update() wake a coroutine.  It stores the coroutine in
> QemuConsole, exploiting that only one call site actually waits for an
> asynchronous update to complete, and that caller is never reentered.
>
> This new mechanism is not usable for any other caller, unless it somehow
> synchronizes with screendump to avoid reentrance.
>
> Shouldn't we offer a more generally useful way to wait for asynchronous
> update to complete?  Kevin's idea to use a queue of waiters sounds more
> appropriate than ever to me.
>

A CoQueue is a queue of coroutine. Similarly to the GHook suggestion,
I don't see much point as long as there is a single known handler.
Covering it through those abstractions will just lead to wrong
assumptions or code harder to read imho.

--=20
Marc-Andr=C3=A9 Lureau

