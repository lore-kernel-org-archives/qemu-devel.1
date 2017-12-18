Received: from eggs.gnu.org ([2001:4830:134:3::10]:40407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQw8t-0004Br-54
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQw8j-0005uG-Ts
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:11:43 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eQw8j-0005rD-F9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:11:33 -0500
Received: by mail-wm0-x229.google.com with SMTP id 64so29592371wme.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 06:11:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218140002.23677-1-cohuck@redhat.com>
References: <20171218140002.23677-1-cohuck@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Dec 2017 15:11:31 +0100
Message-ID: <CAJ+F1CKAzoyg4C1-LDJNv-j8YigxzE8DvGZE2UiEh3iTj8zhhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm: move qdev_prop_tpm to hw/tpm/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Mon, Dec 18, 2017 at 3:00 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> Building with --disable-tpm yields
>
> ../hw/core/qdev-properties-system.o: In function `set_tpm':
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:274: undefined ref=
erence to `qemu_find_tpm_be'
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:278: undefined ref=
erence to `tpm_backend_init'
> ../hw/core/qdev-properties-system.o: In function `release_tpm':
> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:291: undefined ref=
erence to `tpm_backend_reset'
>
> Move the implementation of DEFINE_PROP_TPMBE to hw/tpm/ so that it is
> only built when tpm is actually configured.
>
> Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/core/qdev-properties-system.c | 64 ----------------------------------=
----
>  hw/tpm/tpm_util.c                | 67 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/tpm/tpm_util.h                |  3 ++
>  include/hw/qdev-properties.h     |  2 --
>  4 files changed, 70 insertions(+), 66 deletions(-)
>
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
> index c17364655c..ec10da7424 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -21,7 +21,6 @@
>  #include "net/hub.h"
>  #include "qapi/visitor.h"
>  #include "chardev/char-fe.h"
> -#include "sysemu/tpm_backend.h"
>  #include "sysemu/iothread.h"
>
>  static void get_pointer(Object *obj, Visitor *v, Property *prop,
> @@ -237,69 +236,6 @@ const PropertyInfo qdev_prop_chr =3D {
>      .release =3D release_chr,
>  };
>
> -/* --- character device --- */
> -
> -static void get_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
> -                    Error **errp)
> -{
> -    DeviceState *dev =3D DEVICE(obj);
> -    TPMBackend **be =3D qdev_get_prop_ptr(dev, opaque);
> -    char *p;
> -
> -    p =3D g_strdup(*be ? (*be)->id : "");
> -    visit_type_str(v, name, &p, errp);
> -    g_free(p);
> -}
> -
> -static void set_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
> -                    Error **errp)
> -{
> -    DeviceState *dev =3D DEVICE(obj);
> -    Error *local_err =3D NULL;
> -    Property *prop =3D opaque;
> -    TPMBackend *s, **be =3D qdev_get_prop_ptr(dev, prop);
> -    char *str;
> -
> -    if (dev->realized) {
> -        qdev_prop_set_after_realize(dev, name, errp);
> -        return;
> -    }
> -
> -    visit_type_str(v, name, &str, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    s =3D qemu_find_tpm_be(str);
> -    if (s =3D=3D NULL) {
> -        error_setg(errp, "Property '%s.%s' can't find value '%s'",
> -                   object_get_typename(obj), prop->name, str);
> -    } else if (tpm_backend_init(s, TPM_IF(obj), errp) =3D=3D 0) {
> -        *be =3D s; /* weak reference, avoid cyclic ref */
> -    }
> -    g_free(str);
> -}
> -
> -static void release_tpm(Object *obj, const char *name, void *opaque)
> -{
> -    DeviceState *dev =3D DEVICE(obj);
> -    Property *prop =3D opaque;
> -    TPMBackend **be =3D qdev_get_prop_ptr(dev, prop);
> -
> -    if (*be) {
> -        tpm_backend_reset(*be);
> -    }
> -}
> -
> -const PropertyInfo qdev_prop_tpm =3D {
> -    .name  =3D "str",
> -    .description =3D "ID of a tpm to use as a backend",
> -    .get   =3D get_tpm,
> -    .set   =3D set_tpm,
> -    .release =3D release_tpm,
> -};
> -
>  /* --- netdev device --- */
>  static void get_netdev(Object *obj, Visitor *v, const char *name,
>                         void *opaque, Error **errp)
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index a317243a7e..17cafbe6b3 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -21,9 +21,13 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "tpm_util.h"
>  #include "tpm_int.h"
>  #include "exec/memory.h"
> +#include "sysemu/tpm_backend.h"
> +#include "hw/qdev.h"
>
>  #define DEBUG_TPM 0
>
> @@ -33,6 +37,69 @@
>      } \
>  } while (0)
>
> +/* tpm backend property */
> +
> +static void get_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
> +                    Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    TPMBackend **be =3D qdev_get_prop_ptr(dev, opaque);
> +    char *p;
> +
> +    p =3D g_strdup(*be ? (*be)->id : "");
> +    visit_type_str(v, name, &p, errp);
> +    g_free(p);
> +}
> +
> +static void set_tpm(Object *obj, Visitor *v, const char *name, void *opa=
que,
> +                    Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Error *local_err =3D NULL;
> +    Property *prop =3D opaque;
> +    TPMBackend *s, **be =3D qdev_get_prop_ptr(dev, prop);
> +    char *str;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_str(v, name, &str, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    s =3D qemu_find_tpm_be(str);
> +    if (s =3D=3D NULL) {
> +        error_setg(errp, "Property '%s.%s' can't find value '%s'",
> +                   object_get_typename(obj), prop->name, str);
> +    } else if (tpm_backend_init(s, TPM_IF(obj), errp) =3D=3D 0) {
> +        *be =3D s; /* weak reference, avoid cyclic ref */
> +    }
> +    g_free(str);
> +}
> +
> +static void release_tpm(Object *obj, const char *name, void *opaque)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    TPMBackend **be =3D qdev_get_prop_ptr(dev, prop);
> +
> +    if (*be) {
> +        tpm_backend_reset(*be);
> +    }
> +}
> +
> +const PropertyInfo qdev_prop_tpm =3D {
> +    .name  =3D "str",
> +    .description =3D "ID of a tpm to use as a backend",
> +    .get   =3D get_tpm,
> +    .set   =3D set_tpm,
> +    .release =3D release_tpm,
> +};
> +
>  /*
>   * Write an error message in the given output buffer.
>   */
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index 1c17e3913b..2393b6bc0e 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -39,4 +39,7 @@ static inline uint32_t tpm_cmd_get_size(const void *b)
>  int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
>                               size_t *buffersize);
>
> +#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
> +
>  #endif /* TPM_TPM_UTIL_H */
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 4d24cdf8d6..60b42ac561 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -187,8 +187,6 @@ extern const PropertyInfo qdev_prop_link;
>
>  #define DEFINE_PROP_CHR(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
> -#define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
>  #define DEFINE_PROP_STRING(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
>  #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
