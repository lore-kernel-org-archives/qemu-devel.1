Received: from eggs.gnu.org ([209.51.188.92]:53032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmIWv-00029r-K1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmIIx-0005BJ-6B
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmIIw-0005B3-TE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:10:55 -0500
Date: Wed, 23 Jan 2019 13:10:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190123131042.GF27270@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<65f933a2-f63c-962f-c503-43c7e84ab5e8@amd.com>
	<20190123125506.GA2376@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190123125506.GA2376@beluga.usersys.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AMD SEV's /dev/sev permissions and probing QEMU
 for capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dinechin@redhat.com" <dinechin@redhat.com>, "mkletzan@redhat.com" <mkletzan@redhat.com>

On Wed, Jan 23, 2019 at 01:55:06PM +0100, Erik Skultety wrote:
> On Fri, Jan 18, 2019 at 12:51:50PM +0000, Singh, Brijesh wrote:
> >
> > On 1/18/19 3:39 AM, Erik Skultety wrote:
> > > Hi,
> > > this is a summary of a private discussion I've had with guys CC'd o=
n this email
> > > about finding a solution to [1] - basically, the default permission=
s on
> > > /dev/sev (below) make it impossible to query for SEV platform capab=
ilities,
> > > since by default we run QEMU as qemu:qemu when probing for capabili=
ties. It's
> > > worth noting is that this is only relevant to probing, since for a =
proper QEMU
> > > VM we create a mount namespace for the process and chown all the no=
des (needs a
> > > SEV fix though).
> > >
> > > # ll /dev/sev
> > > crw-------. 1 root root
> > >
> > > I suggested either force running QEMU as root for probing (despite =
the obvious
> > > security implications) or using namespaces for probing too. Dan arg=
ued that
> > > this would have a significant perf impact and suggested we ask syst=
emd to add a
> > > global udev rule.
> > >
> > > I proceeded with cloning [1] to systemd and creating an udev rule t=
hat I planned
> > > on submitting to systemd upstream - the initial idea was to mimic /=
dev/kvm and
> > > make it world accessible to which Brijesh from AMD expressed a conc=
ern that
> > > regular users might deplete the resources (limit on the number of g=
uests
> > > allowed by the platform).
> >
> >
> > During private discussion I didn't realized that we are discussing a
> > probe issue hence things I have said earlier may not be applicable
> > during the probe. The /dev/sev is managed by the CCP (aka PSP) driver=
.
> > The /dev/sev is used for communicating with the SEV FW running inside
> > the PSP. The SEV FW offers platform and guest specific services. The
> > guest specific services are used during the guest launch, these servi=
ces
> > are available through KVM driver only. Whereas the platform services =
can
> > be invoked at anytime. A typical platform specific services are:
> >
> > - importing certificates
> >
> > - exporting certificates
> >
> > - querying the SEV FW version etc etc
> >
> > In case of the probe we are not launch SEV guest hence we should not =
be
> > worried about depleting the SEV ASID resources.
> >
> > IIRC, libvirt uses QEMP query-sev-capabilities to probe the SEV suppo=
rt.
> > QEMU executes the below sequence to complete the request:
> >
> > 1. Exports the platform certificates=C2=A0 (this is when /dev/sev is =
accessed).
> >
> > 2. Read the host MSR to determine the C-bit and reduced phys-bit posi=
tion
> >
> > I don't see any reason why we can't give world a 'read' permission to
> > /dev/sev. Anyone should be able to export the certificates and query
>=20
> Okay, makes sense to me. The problem I see is the sev_platform_ioctl fu=
nction
> in QEMU which makes an _IOWR request, therefore the file descriptor bei=
ng
> opened in sev_get_capabilities is O_RDWR. Now, I only understand ioctl =
from
> what I've read in the man page, so I don't quite understand the need fo=
r IOWR
> here - but my honest guess would be that it's because the commands like
> SEV_PDH_CERT_EXPORT or SEV_PLATFORM_STATUS need to be copied from users=
pace to
> kernel to instruct kernel which services we want, ergo _IOWR, is that r=
ight?

I'm not seeing any permissions checks in the sev_ioctl() function in the
kernel, so IIUC, that means any permissions are entirely based on whether
you can open the /dev/sev, once open you can run any ioctl.  What, if any=
thing,
enforces which ioctls you can run when the device is only O_RDONLY vs O_R=
DWR ?

> In any case, a fix of some sort needs to land in QEMU first, because no=
 udev
> rule would fix the current situation. Afterwards, I expect that having =
a rule
> like this:
>=20
> KERNEL=3D=3D"sev", GROUP=3D"kvm", MODE=3D"0644"
>=20
> and a selinux policy rule adding the kvm_device_t label, we should be f=
ine, do
> we agree on that?

Based on what I think I see above, this looks like a bad idea.

It still looks like we can solve this entirely in libvirt by just giving
the libvirt capabilities probing code CAP_DAC_OVERRIDE. This would make
libvirt work for all currently released SEV support in kernel/qemu.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
