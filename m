Received: from eggs.gnu.org ([2001:4830:134:3::10]:37882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e6b7K-00013D-FM
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e6b7H-0007dz-8j
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e6b7H-0007dj-0D
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02A9F154B98
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:41:58 +0000 (UTC)
Date: Mon, 23 Oct 2017 07:41:57 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <680041197.30689263.1508758917529.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171023113611.GJ16472@redhat.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
	<20171023095910.23202-6-marcandre.lureau@redhat.com>
	<20171023113611.GJ16472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/6] Add memfd based hostmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, ehabkost@redhat.com



----- Original Message -----
> On Mon, Oct 23, 2017 at 10:59:09AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Add a new memory backend, similar to hostmem-file, except that it
> > doesn't need to create files. It also enforces memory sealing.
> >=20
> > This backend is mainly useful for sharing the memory with other
> > processes.
> >=20
> > Note that Linux supports transparent huge-pages of shmem/memfd memory
> > since 4.8. It is relatively easier to set up THP than a dedicate
> > hugepage mount point by using "madvise" in
> > /sys/kernel/mm/transparent_hugepage/shmem_enabled.
> >=20
> > Since 4.14, memfd allows to set hugetlb requirement explicitly.
> >=20
> > Usage:
> > -object memory-backend-memfd,id=3Dmem1,size=3D1G
>=20
> [snip]
>=20
> > +static void
> > +memfd_backend_class_init(ObjectClass *oc, void *data)
> > +{
> > +    HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
> > +
> > +    bc->alloc =3D memfd_backend_memory_alloc;
> > +
> > +    object_class_property_add_bool(oc, "hugetlb",
> > +                                   memfd_backend_get_hugetlb,
> > +                                   memfd_backend_set_hugetlb,
> > +                                   &error_abort);
>=20
> I tend to think that instead of a bool hugetlb, we should take an
> integer page size instead eg  hugepagesize=3D2M instead of hugetlb=3Dtrue
>=20

Well, how would you then create a memfd without explicit hugetlb request or=
 one with default hugetlb size?

I think size should be a different property. I'll add it.

>=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 3728e9b4dd..5828caefeb 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4208,6 +4208,21 @@ that @option{discard-data} is only an optimizati=
on,
> > and QEMU
> >  might not discard file contents if it aborts unexpectedly or is
> >  terminated using SIGKILL.
> > =20
> > +@item -object
> > memory-backend-memfd,id=3D@var{id},size=3D@var{size},seal=3D@var{on|off=
},hugetlb=3D@var{on|off}
> > +
> > +Creates an anonymous memory file backend object, which allows QEMU to
> > +share the memory with an external process in some cases (e.g. when
> > +using vhost-user). The memory is allocated with memfd and optional
> > +sealing. (Linux only)
> > +
> > +The @option{id} parameter is a unique ID that will be used to
> > +reference this memory region when configuring the @option{-numa}
> > +argument. The @option{size} option provides the size of the memory
> > +region, and accepts common suffixes, eg @option{500M}. The
> > +@option{seal} option creates a sealed-file, that will block further
> > +resizing the memory ('on' by default). The @option{hugetlb} option
> > +specify the file to be created resides in the hugetlbfs filesystem.
>=20
> This should document that you can't combine sealing and huge pages
>=20

Ok, I am wondering if this is a temporary limitation, I have asked the patc=
h author about it (it looks possible to me, I'll eventually try implementin=
g it)
