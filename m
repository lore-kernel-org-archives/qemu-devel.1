Received: from eggs.gnu.org ([2001:4830:134:3::10]:38334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvIC3-0002i6-1Y
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvI6Y-00087w-8w
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:15:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fvI6Y-00084q-2b
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 938DA40216E7
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 08:15:01 +0000 (UTC)
Date: Thu, 30 Aug 2018 10:14:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180830101457.0071b98e@redhat.com>
In-Reply-To: <20180828153840.22519-1-marcandre.lureau@redhat.com>
References: <20180828153840.22519-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, 28 Aug 2018 17:38:40 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> The share=3Don/off property is used to modified mmap() MAP_SHARED
> setting. Make it on by default for convenience and compatibility
> reasons.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  backends/hostmem-memfd.c | 4 +++-
>  qemu-options.hx          | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 1e20fe0ba8..abd52364db 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -59,7 +59,8 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, =
Error **errp)
> =20
>      name =3D object_get_canonical_path(OBJECT(backend));
>      memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
> -                                   name, backend->size, true, fd, errp);
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
> @@ -4029,7 +4029,7 @@ Memory backend objects offer more control than the =
@option{-m} option that is
>  traditionally used to define guest RAM. Please refer to
>  @option{memory-backend-file} for a description of the options.
> =20
> -@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},du=
mp=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{size},host-nodes=3D@v=
ar{host-nodes},policy=3D@var{default|preferred|bind|interleave},seal=3D@var=
{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{size}
> +@item -object memory-backend-memfd,id=3D@var{id},merge=3D@var{on|off},du=
mp=3D@var{on|off},share=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{=
size},host-nodes=3D@var{host-nodes},policy=3D@var{default|preferred|bind|in=
terleave},seal=3D@var{on|off},hugetlb=3D@var{on|off},hugetlbsize=3D@var{siz=
e}
> =20
>  Creates an anonymous memory file backend object, which allows QEMU to
>  share the memory with an external process (e.g. when using
> @@ -4051,6 +4051,8 @@ with the @option{seal} option (requires at least Li=
nux 4.16).
>  Please refer to @option{memory-backend-file} for a description of the
>  other options.
> =20
> +The @option{share} boolean option is @var{on} by default with memfd.
> +
>  @item -object rng-random,id=3D@var{id},filename=3D@var{/dev/random}
> =20
>  Creates a random number generator backend which obtains entropy from

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
