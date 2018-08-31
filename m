Received: from eggs.gnu.org ([2001:4830:134:3::10]:41893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvdJP-0000iE-Lt
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fvdJM-0002IJ-GH
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:53:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fvdJM-0002Hk-Aq
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 02:53:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51CDC40201BD
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 06:53:39 +0000 (UTC)
Date: Fri, 31 Aug 2018 08:53:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180831085335.4879aea9@redhat.com>
In-Reply-To: <20180830190958.GT8359@habkost.net>
References: <20180830175019.16939-1-marcandre.lureau@redhat.com>
	<20180830190958.GT8359@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hostmem: no need to check for
 host_memory_backend_mr_inited() in alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Thu, 30 Aug 2018 16:09:58 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Aug 30, 2018 at 07:50:19PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > memfd_backend_memory_alloc/file_backend_memory_alloc both needlessly
> > are are calling host_memory_backend_mr_inited() which creates an
> > illusion that alloc could be called multiple times but it isn't, it's
> > called once from UserCreatable complete().

could you extend this patch to cover file_backend_memory_alloc() as well?
Otherwise this logic would be copy-pasted again in the future.

> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> =20
>=20
> If calling the function multiple times is a mistake, should we
> replace the checks with:
>   assert(!host_memory_backend_mr_inited(backend));
> ?
it is confusing calling it where it's not necessary, hence this cleanup.
Considering that HostMemoryBackendClass::alloc is internal bussines
of hostmem backends, assert() would just add clutter.



> > ---
> >  backends/hostmem-file.c  | 2 +-
> >  backends/hostmem-memfd.c | 4 ----
> >  2 files changed, 1 insertion(+), 5 deletions(-)
> >=20
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 2476dcb435..5cd5fa75a7 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -54,7 +54,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend,=
 Error **errp)
> >  #ifndef CONFIG_LINUX
> >      error_setg(errp, "-mem-path not supported on this host");
> >  #else
> > -    if (!host_memory_backend_mr_inited(backend)) {
> > +    {
> >          gchar *path;
> >          backend->force_prealloc =3D mem_prealloc;
> >          path =3D object_get_canonical_path(OBJECT(backend));
> > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > index abd52364db..7184918112 100644
> > --- a/backends/hostmem-memfd.c
> > +++ b/backends/hostmem-memfd.c
> > @@ -44,10 +44,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backen=
d, Error **errp)
> >          return;
> >      }
> > =20
> > -    if (host_memory_backend_mr_inited(backend)) {
> > -        return;
> > -    }
> > -
> >      backend->force_prealloc =3D mem_prealloc;
> >      fd =3D qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> >                             m->hugetlb, m->hugetlbsize, m->seal ?
> > --=20
> > 2.19.0.rc0.48.gb9dfa238d5
> >  =20
>=20
