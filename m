Received: from eggs.gnu.org ([2001:4830:134:3::10]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZObK-0000xB-9z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZObJ-00051h-Bz
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:16:34 -0500
Date: Tue, 18 Dec 2018 18:16:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218181004-mutt-send-email-mst@kernel.org>
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218175122.3229-6-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] migration: Use strnlen() for
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
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On Tue, Dec 18, 2018 at 06:51:22PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> GCC 8 introduced the -Wstringop-overflow, which detect buffer overflow
> by string-modifying functions declared in <string.h>, such strncpy(),
> used in global_state_store_running().
>=20
> Since the global_state.runstate does not necessarily contains a
> terminating NUL character, We had to use the QEMU_NONSTRING attribute.
>=20
> The GCC manual says about the nonstring attribute:
>=20
>   However, when the array is declared with the attribute the call to
>   strlen is diagnosed because when the array doesn=E2=80=99t contain a
>   NUL-terminated string the call is undefined. [...]
>   In addition, calling strnlen and strndup with such arrays is safe
>   provided a suitable bound is specified, and not diagnosed.
>=20
> GCC indeed found an incorrect use of strlen(), because this array
> is loaded by VMSTATE_BUFFER(runstate, GlobalState) then parsed
> using qapi_enum_parse which does not get the buffer length.
>=20
> Use strnlen() which returns sizeof(s->runstate) if the array is not
> NUL-terminated.
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  migration/global_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 6e19333422..c19030ef62 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -106,7 +106,7 @@ static int global_state_pre_save(void *opaque)
>      GlobalState *s =3D opaque;
> =20
>      trace_migrate_global_state_pre_save((char *)s->runstate);
> -    s->size =3D strlen((char *)s->runstate) + 1;
> +    s->size =3D strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
> =20
>      return 0;

I don't think this works correctly if strnlen returns
sizeof(s->runstate). Which never happens so we probably should
jus add

	assert(e->size is <=3D sizeof(s->runstate));

But also I think this is not enough, there's a problem in post-load
in the call to qapi_enum_parse. You probably want to force
the last character to 0 there.


>  }
> --=20
> 2.17.2
