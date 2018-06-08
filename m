Received: from eggs.gnu.org ([2001:4830:134:3::10]:47853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRCxX-0001fw-9F
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRCxW-0002jJ-7J
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:41:23 -0400
Date: Fri, 8 Jun 2018 09:41:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180608084112.GD18233@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
	<20180607103218.GC1455@redhat.com>
	<20180607103620.GJ28827@redhat.com>
	<dd014be5c818e71d4f833e150fbae11e490e2325.camel@redhat.com>
	<7410e002-ba2f-2dd2-b24f-c9841f456ac9@redhat.com>
	<20180608082129.GC2671@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608082129.GC2671@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Andrea Bolognani <abologna@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Fri, Jun 08, 2018 at 09:21:30AM +0100, Dr. David Alan Gilbert wrote:
> * Laszlo Ersek (lersek@redhat.com) wrote:
> > On 06/07/18 12:54, Andrea Bolognani wrote:
> > > On Thu, 2018-06-07 at 11:36 +0100, Daniel P. Berrang=C3=A9 wrote:
> > >> On Thu, Jun 07, 2018 at 11:32:18AM +0100, Richard W.M. Jones wrote=
:
> > >>> Another problem which Laszlo mentioned is the varstore isn't port=
able
> > >>> between UEFI implementations, or if the UEFI is compiled with
> > >>> different options.  You can even imagine shipping multiple
> > >>> varstores(!) which argues for a tar-like format.
> > >>
> > >> Could we perhaps imagine shipping the actual UEFI bios, rather
> > >> than only the varstore.  The bios blob runs in guest context,
> > >> so there shouldn't be able security concerns from hosting
> > >> vendors with running user provided bios. Mostly its a matter
> > >> of confidence that the interface between bios & qemu is stable
> > >> which feels easier than assuming varstore vs different bios is
> > >> portable.
> > >=20
> > > That sounds sensible, and further reinforces the idea that we
> > > need way more than a single string baked into the qcow2 file.
> > >=20
> >=20
> > Sorry for arriving late (thanks Rich for the Fwd).
> >=20
> > The contents of the non-volatile UEFI variables should be considered
> > part of (permanent) guest state, such as disk contents. Therefore I'd
> > argue for bundling the varstore file with the disk image(s).
> >=20
> > In turn, the best way to ensure comaptibility between varstore and
> > firmware binary is to just bundle the firmware binary as well. It's
> > generally not large (x86) or if it is, it compresses extremely well
> > (aarch64). For extra politeness, image providers can bundle a text fi=
le
> > with their firmware build options (like a kernel config), possibly ev=
en
> > a JSON document conforming to the new firmware schema (qemu commit
> > 3a0adfc9bfcf), but that's not a hard requirement I guess.
> >=20
> > If such a VM is to be migrated between hosts, I'd expect the host adm=
in
> > to take care of installing the fw binary on all eligible hosts.
>=20
> There's no way they can do that if they're just importing VMs from
> templates that include the image; who is going to keep track of which
> BIOSs are needed where?

It isn't that unusual a requirement. When Openstack deploys a VM, it
has the user provided image as a base file, and then creates  qcow2
overlay.  If the VM is cold migrated (ie not running) to another
host, OpenStack has to make sure the same base file gets copied across
to the new host so that the overlay still works. Copying the BIOS file
and vars state across at the same time is no more difficult than what
its already doing.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
