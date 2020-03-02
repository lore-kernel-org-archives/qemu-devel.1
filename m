Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA2C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32B221556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwkjEvQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32B221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8n88-0002Ew-2k
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j8n7W-0001mp-9D
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j8n7U-0006gs-Gd
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:36:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51998
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j8n7U-0006gc-9f
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583163395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+1/atCbfReh1bvdA0kDbqj22x71e+Gk58oW8+0XwFU=;
 b=IwkjEvQAwnh+twsB8Tw3sDWm1BsM7xluGKjHjzogGtyISt3tmJV9kptb20rkyHZgTVbqpU
 1wvFZbPyeGUHmEbVaVFZ1vvtGVCTox9yKMAb78IbGUSna8Wj723e+XVkGCj6Kb3iZ//JDN
 aWiNXHtP8rLWyqmO7/sWbUhL1f9RuYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231--kDHGD8MPTK6R1_vdUrGnw-1; Mon, 02 Mar 2020 10:36:33 -0500
X-MC-Unique: -kDHGD8MPTK6R1_vdUrGnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B31C1DBB3;
 Mon,  2 Mar 2020 15:36:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-7.ams2.redhat.com [10.36.117.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8B315DA75;
 Mon,  2 Mar 2020 15:36:27 +0000 (UTC)
Date: Mon, 2 Mar 2020 16:36:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
Message-ID: <20200302153626.GD4965@linux.fritz.box>
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org>
 <20200221100700.GA5254@linux.fritz.box>
 <87pne751g9.fsf@dusky.pond.sub.org>
 <CAJ+F1CKbZiVk0DCQxMojxu8FyEskg5Cw32B08Vi9emaEMw79fQ@mail.gmail.com>
 <87imjm96qy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87imjm96qy.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.03.2020 um 15:22 hat Markus Armbruster geschrieben:
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
>=20
> > Hi
> >
> > On Fri, Feb 21, 2020 at 5:50 PM Markus Armbruster <armbru@redhat.com> w=
rote:
> >>
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>
> >> > Am 20.02.2020 um 17:01 hat Markus Armbruster geschrieben:
> >> >> >> >  void qmp_screendump(const char *filename, bool has_device, co=
nst char *device,
> >> >> >> >                      bool has_head, int64_t head, Error **errp=
)
> >> >> >> >  {
> >> >> >> >      QemuConsole *con;
> >> >> >> >      DisplaySurface *surface;
> >> >> >> > +    g_autoptr(pixman_image_t) image =3D NULL;
> >> >> >> >      int fd;
> >> >> >> >
> >> >> >> >      if (has_device) {
> >> >> >> > @@ -365,7 +375,15 @@ void qmp_screendump(const char *filename,=
 bool has_device, const char *device,
> >> >> >> >          }
> >> >> >> >      }
> >> >> >> >
> >> >> >> > -    graphic_hw_update(con);
> >> >> >> > +    if (qemu_in_coroutine()) {
> >> >> >> > +        assert(!con->screendump_co);
> >> >> >> > +        con->screendump_co =3D qemu_coroutine_self();
> >> >> >> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >> >> >> > +                                graphic_hw_update_bh, con);
> >> >> >> > +        qemu_coroutine_yield();
> >> >> >> > +        con->screendump_co =3D NULL;
> >> >> >> > +    }
> >> >> >>
> >> >> >> What if multiple QMP monitors simultaneously screendump?  Hmm, i=
t works
> >> >> >> because all execute one after another in the same coroutine
> >> >> >> qmp_dispatcher_co.  Implicit mutual exclusion.
> >> >> >>
> >> >> >> Executing them one after another is bad, because it lets an ill-=
behaved
> >> >> >> QMP command starve *all* QMP monitors.  We do it only out of
> >> >> >> (reasonable!) fear of implicit mutual exclusion requirements lik=
e the
> >> >> >> one you add.
> >> >> >>
> >> >> >> Let's not add more if we can help it.
> >> >> >
> >> >> > The situation is not worse than the current blocking handling.
> >> >>
> >> >> Really?
> >> >>
> >> >> What makes executing multiple qmp_screendump() concurrently (in sep=
arate
> >> >> threads) or interleaved (in separate coroutines in the same thread)
> >> >> unsafe before this patch?
> >> >
> >> > QMP command handlers are guaranteed to run in the main thread with t=
he
> >> > BQL held, so there is no concurrency. If you want to change this, yo=
u
> >> > would have much more complicated problems to solve than in this hand=
ler.
> >> > I'm not sure it's fair to require thread-safety from one handler whe=
n
> >> > no other handler is thread safe (except accidentally) and nobody see=
ms
> >> > to plan actually calling them from multiple threads.
> >>
> >> "Let's not [...] if we can help it." is hardly a "change this or else =
no
> >> merge" demand.  It is a challenge to find a more elegant solution.
> >>
> >> >> >> Your screendump_co is per QemuConsole instead of per QMP monitor=
 only
> >> >> >> because you need to find the coroutine in graphic_hw_update_done=
().  Can
> >> >> >> we somehow pass it via function arguments?
> >> >> >
> >> >> > I think it could be done later, so I suggest a TODO.
> >> >>
> >> >> We should avoid making our dependence on implicit mutual exclusion
> >> >> worse.  When we do it anyway, a big, fat, ugly comment is definitel=
y
> >> >> called for.
> >> >
> >> > Anyway, what I really wanted to add:
> >> >
> >> > This should be easy to solve by having a CoQueue instead of a single
> >>
> >> Ah, challenge accepted!  Exactly the outcome I was hoping for :)
> >>
> >> > Coroutine pointer. The coroutine would just call qemu_co_queue_wait(=
),
> >> > which adds itself to the queue before it yields and the update
> >> > completion would wake up all coroutines that are currently queued wi=
th
> >> > qemu_co_queue_restart_all().
> >> >
> >> > qemu_co_queue_wait() takes a lock as its second parameter. You don't
> >> > need it in this context and can just pass NULL. (This is a lock that
> >> > would be dropped while the coroutine is sleeping and automatically
> >> > reacquired afterwards.)
> >> >
> >> >> >> In case avoiding the mutual exclusion is impractical: please exp=
lain it
> >> >> >> in a comment to make it somewhat less implicit.
> >> >>
> >> >> It is anything but: see appended patch.
> >> >
> >> > This works, too, but it requires an additional struct. I think the q=
ueue
> >> > is easier. (Note there is a difference in the mechanism: Your patch
> >> > waits for the specific update it triggered, while the CoQueue would =
wait
> >> > for _any_ update to complete. I assume effectively the result is the
> >> > same.)
> >>
> >> Your idea sounds much nicer to me.  Thanks!
> >
> > Similar to the NULL check you asked to remove,
> > having a CoQueue there would lead to think that several concurrently
> > running screendump are possible.
> >
> > Is this a direction we are willing to take?
>=20
> Let's take a step back.
>=20
> The actual problem is to find the coroutine in graphic_hw_update_done(),
> so you can wake it.
>=20
> Your solution stores the coroutine in the QemuConsole, because that's
> readily available in graphic_hw_update_done().
>=20
> However, it really, really doesn't belong there, it belongs to the
> monitor.  Works anyway only because QMP commands execute one after the
> other.
>=20
> Kevin suggested using a CoQueue to avoid this unspoken dependency.  You
> object, because it could make readers assume multiple screendump
> commands could run concurrently, which is not the case.
>=20
> Alright, let's KISS: since there's just one main loop, there's just one
> coroutine: @qmp_dispatcher_co.  Let's use that, so the dependency on
> "one command after the other" is explicit and obvious.

Ugh... If you choose that this is the way to go, please add an assertion
at least that we are indeed in qmp_dispatcher_co before yielding.

Kevin


