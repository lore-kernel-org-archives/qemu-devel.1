Received: from eggs.gnu.org ([2001:4830:134:3::10]:55653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWkUy-0000LU-9h
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWkUs-0007pW-DQ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:03:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWkUs-0007p3-6L
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:02:58 -0500
Date: Tue, 11 Dec 2018 17:02:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181211170255.51dafe8d@redhat.com>
In-Reply-To: <20181204142023.15982-16-marcandre.lureau@redhat.com>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-16-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 15/19] qom: add
 object_class_get_class_data()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, Andreas =?UTF-8?B?RsOkcmJl?= =?UTF-8?B?cg==?= <afaerber@suse.de>

On Tue,  4 Dec 2018 18:20:19 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Add a simple function to retrieve the associated class data.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qom/object.h | 9 +++++++++
>  qom/object.c         | 5 +++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 5183c587f3..d5266405da 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -916,6 +916,15 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *=
klass,
>   */
>  ObjectClass *object_class_get_parent(ObjectClass *klass);
> =20
> +
> +/**
> + * object_class_get_class_data:
> + * @klass: The class to obtain associated data.
> + *
> + * Returns: the class_data given when registering the type.
> + */
> +void *object_class_get_class_data(ObjectClass *klass);
> +
>  /**
>   * object_class_get_name:
>   * @klass: The class to obtain the QOM typename for.
> diff --git a/qom/object.c b/qom/object.c
> index aa6f3a2a71..bbc6fbbc01 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -867,6 +867,11 @@ const char *object_class_get_name(ObjectClass *klass)
>      return klass->type->name;
>  }
> =20
> +void *object_class_get_class_data(ObjectClass *klass)
> +{
> +    return klass->type->class_data;
> +}
> +
>  ObjectClass *object_class_by_name(const char *typename)
>  {
>      TypeImpl *type =3D type_get_by_name(typename);

alternatively to what's done in 16/19 which requires this helper
you can drop it and use x86 cpu approach, see:

static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)         =
     =20
{                                                                          =
     =20
    X86CPUDefinition *cpudef =3D data;                                     =
       =20
    X86CPUClass *xcc =3D X86_CPU_CLASS(oc);                                =
       =20
                                                                           =
     =20
    xcc->cpu_def =3D cpudef;
    ...
