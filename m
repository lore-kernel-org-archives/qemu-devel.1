Received: from eggs.gnu.org ([2001:4830:134:3::10]:33295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmMFP-0005L7-Pf
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmMFO-0002GA-Nm
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:46:43 -0400
References: <20170828055631.GB3258@host-172-16-90-85.openstacklocal>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7327a956-aef3-a8da-13ff-53073039802f@redhat.com>
Date: Mon, 28 Aug 2017 10:46:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170828055631.GB3258@host-172-16-90-85.openstacklocal>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7ajoD2BGowe0NkEaAAL8kVOStXJECT0VI"
Subject: Re: [Qemu-devel] reduce write bandwidth of qcow2 driver while
 allocating new cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Qing <liuqing@huayun.com>, qemu-devel@nongnu.org, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ajoD2BGowe0NkEaAAL8kVOStXJECT0VI
From: Eric Blake <eblake@redhat.com>
To: Liu Qing <liuqing@huayun.com>, qemu-devel@nongnu.org,
 qemu block <qemu-block@nongnu.org>
Message-ID: <7327a956-aef3-a8da-13ff-53073039802f@redhat.com>
Subject: Re: [Qemu-devel] reduce write bandwidth of qcow2 driver while
 allocating new cluster
References: <20170828055631.GB3258@host-172-16-90-85.openstacklocal>
In-Reply-To: <20170828055631.GB3258@host-172-16-90-85.openstacklocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding qemu-block]

On 08/28/2017 12:56 AM, Liu Qing wrote:
> Dear list,
>     Recently I used fio to test qcow2 driver in the guest os, and found=
 out
> that when a new cluster is allocated the 4K IO will occupy 64K(default =
cluster
> size) bandwith.
>     From the code qcow2 driver will fill the unused part of new allocat=
ed
> cluster with 0 in perform_cow. These 0s are set in qcow2_co_readv when =
the read
> destination is not allocated and it has no backing file. Could I forbid=
den any
> further write in copy_sectors if the copy source is not allocated and i=
t has
> no backing file? So only the requested data is written to the cluster. =
Function
> copy_sectors is only used by perform_cow in the master branch.

There have already been discussions on optimizing COW writes in a manner
similar to what you are describing; for example,

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg00109.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7ajoD2BGowe0NkEaAAL8kVOStXJECT0VI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmkOtoACgkQp6FrSiUn
Q2qh8gf+IMAn5KcIlEToXChMMZ5SUYUUCrW0Wg+okK86loB4h4s1O4nJOffG/1H2
OyydhTHJCTOaZfcijFeSVk7U2uP0cWc05f6vYcuuHCqc+MvFAWo9tUTlQawQiNGL
GAAMV94wZkjaVCtARXQMX0fhsB9lQVjD64r2idSTUPl+ReMCVPEVe6+OVRrLmuwP
9DBVRx7r7TP3pGrbBOBVNslUnZXWeQkmJvGdhx8Z0jnLJi/U8Fm96142ZshPvkwO
2hZnRl+NUrgbskrpqUdfJ3uXOMa+J9SwDkNdcA+nGMQYjZ/FkwoFG9bMZJBgP3vI
ClHcdJG8m5wyRCXun6HwQfZLKWXpVA==
=EAnv
-----END PGP SIGNATURE-----

--7ajoD2BGowe0NkEaAAL8kVOStXJECT0VI--
