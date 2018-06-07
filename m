Received: from eggs.gnu.org ([2001:4830:134:3::10]:53678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQsvD-0001Ub-P3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQsvC-0004pN-SV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:17:39 -0400
Message-ID: <2afb9305deb37c8ca4f930235eaf52486ab0153e.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 07 Jun 2018 13:17:24 +0200
In-Reply-To: <20180607102257.GH28827@redhat.com>
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
	<20180607102257.GH28827@redhat.com>
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
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, 2018-06-07 at 11:22 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jun 07, 2018 at 12:02:29PM +0200, Andrea Bolognani wrote:
> > While hints might be considered a reasonable fit for qcow2, I think
> > it's pretty hard to argue for embedding the NVRAM file in there,
> > which to me signals quite clearly that an archive containing the
> > disk image(s) *and* the configuration hints *and* other ancillary
> > files such as the NVRAM is the only way to build a solution that's
> > not dead on arrival.
>=20
> On a similar theme, I can imagine users wanting to provide a TPM
> data blob too, and for AMD SEV we'd need to be able to provide a
> DH key, and session blob too IIUC.

I'm not familiar with the technologies you're talking about, but
all that sounds like something very security sensitive and not
something eg. the Fedora project would want to bake into their
cloud images.

Perhaps we should keep in mind that this kind of archive format
lends itself quite naturally to both generic ready-made images and
custom, fully configured images: in the former case it would only
contain the few things mentione above, while in the latter it might
also have security sensitive data that's specific to the deployment
it's going to be used against.

For non-vanilla images, it might be interesting to include the
libvirt XML in its entirety, which would make it trivial to keep
around a full-contained copy of a guest that can be imported back
into libvirt with a single click; on the other hand, the management
layer might want to override that, and for generic images we
probably want to avoid the security implications of people
importing potentially untrusted configurations into the system
libvirt instance and stick to just a few hints instead.

So there's at least two partially overlapping use cases right
there. Fun :)

--=20
Andrea Bolognani / Red Hat / Virtualization
