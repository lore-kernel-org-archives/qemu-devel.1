Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1831AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B33214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJCvGCjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B33214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8lyK-0000da-2O
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j8lxf-0000B5-Dh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j8lxd-0003Sn-8O
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:22:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j8lxd-0003SX-4c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 09:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583158940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbWN5TeQTHiNWHSlF813QOo8N8pbB0mrB0UCapINWJc=;
 b=BJCvGCjqcBMi35/ccRKl7XRES/LROXshp9LTUzHal6Zf34xMv1kBjz745nEF5JSTVLoIQE
 pxh4H6tKezbx6EOFMXqyTxAsqJas+VQbpvJ4KcYSiV+igDVcFKW8a+IssDFsAduCjQDsno
 r7T67fzybODnKE0KfO4xrCq8yjxzqWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-H_F3ui1APaykVYqkGWdqxA-1; Mon, 02 Mar 2020 09:22:18 -0500
X-MC-Unique: H_F3ui1APaykVYqkGWdqxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A68758018A6;
 Mon,  2 Mar 2020 14:22:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C83CC8D574;
 Mon,  2 Mar 2020 14:22:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C0E411386A6; Mon,  2 Mar 2020 15:22:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org>
 <20200221100700.GA5254@linux.fritz.box>
 <87pne751g9.fsf@dusky.pond.sub.org>
 <CAJ+F1CKbZiVk0DCQxMojxu8FyEskg5Cw32B08Vi9emaEMw79fQ@mail.gmail.com>
Date: Mon, 02 Mar 2020 15:22:13 +0100
In-Reply-To: <CAJ+F1CKbZiVk0DCQxMojxu8FyEskg5Cw32B08Vi9emaEMw79fQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 24 Feb 2020
 17:20:33 +0100")
Message-ID: <87imjm96qy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 David Alan Gilbert <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Fri, Feb 21, 2020 at 5:50 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Kevin Wolf <kwolf@redhat.com> writes:
>>
>> > Am 20.02.2020 um 17:01 hat Markus Armbruster geschrieben:
>> >> >> >  void qmp_screendump(const char *filename, bool has_device, cons=
t char *device,
>> >> >> >                      bool has_head, int64_t head, Error **errp)
>> >> >> >  {
>> >> >> >      QemuConsole *con;
>> >> >> >      DisplaySurface *surface;
>> >> >> > +    g_autoptr(pixman_image_t) image =3D NULL;
>> >> >> >      int fd;
>> >> >> >
>> >> >> >      if (has_device) {
>> >> >> > @@ -365,7 +375,15 @@ void qmp_screendump(const char *filename, b=
ool has_device, const char *device,
>> >> >> >          }
>> >> >> >      }
>> >> >> >
>> >> >> > -    graphic_hw_update(con);
>> >> >> > +    if (qemu_in_coroutine()) {
>> >> >> > +        assert(!con->screendump_co);
>> >> >> > +        con->screendump_co =3D qemu_coroutine_self();
>> >> >> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> >> >> > +                                graphic_hw_update_bh, con);
>> >> >> > +        qemu_coroutine_yield();
>> >> >> > +        con->screendump_co =3D NULL;
>> >> >> > +    }
>> >> >>
>> >> >> What if multiple QMP monitors simultaneously screendump?  Hmm, it =
works
>> >> >> because all execute one after another in the same coroutine
>> >> >> qmp_dispatcher_co.  Implicit mutual exclusion.
>> >> >>
>> >> >> Executing them one after another is bad, because it lets an ill-be=
haved
>> >> >> QMP command starve *all* QMP monitors.  We do it only out of
>> >> >> (reasonable!) fear of implicit mutual exclusion requirements like =
the
>> >> >> one you add.
>> >> >>
>> >> >> Let's not add more if we can help it.
>> >> >
>> >> > The situation is not worse than the current blocking handling.
>> >>
>> >> Really?
>> >>
>> >> What makes executing multiple qmp_screendump() concurrently (in separ=
ate
>> >> threads) or interleaved (in separate coroutines in the same thread)
>> >> unsafe before this patch?
>> >
>> > QMP command handlers are guaranteed to run in the main thread with the
>> > BQL held, so there is no concurrency. If you want to change this, you
>> > would have much more complicated problems to solve than in this handle=
r.
>> > I'm not sure it's fair to require thread-safety from one handler when
>> > no other handler is thread safe (except accidentally) and nobody seems
>> > to plan actually calling them from multiple threads.
>>
>> "Let's not [...] if we can help it." is hardly a "change this or else no
>> merge" demand.  It is a challenge to find a more elegant solution.
>>
>> >> >> Your screendump_co is per QemuConsole instead of per QMP monitor o=
nly
>> >> >> because you need to find the coroutine in graphic_hw_update_done()=
.  Can
>> >> >> we somehow pass it via function arguments?
>> >> >
>> >> > I think it could be done later, so I suggest a TODO.
>> >>
>> >> We should avoid making our dependence on implicit mutual exclusion
>> >> worse.  When we do it anyway, a big, fat, ugly comment is definitely
>> >> called for.
>> >
>> > Anyway, what I really wanted to add:
>> >
>> > This should be easy to solve by having a CoQueue instead of a single
>>
>> Ah, challenge accepted!  Exactly the outcome I was hoping for :)
>>
>> > Coroutine pointer. The coroutine would just call qemu_co_queue_wait(),
>> > which adds itself to the queue before it yields and the update
>> > completion would wake up all coroutines that are currently queued with
>> > qemu_co_queue_restart_all().
>> >
>> > qemu_co_queue_wait() takes a lock as its second parameter. You don't
>> > need it in this context and can just pass NULL. (This is a lock that
>> > would be dropped while the coroutine is sleeping and automatically
>> > reacquired afterwards.)
>> >
>> >> >> In case avoiding the mutual exclusion is impractical: please expla=
in it
>> >> >> in a comment to make it somewhat less implicit.
>> >>
>> >> It is anything but: see appended patch.
>> >
>> > This works, too, but it requires an additional struct. I think the que=
ue
>> > is easier. (Note there is a difference in the mechanism: Your patch
>> > waits for the specific update it triggered, while the CoQueue would wa=
it
>> > for _any_ update to complete. I assume effectively the result is the
>> > same.)
>>
>> Your idea sounds much nicer to me.  Thanks!
>
> Similar to the NULL check you asked to remove,
> having a CoQueue there would lead to think that several concurrently
> running screendump are possible.
>
> Is this a direction we are willing to take?

Let's take a step back.

The actual problem is to find the coroutine in graphic_hw_update_done(),
so you can wake it.

Your solution stores the coroutine in the QemuConsole, because that's
readily available in graphic_hw_update_done().

However, it really, really doesn't belong there, it belongs to the
monitor.  Works anyway only because QMP commands execute one after the
other.

Kevin suggested using a CoQueue to avoid this unspoken dependency.  You
object, because it could make readers assume multiple screendump
commands could run concurrently, which is not the case.

Alright, let's KISS: since there's just one main loop, there's just one
coroutine: @qmp_dispatcher_co.  Let's use that, so the dependency on
"one command after the other" is explicit and obvious.

[...]


