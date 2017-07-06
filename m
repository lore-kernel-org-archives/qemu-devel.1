Received: from eggs.gnu.org ([2001:4830:134:3::10]:49024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT6HZ-0002To-HK
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT6HY-0000mO-8s
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:53:21 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dT6HX-0000lr-Rv
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:53:20 -0400
Received: by mail-lf0-x242.google.com with SMTP id f28so191651lfi.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 05:53:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499342940-56739-4-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1499342940-56739-4-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Jul 2017 05:53:17 -0700
Message-ID: <CAJ+F1CK_Cti6hUV7LAjK9HCrOprOVNXhPN_-A-G99fEqNmRLzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/13] char: chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, den@virtuozzo.com, amit@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jul 6, 2017 at 5:08 AM, Anton Nefedov
<anton.nefedov@virtuozzo.com> wrote:
> This patch adds a possibility to change a char device without a frontend
> removal.
>
> Ideally, it would have to happen transparently to a frontend, i.e.
> frontend would continue its regular operation.
> However, backends are not stateless and are set up by the frontends
> via qemu_chr_fe_<> functions, and it's not (generally) possible to replay
> that setup entirely in a backend code, as different chardevs respond
> to the setup calls differently, so do frontends work differently basing
> on those setup responses.
> Moreover, some frontend can generally get and save the backend pointer
> (qemu_chr_fe_get_driver()), and it will become invalid after backend chan=
ge.
>
> So, a frontend which would like to support chardev hotswap has to registe=
r
> a "backend change" handler, and redo its backend setup there.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>  include/chardev/char.h |  9 ++++++
>  chardev/char.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  qapi-schema.json       | 40 ++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 8a9ade4..22fd734 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -93,6 +93,15 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevComm=
on *backend);
>  Chardev *qemu_chr_new(const char *label, const char *filename);
>
>  /**
> + * @qemu_chr_change:
> + *
> + * Change an existing character backend
> + *
> + * @opts the new backend options
> + */
> +void qemu_chr_change(QemuOpts *opts, Error **errp);
> +
> +/**
>   * @qemu_chr_cleanup:
>   *
>   * Delete all chardevs (when leaving qemu)
> diff --git a/chardev/char.c b/chardev/char.c
> index 839eff6..d6b9d89 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -951,6 +951,89 @@ ChardevReturn *qmp_chardev_add(const char *id, Chard=
evBackend *backend,
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
> +    chr_new =3D qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLAS=
S(cc)),
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
> +    chr->be =3D NULL;
> +    qemu_chr_fe_init(be, chr_new, &error_abort);
> +
> +    if (be->chr_be_change(be->opaque) < 0) {
> +        error_setg(errp, "Chardev '%s' change failed", chr_new->label);
> +        chr_new->be =3D NULL;
> +        qemu_chr_fe_init(be, chr, &error_abort);
> +        if (closed_sent) {
> +            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> +        }
> +        object_unref(OBJECT(chr_new));
> +        return NULL;
> +    }
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
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 37c4b95..0090fbf 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5098,6 +5098,46 @@
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



--=20
Marc-Andr=C3=A9 Lureau
