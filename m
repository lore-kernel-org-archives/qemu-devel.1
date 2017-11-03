Received: from eggs.gnu.org ([2001:4830:134:3::10]:38845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYqY-0004Nn-Bg
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAYqS-0005hL-FW
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:05:06 -0400
Date: Fri, 3 Nov 2017 10:04:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103100457.GF5078@stefanha-x1.localdomain>
References: <20171102120223.GI32533@redhat.com>
	<20171102164028.lkl3cv52stkdiywj@eukaryote>
	<20171102170448.GX32533@redhat.com>
	<3c41f881-d773-85e1-f18a-ea1b6c77cf9c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <3c41f881-d773-85e1-f18a-ea1b6c77cf9c@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mbooth@redhat.com


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 12:50:39PM -0500, Eric Blake wrote:
> On 11/02/2017 12:04 PM, Daniel P. Berrange wrote:
>=20
> > vm-a-disk1.qcow2 open - its just a regular backing file setup.
> >=20
> >>
> >>> 	    |  (format=3Dqcow2, proto=3Dfile)
> >>>           |
> >>>           +-  vm-a-disk1.qcow2  (qemu-system-XXX)
> >>>
> >>> The problem is that many VMs are wanting to use cache-disk1.qcow2 as
> >>> their disk's backing file, and only one process is permitted to be
> >>> writing to disk backing file at any time.
> >>
> >> Can you explain a bit more about how many VMs are trying to write to
> >> write to the same backing file 'cache-disk1.qcow2'?  I'd assume it's
> >> just the "immutable" local backing store (once the previous 'mirror' j=
ob
> >> is completed), based on which Nova creates a qcow2 overlay for each
> >> instance it boots.
> >=20
> > An arbitrary number of  vm-*-disk1.qcow2 files could exist all using
> > the same cache-disk1.qcow2 image. Its only limited by how many VMs
> > you can fit on the host. By definition you can only ever have a single
> > process writing to a qcow2 file though, otherwise corruption will quick=
ly
> > follow.
>=20
> So if I'm following, your argument is that the local qemu-nbd process is
> the only one writing to the file, while all other overlays are backed by
> the NBD process; and then as any one of the VMs reads, the qemu-nbd
> process pulls those sectors into the local storage as a result.
>=20
> >=20
> >> When I pointed this e-mail of yours to Matt Booth on Freenode Nova IRC
> >> channel, he said the intermediate image (cache-disk1.qcow2) is a COR
> >> Copy-On-Read).  I realize what COR is -- everytime you read a cluster
> >> from the backing file, you write that locally, to avoid reading it
> >> again.
> >=20
> > qcow2 doesn't give you COR, only COW. So every read request would have =
a miss
> > in cache-disk1.qcow2 and thus have to be fetched from master-disk1.qcow=
2. The
> > use of drive-mirror to pull master-disk1.qcow2 contents into cache-disk=
1.qcow
> > makes up for the lack of COR by populating cache-disk1.qcow2 in the bac=
kground.
>=20
> Ah, but qcow2 (or more precisely, any protocol qemu BDS) DOES have
> copy-on-read, built in to the block layer.  See qemu-iotest 197 for an
> example of it in use.  If we use COR correctly, then every initial read
> request will miss in the cache, but the COR will populate the cache
> without having to have a background drive-mirror.  A background
> drive-mirror may still be useful to populate the cache faster, but COR
> populates the parts you want now regardless of how fast the background
> task is running.

-drive copy-on-read=3Don and the stream block job were added exactly for
this provisioning use case.  They can be used together.

I was a little surprised that the discussion has been about the mirror
job rather than the stream job.

One difference between stream and mirror is that stream doesn't pivot
the image file on completion.  Instead it clears the backing file so the
link to the remote server no longer exists.

Stefan

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/D9JAAoJEJykq7OBq3PIyVIIAMqjDPYCovcz6rER+SSNd2Oe
zvffVCLgcAeQcmol3NP/fPGi45k6wR/DzItnOJQ+k2DduTM12a4r3lywaIQXAyjH
MxKZ+RQxJZ9gs/6xL7VDEulaxtuKznhOZo8cSNgkpfpHXNNulZKZM/BywAzvFwzL
36olLTVaIMMZ9WugsHWJxB5vu95+PHTMwjMk9CnVDf67kMxcEzx4yAt12UK7iBfr
4an6AHi8gi3dOUEGO/uACsgACc2y+MtJnFDWfNtsZkeW3Tp76RtrzyTWgN4H25qp
itTY9Ti8M9tDmk9LdkqyAnuVypWUCf7JSuKODdm9Lwjrj0q3Fm/aQI1MmbckfDU=
=xtFZ
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
