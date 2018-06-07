Received: from eggs.gnu.org ([2001:4830:134:3::10]:46503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQsW1-000546-34
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQsVz-0003To-KZ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:51:36 -0400
Message-ID: <cd5b03648b98bea6ecb44234a72aff0b58aa8fd3.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 07 Jun 2018 12:51:21 +0200
In-Reply-To: <20180607103218.GC1455@redhat.com>
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
	<20180607103218.GC1455@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, 2018-06-07 at 11:32 +0100, Richard W.M. Jones wrote:
> On Thu, Jun 07, 2018 at 12:02:29PM +0200, Andrea Bolognani wrote:
> > Something that I haven't seen mentioned in the thread - and this
> > looks like as good a point as any to jump in - is that for q35
> > guests using EFI as well as aarch64 guests the "one click import"
> > experience requires not only hints about the machine (and firmware!)
> > type, but also a copy of the EFI variable store:
> >=20
> >   $ virt-builder fedora-27 --arch aarch64 --notes
> >   Fedora=C2=AE 27 Server (aarch64)
> >=20
> >   [...]
> >=20
> >   You will need to use the associated UEFI NVRAM variables file:
> >     http://libguestfs.org/download/builder/fedora-27-aarch64-nvram.xz
>=20
> This is true, although only sometimes.  If the bootloader[*] has a
> working fallback path then usually it is able to boot and reset the
> UEFI varstore back to the correct values.  We have had bugs before
> where the fallback path was not working, eg:
>=20
>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1353689 (yours!)
>   https://bugzilla.redhat.com/show_bug.cgi?id=3D1558793

[...]
> [*] I'm not sure exactly which bit of the bootloader does this,
> whether it's UEFI itself, or the grub-efi in the guest.

IIUC the UEFI spec itself reserves certain file names in the ESP
for this fallback mechanism; it's then up to the guest operating
system to actually install something appropriate there.

In Fedora and RHEL, shim is what takes care of it (except when it
doesn't ;), but in Debian and Ubuntu AFAIK shim is not included
and the fallback path doesn't work at all, which makes providing
the NVRAM file a hard requirement to boot such guests.

--=20
Andrea Bolognani / Red Hat / Virtualization
