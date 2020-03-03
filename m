Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFEC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE05320CC7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3nRP42M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE05320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9A2D-0005cs-TM
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 11:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j9A1G-000560-RG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j9A1F-0005mr-50
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:03:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j9A1E-0005mb-Uq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 11:03:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id n7so4975742wrt.11
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 08:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=THNVeMkGBSbrKq/GO6XD630D+gAwyr3Oo84wDVD60XU=;
 b=a3nRP42MCxq3LsUFztvg2vo6sEMg6rsKI9TQVhWD6yJcQp/yd64sDaPAvKkumuxl1B
 OgzJwqSeICz1rMTCqjYX8k9Fxyt1MdtkRiQl6BIyFYrAex7bK9YjyjfJpBSnsQaa974f
 POZDVOyWzCsVuFSd5GR4RkiVHERfSQ0pjPL/tCTiI65E8XR3JpxQxRqSppGV7w3ZHMfj
 9ZvNwEleNBzCp/b9sI9uf4rHkn6zL6TsRBW1HA5fMlIf7dShLCdv9wjuHA54WfcFDePi
 7AxBrFXj39pn9K1iHwW+z7hliSjtZDiURHturtl/7hZFHaru4Kb0uRpcQjAwQMsec4bS
 HUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=THNVeMkGBSbrKq/GO6XD630D+gAwyr3Oo84wDVD60XU=;
 b=YnP0IdeDnF7Yi0InmI0q+vmNGbRv9cT4MsJgpzdn9EjA0ZRVxVn02bIPJTvdgC3Bdn
 O/1wt++EH2JbaxkEFtllGJeOSVf9YjvK6w7fi3UtFAUF+OiI3+RaSWIX+U8Nwf8T56q4
 lC8HMYdw0DuZ5HmkXrlIK5AiWlfsI43OmgCrRi5Am80EBGJFuPZFZpC1wTMWvH/h5d34
 s8Yke2P/hOYghDXY8s0xIICPqyyOM3MFELafizjw/gBPGKTB9wvp9VVpzYKlXbGnMijU
 sbBHNXrfmdJBmsLkpxmU6qiM2yV/es+j7eYyRU4JX1FCmgiEh8O59MqXmOaBiBUdcLxL
 /CfA==
X-Gm-Message-State: ANhLgQ0quldnhG5yMmMCxAp3S5t/o7c2/xo8XG0WyuMj0MRr7USjd0YY
 ziyn0zt4/aeK3pDtc6sDMSkCZQSw/0ZzrxmN9qc=
X-Google-Smtp-Source: ADFU+vsnHM9I+bQDevZdyPOb7QjItMUSV57Ffsbo9y8RRGHuGXrRrVCWLGeGdKAe48uA6PSFY2qVu1crIlDkGWewVJ0=
X-Received: by 2002:adf:f604:: with SMTP id t4mr6229613wrp.96.1583251418293;
 Tue, 03 Mar 2020 08:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org> <20200221100700.GA5254@linux.fritz.box>
 <87pne751g9.fsf@dusky.pond.sub.org>
 <CAJ+F1CKbZiVk0DCQxMojxu8FyEskg5Cw32B08Vi9emaEMw79fQ@mail.gmail.com>
 <87imjm96qy.fsf@dusky.pond.sub.org> <20200302153626.GD4965@linux.fritz.box>
 <875zflevh1.fsf@dusky.pond.sub.org>
In-Reply-To: <875zflevh1.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Mar 2020 17:03:25 +0100
Message-ID: <CAJ+F1CK=15RH6VOTEyogp3xht-DQj2zQvwrukXNZKPBCUCX1aA@mail.gmail.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Gerd Hoffmann <kraxel@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Mar 3, 2020 at 8:41 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Kevin Wolf <kwolf@redhat.com> writes:
>
> > Am 02.03.2020 um 15:22 hat Markus Armbruster geschrieben:
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Fri, Feb 21, 2020 at 5:50 PM Markus Armbruster <armbru@redhat.com=
> wrote:
> >> >>
> >> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> >>
> >> >> > Am 20.02.2020 um 17:01 hat Markus Armbruster geschrieben:
> >> >> >> >> >  void qmp_screendump(const char *filename, bool has_device,=
 const char *device,
> >> >> >> >> >                      bool has_head, int64_t head, Error **e=
rrp)
> >> >> >> >> >  {
> >> >> >> >> >      QemuConsole *con;
> >> >> >> >> >      DisplaySurface *surface;
> >> >> >> >> > +    g_autoptr(pixman_image_t) image =3D NULL;
> >> >> >> >> >      int fd;
> >> >> >> >> >
> >> >> >> >> >      if (has_device) {
> >> >> >> >> > @@ -365,7 +375,15 @@ void qmp_screendump(const char *filena=
me, bool has_device, const char *device,
> >> >> >> >> >          }
> >> >> >> >> >      }
> >> >> >> >> >
> >> >> >> >> > -    graphic_hw_update(con);
> >> >> >> >> > +    if (qemu_in_coroutine()) {
> >> >> >> >> > +        assert(!con->screendump_co);
> >> >> >> >> > +        con->screendump_co =3D qemu_coroutine_self();
> >> >> >> >> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >> >> >> >> > +                                graphic_hw_update_bh, con)=
;
> >> >> >> >> > +        qemu_coroutine_yield();
> >> >> >> >> > +        con->screendump_co =3D NULL;
> >> >> >> >> > +    }
> >> >> >> >>
> >> >> >> >> What if multiple QMP monitors simultaneously screendump?  Hmm=
, it works
> >> >> >> >> because all execute one after another in the same coroutine
> >> >> >> >> qmp_dispatcher_co.  Implicit mutual exclusion.
> >> >> >> >>
> >> >> >> >> Executing them one after another is bad, because it lets an i=
ll-behaved
> >> >> >> >> QMP command starve *all* QMP monitors.  We do it only out of
> >> >> >> >> (reasonable!) fear of implicit mutual exclusion requirements =
like the
> >> >> >> >> one you add.
> >> >> >> >>
> >> >> >> >> Let's not add more if we can help it.
> >> >> >> >
> >> >> >> > The situation is not worse than the current blocking handling.
> >> >> >>
> >> >> >> Really?
> >> >> >>
> >> >> >> What makes executing multiple qmp_screendump() concurrently (in =
separate
> >> >> >> threads) or interleaved (in separate coroutines in the same thre=
ad)
> >> >> >> unsafe before this patch?
> >> >> >
> >> >> > QMP command handlers are guaranteed to run in the main thread wit=
h the
> >> >> > BQL held, so there is no concurrency. If you want to change this,=
 you
> >> >> > would have much more complicated problems to solve than in this h=
andler.
> >> >> > I'm not sure it's fair to require thread-safety from one handler =
when
> >> >> > no other handler is thread safe (except accidentally) and nobody =
seems
> >> >> > to plan actually calling them from multiple threads.
> >> >>
> >> >> "Let's not [...] if we can help it." is hardly a "change this or el=
se no
> >> >> merge" demand.  It is a challenge to find a more elegant solution.
> >> >>
> >> >> >> >> Your screendump_co is per QemuConsole instead of per QMP moni=
tor only
> >> >> >> >> because you need to find the coroutine in graphic_hw_update_d=
one().  Can
> >> >> >> >> we somehow pass it via function arguments?
> >> >> >> >
> >> >> >> > I think it could be done later, so I suggest a TODO.
> >> >> >>
> >> >> >> We should avoid making our dependence on implicit mutual exclusi=
on
> >> >> >> worse.  When we do it anyway, a big, fat, ugly comment is defini=
tely
> >> >> >> called for.
> >> >> >
> >> >> > Anyway, what I really wanted to add:
> >> >> >
> >> >> > This should be easy to solve by having a CoQueue instead of a sin=
gle
> >> >>
> >> >> Ah, challenge accepted!  Exactly the outcome I was hoping for :)
> >> >>
> >> >> > Coroutine pointer. The coroutine would just call qemu_co_queue_wa=
it(),
> >> >> > which adds itself to the queue before it yields and the update
> >> >> > completion would wake up all coroutines that are currently queued=
 with
> >> >> > qemu_co_queue_restart_all().
> >> >> >
> >> >> > qemu_co_queue_wait() takes a lock as its second parameter. You do=
n't
> >> >> > need it in this context and can just pass NULL. (This is a lock t=
hat
> >> >> > would be dropped while the coroutine is sleeping and automaticall=
y
> >> >> > reacquired afterwards.)
> >> >> >
> >> >> >> >> In case avoiding the mutual exclusion is impractical: please =
explain it
> >> >> >> >> in a comment to make it somewhat less implicit.
> >> >> >>
> >> >> >> It is anything but: see appended patch.
> >> >> >
> >> >> > This works, too, but it requires an additional struct. I think th=
e queue
> >> >> > is easier. (Note there is a difference in the mechanism: Your pat=
ch
> >> >> > waits for the specific update it triggered, while the CoQueue wou=
ld wait
> >> >> > for _any_ update to complete. I assume effectively the result is =
the
> >> >> > same.)
> >> >>
> >> >> Your idea sounds much nicer to me.  Thanks!
> >> >
> >> > Similar to the NULL check you asked to remove,
> >> > having a CoQueue there would lead to think that several concurrently
> >> > running screendump are possible.
> >> >
> >> > Is this a direction we are willing to take?
> >>
> >> Let's take a step back.
> >>
> >> The actual problem is to find the coroutine in graphic_hw_update_done(=
),
> >> so you can wake it.
> >>
> >> Your solution stores the coroutine in the QemuConsole, because that's
> >> readily available in graphic_hw_update_done().
> >>
> >> However, it really, really doesn't belong there, it belongs to the
> >> monitor.  Works anyway only because QMP commands execute one after the
> >> other.
> >>
> >> Kevin suggested using a CoQueue to avoid this unspoken dependency.  Yo=
u
> >> object, because it could make readers assume multiple screendump
> >> commands could run concurrently, which is not the case.
> >>
> >> Alright, let's KISS: since there's just one main loop, there's just on=
e
> >> coroutine: @qmp_dispatcher_co.  Let's use that, so the dependency on
> >> "one command after the other" is explicit and obvious.
> >
> > Ugh... If you choose that this is the way to go, please add an assertio=
n
> > at least that we are indeed in qmp_dispatcher_co before yielding.
>
> No objection.
>
> To apply the QMP coroutine infrastructure for 5.0, I need a user.  We
> have two: block_resize from Kevin, and screendump from Marc-Andr=C3=A9.
> Neither is quite ready, yet.  I'll wait for a respin of either one.
>

Is this the change you expect?

diff --git a/ui/console.c b/ui/console.c
index 57df3a5439..d6a8bf0cee 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -167,7 +167,7 @@ struct QemuConsole {
     QEMUFIFO out_fifo;
     uint8_t out_fifo_buf[16];
     QEMUTimer *kbd_timer;
-    Coroutine *screendump_co;
+    bool wake_qmp_dispatcher_on_update;

     QTAILQ_ENTRY(QemuConsole) next;
 };
@@ -263,8 +263,8 @@ static void gui_setup_refresh(DisplayState *ds)

 void graphic_hw_update_done(QemuConsole *con)
 {
-    if (con && con->screendump_co) {
-        aio_co_wake(con->screendump_co);
+    if (con->wake_qmp_dispatcher_on_update) {
+        aio_co_wake(qmp_dispatcher_co);
     }
 }

@@ -376,12 +376,15 @@ void qmp_screendump(const char *filename, bool
has_device, const char *device,
     }

     if (qemu_in_coroutine()) {
-        assert(!con->screendump_co);
-        con->screendump_co =3D qemu_coroutine_self();
+        /*
+         * The coroutine code is generic, but we are supposed to be on
+         * the QMP dispatcher coroutine, and we will resume only that now.
+         */
+        assert(qemu_coroutine_self() =3D=3D qmp_dispatcher_co);
+        con->wake_qmp_dispatcher_on_update =3D true;
         aio_bh_schedule_oneshot(qemu_get_aio_context(),
                                 graphic_hw_update_bh, con);
         qemu_coroutine_yield();
-        con->screendump_co =3D NULL;
+        con->wake_qmp_dispatcher_on_update =3D false;
     }

--=20
Marc-Andr=C3=A9 Lureau

