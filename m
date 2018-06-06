Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQbQS-0003Zh-6N
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQbQQ-0006qX-Qv
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:36:44 -0400
Date: Wed, 6 Jun 2018 17:36:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606163625.GK2660@work-vm>
References: <46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606163246.GL3064@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Jun 06, 2018 at 10:36:20AM -0500, Eric Blake wrote:
> > On 06/06/2018 10:05 AM, Dr. David Alan Gilbert wrote:
> >=20
> > > > If that's the issue, add a UUID to qcow2 files and reference it f=
rom the
> > > > config file.
> > >=20
> > > Is a UUID a small string :-)
> >=20
> > Even better, it's something that you could stick directly in the qcow=
2
> > header (and which therefore cannot grow to a larger size) - it would =
be a
> > well-constrained scoped addition.  Maybe the analogy to actual hardwa=
re
> > would be that the config file is like a sticky note, and a UUID embed=
ded in
> > the qcow2 file would be the disk serial number; if you are paranoid t=
hat the
> > sticky note could be too easily pulled off one disk and put on anothe=
r, then
> > the sticky note can include the serial number.
> >=20
> > >=20
> > > > > We should make this EASY for users.
> > > >=20
> > > > To me, having a simple config file they can edit manually certain=
ly
> > > > seems simpler than having to use specific tools to edit it inside=
 of the
> > > > qcow2 file.
> > >=20
> > > The users never touch the tools; they click and import the VM image=
.
> >=20
> > And if we make it easy to import a tar file as the VM image, then tha=
t's
> > still the case.
> >=20
> > > > Sure that it isn't a soft constraint?  If most tools can stay unc=
hanged
> > > > but some very specific ones have to be changed, that seems reason=
able to me.
> > >=20
> > > The hard constraint is the normal path stays unchanged; we can chan=
ge
> > > the tools to make use of the extra data, but not change what's out
> > > there.
> >=20
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

Libvirt could provide a wrapper around whichever format to extract the
data and provide it to the upper layer.  It could also validate against
it to see if the constraints were met as a service for an upper layer.

Dave

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
