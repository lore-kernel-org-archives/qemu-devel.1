Received: from eggs.gnu.org ([2001:4830:134:3::10]:41457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQsDZ-0006TZ-Bq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQsDY-00054D-9U
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:32:33 -0400
Date: Thu, 7 Jun 2018 11:32:18 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180607103218.GC1455@redhat.com>
References: <20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
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
To: Andrea Bolognani <abologna@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, Jun 07, 2018 at 12:02:29PM +0200, Andrea Bolognani wrote:
> Something that I haven't seen mentioned in the thread - and this
> looks like as good a point as any to jump in - is that for q35
> guests using EFI as well as aarch64 guests the "one click import"
> experience requires not only hints about the machine (and firmware!)
> type, but also a copy of the EFI variable store:
>=20
>   $ virt-builder fedora-27 --arch aarch64 --notes
>   Fedora=C2=AE 27 Server (aarch64)
>=20
>   [...]
>=20
>   You will need to use the associated UEFI NVRAM variables file:
>     http://libguestfs.org/download/builder/fedora-27-aarch64-nvram.xz

This is true, although only sometimes.  If the bootloader[*] has a
working fallback path then usually it is able to boot and reset the
UEFI varstore back to the correct values.  We have had bugs before
where the fallback path was not working, eg:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1353689 (yours!)
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1558793

Another problem which Laszlo mentioned is the varstore isn't portable
between UEFI implementations, or if the UEFI is compiled with
different options.  You can even imagine shipping multiple
varstores(!) which argues for a tar-like format.

> While hints might be considered a reasonable fit for qcow2, I think
> it's pretty hard to argue for embedding the NVRAM file in there,
> which to me signals quite clearly that an archive containing the
> disk image(s) *and* the configuration hints *and* other ancillary
> files such as the NVRAM is the only way to build a solution that's
> not dead on arrival.

The tar argument is quite strong.  Just not the wretched OVA/OVF :-)

> It's pretty easy then to imagine using something like
>=20
>   $ virt-builder \
>     fedora-27 \
>     --arch aarch64 \
>     --format qva \
>     --output f27-aarch64.qva
>=20
> or download the equivalent from some website, followed by
>=20
>   $ virt-install \
>     --name f27-aarch64 \
>     --import \
>     --input f27-aarch.qva
>=20
> or the equivalent pointy-clicky import step and having things
> Just Work=E2=84=A2, provided sufficient hints are included in the archi=
ve;
> the user, or the management application, would of course be able
> to override such hints at import time.

RFEs for virt-builder & virt-install one day :-)

Rich.

[*] I'm not sure exactly which bit of the bootloader does this,
whether it's UEFI itself, or the grub-efi in the guest.


--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
