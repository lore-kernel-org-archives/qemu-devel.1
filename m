Received: from eggs.gnu.org ([2001:4830:134:3::10]:45763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRKCS-0008HF-Ar
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRKCP-0006yP-4V
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:57:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRKCO-0006yF-Tf
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:57:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D895308FBAC
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 16:57:28 +0000 (UTC)
References: <20180828153840.22519-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <edfe3eae-a63f-0833-f775-df21ec2cad2f@redhat.com>
Date: Mon, 26 Nov 2018 17:57:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180828153840.22519-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hostmem-memfd: honour share=on/off property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 28/08/18 17:38, Marc-Andr=C3=A9 Lureau wrote:
> The share=3Don/off property is used to modified mmap() MAP_SHARED
> setting. Make it on by default for convenience and compatibility
> reasons.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Is this still needed?

Paolo

> ---
>  backends/hostmem-memfd.c | 4 +++-
>  qemu-options.hx          | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 1e20fe0ba8..abd52364db 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -59,7 +59,8 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend=
, Error **errp)
> =20
>      name =3D object_get_canonical_path(OBJECT(backend));
>      memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
> -                                   name, backend->size, true, fd, errp=
);
> +                                   name, backend->size,
> +                                   backend->share, fd, errp);
>      g_free(name);
>  }
> =20
> @@ -131,6 +132,7 @@ memfd_backend_instance_init(Object *obj)
> =20
>      /* default to sealed file */
>      m->seal =3D true;
> +    MEMORY_BACKEND(m)->share =3D true;
>  }
> =20
>  static void
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f14e423b7c..25c02d72b8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4029,7 +4029,7 @@ Memory backend objects offer more control than th=
e @option{-m} option that is
>  traditionally used to define guest RAM. Please refer to
>  @option{memory-backend-file} for a description of the options.
> =20
> -@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},=
dump=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{size},host-nodes=3D=
@var{host-nodes},policy=3D@var{default|preferred|bind|interleave},seal=3D=
@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{size}
> +@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},=
dump=3D@var{on|off},share=3D@var{on|off},prealloc=3D@var{on|off},size=3D@=
var{size},host-nodes=3D@var{host-nodes},policy=3D@var{default|preferred|b=
ind|interleave},seal=3D@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D=
@var{size}
> =20
>  Creates an anonymous memory file backend object, which allows QEMU to
>  share the memory with an external process (e.g. when using
> @@ -4051,6 +4051,8 @@ with the @option{seal} option (requires at least =
Linux 4.16).
>  Please refer to @option{memory-backend-file} for a description of the
>  other options.
> =20
> +The @option{share} boolean option is @var{on} by default with memfd.
> +
>  @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
> =20
>  Creates a random number generator backend which obtains entropy from
>=20
