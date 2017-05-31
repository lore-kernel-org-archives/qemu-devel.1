Received: from eggs.gnu.org ([2001:4830:134:3::10]:33838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9B0-0003qm-7x
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG9Ax-0004pA-IO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:21:02 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG9Ax-0004og-0l
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:20:59 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4so2288540lfj.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 12:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-4-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 19:20:47 +0000
Message-ID: <CAJ+F1CLJBBJRRGzxRFGxihuD7Gsbxm-0Gg4uvyLfFsC_77NiQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/13] char: chardevice hotswap
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

On Tue, May 30, 2017 at 6:12 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
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
Tbh, I don't understand the need for a different lock. Could you explain?
Even better would be to write a test that shows in which way the lock helps=
.



Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>

patch looks good otherwise


> ---
>  chardev/char.c        | 126
> ++++++++++++++++++++++++++++++++++++++++++++++----
>  include/sysemu/char.h |   9 ++++
>  qapi-schema.json      |  40 ++++++++++++++++
>  3 files changed, 165 insertions(+), 10 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 1b097b3..ba1a5f5 100644
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
> +
> +    s =3D be->chr;
> +    ret =3D s ? qemu_chr_write_all(s, buf, len) : 0;
>
> -    return qemu_chr_write_all(s, buf, len);
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
> +static bool qemu_chr_fe_connect(CharBackend *b, Chardev *s, Error **errp=
)
>  {
>      int tag =3D 0;
>
> @@ -507,6 +516,16 @@ unavailable:
>      return false;
>  }
>
> +bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
> +{
> +    if (!qemu_chr_fe_connect(b, s, errp)) {
> +        return false;
> +    }
> +
> +    qemu_mutex_init(&b->chr_lock);
> +    return true;
> +}
> +
>  static bool qemu_chr_is_busy(Chardev *s)
>  {
>      if (CHARDEV_IS_MUX(s)) {
> @@ -531,6 +550,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
>              d->backends[b->tag] =3D NULL;
>          }
>          b->chr =3D NULL;
> +        qemu_mutex_destroy(&b->chr_lock);
>      }
>  }
>
> @@ -1306,6 +1326,92 @@ ChardevReturn *qmp_chardev_add(const char *id,
> ChardevBackend *backend,
>      return ret;
>  }
>
> +ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backen=
d,
> +                                  Error **errp)
> +{
> +    CharBackend *be;
> +    const ChardevClass *cc;
> +    Chardev *chr, *chr_new;
> +    bool closed_sent =3D false;
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
> +    be =3D chr->be;
> +    if (!be) {
> +        /* easy case */
> +        object_unparent(OBJECT(chr));
> +        return qmp_chardev_add(id, backend, errp);
> +    }
> +
> +    if (!be->chr_be_change) {
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
> +    if (!chr_new) {
> +        return NULL;
> +    }
> +    chr_new->label =3D g_strdup(id);
> +
> +    if (chr->be_open && !chr_new->be_open) {
> +        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +        closed_sent =3D true;
> +    }
> +
> +    qemu_mutex_lock(&be->chr_lock);
> +    chr->be =3D NULL;
> +    qemu_chr_fe_connect(be, chr_new, &error_abort);
> +
> +    if (be->chr_be_change(be->opaque) < 0) {
> +        error_setg(errp, "Chardev '%s' change failed", chr_new->label);
> +        chr_new->be =3D NULL;
> +        qemu_chr_fe_connect(be, chr, &error_abort);
> +        qemu_mutex_unlock(&be->chr_lock);
> +        if (closed_sent) {
> +            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +        }
> +        object_unref(OBJECT(chr_new));
> +        return NULL;
> +    }
> +    qemu_mutex_unlock(&be->chr_lock);
> +
> +    object_unparent(OBJECT(chr));
> +    object_property_add_child(get_chardevs_root(), chr_new->label,
> +                              OBJECT(chr_new), &error_abort);
> +    object_unref(OBJECT(chr_new));
> +
> +    ret =3D g_new0(ChardevReturn, 1);
> +    if (CHARDEV_IS_PTY(chr_new)) {
> +        ret->pty =3D g_strdup(chr_new->filename + 4);
> +        ret->has_pty =3D true;
> +    }
> +
> +    return ret;
> +}
> +
>  void qmp_chardev_remove(const char *id, Error **errp)
>  {
>      Chardev *chr;
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 9f8df07..014ebbc 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -92,6 +92,7 @@ typedef struct CharBackend {
>      void *opaque;
>      int tag;
>      int fe_open;
> +    QemuMutex chr_lock;
>  } CharBackend;
>
>  struct Chardev {
> @@ -141,6 +142,14 @@ void qemu_chr_parse_common(QemuOpts *opts,
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
>  /**
>   * @qemu_chr_fe_disconnect:
> diff --git a/qapi-schema.json b/qapi-schema.json
> index e38c5f0..0f0df36 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5097,6 +5097,46 @@
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
