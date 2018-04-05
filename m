Received: from eggs.gnu.org ([2001:4830:134:3::10]:53950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f40Vl-0005rd-TQ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f40Vh-0001UL-W4
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:44:49 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:60995
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1f40Vh-0001Tr-Nr
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:44:45 -0400
References: <20180405012241.25714-1-f4bug@amsat.org>
	<20180405012241.25714-5-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <fc68eee3-cd18-016c-a323-3e62250e4ea8@adacore.com>
Date: Thu, 5 Apr 2018 10:44:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180405012241.25714-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] memory: Add
 memory_region_set_priority()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org



On 04/05/2018 03:22 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Sadly I'm missing something, this does not work.

Hmmm is that supposed to work dynamically?

If so I think you might need to call
memory_region_update_container_subregions(..) because it will
actually change the map?

Take a look at how memory_add_subregion works.

Thanks,
Fred

>=20
>   memory.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/memory.c b/memory.c
> index eaa5fa7f23..ae45ea7779 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1225,6 +1225,22 @@ static void memory_region_get_priority(Object *o=
bj, Visitor *v,
>       visit_type_int32(v, name, &value, errp);
>   }
>  =20
> +static void memory_region_set_priority(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    MemoryRegion *mr =3D MEMORY_REGION(obj);
> +    int32_t priority;
> +    Error *local_err =3D NULL;
> +
> +    visit_type_int32(v, name, &priority, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    mr->priority =3D priority;
> +}
> +
>   static void memory_region_get_size(Object *obj, Visitor *v, const cha=
r *name,
>                                      void *opaque, Error **errp)
>   {
> @@ -1260,7 +1276,7 @@ static void memory_region_initfn(Object *obj)
>                           NULL, NULL, &error_abort);
>       object_property_add(OBJECT(mr), "priority", "int32",
>                           memory_region_get_priority,
> -                        NULL, /* memory_region_set_priority */
> +                        memory_region_set_priority,
>                           NULL, NULL, &error_abort);
>       object_property_add(OBJECT(mr), "size", "uint64",
>                           memory_region_get_size,
>=20
