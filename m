Received: from eggs.gnu.org ([2001:4830:134:3::10]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6bCv-00022s-1K
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6bCs-0001oB-Ep
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6bCs-0001nt-82
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:47:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9A565F7BE
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 11:47:44 +0000 (UTC)
Date: Mon, 23 Oct 2017 12:47:37 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023114737.GK16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
	<20171023095910.23202-6-marcandre.lureau@redhat.com>
	<20171023113611.GJ16472@redhat.com>
	<680041197.30689263.1508758917529.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <680041197.30689263.1508758917529.JavaMail.zimbra@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, ehabkost@redhat.com

On Mon, Oct 23, 2017 at 07:41:57AM -0400, Marc-Andr=C3=A9 Lureau wrote:
>=20
>=20
> ----- Original Message -----
> > On Mon, Oct 23, 2017 at 10:59:09AM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Add a new memory backend, similar to hostmem-file, except that it
> > > doesn't need to create files. It also enforces memory sealing.
> > >=20
> > > This backend is mainly useful for sharing the memory with other
> > > processes.
> > >=20
> > > Note that Linux supports transparent huge-pages of shmem/memfd memo=
ry
> > > since 4.8. It is relatively easier to set up THP than a dedicate
> > > hugepage mount point by using "madvise" in
> > > /sys/kernel/mm/transparent_hugepage/shmem_enabled.
> > >=20
> > > Since 4.14, memfd allows to set hugetlb requirement explicitly.
> > >=20
> > > Usage:
> > > -object memory-backend-memfd,id=3Dmem1,size=3D1G
> >=20
> > [snip]
> >=20
> > > +static void
> > > +memfd_backend_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
> > > +
> > > +    bc->alloc =3D memfd_backend_memory_alloc;
> > > +
> > > +    object_class_property_add_bool(oc, "hugetlb",
> > > +                                   memfd_backend_get_hugetlb,
> > > +                                   memfd_backend_set_hugetlb,
> > > +                                   &error_abort);
> >=20
> > I tend to think that instead of a bool hugetlb, we should take an
> > integer page size instead eg  hugepagesize=3D2M instead of hugetlb=3D=
true
> >=20
>=20
> Well, how would you then create a memfd without explicit hugetlb
> request or one with default hugetlb size?

Hmm, yes, libvirt would not need that, but that would be useful still for
direct QEMU users.

> I think size should be a different property. I'll add it.

Yep ok

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
