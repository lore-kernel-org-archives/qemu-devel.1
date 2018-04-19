Received: from eggs.gnu.org ([2001:4830:134:3::10]:34547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9C4G-0003fr-AL
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9C4B-0005oV-Qp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:05:52 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:39563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f9C4B-0005nd-Gp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:05:47 -0400
Received: by mail-wr0-x22e.google.com with SMTP id q3-v6so5457562wrj.6
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:05:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180412144814.GH2704@work-vm>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-36-marcandre.lureau@redhat.com>
	<20180412144814.GH2704@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Apr 2018 18:05:45 +0200
Message-ID: <CAJ+F1CJsG8wV9hW3qNx9m8rsKh4nKCN2=ob1_vigjUugHCb9Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 35/38] console: make screendump
 asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Apr 12, 2018 at 4:48 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
>> Make screendump asynchronous to provide correct screendumps.
>>
>> HMP doesn't have async support, so it has to remain synchronous and
>> potentially incorrect to avoid potential races.
>>
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1230527
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>   Looking at this and the previous pair of patches, I think we'd be
> better if we defined that async commands took a callback function
> pointer and data that they call.
>
>   Here we've got 'graphic_hw_update_done' that explicitly walks qmp
> lists; but I think it's better just to pass graphic_hw_update() the
> completion data together with a callback function and it calls that when
> it's done.
>
> (Also isn't it a little bit of a race, calling graphic_hw_update() and
> *then* adding the entry to the list? Can't it end up calling the _done()
> before we've added it to the list).
>
> Also, do we need a list of outstanding screendumps, or should we just
> have a list of async commands.
>
> It wouldn't seem hard to use the async-QMP command from the HMP
> and then just provide a way to tell whether it had finished.
>

I should have updated the commit message, but the following patches do
introduce async-QMP support for HMP (by suspending HMP monitor, just
like QMP).

> Dave
>
>> ---
>>  qapi/ui.json         |  3 +-
>>  include/ui/console.h |  3 ++
>>  hmp.c                |  2 +-
>>  ui/console.c         | 99 ++++++++++++++++++++++++++++++++++++++++----
>>  4 files changed, 96 insertions(+), 11 deletions(-)
>>
>> diff --git a/qapi/ui.json b/qapi/ui.json
>> index 5d01ad4304..4d2c326fb9 100644
>> --- a/qapi/ui.json
>> +++ b/qapi/ui.json
>> @@ -96,7 +96,8 @@
>>  #
>>  ##
>>  { 'command': 'screendump',
>> -  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
>> +  'data': {'filename': 'str', '*device': 'str', '*head': 'int'},
>> +  'async': true }
>>
>>  ##
>>  # =3D=3D Spice
>> diff --git a/include/ui/console.h b/include/ui/console.h
>> index fc21621656..0c02190963 100644
>> --- a/include/ui/console.h
>> +++ b/include/ui/console.h
>> @@ -74,6 +74,9 @@ struct MouseTransformInfo {
>>  };
>>
>>  void hmp_mouse_set(Monitor *mon, const QDict *qdict);
>> +void hmp_screendump_sync(const char *filename,
>> +                         bool has_device, const char *device,
>> +                         bool has_head, int64_t head, Error **errp);
>>
>>  /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
>>     constants) */
>> diff --git a/hmp.c b/hmp.c
>> index 679467d85a..da9008fe63 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -2144,7 +2144,7 @@ void hmp_screendump(Monitor *mon, const QDict *qdi=
ct)
>>      int64_t head =3D qdict_get_try_int(qdict, "head", 0);
>>      Error *err =3D NULL;
>>
>> -    qmp_screendump(filename, id !=3D NULL, id, id !=3D NULL, head, &err=
);
>> +    hmp_screendump_sync(filename, id !=3D NULL, id, id !=3D NULL, head,=
 &err);
>>      hmp_handle_error(mon, &err);
>>  }
>>
>> diff --git a/ui/console.c b/ui/console.c
>> index 29234605a7..da51861191 100644
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -32,6 +32,7 @@
>>  #include "chardev/char-fe.h"
>>  #include "trace.h"
>>  #include "exec/memory.h"
>> +#include "monitor/monitor.h"
>>
>>  #define DEFAULT_BACKSCROLL 512
>>  #define CONSOLE_CURSOR_PERIOD 500
>> @@ -116,6 +117,12 @@ typedef enum {
>>      TEXT_CONSOLE_FIXED_SIZE
>>  } console_type_t;
>>
>> +struct qmp_screendump {
>> +    gchar *filename;
>> +    QmpReturn *ret;
>> +    QLIST_ENTRY(qmp_screendump) link;
>> +};
>> +
>>  struct QemuConsole {
>>      Object parent;
>>
>> @@ -165,6 +172,8 @@ struct QemuConsole {
>>      QEMUFIFO out_fifo;
>>      uint8_t out_fifo_buf[16];
>>      QEMUTimer *kbd_timer;
>> +
>> +    QLIST_HEAD(, qmp_screendump) qmp_screendumps;
>>  };
>>
>>  struct DisplayState {
>> @@ -190,6 +199,8 @@ static void dpy_refresh(DisplayState *s);
>>  static DisplayState *get_alloc_displaystate(void);
>>  static void text_console_update_cursor_timer(void);
>>  static void text_console_update_cursor(void *opaque);
>> +static void ppm_save(const char *filename, DisplaySurface *ds,
>> +                     Error **errp);
>>
>>  static void gui_update(void *opaque)
>>  {
>> @@ -256,8 +267,42 @@ static void gui_setup_refresh(DisplayState *ds)
>>      ds->have_text =3D have_text;
>>  }
>>
>> +static void qmp_screendump_finish(QemuConsole *con, const char *filenam=
e,
>> +                                  QmpReturn *ret)
>> +{
>> +    Error *err =3D NULL;
>> +    DisplaySurface *surface;
>> +    Monitor *prev_mon =3D cur_mon;
>> +
>> +    if (qmp_return_is_cancelled(ret)) {
>> +        return;
>> +    }
>> +
>> +    cur_mon =3D qmp_return_get_monitor(ret);
>> +    surface =3D qemu_console_surface(con);
>> +
>> +    /* FIXME: async save with coroutine? it would have to copy or lock
>> +     * the surface. */
>> +    ppm_save(filename, surface, &err);
>> +
>> +    if (err) {
>> +        qmp_return_error(ret, err);
>> +    } else {
>> +        qmp_screendump_return(ret);
>> +    }
>> +    cur_mon =3D prev_mon;
>> +}
>> +
>>  void graphic_hw_update_done(QemuConsole *con)
>>  {
>> +    struct qmp_screendump *dump, *next;
>> +
>> +    QLIST_FOREACH_SAFE(dump, &con->qmp_screendumps, link, next) {
>> +        qmp_screendump_finish(con, dump->filename, dump->ret);
>> +        g_free(dump->filename);
>> +        QLIST_REMOVE(dump, link);
>> +        g_free(dump);
>> +    }
>>  }
>>
>>  bool graphic_hw_update(QemuConsole *con)
>> @@ -358,35 +403,70 @@ write_err:
>>      goto out;
>>  }
>>
>> -void qmp_screendump(const char *filename, bool has_device, const char *=
device,
>> -                    bool has_head, int64_t head, Error **errp)
>> +
>> +static QemuConsole *get_console(bool has_device, const char *device,
>> +                                bool has_head, int64_t head, Error **er=
rp)
>>  {
>> -    QemuConsole *con;
>> -    DisplaySurface *surface;
>> +    QemuConsole *con =3D NULL;
>>
>>      if (has_device) {
>>          con =3D qemu_console_lookup_by_device_name(device, has_head ? h=
ead : 0,
>>                                                   errp);
>> -        if (!con) {
>> -            return;
>> -        }
>>      } else {
>>          if (has_head) {
>>              error_setg(errp, "'head' must be specified together with 'd=
evice'");
>> -            return;
>> +            return NULL;
>>          }
>>          con =3D qemu_console_lookup_by_index(0);
>>          if (!con) {
>>              error_setg(errp, "There is no console to take a screendump =
from");
>> -            return;
>>          }
>>      }
>>
>> +    return con;
>> +}
>> +
>> +void hmp_screendump_sync(const char *filename,
>> +                         bool has_device, const char *device,
>> +                         bool has_head, int64_t head, Error **errp)
>> +{
>> +    DisplaySurface *surface;
>> +    QemuConsole *con =3D get_console(has_device, device, has_head, head=
, errp);
>> +
>> +    if (!con) {
>> +        return;
>> +    }
>> +    /* This may not complete the drawing with Spice, you may have
>> +     * glitches or outdated dumps, use qmp instead! */
>>      graphic_hw_update(con);
>>      surface =3D qemu_console_surface(con);
>>      ppm_save(filename, surface, errp);
>>  }
>>
>> +void qmp_screendump(const char *filename,
>> +                    bool has_device, const char *device,
>> +                    bool has_head, int64_t head,
>> +                    QmpReturn *qret)
>> +{
>> +    Error *err =3D NULL;
>> +    bool async;
>> +    QemuConsole *con =3D get_console(has_device, device, has_head, head=
, &err);
>> +
>> +    if (!con) {
>> +        qmp_return_error(qret, err);
>> +        return;
>> +    }
>> +    async =3D graphic_hw_update(con);
>> +    if (async) {
>> +        struct qmp_screendump *dump =3D g_new(struct qmp_screendump, 1)=
;
>> +        dump->filename =3D g_strdup(filename);
>> +        dump->ret =3D qret;
>> +        QLIST_INSERT_HEAD(&con->qmp_screendumps, dump, link);
>> +    } else {
>> +        qmp_screendump_finish(con, filename, qret);
>> +    }
>> +}
>> +
>>  void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
>>  {
>>      if (!con) {
>> @@ -1280,6 +1360,7 @@ static QemuConsole *new_console(DisplayState *ds, =
console_type_t console_type,
>>      obj =3D object_new(TYPE_QEMU_CONSOLE);
>>      s =3D QEMU_CONSOLE(obj);
>>      s->head =3D head;
>> +    QLIST_INIT(&s->qmp_screendumps);
>>      object_property_add_link(obj, "device", TYPE_DEVICE,
>>                               (Object **)&s->device,
>>                               object_property_allow_set_link,
>> --
>> 2.17.0.rc1.1.g4c4f2b46a3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>



--=20
Marc-Andr=C3=A9 Lureau
