Received: from eggs.gnu.org ([2001:4830:134:3::10]:55991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcb3-00087E-Fm
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcb2-0001RI-Ik
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:11:21 -0500
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
	<f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
	<2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
	<20180306134757.GH31045@stefanha-x1.localdomain>
	<20180306173718.GK7139@localhost.localdomain>
	<a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
	<adaf915b-50fc-c0a4-a27f-12b9e609c14a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2aa27f4f-2db4-47bd-5c48-faaad6154843@redhat.com>
Date: Wed, 7 Mar 2018 18:11:04 +0100
MIME-Version: 1.0
In-Reply-To: <adaf915b-50fc-c0a4-a27f-12b9e609c14a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bpA7L3Q7RIiTT6eEEGRLZDSnZ09L3EWi8"
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bpA7L3Q7RIiTT6eEEGRLZDSnZ09L3EWi8
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <2aa27f4f-2db4-47bd-5c48-faaad6154843@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
References: <20180226170313.8178-1-mreitz@redhat.com>
 <20180227161743.GC32480@stefanha-x1.localdomain>
 <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
 <2fddac03-cde4-8d83-7651-a3928398e909@redhat.com>
 <20180306134757.GH31045@stefanha-x1.localdomain>
 <20180306173718.GK7139@localhost.localdomain>
 <a9315872-40fa-16fe-7107-7d74e2b24e52@redhat.com>
 <adaf915b-50fc-c0a4-a27f-12b9e609c14a@redhat.com>
In-Reply-To: <adaf915b-50fc-c0a4-a27f-12b9e609c14a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-07 17:33, Paolo Bonzini wrote:
> On 07/03/2018 16:57, Max Reitz wrote:
>>>>> (2) For sparse raw images, this is absolutely devastating.  Reading=
 them
>>>>> now takes more than (ext4) or nearly (xfs) twice as much time as re=
ading
>>>>> a fully allocated image.  So much for "if a filesystem driver has a=
ny
>>>>> sense".
>>> Are you sure that only the filesystem is the problem? Checking for ev=
ery
>>> single byte of an image whether it is zero has to cost some performan=
ce.
>> Well, yes, but "read data location from FS metadata" + "realize it's a=

>> hole" + memset() + "repe scasb" shouldn't take twice as much time as
>> "read data location from FS metadata" + "read data from SSD".
>>
>> I expected the "realize it's a hole" part to fall out for free, so thi=
s
>> would that memset() + repe scasb take much longer than reading data fr=
om
>> the SSD -- and that's just pretty much impossible.
>>
>=20
> This makes a lot of sense, but just to double-check, what does profilin=
g
> say?

Oops, right.  I forgot that I forgot to drop the caches in that first
benchmark...
(http://lists.nongnu.org/archive/html/qemu-block/2018-02/msg01166.html)

I don't have a full test run for this RFC version, but with the modified
series I hinted at in
http://lists.nongnu.org/archive/html/qemu-block/2018-03/msg00244.html I g=
et:
- 0.6 s for a sparse qcow2
- 1.3 s for a preallocated qcow2 (basically like a sparse raw file in
this RFC here)
- 4.0 s for a fully allocated qcow2

So that makes more sense.

Max


--bpA7L3Q7RIiTT6eEEGRLZDSnZ09L3EWi8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgHSgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjyUIALKYr9fy8AbMxvYblKV0n7yklTmyB01O
izbttjchWFX8lIV4qPg0sqjHkRNA6KLlmJ1M5IDwegBLVhDOgyyMdTGxAgKSXnVW
s6c1d09ySN3QdNQ3xo2IRY4f4rk+UBAfqM1rEsy0pr+hzBsr5+zwrUcHpwnu6Tgy
r7nT0Ikhe4Jk3cTiLdkin6omq6tWQhJz4GmM4k627ba2gcDNlUSWoR5CfVIjnaId
9NT4M0Rhg8uMWgFiAJI7XYguFFKh3ItAvU7agXh+anqec4CT/Ea/WERqXGnqJRmJ
Lmaq+VDZweuF9PA9QDJtdmtDuuyZBJWcS9v6ztjqYvJ/yOm34zxBsE4=
=k+lb
-----END PGP SIGNATURE-----

--bpA7L3Q7RIiTT6eEEGRLZDSnZ09L3EWi8--
