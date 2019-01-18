Received: from eggs.gnu.org ([209.51.188.92]:46755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkcyQ-0004T7-J1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gkcyO-0006xF-EU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:50:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gkcyM-0005ri-D5
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 17:50:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 943F73DE06
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 22:50:17 +0000 (UTC)
Date: Fri, 18 Jan 2019 15:50:11 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190118155011.3c6a23d1@x1.home>
In-Reply-To: <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-4-berrange@redhat.com>
	<c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 18 Jan 2019 11:50:39 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > The '%m' format specifier instructs glibc's printf() implementation to
> > insert the contents of strerror(errno). =20
>=20
> That is a glibc-only extension in printf(), but mandatory (and supported
> in ALL platforms) in syslog().  However, you are correct that:
>=20
> > This is not something that
> > should ever be used in trace-events files because several of the
> > backends do not use the format string and so this error information is
> > invisible to them. The errno value should be given as an explicit
> > trace argument instead. Use of '%m' should also be avoided as it is not
> > portable to all QEMU build targets. =20

It's portable to all QEMU build targets that support vfio, but we can
remove it if we want it out of the trace system, which of course does
support other targets.

> If all of our traces are compiled to syslog(), it would be portable, but
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
> > @@ -2581,7 +2581,7 @@ static void vfio_populate_device(VFIOPCIDevice *v=
dev, Error **errp)
> >      ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_in=
fo);
> >      if (ret) {
> >          /* This can fail for an old kernel or legacy PCI dev */
> > -        trace_vfio_populate_device_get_irq_info_failure();
> > +        trace_vfio_populate_device_get_irq_info_failure(errno); =20
>=20
> trace_vfio_populate_device_get_irq_info_failure(strerror(errno))

Yep, I agree, the intent of the original code is not maintained.
Thanks,

Alex

> >      } else if (irq_info.count =3D=3D 1) {
> >          vdev->pci_aer =3D true;
> >      } else {
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > index a85e8662ea..6d412afc83 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -37,7 +37,7 @@ vfio_pci_hot_reset_has_dep_devices(const char *name) =
"%s: hot reset dependent de
> >  vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int func=
tion, int group_id) "\t%04x:%02x:%02x.%x group %d"
> >  vfio_pci_hot_reset_result(const char *name, const char *result) "%s ho=
t reset: %s"
> >  vfio_populate_device_config(const char *name, unsigned long size, unsi=
gned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, o=
ffset: 0x%lx, flags: 0x%lx"
> > -vfio_populate_device_get_irq_info_failure(void) "VFIO_DEVICE_GET_IRQ_I=
NFO failure: %m"
> > +vfio_populate_device_get_irq_info_failure(int err) "VFIO_DEVICE_GET_IR=
Q_INFO failure: %d" =20
>=20
> vfio_populate_device_get_irq_info_failur(const char *err)
> "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
>=20
> ...if we are trying to match the original intent.
>=20
> >  vfio_realize(const char *name, int group_id) " (%s) group %d"
> >  vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
> >  vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offs=
et) "%s 0x%x@0x%x"
> > diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__=
.py
> > index 3478ac93ab..6fca674936 100644
> > --- a/scripts/tracetool/__init__.py
> > +++ b/scripts/tracetool/__init__.py
> > @@ -274,6 +274,10 @@ class Event(object):
> >          props =3D groups["props"].split()
> >          fmt =3D groups["fmt"]
> >          fmt_trans =3D groups["fmt_trans"]
> > +        if fmt.find("%m") !=3D -1 or fmt_trans.find("%m") !=3D -1:
> > +            raise ValueError("Event format '%m' is forbidden, pass the=
 error "
> > +                             "as an explicit trace argument") =20
>=20
> Whether or not checkpatch decides to flag %m as suspicious in the
> overall code base, I like that you are forbidding it in trace files.
>=20
