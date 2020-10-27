Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65846C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDA9207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0tU+1jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDA9207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKZ6-0002xR-Lp
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 04:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXKXk-0002Uc-Qh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXKXi-0005zM-Kr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 04:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603788081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REcG8Ey/wkpeCx1vcXUNRELaOwBYPzOkicDUIc+wlPY=;
 b=Q0tU+1jNSlrU5QN6q4k0UMoGwd83tFGd+xkWOODHIJzHOGSdoFnO+ubLcfkYDioogddxw3
 KJOGA2tpjKuG6zUy+abnepX3/axVQjt8N385FMaHTKZ6v/ZjUEDFdHZVfAQFr3G4hD/OjL
 17N9IoLyYtTQC2GeqVez/U1RMbUTMHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-mUVine6UNs6rLLzsba9m3g-1; Tue, 27 Oct 2020 04:41:18 -0400
X-MC-Unique: mUVine6UNs6rLLzsba9m3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F61809DD1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 08:41:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C01D62A0B;
 Tue, 27 Oct 2020 08:41:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9679113865F; Tue, 27 Oct 2020 09:41:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH 3/3] console: make QMP/HMP screendump run in coroutine
References: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
 <20201010204106.1368710-4-marcandre.lureau@redhat.com>
Date: Tue, 27 Oct 2020 09:41:15 +0100
In-Reply-To: <20201010204106.1368710-4-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Sun, 11 Oct 2020 00:41:06 +0400")
Message-ID: <87o8koysb8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thanks to the monitors coroutine support, the screendump handler can

monitors'

Suggest to add (merge commit b7092cda1b3) right before the comma.

> trigger a graphic_hw_update(), yield and let the main loop run until
> update is done. Then the handler is resumed, and ppm_save() will write
> the screen image to disk in the coroutine context (thus non-blocking).
>
> Potentially, during non-blocking write, some new graphic update could
> happen, and thus the image may have some glitches. Whether that
> behaviour is acceptable is discutable. Allocating new memory may not be

s/discutable/debatable/

> a good idea, as framebuffers can be quite large. Even then, QEMU may
> become less responsive as it requires paging in etc.

Tradeoff.  I'm okay with "simple & efficient, but might glitch".  It
should be documented, though.  Followup patch is fine.

> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hmp-commands.hx    |  1 +
>  monitor/hmp-cmds.c |  3 ++-
>  qapi/ui.json       |  3 ++-
>  ui/console.c       | 27 ++++++++++++++++++++++++---
>  4 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index cd068389de..ff2d7aa8f3 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -254,6 +254,7 @@ ERST
>          .help       =3D "save screen from head 'head' of display device =
'device' "
>                        "into PPM image 'filename'",
>          .cmd        =3D hmp_screendump,
> +        .coroutine  =3D true,
>      },
> =20
>  SRST
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9789f4277f..91608bac6d 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1756,7 +1756,8 @@ err_out:
>      goto out;
>  }
> =20
> -void hmp_screendump(Monitor *mon, const QDict *qdict)
> +void coroutine_fn
> +hmp_screendump(Monitor *mon, const QDict *qdict)
>  {
>      const char *filename =3D qdict_get_str(qdict, "filename");
>      const char *id =3D qdict_get_try_str(qdict, "device");
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 9d6721037f..6c7b33cb72 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -98,7 +98,8 @@
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
> index a56fe0dd26..0118f70d9a 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -168,6 +168,7 @@ struct QemuConsole {
>      QEMUFIFO out_fifo;
>      uint8_t out_fifo_buf[16];
>      QEMUTimer *kbd_timer;
> +    CoQueue dump_queue;
> =20
>      QTAILQ_ENTRY(QemuConsole) next;
>  };
> @@ -263,6 +264,7 @@ static void gui_setup_refresh(DisplayState *ds)
> =20
>  void graphic_hw_update_done(QemuConsole *con)
>  {
> +    qemu_co_queue_restart_all(&con->dump_queue);
>  }
> =20
>  void graphic_hw_update(QemuConsole *con)
> @@ -340,8 +342,15 @@ static bool ppm_save(int fd, pixman_image_t *image, =
Error **errp)
>      return true;
>  }
> =20
> -void qmp_screendump(const char *filename, bool has_device, const char *d=
evice,
> -                    bool has_head, int64_t head, Error **errp)
> +static void graphic_hw_update_bh(void *con)
> +{
> +    graphic_hw_update(con);
> +}
> +
> +/* Safety: coroutine-only, concurrent-coroutine safe, main thread only *=
/
> +void coroutine_fn
> +qmp_screendump(const char *filename, bool has_device, const char *device=
,
> +               bool has_head, int64_t head, Error **errp)
>  {
>      g_autoptr(pixman_image_t) image =3D NULL;
>      QemuConsole *con;
> @@ -366,7 +375,15 @@ void qmp_screendump(const char *filename, bool has_d=
evice, const char *device,
>          }
>      }
> =20
> -    graphic_hw_update(con);
> +    if (qemu_co_queue_empty(&con->dump_queue)) {
> +        /* Defer the update, it will restart the pending coroutines */
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                graphic_hw_update_bh, con);
> +    }
> +    qemu_co_queue_wait(&con->dump_queue, NULL);
> +
> +    /* All pending coroutines are woken up, while BQL taken, no further =
graphic
> +     * update are possible until it is released, take an image ref befor=
e that. */

"while BQL taken": I guess you mean "while the BQL is held".

Style nit: CODING_STYLE.rst asks for wings.

Recommend to limit comment line length for readability.

Recommend to turn a few commas into periods.

Together:

    /*
     * All pending coroutines are woken up, while the BQL is held.  No
     * further graphic update are possible until it is released.  Take
     * an image ref before that.
     */

>      surface =3D qemu_console_surface(con);
>      if (!surface) {
>          error_setg(errp, "no surface");
> @@ -381,6 +398,9 @@ void qmp_screendump(const char *filename, bool has_de=
vice, const char *device,
>          return;
>      }
> =20
> +    /* The image content could potentially be updated as the coroutine y=
ields
> +     * and releases the BQL. It could produce corrupted dump, but it sho=
uld be
> +     * otherwise safe. */

Similar nit.

    /*
     * The image content could potentially be updated as the coroutine
     * yields and releases the BQL. It could produce corrupted dump, but
     * it should be otherwise safe.
     */

>      if (!ppm_save(fd, image, errp)) {
>          qemu_unlink(filename);
>      }
> @@ -1297,6 +1317,7 @@ static QemuConsole *new_console(DisplayState *ds, c=
onsole_type_t console_type,
> =20
>      obj =3D object_new(TYPE_QEMU_CONSOLE);
>      s =3D QEMU_CONSOLE(obj);
> +    qemu_co_queue_init(&s->dump_queue);
>      s->head =3D head;
>      object_property_add_link(obj, "device", TYPE_DEVICE,
>                               (Object **)&s->device,

Simpler than v1 thanks to coroutine support for HMP, and the use of
CoQueue.


Let's revisit the experiment I did for v1: "observe the main loop keeps
running while the screendump does its work".

Message-ID: <87a74ueudt.fsf@dusky.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg01235.html

I repeated the first experiment "does the main loop continue to run when
writing out the screendump blocks / would block?"  Same result: main
loop remains blocked.

Back then, you replied

    Right, the goal was rather originally to fix rhbz#1230527. We got
    coroutine IO by accident, and I was too optimistic about default
    behaviour change ;) I will update the patch.

I'm unsure what exactly the update is.  Is it the change from

    Fixes:
    https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527

to

    Related to:
    https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527

?

The commit message says "ppm_save() will write the screen image to disk
in the coroutine context (thus non-blocking)."  Sure reads like a claim
the main loop is no longer blocked.  It is blocked, at least for me.
Please clarify.

Back then, I proposed a second experiment: "does the main loop continue
to run while we wait for graphic_hw_update_done()?"  I don't know the
result.  Do you?

The commit message claims "the screendump handler can trigger a
graphic_hw_update(), yield and let the main loop run until update is
done."


