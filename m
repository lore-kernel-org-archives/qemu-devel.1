Received: from eggs.gnu.org ([2001:4830:134:3::10]:35037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQrkl-0007TH-6n
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQrkk-0008EP-37
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:02:47 -0400
Message-ID: <f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 07 Jun 2018 12:02:29 +0200
In-Reply-To: <20180606163246.GL3064@redhat.com>
References: <20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
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
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Wed, 2018-06-06 at 17:32 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jun 06, 2018 at 10:36:20AM -0500, Eric Blake wrote:
> > But for the new config to be useful, you have to modify at least one =
tool in
> > the path.  At which point, it is just as easy to say: "libvirt is now=
 smart
> > enough to read the config file out of a .qcow2 to know that it should=
 prefer
> > a q35 machine" as it is to say "libvirt is now smart enough to treat =
a .tar
> > file containing .qcow2 and a config file that states that it should p=
refer a
> > q35 machine", and either approach requires just a single file for the=
 user
> > to download.
>=20
> Just to be clear, libvirt isn't going to do either of those things.
>=20
> Whether there is metadata stuffed inside qcow2, or in a metdata file
> inside a tar file, libvirt is not going to look inside either of them.
> The XML is the only place libvirt deals with the hardware config.
>=20
> Extracting machine type is always going to be a job for the layer above
> such as OpenStack/OVirt/Virt-manager/etc. They will then decide whether
> or not they want to honour that info, and if so, put it into the XML
> they give to libvirt.
>=20
> As mentioned elsewhere, IMHO, it is more friendly to those tools
> to use pre-existing formats, eg TAR and XML/JSON, for which
> their respective programming langauges already have APIs/parsers.

Something that I haven't seen mentioned in the thread - and this
looks like as good a point as any to jump in - is that for q35
guests using EFI as well as aarch64 guests the "one click import"
experience requires not only hints about the machine (and firmware!)
type, but also a copy of the EFI variable store:

  $ virt-builder fedora-27 --arch aarch64 --notes
  Fedora=C2=AE 27 Server (aarch64)

  [...]

  You will need to use the associated UEFI NVRAM variables file:
    http://libguestfs.org/download/builder/fedora-27-aarch64-nvram.xz

While hints might be considered a reasonable fit for qcow2, I think
it's pretty hard to argue for embedding the NVRAM file in there,
which to me signals quite clearly that an archive containing the
disk image(s) *and* the configuration hints *and* other ancillary
files such as the NVRAM is the only way to build a solution that's
not dead on arrival.

It's pretty easy then to imagine using something like

  $ virt-builder \
    fedora-27 \
    --arch aarch64 \
    --format qva \
    --output f27-aarch64.qva

or download the equivalent from some website, followed by

  $ virt-install \
    --name f27-aarch64 \
    --import \
    --input f27-aarch.qva

or the equivalent pointy-clicky import step and having things
Just Work=E2=84=A2, provided sufficient hints are included in the archive=
;
the user, or the management application, would of course be able
to override such hints at import time.

--=20
Andrea Bolognani / Red Hat / Virtualization
