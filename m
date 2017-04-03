Received: from eggs.gnu.org ([2001:4830:134:3::10]:55755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv8kQ-0004RC-Si
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv8kQ-000196-0F
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:38:46 -0400
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
Date: Mon, 3 Apr 2017 15:38:36 -0500
MIME-Version: 1.0
In-Reply-To: <0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="njH2v5FcQlKFt34UNkVLQqSCGEA1WieHl"
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--njH2v5FcQlKFt34UNkVLQqSCGEA1WieHl
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
 <0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
In-Reply-To: <0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 03:29 PM, John Snow wrote:
>=20
>=20
> On 03/24/2017 08:34 AM, Kashyap Chamarthy wrote:
>> While debugging some other issue, I happened to stumble across an old
>> libvirt commit[*] that adds support for pivot (whether QEMU should
>> switch to a target copy or not) operation as a result of issuing QMP
>> 'block-job-cancel' to a 'drive-mirror' (in libvirt parlance, "block
>> copy").
>>
>> In the libvirt commit message[*] Eric Blake writes:
>>
>>     "[...] There may be potential improvements to the snapshot code to=

>>     exploit block copy over multiple disks all at one point in time.
>>     And, if 'block-job-cancel' were made part of 'transaction', you
>>     could copy multiple disks at the same point in time without pausin=
g
>>     the domain. [...]"
>>
>=20
> Oh, you want a transactional cancel to basically capitalize on the
> second completion mode of the mirror job.
>=20
> I have never really cared for the way this job works, because I don't
> think "canceling" a ready job is semantically valid (it's not canceled!=

> We completed successfully, just using a different completion mode) --
> but if I am in the minority here I would cede that a transactional
> cancel would be a worthwhile thing to have.
>=20
> I think at other points we have discussed the concept of having a
> configurable completion mode that jobs could have (and allowing this
> setting to be adjusted at runtime) that changes which completion mode
> they'll pursue.

Indeed, having a runtime-adjustable completion mode would allow what
libvirt wants: libvirt doesn't know what mode the user wants until they
request virDomainBlockJobAbort() (the name is scary, but it merely means
that they are stopping what is otherwise an unending job), and pass a
flag that says whether they want pivot or end-point-in-time copy
semantics.  If they request pivot semantics, libvirt invokes
block-job-complete to do its default completion mode, if they request
copy semantics, libvirt then switches the completion mode and still
calls block-job-complete (which _is_ valid in a transaction).

>=20
> This would make a cancel unambiguously a cancellation. It would make a
> non-pivot completion to a mirror action an unambiguous success, too.
>=20
> Minor nit, perhaps, but I want to be sure before we cement the semantic=
s
> of how mirror can be "successful."

Minor or not, it is a useful viewpoint. Either way, as long as the new
way of getting a transactional non-pivot successful completion is
something that libvirt can learn via introspection, it should solve what
we are hoping for here.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--njH2v5FcQlKFt34UNkVLQqSCGEA1WieHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4rLMAAoJEKeha0olJ0Nq/YMH/30RbdFGZOuvH6Ztcek1Pu5j
LLURbZzPs4u8GBy6lIkD7wuP5djUQsufM9iSN8wAc1LzSE43lSGLlpAZFy6gIPiP
11Ws7hMmwjW++Pnnw7JoVo2GXxXU6oEz7bHPV2owIHXoaXmrlhDRNCQRMJkdHfSz
h6f7hgG/OoTS5HF8ky4pYZ/drRdlGvY/ReFFzqTuSWjxSXCfF3QNd7Nkzx1abyxS
mvORViO9NMxKh+gIVKZYrkMJxC28w2tnDgV5OrXF8psxCQs6uCbQsHpcWnQ56Ufp
Kp06/vqwB7if/2atpIyoXivPWaM5OYS2dOXYsiJ7/CfKl08LsO1aP2qH418rq/g=
=HdbP
-----END PGP SIGNATURE-----

--njH2v5FcQlKFt34UNkVLQqSCGEA1WieHl--
