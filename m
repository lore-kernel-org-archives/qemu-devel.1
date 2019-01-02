Received: from eggs.gnu.org ([208.118.235.92]:37969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gef9n-0008WO-KO
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gef9j-0000HR-9t
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:57:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gef9j-0000GJ-0y
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 06:57:51 -0500
Date: Wed, 2 Jan 2019 11:57:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190102115730.GE2446@work-vm>
References: <20181228173356.15359-1-philmd@redhat.com>
	<20181228173356.15359-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181228173356.15359-6-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/5] migration: Use strnlen() for
 fixed-size string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> GCC 8 introduced the -Wstringop-overflow, which detect buffer overflow
> by string-modifying functions declared in <string.h>, such strncpy(),
> used in global_state_store_running().
>=20
> GCC indeed found an incorrect use of strlen(), because this array
> is loaded by VMSTATE_BUFFER(runstate, GlobalState) then parsed
> using qapi_enum_parse which does not get the buffer length.
>=20
> Use strnlen() which returns sizeof(s->runstate) if the array is not
> NUL-terminated, assert the size is within range, and enforce the array
> to be NUL-terminated to avoid an overflow in qapi_enum_parse().
>=20
> This fixes:
>=20
>     CC      migration/global_state.o
>   qemu/migration/global_state.c: In function 'global_state_pre_save':
>   qemu/migration/global_state.c:109:15: error: 'strlen' argument 1 decl=
ared attribute 'nonstring' [-Werror=3Dstringop-overflow=3D]
>        s->size =3D strlen((char *)s->runstate) + 1;
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   qemu/migration/global_state.c:24:13: note: argument 'runstate' declar=
ed here
>        uint8_t runstate[100] QEMU_NONSTRING;
>                ^~~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/global_state.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 01805c567a..4f060a6dbd 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -89,6 +89,16 @@ static int global_state_post_load(void *opaque, int =
version_id)
>      s->received =3D true;
>      trace_migrate_global_state_post_load(runstate);
> =20
> +    if (strnlen((char *)s->runstate,
> +                sizeof(s->runstate)) =3D=3D sizeof(s->runstate)) {
> +        /* This condition should never happen during migration, becaus=
e
> +         * all runstate names are shorter than 100 bytes (the size of
> +         * s->runstate). However, a malicious stream could overflow
> +         * the qapi_enum_parse() call, so we force the last character
> +         * to a NUL byte.
> +         */
> +        s->runstate[sizeof(s->runstate) - 1] =3D '\0';
> +    }
>      r =3D qapi_enum_parse(&RunState_lookup, runstate, -1, &local_err);
> =20
>      if (r =3D=3D -1) {
> @@ -107,7 +117,8 @@ static int global_state_pre_save(void *opaque)
>      GlobalState *s =3D opaque;
> =20
>      trace_migrate_global_state_pre_save((char *)s->runstate);
> -    s->size =3D strlen((char *)s->runstate) + 1;
> +    s->size =3D strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
> +    assert(s->size <=3D sizeof(s->runstate));
> =20
>      return 0;
>  }
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
