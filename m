Received: from eggs.gnu.org ([2001:4830:134:3::10]:34512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRHSY-0006UN-TR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRHSY-00015B-0K
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:29:42 -0400
Date: Fri, 8 Jun 2018 14:29:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180608132927.GC31164@stefanha-x1.localdomain>
References: <20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
	<d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
	<20180510082659.GC1296@stefanha-x1.localdomain>
	<20180511172531.GB5016@localhost.localdomain>
	<20180514134846.GD5182@stefanha-x1.localdomain>
	<20180530144450.GB5973@stefanha-x1.localdomain>
	<20180530160719.GD4311@localhost.localdomain>
	<20180531104838.GC27838@stefanha-x1.localdomain>
	<EC8A4E314CF1574AB62C80421BD983393409C805@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <EC8A4E314CF1574AB62C80421BD983393409C805@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "He, Junyan" <junyan.he@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 05:02:58AM +0000, He, Junyan wrote:
> I use the simple way to handle this,
> 1. Separate the nvdimm region from ram when do snapshot.
> 2. If the first time, we dump all the nvdimm data the same as ram, and en=
able dirty log trace
> for nvdimm kind region.
> 3. If not the first time, we find the previous snapshot point and add ref=
erence to its clusters
> which is used to store nvdimm data. And this time, we just save dirty pag=
e bitmap and dirty pages.
> Because the previous nvdimm data clusters is ref added, we do not need to=
 worry about its deleting.
>=20
> I encounter a lot of problems:
> 1. Migration and snapshot logic is mixed and need to separate them for nv=
dimm.
> 2. Cluster has its alignment. When do snapshot, we just save data to disk=
 continuous. Because we
> need to add ref to cluster, we really need to consider the alignment. I j=
ust use a little trick way=20
> to padding some data to alignment now, and I think it is not a good way.
> 3. Dirty log trace may have some performance problem.
>=20
> In theory, this manner can be used to handle all kind of huge memory snap=
shot, we need to find the=20
> balance between guest performance(Because of dirty log trace) and snapsho=
t saving time.

If the snapshots are placed on the NVDIMM then save/load times should be
shorter.  I'm not sure how practical that is since this approach may be
too expensive for users.

Stefan

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGoS3AAoJEJykq7OBq3PIkmYH/RGH3dj9VAHJIptxx0QPptPS
cn+uBwepNLQMRGazjALebjdYW8zV8Ll9/sc2L2ndcnqbqfPWllhACqqg1OMqA1kT
1GRyUWS/wlqbrNJpUqOLnBToOnrPdk6YOZPvdyh6gX0hFkkJOy2rwMvRtxXuxSlE
YDtBYjyiUGYA92RSwOP6i4USnQM/rvNyVVhVbloxqCnGbCi5034x5/3NT2ODr6+W
eSJWmyX2t5X8e6WMo709EQLHnNE6hQe6dzdybGbucabVH6FY1QscMIFjrGjjslmS
p1q0x+B4qgypThsD6C2KS+AQAfqUOfSmsPt7ljvLPuiz5fsjQ+KwU7VUuFRvasw=
=wop9
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
