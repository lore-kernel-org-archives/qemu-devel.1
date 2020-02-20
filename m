Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4F3C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8429B208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4Um58Je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8429B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4gaY-0005Vn-MQ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 02:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j4ga0-00051b-ER
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j4gZx-0001gG-OM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:49:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j4gZx-0001fd-Eg
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582184940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+X1pwwIjNIfwdR5yiuyQP/3CdtT/VVp6zkS9z8F+x8=;
 b=d4Um58Jeme+lJcrgFQHvFzetw0FiWiXA8Ipbyq9BtU8JDTA1FCUq/xbzZpbjlj/BqvjvyM
 MQ11V/axi07hWd7LA5jErfldHOMQS7VX/lT5Yj66bLFvt8tPcZ4/gvW39WyHcopxTTmmTC
 /IqQz5f5HdL+tPKhsFK21GstDr3Oa6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-A717rpbLPfaqq-v2OWekTw-1; Thu, 20 Feb 2020 02:48:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD5C0A0CC2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:48:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37BDB8ED00;
 Thu, 20 Feb 2020 07:48:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B81A11386A6; Thu, 20 Feb 2020 08:48:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
Date: Thu, 20 Feb 2020 08:48:50 +0100
In-Reply-To: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 13 Jan 2020
 18:48:48 +0400")
Message-ID: <87a75dn1gd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: A717rpbLPfaqq-v2OWekTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Thanks to the QMP coroutine support, the screendump handler can
> trigger a graphic_hw_update(), yield and let the main loop run until
> update is done. Then the handler is resumed, and the ppm_save() will
> write the screen image to disk in the coroutine context (thus
> non-blocking).
>
> For now, HMP doesn't have coroutine support, so it remains potentially
> outdated or glitched.
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
>
> Based-on: <20200109183545.27452-2-kwolf@redhat.com>
>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/ui.json    |  3 ++-
>  ui/console.c    | 35 +++++++++++++++++++++++++++--------
>  ui/trace-events |  2 +-
>  3 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index e04525d8b4..d941202f34 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -96,7 +96,8 @@
>  #
>  ##
>  { 'command': 'screendump',
> -  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
> +  'data': {'filename': 'str', '*device': 'str', '*head': 'int'},
> +  'coroutine': true }
> =20
>  ##
>  # =3D=3D Spice
> diff --git a/ui/console.c b/ui/console.c
> index ac79d679f5..db184b473f 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -167,6 +167,7 @@ struct QemuConsole {
>      QEMUFIFO out_fifo;
>      uint8_t out_fifo_buf[16];
>      QEMUTimer *kbd_timer;
> +    Coroutine *screendump_co;
> =20
>      QTAILQ_ENTRY(QemuConsole) next;
>  };
> @@ -194,7 +195,6 @@ static void dpy_refresh(DisplayState *s);
>  static DisplayState *get_alloc_displaystate(void);
>  static void text_console_update_cursor_timer(void);
>  static void text_console_update_cursor(void *opaque);
> -static bool ppm_save(int fd, DisplaySurface *ds, Error **errp);
> =20
>  static void gui_update(void *opaque)
>  {
> @@ -263,6 +263,9 @@ static void gui_setup_refresh(DisplayState *ds)
> =20
>  void graphic_hw_update_done(QemuConsole *con)
>  {
> +    if (con && con->screendump_co) {

How can !con happen?

> +        aio_co_wake(con->screendump_co);
> +    }
>  }
> =20
>  void graphic_hw_update(QemuConsole *con)
> @@ -310,16 +313,16 @@ void graphic_hw_invalidate(QemuConsole *con)
>      }
>  }
> =20
> -static bool ppm_save(int fd, DisplaySurface *ds, Error **errp)
> +static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
>  {
> -    int width =3D pixman_image_get_width(ds->image);
> -    int height =3D pixman_image_get_height(ds->image);
> +    int width =3D pixman_image_get_width(image);
> +    int height =3D pixman_image_get_height(image);
>      g_autoptr(Object) ioc =3D OBJECT(qio_channel_file_new_fd(fd));
>      g_autofree char *header =3D NULL;
>      g_autoptr(pixman_image_t) linebuf =3D NULL;
>      int y;
> =20
> -    trace_ppm_save(fd, ds);
> +    trace_ppm_save(fd, image);
> =20
>      header =3D g_strdup_printf("P6\n%d %d\n%d\n", width, height, 255);
>      if (qio_channel_write_all(QIO_CHANNEL(ioc),
> @@ -329,7 +332,7 @@ static bool ppm_save(int fd, DisplaySurface *ds, Erro=
r **errp)
> =20
>      linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
>      for (y =3D 0; y < height; y++) {
> -        qemu_pixman_linebuf_fill(linebuf, ds->image, width, 0, y);
> +        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
>          if (qio_channel_write_all(QIO_CHANNEL(ioc),
>                                    (char *)pixman_image_get_data(linebuf)=
,
>                                    pixman_image_get_stride(linebuf), errp=
) < 0) {

Looks like an unrelated optimization / simplification.  If I was
maintainer, I'd ask for a separate patch.

> @@ -340,11 +343,18 @@ static bool ppm_save(int fd, DisplaySurface *ds, Er=
ror **errp)
>      return true;
>  }
> =20
> +static void graphic_hw_update_bh(void *con)
> +{
> +    graphic_hw_update(con);
> +}
> +
> +/* may be called in coroutine context or not */

Hmm.

Even though the QMP core always calls in coroutine context, the comment
is correct: hmp_screendump() calls it outside coroutine context.
Because of that...

>  void qmp_screendump(const char *filename, bool has_device, const char *d=
evice,
>                      bool has_head, int64_t head, Error **errp)
>  {
>      QemuConsole *con;
>      DisplaySurface *surface;
> +    g_autoptr(pixman_image_t) image =3D NULL;
>      int fd;
> =20
>      if (has_device) {
> @@ -365,7 +375,15 @@ void qmp_screendump(const char *filename, bool has_d=
evice, const char *device,
>          }
>      }
> =20
> -    graphic_hw_update(con);
> +    if (qemu_in_coroutine()) {
> +        assert(!con->screendump_co);

What if multiple QMP monitors simultaneously screendump?  Hmm, it works
because all execute one after another in the same coroutine
qmp_dispatcher_co.  Implicit mutual exclusion.

Executing them one after another is bad, because it lets an ill-behaved
QMP command starve *all* QMP monitors.  We do it only out of
(reasonable!) fear of implicit mutual exclusion requirements like the
one you add.

Let's not add more if we can help it.

Your screendump_co is per QemuConsole instead of per QMP monitor only
because you need to find the coroutine in graphic_hw_update_done().  Can
we somehow pass it via function arguments?

In case avoiding the mutual exclusion is impractical: please explain it
in a comment to make it somewhat less implicit.

> +        con->screendump_co =3D qemu_coroutine_self();
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                graphic_hw_update_bh, con);
> +        qemu_coroutine_yield();
> +        con->screendump_co =3D NULL;
> +    }
> +

... the command handler needs extra code to cope with either.  Is this
really what we want for coroutine QMP command handlers?  We'll acquire
more of them, and I'd hate to make each one run both in and outside
coroutine context.  Shouldn't we let the HMP core take care of this?  Or
at least have some common infrastructure these handlers can use?

Why is it okay not to call graphic_hw_update() anymore when
!qemu_in_coroutine()?

If qemu_in_coroutine(), we now run graphic_hw_update() in a bottom half,
then yield until the update completes (see graphic_hw_update_done()
above).  Can you explain the need for the bottom half?

>      surface =3D qemu_console_surface(con);
>      if (!surface) {
>          error_setg(errp, "no surface");
> @@ -379,7 +397,8 @@ void qmp_screendump(const char *filename, bool has_de=
vice, const char *device,
>          return;
>      }
> =20
> -    if (!ppm_save(fd, surface, errp)) {
> +    image =3D pixman_image_ref(surface->image);
> +    if (!ppm_save(fd, image, errp)) {
>          qemu_unlink(filename);
>      }
>  }
> diff --git a/ui/trace-events b/ui/trace-events
> index 0dcda393c1..e8726fc969 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -15,7 +15,7 @@ displaysurface_create_pixman(void *display_surface) "su=
rface=3D%p"
>  displaysurface_free(void *display_surface) "surface=3D%p"
>  displaychangelistener_register(void *dcl, const char *name) "%p [ %s ]"
>  displaychangelistener_unregister(void *dcl, const char *name) "%p [ %s ]=
"
> -ppm_save(int fd, void *display_surface) "fd=3D%d surface=3D%p"
> +ppm_save(int fd, void *image) "fd=3D%d image=3D%p"
> =20
>  # gtk.c
>  # gtk-gl-area.c


