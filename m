Received: from eggs.gnu.org ([2001:4830:134:3::10]:38802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXnQB-0005hS-SI
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXnQA-0006kV-MJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:22:27 -0500
Date: Fri, 14 Dec 2018 13:22:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181214132214.GJ4265@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<14b32e39-a9f6-1a83-87e6-6e150954ddb7@redhat.com>
	<20181213144914.GH5427@linux.fritz.box>
	<db4f1763-e28f-387c-2652-ba71c29e97ff@redhat.com>
	<DB6PR07MB3333BA55F6C06E1DB3388D55AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
	<CAMRbyyug2e_MK+Nzdzso9RheENVzuTba5nYzjBNZbrXCaB2hrw@mail.gmail.com>
	<VI1PR07MB3344412C5DE71936F9689909AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
	<VI1PR07MB334400B255A91277D3597F79AEA10@VI1PR07MB3344.eurprd07.prod.outlook.com>
	<20181214122659.GB4341@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181214122659.GB4341@dhcp-200-186.str.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Request for clarification on qemu-img
 convert behavior zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "De Backer, Fred (Nokia - BE/Antwerp)" <fred.de_backer@nokia.com>, qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Aamir T, Owais (Nokia - IN/Chennai)" <owais.aamir_t@nokia.com>, "Richard W.M. Jones" <rjones@redhat.com>, Nir Soffer <nsoffer@redhat.com>

On Fri, Dec 14, 2018 at 01:26:59PM +0100, Kevin Wolf wrote:
> Am 14.12.2018 um 11:59 hat De Backer, Fred (Nokia - BE/Antwerp) geschri=
eben:
> > >>> Indeed, performance traces are important for issues like this.
> > >>See strace of both FC27 and FC29 attached
> >=20
> > >Looks like you traced only the main thread. All the I/O is done in o=
ther threads.
> > >These flags would be useful:
> > >
> > >=C2=A0 =C2=A0 strace -o log -f -T -tt
> >=20
> > New straces attached with mentioned flags.  Both truncated due to fil=
e
> > size at what I believe to be the same position in the "write-phase".
> > FC29 has the "zeroing-phase" in front.
>=20
> So this is indeed using BLKZEROOUT, which has a slow fallback in the
> kernel (slow means ~12 seconds for each 2 GB chunk).
>=20
> We need to avoid calling BLKZEROOUT in the context of pre-zeroing the
> image for qemu-img convert.
>=20
> Of course, we should also think about the other problem you mentioned,
> related to copying a smaller image to a larger block device. Does this
> require zeroing the parts after the image or should we leave them alone=
?
>=20
> I'd tend to say that since you're passing the whole block device as a
> target to 'qemu-img convert', and the whole block device will be visibl=
e
> to a guest run with the same block device configuration, we should
> indeed zero out the whole device. But then we would declare the F27
> behaviour buggy and this case would stay slow (it would become slightly
> faster because we avoid the double writes, but we wouldn't save the
> writes to the unused space).

I think this behaviour needs to be configurable.

Exposing old data from the block device to the guest is indeed a
security flaw, however, qemu-img can't ever know if there is old
data there or not. Assuming the worst case is a sensible default,
but is too pessimistic to be hardcoded.

If the mgmt application has taken care to ensure the volume was
already zeroed out, there should be a way for it to tell qemu-img
not to do zero'ing again.

Zero'ing of block devices is very expensive and so you really
don't want to it to be done in the hot startup path. I recall
that to deal with this, Nova (or was it Cinder) put zero'ing
of block devices into the guest cleanup path in the background.
That way the expensive zero'ing operation is done at a place
there it won't impact any user visible operations. It just
delays the time until the block device can be re-used for a
new guest.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
