Received: from eggs.gnu.org ([2001:4830:134:3::10]:45967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtm2-00047x-Ku
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtlz-0007Rp-S0
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:29:58 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDtlz-0007RN-9g
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:29:55 -0400
Received: by mail-lf0-x244.google.com with SMTP id 99so13517324lfu.2
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 07:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495198042-124203-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495198042-124203-4-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 May 2017 14:29:41 +0000
Message-ID: <CAJ+F1CKHOsDjf8_+vkAT8A5Onz+pbP8xwsLT2rOA4wg2UqX5EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/9] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

Hi

On Fri, May 19, 2017 at 4:51 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> This patch adds a possibility to change a char device without a frontend
> removal.
>
> 1. Ideally, it would have to happen transparently to a frontend, i.e.
> frontend would continue its regular operation.
> However, backends are not stateless and are set up by the frontends
> via qemu_chr_fe_<> functions, and it's not (generally) possible to replay
> that setup entirely in a backend code, as different chardevs respond
> to the setup calls differently, so do frontends work differently basing
> on those setup responses.
> Moreover, some frontend can generally get and save the backend pointer
> (qemu_chr_fe_get_driver()), and it will become invalid after backend
> change.
>
> So, a frontend which would like to support chardev hotswap has to registe=
r
> a "backend change" handler, and redo its backend setup there.
>
> 2. Write path can be used by multiple threads and thus protected with
> chr_write_lock.
> So hotswap also has to be protected so write functions won't access
> a backend being replaced.
>
>
Why not use the chr_write_lock then? (rename it chr_lock?)


> 3. Hotswap function can be called from e.g. a read handler of a monitor
> socket. This can cause troubles so it's safer to defer execution to
> a bottom-half (however, it means we cannot return some of the errors
> synchronously - but most of them we can)
>

What kind of troubles?

>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  chardev/char.c        | 147
> ++++++++++++++++++++++++++++++++++++++++++++++----
>  include/sysemu/char.h |  10 ++++
>  qapi-schema.json      |  40 ++++++++++++++
>  3 files changed, 187 insertions(+), 10 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index ae60950..bac5e1c 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -132,12 +132,16 @@ static bool qemu_chr_replay(Chardev *chr)
>
>  int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
>  {
> -    Chardev *s =3D be->chr;
> +    Chardev *s;
>      ChardevClass *cc;
>      int ret;
>
> +    qemu_mutex_lock(&be->chr_lock);
> +    s =3D be->chr;
> +
>      if (!s) {
> -        return 0;
> +        ret =3D 0;
> +        goto end;
>      }
>
>      if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
> @@ -145,7 +149,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t
> *buf, int len)
>          replay_char_write_event_load(&ret, &offset);
>          assert(offset <=3D len);
>          qemu_chr_fe_write_buffer(s, buf, offset, &offset);
> -        return ret;
> +        goto end;
>      }
>
>      cc =3D CHARDEV_GET_CLASS(s);
> @@ -161,7 +165,9 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t
> *buf, int len)
>      if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
>          replay_char_write_event_save(ret, ret < 0 ? 0 : ret);
>      }
> -
> +
> +end:
> +    qemu_mutex_unlock(&be->chr_lock);
>      return ret;
>  }
>
> @@ -191,13 +197,16 @@ int qemu_chr_write_all(Chardev *s, const uint8_t
> *buf, int len)
>
>  int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
>  {
> -    Chardev *s =3D be->chr;
> +    Chardev *s;
> +    int ret;
>
> -    if (!s) {
> -        return 0;
> -    }
> +    qemu_mutex_lock(&be->chr_lock);
>
> -    return qemu_chr_write_all(s, buf, len);
> +    s =3D be->chr;
> +    ret =3D s ? qemu_chr_write_all(s, buf, len) : 0;
> +
> +    qemu_mutex_unlock(&be->chr_lock);
> +    return ret;
>  }
>
>  int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
> @@ -478,7 +487,7 @@ Chardev *qemu_chr_fe_get_driver(CharBackend *be)
>      return be->chr;
>  }
>
> -bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
> +static bool fe_connect(CharBackend *b, Chardev *s, Error **errp)
>  {
>

I would rather keep a qemu_chr prefix for consistency


>      int tag =3D 0;
>
> @@ -507,6 +516,17 @@ unavailable:
>      return false;
>  }
>
> +bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
> +{
> +    if (!fe_connect(b, s, errp)) {
> +        return false;
> +    }
> +
> +    qemu_mutex_init(&b->chr_lock);
> +    b->hotswap_bh =3D NULL;
> +    return true;
> +}
> +
>  static bool qemu_chr_is_busy(Chardev *s)
>  {
>      if (CHARDEV_IS_MUX(s)) {
> @@ -531,6 +551,10 @@ void qemu_chr_fe_deinit(CharBackend *b)
>              d->backends[b->tag] =3D NULL;
>          }
>          b->chr =3D NULL;
> +        qemu_mutex_destroy(&b->chr_lock);
> +        if (b->hotswap_bh) {
> +            qemu_bh_delete(b->hotswap_bh);
>

Could there be a chr_new leak here?


> +        }
>      }
>  }
>
> @@ -1308,6 +1332,109 @@ ChardevReturn *qmp_chardev_add(const char *id,
> ChardevBackend *backend,
>      return ret;
>  }
>
> +static void chardev_change_bh(void *opaque)
> +{
> +    Chardev *chr_new =3D opaque;
> +    const char *id =3D chr_new->label;
> +    Chardev *chr =3D qemu_chr_find(id);
>

Could chr be gone in the meantime? potentially


> +    CharBackend *be =3D chr->be;
> +    bool closed_sent =3D false;
> +
> +    if (!be) {
> +        /* disconnected since we checked: ok, less work for us */
> +        goto end;
> +    }
> +
> +    if (chr->be_open && !chr_new->be_open) {
> +        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +        closed_sent =3D true;
> +    }
> +
> +    qemu_mutex_lock(&be->chr_lock);
> +    chr->be =3D NULL;
> +    fe_connect(be, chr_new, &error_abort);
> +
> +    if (be->chr_be_change(be->opaque) < 0) {
> +        error_report("Chardev '%s' change failed", id);
> +        fe_connect(be, chr, &error_abort);
> +        qemu_mutex_unlock(&be->chr_lock);
> +        if (closed_sent) {
> +            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +        }
> +        object_unref(OBJECT(chr_new));
> +        return;
> +    }
> +    qemu_mutex_unlock(&be->chr_lock);
> +
> +end:
> +    object_unparent(OBJECT(chr));
> +    object_property_add_child(get_chardevs_root(), id, OBJECT(chr_new),
> +                              &error_abort);
> +    object_unref(OBJECT(chr_new));
> +}
> +
> +ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backen=
d,
> +                                  Error **errp)
> +{
> +    const ChardevClass *cc;
> +    Chardev *chr, *chr_new;
> +    ChardevReturn *ret;
> +
> +    chr =3D qemu_chr_find(id);
> +    if (!chr) {
> +        error_setg(errp, "Chardev '%s' does not exist", id);
> +        return NULL;
> +    }
> +
> +    if (CHARDEV_IS_MUX(chr)) {
> +        error_setg(errp, "Mux device hotswap not supported yet");
> +        return NULL;
> +    }
> +
> +    if (qemu_chr_replay(chr)) {
> +        error_setg(errp,
> +            "Chardev '%s' cannot be changed in record/replay mode", id);
> +        return NULL;
> +    }
> +
> +    if (!chr->be) {
> +        /* easy case */
> +        object_unparent(OBJECT(chr));
> +        return qmp_chardev_add(id, backend, errp);
> +    }
> +
> +    if (!chr->be->chr_be_change) {
> +        error_setg(errp, "Chardev user does not support chardev hotswap"=
);
> +        return NULL;
> +    }
> +
> +    cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], errp=
);
> +    if (!cc) {
> +        return NULL;
> +    }
> +
> +    chr_new =3D qemu_chardev_new(NULL,
> object_class_get_name(OBJECT_CLASS(cc)),
> +                               backend, errp);
> +    chr_new->label =3D g_strdup(id);
>

move it below the check for !chr_new


> +    if (!chr_new) {
> +        return NULL;
> +    }
> +
> +    if (chr->be->hotswap_bh) {
> +        qemu_bh_delete(chr->be->hotswap_bh);
> +    }
>

Is it necessary to delete and recreate the bh? Could there be a chr_new
leak if the bh didn't run? It's probably best to deny backend change while
one is going on.


> +    chr->be->hotswap_bh =3D qemu_bh_new(chardev_change_bh, chr_new);
> +    qemu_bh_schedule(chr->be->hotswap_bh);
> +
> +    ret =3D g_new0(ChardevReturn, 1);
> +    if (CHARDEV_IS_PTY(chr_new)) {
> +        ret->pty =3D g_strdup(chr_new->filename + 4);
> +        ret->has_pty =3D true;
> +    }
> +
> +    return ret;
>

ah, potentially a case where qmp-async would be better..

+}
> +
>  void qmp_chardev_remove(const char *id, Error **errp)
>  {
>      Chardev *chr;
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 9f8df07..68c7876 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -92,6 +92,8 @@ typedef struct CharBackend {
>      void *opaque;
>      int tag;
>      int fe_open;
> +    QemuMutex chr_lock;
> +    QEMUBH *hotswap_bh;
>  } CharBackend;
>
>  struct Chardev {
> @@ -141,6 +143,14 @@ void qemu_chr_parse_common(QemuOpts *opts,
> ChardevCommon *backend);
>   */
>  Chardev *qemu_chr_new(const char *label, const char *filename);
>
> +/**
> + * @qemu_chr_change:
> + *
> + * Change an existing character backend
> + *
> + * @opts the new backend options
> + */
> +void qemu_chr_change(QemuOpts *opts, Error **errp);
>
>
This patch needs some test-char.c tests.


>  /**
>   * @qemu_chr_fe_disconnect:
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 80603cf..bf72166 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5075,6 +5075,46 @@
>    'returns': 'ChardevReturn' }
>
>  ##
> +# @chardev-change:
> +#
> +# Change a character device backend
> +#
> +# @id: the chardev's ID, must exist
> +# @backend: new backend type and parameters
> +#
> +# Returns: ChardevReturn.
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "execute" : "chardev-change",
> +#      "arguments" : { "id" : "baz",
> +#                      "backend" : { "type" : "pty", "data" : {} } } }
> +# <- { "return": { "pty" : "/dev/pty/42" } }
> +#
> +# -> {"execute" : "chardev-change",
> +#     "arguments" : {
> +#         "id" : "charchannel2",
> +#         "backend" : {
> +#             "type" : "socket",
> +#             "data" : {
> +#                 "addr" : {
> +#                     "type" : "unix" ,
> +#                     "data" : {
> +#                         "path" : "/tmp/charchannel2.socket"
> +#                     }
> +#                  },
> +#                  "server" : true,
> +#                  "wait" : false }}}}
> +# <- {"return": {}}
> +#
> +##
> +{ 'command': 'chardev-change', 'data': {'id'      : 'str',
> +                                        'backend' : 'ChardevBackend' },
> +  'returns': 'ChardevReturn' }
> +
> +##
>  # @chardev-remove:
>  #
>  # Remove a character device backend
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
