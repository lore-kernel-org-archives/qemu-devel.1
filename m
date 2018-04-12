Received: from eggs.gnu.org ([2001:4830:134:3::10]:40528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6eyz-0000D3-TQ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6eyt-0006c8-Qz
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:21:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6eyt-0006bg-Jt
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C800406802F
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 16:21:47 +0000 (UTC)
References: <20180412111614.9724-1-prasanna.kalever@redhat.com>
	<20180412133158.GB21158@ndevos-x270>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74ea6d81-1800-d580-ecb1-6d85d83115bc@redhat.com>
Date: Thu, 12 Apr 2018 11:21:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180412133158.GB21158@ndevos-x270>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iZPkSS8QqyCuxtYGqlIp4yJxqiPeCUBcN"
Subject: Re: [Qemu-devel] [PATCH] block/gluster: defend on legacy ftruncate
 api use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Niels de Vos <ndevos@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iZPkSS8QqyCuxtYGqlIp4yJxqiPeCUBcN
From: Eric Blake <eblake@redhat.com>
To: Niels de Vos <ndevos@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <74ea6d81-1800-d580-ecb1-6d85d83115bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/gluster: defend on legacy ftruncate
 api use
References: <20180412111614.9724-1-prasanna.kalever@redhat.com>
 <20180412133158.GB21158@ndevos-x270>
In-Reply-To: <20180412133158.GB21158@ndevos-x270>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

n 04/12/2018 08:31 AM, Niels de Vos wrote:
> This change looks good to me, but a commit message would have been
> helpful. I suggest something like this:
>=20
>   Gluster 4.0 changed the signature of glfs_ftruncate(). The function
>   now has two additional arguments, namely prestat and poststat. These
>   provide not benefit for QEMU, so ignoring them and passing NULL makes=

>   the gluster-block driver compile with the new Gluster version again.
>=20
> And maybe add this too:
>=20
>   Glusters libgfapi uses symbol versioning and provides backwards
>   compatible functions. Binaries compiled against previous versions of
>   Gluster keep on functioning with the new library.
>=20

>> @@ -3856,6 +3857,9 @@ if test "$glusterfs" !=3D "no" ; then
>>        glusterfs_fallocate=3D"yes"
>>        glusterfs_zerofill=3D"yes"
>>      fi
>> +    if ! $pkg_config --atleast-version=3D7.4 glusterfs-api; then
>> +      glusterfs_legacy_ftruncate=3D"yes"

Also, version-based tests are lousy.  Feature-based tests (does a call
to glfs_ftruncate(0, 0) compile without error? then we are legacy) are
less brittle, especially when features can be backported across
versions.  So this should be reworked to a compile check, rather than a
version query.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iZPkSS8QqyCuxtYGqlIp4yJxqiPeCUBcN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrPh5YACgkQp6FrSiUn
Q2rypwf+O13fEDsUfRnoqaO/X20GPNZKMOdfkLU59Ipuce9Dg+dR4u1xSJLYSvGc
QvyP7iovKpWCDNcpRx7RTwbbcQQ9dyRU90vLVQy+ltdZp9mH9cVjV8FBk+Q24fqd
DIMegTnV3VNzujoBbv9FWm7Gds2si6SGBsuZnzGy/UCO3zQbtPSeeE6N2Vxvfgln
imu8o0IRlsa0AJU1S5Ia5SoDHGXeuIErm1I18/UGWtXBSpU0CtJJJKHKJATuHswo
LKzb/zY/iLtw1IE493tR8+RKUo8+X43tOZq3Z55mHQWbgyIEIaw7EDUzsEeid4Sr
uisTWoo9+6s8hzkZ+1CmG053yvqBiQ==
=gGjc
-----END PGP SIGNATURE-----

--iZPkSS8QqyCuxtYGqlIp4yJxqiPeCUBcN--
