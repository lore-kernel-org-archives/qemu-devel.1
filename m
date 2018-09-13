Received: from eggs.gnu.org ([2001:4830:134:3::10]:57900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0Q47-00058B-8a
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0Q44-0005fe-4g
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:45:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g0Q43-0005em-S8
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F359811B7
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 11:45:39 +0000 (UTC)
Date: Thu, 13 Sep 2018 13:45:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180913134535.4b19e520@redhat.com>
In-Reply-To: <20180910134946.16773-1-marcandre.lureau@redhat.com>
References: <20180910134946.16773-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hostmem: no need to check for
 host_memory_backend_mr_inited() in alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 10 Sep 2018 17:49:46 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> memfd_backend_memory_alloc/file_backend_memory_alloc both needlessly
> are are calling host_memory_backend_mr_inited() which creates an
> illusion that alloc could be called multiple times but it isn't, it's
> called once from UserCreatable complete().
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  backends/hostmem-file.c  | 24 ++++++++++++------------
>  backends/hostmem-memfd.c |  4 ----
>  2 files changed, 12 insertions(+), 16 deletions(-)
>=20
> v2:
>  - cosmetic: remove extra indentation in backends/hostmem-file.c
>=20
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 2476dcb435..09b21280ce 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -42,6 +42,9 @@ static void
>  file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>  {
>      HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(backend);
> +#ifdef CONFIG_LINUX
> +    gchar *path;
> +#endif
> =20
>      if (!backend->size) {
>          error_setg(errp, "can't create backend with size 0");
> @@ -54,18 +57,15 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
>  #ifndef CONFIG_LINUX
>      error_setg(errp, "-mem-path not supported on this host");
>  #else
> -    if (!host_memory_backend_mr_inited(backend)) {
> -        gchar *path;
> -        backend->force_prealloc =3D mem_prealloc;
> -        path =3D object_get_canonical_path(OBJECT(backend));
> -        memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> -                                 path,
> -                                 backend->size, fb->align,
> -                                 (backend->share ? RAM_SHARED : 0) |
> -                                 (fb->is_pmem ? RAM_PMEM : 0),
> -                                 fb->mem_path, errp);
> -        g_free(path);
> -    }
> +    backend->force_prealloc =3D mem_prealloc;
> +    path =3D object_get_canonical_path(OBJECT(backend));
> +    memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> +                                     path,
> +                                     backend->size, fb->align,
> +                                     (backend->share ? RAM_SHARED : 0) |
> +                                     (fb->is_pmem ? RAM_PMEM : 0),
> +                                     fb->mem_path, errp);
> +    g_free(path);
>  #endif
>  }
> =20
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index abd52364db..7184918112 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -44,10 +44,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
>          return;
>      }
> =20
> -    if (host_memory_backend_mr_inited(backend)) {
> -        return;
> -    }
> -
>      backend->force_prealloc =3D mem_prealloc;
>      fd =3D qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
>                             m->hugetlb, m->hugetlbsize, m->seal ?
