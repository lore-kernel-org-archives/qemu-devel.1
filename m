Received: from eggs.gnu.org ([209.51.188.92]:45388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1o9-0007pp-NV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1ab-0004CK-P6
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:20:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm1ab-00049g-DX
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:20:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD46DC058CB7
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:33:12 +0000 (UTC)
Date: Tue, 22 Jan 2019 14:32:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122143257.GR13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-4-berrange@redhat.com>
	<c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 18, 2019 at 11:50:39AM -0600, Eric Blake wrote:
> On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > The '%m' format specifier instructs glibc's printf() implementation t=
o
> > insert the contents of strerror(errno).
>=20
> That is a glibc-only extension in printf(), but mandatory (and supporte=
d
> in ALL platforms) in syslog().  However, you are correct that:
>=20
> > This is not something that
> > should ever be used in trace-events files because several of the
> > backends do not use the format string and so this error information i=
s
> > invisible to them. The errno value should be given as an explicit
> > trace argument instead. Use of '%m' should also be avoided as it is n=
ot
> > portable to all QEMU build targets.
>=20
> If all of our traces are compiled to syslog(), it would be portable, bu=
t
> that's not the case.
>=20
> What's more, using %m is subject to race conditions - the more code you
> have between when the format string containing %m is given, and the
> point where the actual error message is emitted, the higher the
> probability that some of the intermediate code could have stomped on
> errno in the meantime, rendering the logged message incorrect.  And
> forcing logging wrappers to save/restore the current state of errno,
> just in case they might encounter %m, can get wasteful.
>=20
> Should checkpatch be taught to flag %m as suspicious?
>=20
> However, tracing the errno value is NOT what %m did; I'd rather see...
>=20
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  hw/vfio/pci.c                 | 2 +-
> >  hw/vfio/trace-events          | 2 +-
> >  scripts/tracetool/__init__.py | 4 ++++
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index c0cb1ec289..85f1908cfe 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2581,7 +2581,7 @@ static void vfio_populate_device(VFIOPCIDevice =
*vdev, Error **errp)
> >      ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_=
info);
> >      if (ret) {
> >          /* This can fail for an old kernel or legacy PCI dev */
> > -        trace_vfio_populate_device_get_irq_info_failure();
> > +        trace_vfio_populate_device_get_irq_info_failure(errno);
>=20
> trace_vfio_populate_device_get_irq_info_failure(strerror(errno))

The caveat is that 'strerror' is not required to be thread safe,
however, given that this is Linux only code I guess we can assume
the glibc impl which fortunately is thread safe.

On this point though, does anyone know of any platforms we support[1],
or are likely to support in future, where 'strerror' is *not* thread
safe ?

I see rumours that Windows strerror() is not thread safe but not
found a concrete source for that.

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms



> > diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init=
__.py
> > index 3478ac93ab..6fca674936 100644
> > --- a/scripts/tracetool/__init__.py
> > +++ b/scripts/tracetool/__init__.py
> > @@ -274,6 +274,10 @@ class Event(object):
> >          props =3D groups["props"].split()
> >          fmt =3D groups["fmt"]
> >          fmt_trans =3D groups["fmt_trans"]
> > +        if fmt.find("%m") !=3D -1 or fmt_trans.find("%m") !=3D -1:
> > +            raise ValueError("Event format '%m' is forbidden, pass t=
he error "
> > +                             "as an explicit trace argument")
>=20
> Whether or not checkpatch decides to flag %m as suspicious in the
> overall code base, I like that you are forbidding it in trace files.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
