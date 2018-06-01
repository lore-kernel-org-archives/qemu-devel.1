Received: from eggs.gnu.org ([2001:4830:134:3::10]:60705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOitR-0006Jd-RC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOitN-0007Rx-O3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:10:53 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:53359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOitN-0007RQ-GQ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:10:49 -0400
Received: by mail-wm0-x22c.google.com with SMTP id a67-v6so2609738wmf.3
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:10:49 -0700 (PDT)
Date: Fri, 1 Jun 2018 13:10:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601121046.GM8687@stefanha-x1.localdomain>
References: <2ab117c8.29cbc.163a6407028.Coremail.lichunguang@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxlYARId5dseejUu"
Content-Disposition: inline
In-Reply-To: <2ab117c8.29cbc.163a6407028.Coremail.lichunguang@hust.edu.cn>
Subject: Re: [Qemu-devel] VM I/O performance drops dramatically during
 storage migration with drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chunguang Li <lichunguang@hust.edu.cn>
Cc: qemu-devel@nongnu.org


--FxlYARId5dseejUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2018 at 06:17:10PM +0800, Chunguang Li wrote:
> Hi, everyone.
>=20
>=20
>=20
>=20
> Recently I am doing some tests on the VM storage+memory migration with KV=
M/QEMU/libvirt. I use the following migrate command through virsh: "virsh m=
igrate --live --copy-storage-all --verbose vm1 qemu+ssh://192.168.1.91/syst=
em tcp://192.168.1.91". I have checked the libvirt debug output, and make s=
ure that the drive-mirror + NBD migration method is used.
>=20
> Inside the VM, I use an I/O benchmark (Iometer) to generate an oltp workl=
oad. I record the I/O performance (IOPS) before/during/after migration. Whe=
n the migration begins, the IOPS dropped by 30%-40%. This is reasonable, be=
cause the migration I/O competes with the workload I/O. However, during alm=
ost the last period of migration (which is 66s in my case), the IOPS droppe=
d dramatically, from about 170 to less than 10. I also show the figure of t=
his experiment in the attachment of this email.
>=20
>=20
>=20
>=20
> I want to figure out what results in this period with very low IOPS. Firs=
t, I added some printf()s in the QEMU code, and knew that, this period occu=
rs just before the memory migration phase. (BTW, the memory migration is ve=
ry fast, which is just about 5s.) So I think this period should be the last=
 phase of the "drive-mirror" process of QEMU. So then I tried to read the c=
ode of "drive-mirror" in QEMU, but failed to understand it very well.
>=20
>=20
>=20
>=20
> Does anybody know what may lead to this period with very low IOPS? Thank =
you very much.=20

IOPS dropped from 170 to less than 10.  That could be because QEMU or
the storage device is slow at completing requests due to the other
activity (drive-mirror).  But it could also be because the guest simply
isn't submitting many I/O requests!

So I think the first step is to determine how much I/O the guest is
submitting.  There are several ways of doing this.  You can enable the
virtio_blk_handle_write and virtio_blk_handle_read trace events if you
are using virtio-blk (see docs/devel/tracing.txt).  Or you could use
iostat(1) inside the guest to observe the number of completed requests +
queue size.

If the guest is not submitting the expected number of requests then
you'll need to investigate why Iometer is starved.

> Some details of this experiment:
> The VM disk image file is 30GB (format =3D raw,cache=3Dnone,aio=3Dnative)=
, and Iometer operates on an 10GB file inside the VM. The oltp workload con=
sists of 33% writes and 67% reads (8KB request size, all random). The VM me=
mory size is 4GB, most of which should be zero pages, so the memory migrati=
on is very fast.
>=20
>=20
>=20
>=20
> --
> Chunguang Li, Ph.D. Candidate
> Wuhan National Laboratory for Optoelectronics (WNLO)
> Huazhong University of Science & Technology (HUST)
> Wuhan, Hubei Prov., China
>=20



--FxlYARId5dseejUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETfGAAoJEJykq7OBq3PIS1UH/1gyvCN03uo1zWnwyvABP0xb
AAX+ukx938Mk02M/1Zcg3chWPwb3st9lGQLHrDQnp9DAqcq9fGlukbGpXRTyEydZ
j1Yw5qfTz4oUt1b2C23WhzDPQnnaWuDb3UoPx4IZSv9V8bzVSB7HTrBPGXn2XN/p
ZNkpPOV2yq3P0GMZNpRYZcFzMpK083yHT6ILsduGeJd7l84eLALh+TjtBqYZRQ22
+dPVC32j3Xcbb+CJh5pG/3LrRGf9X6zl4AxBpOPn2lAjsVVXRxb+t+R2gpOAwI9E
qDcYPpBoKNR0pRwoH6UwfQKbC1MSBLo7x6Vwdi8DzLsyqPhLgPaiIcrBEiV74RI=
=Jkp6
-----END PGP SIGNATURE-----

--FxlYARId5dseejUu--
