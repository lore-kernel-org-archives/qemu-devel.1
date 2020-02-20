Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA3C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D5F20722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHoV5KJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D5F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4sCH-00054W-Ta
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 15:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j4sB8-0003jo-01
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j4sB4-000727-Pr
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:12:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j4sB4-00071r-GM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 15:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582229525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5ieoWgbqoEu3nVW2KvPGZquCuIsfpB31o3TY0o/gnc=;
 b=SHoV5KJaH7/LHrOV63pTNITB1CPgQr5sNmgVAYk+3jrwK0iQpLYrf5PIJJi6uadp9UsWlu
 wGHidXjmoUAXiOKHfbKKjfC3KjpB7wF6w942Ug196LHuWpExp+VrWXY2zDHw/VAKwcQ+1j
 OvqYFuEkSHMxd5N2XwfdFSk9FGphSNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-OEKz89jlMdSkhiZDVi8J9g-1; Thu, 20 Feb 2020 15:12:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4EE1B18BC0;
 Thu, 20 Feb 2020 20:12:02 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F418F388;
 Thu, 20 Feb 2020 20:11:57 +0000 (UTC)
Date: Thu, 20 Feb 2020 20:11:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
Message-ID: <20200220201155.GJ2836@work-vm>
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a75dn1gd.fsf@dusky.pond.sub.org>
 <CAJ+F1C+M3yPreBLOHXkt16b5aghesT7qYkEPbS_3Dm7vGTaMKA@mail.gmail.com>
 <87blptckoi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87blptckoi.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OEKz89jlMdSkhiZDVi8J9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Cc: David for questions regarding the HMP core.  David, please look for
> "Is HMP blocking the main loop a problem?"
>=20
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
>=20
> > Hi
> >
> > On Thu, Feb 20, 2020 at 8:49 AM Markus Armbruster <armbru@redhat.com> w=
rote:
> >>
> >> Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Thanks to the QMP coroutine support, the screendump handler can
> >> > trigger a graphic_hw_update(), yield and let the main loop run until
> >> > update is done. Then the handler is resumed, and the ppm_save() will
> >> > write the screen image to disk in the coroutine context (thus
> >> > non-blocking).
> >> >
> >> > For now, HMP doesn't have coroutine support, so it remains potential=
ly
> >> > outdated or glitched.
> >> >
> >> > Fixes:
> >> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
> >> >
> >> > Based-on: <20200109183545.27452-2-kwolf@redhat.com>
> >> >
> >> > Cc: Kevin Wolf <kwolf@redhat.com>
> >> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >> > ---
> >> >  qapi/ui.json    |  3 ++-
> >> >  ui/console.c    | 35 +++++++++++++++++++++++++++--------
> >> >  ui/trace-events |  2 +-
> >> >  3 files changed, 30 insertions(+), 10 deletions(-)
> >> >
> >> > diff --git a/qapi/ui.json b/qapi/ui.json
> >> > index e04525d8b4..d941202f34 100644
> >> > --- a/qapi/ui.json
> >> > +++ b/qapi/ui.json
> >> > @@ -96,7 +96,8 @@
> >> >  #
> >> >  ##
> >> >  { 'command': 'screendump',
> >> > -  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
> >> > +  'data': {'filename': 'str', '*device': 'str', '*head': 'int'},
> >> > +  'coroutine': true }
> >> >
> >> >  ##
> >> >  # =3D=3D Spice
> >> > diff --git a/ui/console.c b/ui/console.c
> >> > index ac79d679f5..db184b473f 100644
> >> > --- a/ui/console.c
> >> > +++ b/ui/console.c
> >> > @@ -167,6 +167,7 @@ struct QemuConsole {
> >> >      QEMUFIFO out_fifo;
> >> >      uint8_t out_fifo_buf[16];
> >> >      QEMUTimer *kbd_timer;
> >> > +    Coroutine *screendump_co;
> >> >
> >> >      QTAILQ_ENTRY(QemuConsole) next;
> >> >  };
> >> > @@ -194,7 +195,6 @@ static void dpy_refresh(DisplayState *s);
> >> >  static DisplayState *get_alloc_displaystate(void);
> >> >  static void text_console_update_cursor_timer(void);
> >> >  static void text_console_update_cursor(void *opaque);
> >> > -static bool ppm_save(int fd, DisplaySurface *ds, Error **errp);
> >> >
> >> >  static void gui_update(void *opaque)
> >> >  {
> >> > @@ -263,6 +263,9 @@ static void gui_setup_refresh(DisplayState *ds)
> >> >
> >> >  void graphic_hw_update_done(QemuConsole *con)
> >> >  {
> >> > +    if (con && con->screendump_co) {
> >>
> >> How can !con happen?
> >
> > I don't think it can happen anymore (the patch evolved over several
> > years, this is probably a left-over). In any case, it doesn't hurt.
>=20
> I hate such dead checks, because they make me assume they can actually
> happen.  Incorrect assumptions breed bugs.
>=20
> But I'm willing to defer to the maintainer here.  Gerd?
>=20
> >> > +        aio_co_wake(con->screendump_co);
> >> > +    }
> >> >  }
> >> >
> >> >  void graphic_hw_update(QemuConsole *con)
> >> > @@ -310,16 +313,16 @@ void graphic_hw_invalidate(QemuConsole *con)
> >> >      }
> >> >  }
> >> >
> >> > -static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
> >> > +static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
> >> >  {
> >> > -    int width =3D pixman_image_get_width(ds->image);
> >> > -    int height =3D pixman_image_get_height(ds->image);
> >> > +    int width =3D pixman_image_get_width(image);
> >> > +    int height =3D pixman_image_get_height(image);
> >> >      g_autoptr(Object) ioc =3D OBJECT(qio_channel_file_new_fd(fd));
> >> >      g_autofree char *header =3D NULL;
> >> >      g_autoptr(pixman_image_t) linebuf =3D NULL;
> >> >      int y;
> >> >
> >> > -    trace_ppm_save(fd, ds);
> >> > +    trace_ppm_save(fd, image);
> >> >
> >> >      header =3D g_strdup_printf("P6\n%d %d\n%d\n", width, height, 25=
5);
> >> >      if (qio_channel_write_all(QIO_CHANNEL(ioc),
> >> > @@ -329,7 +332,7 @@ static bool ppm_save(int fd, DisplaySurface *ds,=
 Error **errp)
> >> >
> >> >      linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width)=
;
> >> >      for (y =3D 0; y < height; y++) {
> >> > -        qemu_pixman_linebuf_fill(linebuf, ds->image, width, 0, y);
> >> > +        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
> >> >          if (qio_channel_write_all(QIO_CHANNEL(ioc),
> >> >                                    (char *)pixman_image_get_data(lin=
ebuf),
> >> >                                    pixman_image_get_stride(linebuf),=
 errp) < 0) {
> >>
> >> Looks like an unrelated optimization / simplification.  If I was
> >> maintainer, I'd ask for a separate patch.
> >
> > I can be split, but it's related. We should pass a reference to
> > pixman_image_t, rather than a pointer to DisplaySurface, as the
> > underlying image may change over time, and would result in corrupted
> > coroutine save or worse.
>=20
> Work that into your commit message, please.  Might be easier if you
> split, but that's between you and the maintainer :)
>=20
> >> > @@ -340,11 +343,18 @@ static bool ppm_save(int fd, DisplaySurface *d=
s, Error **errp)
> >> >      return true;
> >> >  }
> >> >
> >> > +static void graphic_hw_update_bh(void *con)
> >> > +{
> >> > +    graphic_hw_update(con);
> >> > +}
> >> > +
> >> > +/* may be called in coroutine context or not */
> >>
> >> Hmm.
> >>
> >> Even though the QMP core always calls in coroutine context, the commen=
t
> >> is correct: hmp_screendump() calls it outside coroutine context.
> >> Because of that...
> >>
> >> >  void qmp_screendump(const char *filename, bool has_device, const ch=
ar *device,
> >> >                      bool has_head, int64_t head, Error **errp)
> >> >  {
> >> >      QemuConsole *con;
> >> >      DisplaySurface *surface;
> >> > +    g_autoptr(pixman_image_t) image =3D NULL;
> >> >      int fd;
> >> >
> >> >      if (has_device) {
> >> > @@ -365,7 +375,15 @@ void qmp_screendump(const char *filename, bool =
has_device, const char *device,
> >> >          }
> >> >      }
> >> >
> >> > -    graphic_hw_update(con);
> >> > +    if (qemu_in_coroutine()) {
> >> > +        assert(!con->screendump_co);
> >>
> >> What if multiple QMP monitors simultaneously screendump?  Hmm, it work=
s
> >> because all execute one after another in the same coroutine
> >> qmp_dispatcher_co.  Implicit mutual exclusion.
> >>
> >> Executing them one after another is bad, because it lets an ill-behave=
d
> >> QMP command starve *all* QMP monitors.  We do it only out of
> >> (reasonable!) fear of implicit mutual exclusion requirements like the
> >> one you add.
> >>
> >> Let's not add more if we can help it.
> >
> > The situation is not worse than the current blocking handling.
>=20
> Really?
>=20
> What makes executing multiple qmp_screendump() concurrently (in separate
> threads) or interleaved (in separate coroutines in the same thread)
> unsafe before this patch?
>=20
> >> Your screendump_co is per QemuConsole instead of per QMP monitor only
> >> because you need to find the coroutine in graphic_hw_update_done().  C=
an
> >> we somehow pass it via function arguments?
> >
> > I think it could be done later, so I suggest a TODO.
>=20
> We should avoid making our dependence on implicit mutual exclusion
> worse.  When we do it anyway, a big, fat, ugly comment is definitely
> called for.
>=20
> >> In case avoiding the mutual exclusion is impractical: please explain i=
t
> >> in a comment to make it somewhat less implicit.
>=20
> It is anything but: see appended patch.
>=20
> >> > +        con->screendump_co =3D qemu_coroutine_self();
> >> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >> > +                                graphic_hw_update_bh, con);
> >> > +        qemu_coroutine_yield();
> >> > +        con->screendump_co =3D NULL;
> >> > +    }
> >> > +
> >>
> >> ... the command handler needs extra code to cope with either.  Is this
> >> really what we want for coroutine QMP command handlers?  We'll acquire
> >> more of them, and I'd hate to make each one run both in and outside
> >> coroutine context.  Shouldn't we let the HMP core take care of this?  =
Or
> >> at least have some common infrastructure these handlers can use?
> >
> > We have several functions that have this dual support, for ex QIO.
> >
> > Changing both QMP & HMP commands to run in coroutine is likely
> > additional work that we may not care at this point.
>=20
> If it wasn't for non-QMP calls (typically HMP, but also CLI), then
> handlers for QMP commands with 'coroutine': true could be coroutine_fn.
>=20
> So far, coroutine_fn is merely documentation.  Perhaps it can guide a
> checker for "do coroutine stuff only in coroutines" some day.  Would be
> nice, because the coroutine calls are often buried deep, and far away
> from the code that ensures they run in a coroutine.
>=20
> My point is: marking functions coroutine_fn is good.  We should do it
> more.  We should try to avoid stuff that hinders doing it more.
>=20
> > I propose to leave a TODO, once we have several similar QMP & HMP mix
> > cases we can try to find a common HMP solution to make the code
> > simpler in QMP handler.
>=20
> Collecting several users before building infrastructure makes sense when
> the design of the infrastructure isn't obvious, or when the need for it
> is in doubt.
>=20
> Neither is the case for running QMP handlers in a coroutine: QMP
> commands blocking the main loop is without doubt a problem we need to
> solve, and the way to solve it was obvious enough for Kevin to do it
> with one user: block_resize.  A second one quickly followed: screendump.
>=20
> The only part that's different for HMP, I think, is "need".
>=20
> Is HMP blocking the main loop a problem?
>=20
> If yes, is it serious enough to justify solving it?

I don't mind if HMP blocks for a small time while doing something, but
not if it can hang if the guest (or something else like it) misbehaves.
Not if it's something you might need to issue another command to recover
from.

Dave

> If yes, then putting workarounds into QMP handlers now so we can put off
> solving it some more is taking on technical debt.
>=20
> > I don't know if this is going to be a common pattern, we may end up
> > with conversions that can run both without explicit handling (like the
> > ppm_save() function, thanks to QIO).
>=20
> Yes, such handlers may exist.  Running them out of coroutine context
> would throw away their capability not to block the event loop, though,
> wouldn't it?
>=20
> >> Why is it okay not to call graphic_hw_update() anymore when
> >> !qemu_in_coroutine()?
> >
> > You could call it, but then you should wait for completion by
> > reentering the main loop (that was the point of my earlier qapi-async
> > series)
>=20
> Possibly stupid question: why is it necessary before this patch
> (assuming it is, since we call it), and why is it no longer necessary
> after?
>=20
> Oh, see below.
>=20
> >>
> >> If qemu_in_coroutine(), we now run graphic_hw_update() in a bottom hal=
f,
> >> then yield until the update completes (see graphic_hw_update_done()
> >> above).  Can you explain the need for the bottom half?
> >
> > At least spice rendering is done in a separate thread, completion is as=
ync.
>=20
> When I ask a stupid question like this one, I'm really after the "for
> dummies" explanation.  I may be able to figure it out myself with some
> effort, but having to put that kind of effort into patch review makes me
> grumpy, and once I'm sufficiently grumpy, I don't want to review patches
> anymore, let alone merge them.
>=20
> Oh well, let me try.  We're in the main loop.  We want to trigger a
> "graphics update" (whatever that is, doesn't matter) and wait for it to
> complete without blocking the main loop.
>=20
> "Without blocking the main loop" means the QMP coroutine yields.  I'd
> naively expect
>=20
>     QMP coroutine: schedule the job; yield
>     whatever gets scheduled: complete the job; wake up QMP coroutine
>=20
> Now let's examine the "graphics update" interface.
>=20
> GraphicHwOps callback gfx_update() comes in two flavours:
>=20
> * synchronous: complete the job, return
>=20
> * asynchronous: start the job, return immediately,
>   graphic_hw_update_done() will get called on job completion
>=20
> graphic_hw_update() partly hides the difference:
>=20
> * synchronous: complete the job, call graphic_hw_update_done()
>=20
> * asynchronous: start the job, return immediately,
>   graphic_hw_update_done() will get called on job completion
>=20
> This lets you treat the synchronous case more like the asynchronous
> case.
>=20
> You use graphic_hw_update_done() to wake up the QMP coroutine.
>=20
> I think I can now answer my question "why is it okay not to call
> graphic_hw_update() anymore when !qemu_in_coroutine()?"
>=20
> Before the patch, both QMP and HMP:
>=20
> * with synchronous gfx_update(): we update before we write out the
>   screendump.  The screendump is up-to-date.  Both update and write out
>   block the main loop.
>=20
> * with asynchronous gfx_update(): we start updating, but don't wait for
>   it to complete before we write out.  This is wrong.  Write out blocks
>   the main loop, but update does not.
>=20
> After the patch:
>=20
> * QMP with either gfx_update(): we update before we write out the
>   screendump.  The screendump is up-to-date.  Neither update nor write
>   out block the main loop.  Improvement.
>=20
> * HMP with either gfx_update(): we don't update before we write out.
>   Similarly wrong for asynchronous gfx_update(), regression for
>   synchronous gfx_update().  Write out blocks the main loop as before.
>=20
> Why is the regression okay?
>=20
> Back to the bottom half.  The way graphic_hw_update() works, the QMP
> coroutine can't schedule then yield.  It *has* to yield before
> graphic_hw_update() runs.  That means we need a bottom half.
>=20
> Alright, I'm officially grumpy now.
>=20
> Please explain the need for a bottom half in a comment.
>=20
> >> >      surface =3D qemu_console_surface(con);
> >> >      if (!surface) {
> >> >          error_setg(errp, "no surface");
> >> > @@ -379,7 +397,8 @@ void qmp_screendump(const char *filename, bool h=
as_device, const char *device,
> >> >          return;
> >> >      }
> >> >
> >> > -    if (!ppm_save(fd, surface, errp)) {
> >> > +    image =3D pixman_image_ref(surface->image);
> >> > +    if (!ppm_save(fd, image, errp)) {
> >> >          qemu_unlink(filename);
> >> >      }
> >> >  }
> >> > diff --git a/ui/trace-events b/ui/trace-events
> >> > index 0dcda393c1..e8726fc969 100644
> >> > --- a/ui/trace-events
> >> > +++ b/ui/trace-events
> >> > @@ -15,7 +15,7 @@ displaysurface_create_pixman(void *display_surface=
) "surface=3D%p"
> >> >  displaysurface_free(void *display_surface) "surface=3D%p"
> >> >  displaychangelistener_register(void *dcl, const char *name) "%p [ %=
s ]"
> >> >  displaychangelistener_unregister(void *dcl, const char *name) "%p [=
 %s ]"
> >> > -ppm_save(int fd, void *display_surface) "fd=3D%d surface=3D%p"
> >> > +ppm_save(int fd, void *image) "fd=3D%d image=3D%p"
> >> >
> >> >  # gtk.c
> >> >  # gtk-gl-area.c
>=20
>=20
> diff --git a/ui/console.c b/ui/console.c
> index 57df3a5439..c5aabf5a5f 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -167,7 +167,6 @@ struct QemuConsole {
>      QEMUFIFO out_fifo;
>      uint8_t out_fifo_buf[16];
>      QEMUTimer *kbd_timer;
> -    Coroutine *screendump_co;
> =20
>      QTAILQ_ENTRY(QemuConsole) next;
>  };
> @@ -261,14 +260,20 @@ static void gui_setup_refresh(DisplayState *ds)
>      ds->have_text =3D have_text;
>  }
> =20
> -void graphic_hw_update_done(QemuConsole *con)
> +static void graphic_hw_update_done_with_kick(QemuConsole *con,
> +                                             Coroutine *kick_me)
>  {
> -    if (con && con->screendump_co) {
> -        aio_co_wake(con->screendump_co);
> +    if (kick_me) {
> +        aio_co_wake(kick_me);
>      }
>  }
> =20
> -void graphic_hw_update(QemuConsole *con)
> +void graphic_hw_update_done(QemuConsole *con)
> +{
> +    graphic_hw_update_done_with_kick(con, NULL);
> +}
> +
> +static void graphic_hw_update_with_kick(QemuConsole *con, Coroutine *kic=
k_me)
>  {
>      bool async =3D false;
>      if (!con) {
> @@ -279,10 +284,15 @@ void graphic_hw_update(QemuConsole *con)
>          async =3D con->hw_ops->gfx_update_async;
>      }
>      if (!async) {
> -        graphic_hw_update_done(con);
> +        graphic_hw_update_done_with_kick(con, kick_me);
>      }
>  }
> =20
> +void graphic_hw_update(QemuConsole *con)
> +{
> +    graphic_hw_update_with_kick(con, NULL);
> +}
> +
>  void graphic_hw_gl_block(QemuConsole *con, bool block)
>  {
>      assert(con !=3D NULL);
> @@ -343,9 +353,16 @@ static bool ppm_save(int fd, pixman_image_t *image, =
Error **errp)
>      return true;
>  }
> =20
> -static void graphic_hw_update_bh(void *con)
> +typedef struct {
> +    QemuConsole *con;
> +    Coroutine *kick_me;
> +} UpdateBHargs;
> +
> +static void graphic_hw_update_bh(void *p)
>  {
> -    graphic_hw_update(con);
> +    UpdateBHargs *args =3D p;
> +
> +    graphic_hw_update_with_kick(args->con, args->kick_me);
>  }
> =20
>  /* may be called in coroutine context or not */
> @@ -376,12 +393,13 @@ void qmp_screendump(const char *filename, bool has_=
device, const char *device,
>      }
> =20
>      if (qemu_in_coroutine()) {
> -        assert(!con->screendump_co);
> -        con->screendump_co =3D qemu_coroutine_self();
> +        UpdateBHargs args =3D {
> +            .con =3D con,
> +            .kick_me =3D qemu_coroutine_self(),
> +        };
>          aio_bh_schedule_oneshot(qemu_get_aio_context(),
> -                                graphic_hw_update_bh, con);
> +                                graphic_hw_update_bh, &args);
>          qemu_coroutine_yield();
> -        con->screendump_co =3D NULL;
>      }
> =20
>      surface =3D qemu_console_surface(con);
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


