Received: from eggs.gnu.org ([2001:4830:134:3::10]:55764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzRD-0006BC-5m
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzR8-0006EU-9G
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:46:42 -0500
MIME-Version: 1.0
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181107123652.23417-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:46:24 +0100
Message-ID: <CAAdtpL7Ppk1CNVFzXrjgoaQ13wXuK=7pQ_DDUrEVm8wsxmsDnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 05/14] qdev: move
 qdev_prop_register_global_list() to tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.ibm.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Wed, Nov 7, 2018 at 1:40 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The function is only used by a test, move it there.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  include/hw/qdev-properties.h   |  1 -
>  hw/core/qdev-properties.c      |  9 ---------
>  tests/test-qdev-global-props.c | 18 ++++++++++++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index a95f4a73eb..3ab9cd2eb6 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -249,7 +249,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char =
*name, int value);
>  void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
>
>  void qdev_prop_register_global(GlobalProperty *prop);
> -void qdev_prop_register_global_list(GlobalProperty *props);
>  int qdev_prop_check_globals(void);
>  void qdev_prop_set_globals(DeviceState *dev);
>  void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *=
dev,
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ab61d502fd..bd84c4ea4c 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1180,15 +1180,6 @@ void qdev_prop_register_global(GlobalProperty *pro=
p)
>      global_props =3D g_list_append(global_props, prop);
>  }
>
> -void qdev_prop_register_global_list(GlobalProperty *props)
> -{
> -    int i;
> -
> -    for (i =3D 0; props[i].driver !=3D NULL; i++) {
> -        qdev_prop_register_global(props+i);
> -    }
> -}
> -
>  int qdev_prop_check_globals(void)
>  {
>      GList *l;
> diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
> index ccdf6c57c1..b1eb505442 100644
> --- a/tests/test-qdev-global-props.c
> +++ b/tests/test-qdev-global-props.c
> @@ -89,6 +89,16 @@ static void test_static_prop(void)
>      g_test_trap_assert_stdout("");
>  }
>
> +static void register_global_properties(GlobalProperty *props)
> +{
> +    int i;
> +
> +    for (i =3D 0; props[i].driver !=3D NULL; i++) {
> +        qdev_prop_register_global(props + i);
> +    }
> +}
> +
> +
>  /* Test setting of static property using global properties */
>  static void test_static_globalprop_subprocess(void)
>  {
> @@ -98,7 +108,7 @@ static void test_static_globalprop_subprocess(void)
>          {}
>      };
>
> -    qdev_prop_register_global_list(props);
> +    register_global_properties(props);
>
>      mt =3D STATIC_TYPE(object_new(TYPE_STATIC_PROPS));
>      qdev_init_nofail(DEVICE(mt));
> @@ -216,7 +226,7 @@ static void test_dynamic_globalprop_subprocess(void)
>      };
>      int global_error;
>
> -    qdev_prop_register_global_list(props);
> +    register_global_properties(props);
>
>      mt =3D DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
>      qdev_init_nofail(DEVICE(mt));
> @@ -261,7 +271,7 @@ static void test_dynamic_globalprop_nouser_subprocess=
(void)
>      };
>      int global_error;
>
> -    qdev_prop_register_global_list(props);
> +    register_global_properties(props);
>
>      mt =3D DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
>      qdev_init_nofail(DEVICE(mt));
> @@ -299,7 +309,7 @@ static void test_subclass_global_props(void)
>          {}
>      };
>
> -    qdev_prop_register_global_list(props);
> +    register_global_properties(props);
>
>      mt =3D STATIC_TYPE(object_new(TYPE_SUBCLASS));
>      qdev_init_nofail(DEVICE(mt));
> --
> 2.19.1.708.g4ede3d42df
>
>
