Received: from eggs.gnu.org ([2001:4830:134:3::10]:42983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWPEK-0008QS-Aw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWPEG-0005b4-LM
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:20:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWPEG-0005Zx-9u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:20:24 -0500
Date: Mon, 10 Dec 2018 18:20:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181210182013.6d96fa66@Igors-MacBook-Pro.local>
In-Reply-To: <20181204142023.15982-14-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 13/19] qdev-props: remove errp
 from GlobalProperty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On Tue,  4 Dec 2018 18:20:17 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> All qdev_prop_register_global() set &error_fatal for errp, except
> '-rtc driftfix=3Dslew', which arguably should also use &error_fatal, as
this one shouldn't fail if machine has mc146818rtc instantiated,
it should warn only in case when CLI is mis-configured (i.e. machine
doesn't have mc146818rtc device). I'd say let it die in this case
and make user fix CLI.

> otherwise failing to apply the property would only report a warning.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/qdev-core.h    | 6 ------
>  hw/core/qdev-properties.c | 4 ++--
>  qom/cpu.c                 | 1 -
>  target/i386/cpu.c         | 1 -
>  target/sparc/cpu.c        | 1 -
>  vl.c                      | 1 -
>  6 files changed, 2 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 7d25c99a77..1d4f4aa1f5 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -250,18 +250,12 @@ struct PropertyInfo {
>  /**
>   * GlobalProperty:
>   * @used: Set to true if property was used when initializing a device.
> - * @errp: Error destination, used like first argument of error_setg()
> - *        in case property setting fails later. If @errp is NULL, we
> - *        print warnings instead of ignoring errors silently. For
> - *        hotplugged devices, errp is always ignored and warnings are
> - *        printed instead.
>   */
>  typedef struct GlobalProperty {
>      const char *driver;
>      const char *property;
>      const char *value;
>      bool used;
> -    Error **errp;
>  } GlobalProperty;
> =20
>  static inline void
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 3467e0485c..a2d25d3d37 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1238,8 +1238,8 @@ void qdev_prop_set_globals(DeviceState *dev)
>          if (err !=3D NULL) {
>              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
>                            prop->driver, prop->property, prop->value);
> -            if (!dev->hotplugged && prop->errp) {
> -                error_propagate(prop->errp, err);
> +            if (!dev->hotplugged) {
> +                error_propagate(&error_fatal, err);
>              } else {
>                  warn_report_err(err);
>              }
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 9ad1372d57..5442a7323b 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -312,7 +312,6 @@ static void cpu_common_parse_features(const char *typ=
ename, char *features,
>              prop->driver =3D typename;
>              prop->property =3D g_strdup(featurestr);
>              prop->value =3D g_strdup(val);
> -            prop->errp =3D &error_fatal;
>              qdev_prop_register_global(prop);
>          } else {
>              error_setg(errp, "Expected key=3Dvalue format, found %s.",
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f81d35e1f9..c687a9b694 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3568,7 +3568,6 @@ static void x86_cpu_parse_featurestr(const char *ty=
pename, char *features,
>          prop->driver =3D typename;
>          prop->property =3D g_strdup(name);
>          prop->value =3D g_strdup(val);
> -        prop->errp =3D &error_fatal;
>          qdev_prop_register_global(prop);
>      }
> =20
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 0f090ece54..4a4445bdf5 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -111,7 +111,6 @@ cpu_add_feat_as_prop(const char *typename, const char=
 *name, const char *val)
>      prop->driver =3D typename;
>      prop->property =3D g_strdup(name);
>      prop->value =3D g_strdup(val);
> -    prop->errp =3D &error_fatal;
>      qdev_prop_register_global(prop);
>  }
> =20
> diff --git a/vl.c b/vl.c
> index dfc100f51a..1b25cb3da2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2936,7 +2936,6 @@ static int global_init_func(void *opaque, QemuOpts =
*opts, Error **errp)
>      g->driver   =3D qemu_opt_get(opts, "driver");
>      g->property =3D qemu_opt_get(opts, "property");
>      g->value    =3D qemu_opt_get(opts, "value");
> -    g->errp =3D &error_fatal;
>      qdev_prop_register_global(g);
>      return 0;
>  }
