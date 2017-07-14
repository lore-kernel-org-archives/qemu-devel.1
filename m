Received: from eggs.gnu.org ([2001:4830:134:3::10]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzO4-0004gr-QC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzO3-0008Ee-N7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:08:00 -0400
References: <20170714110048.GC28095@redhat.com> <20170714115742.GG18687@lemon>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd90b5a2-3c77-8cb4-5763-1cdf8fcc3978@redhat.com>
Date: Fri, 14 Jul 2017 07:07:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170714115742.GG18687@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pMIoSJoTVAjF5xFltKXHlRrnpd8daUPp3"
Subject: Re: [Qemu-devel] qcow2 not cleaning up during image create failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pMIoSJoTVAjF5xFltKXHlRrnpd8daUPp3
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <dd90b5a2-3c77-8cb4-5763-1cdf8fcc3978@redhat.com>
Subject: Re: [Qemu-devel] qcow2 not cleaning up during image create failure
References: <20170714110048.GC28095@redhat.com> <20170714115742.GG18687@lemon>
In-Reply-To: <20170714115742.GG18687@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 06:57 AM, Fam Zheng wrote:
> On Fri, 07/14 12:00, Daniel P. Berrange wrote:
>> I've just been looking at the qcow2 image creation code, and found tha=
t
>> if any method in qcow2_create2() returns an error, then we'll report t=
hat,
>> but leave the newly created image file on disk in some partially initi=
alized
>> state. A user may unwittingly use this file later with undefined behav=
iour.
>> This is particularly bad if we fail to setup encryption, because the u=
ser
>> is left with a file with no encryption enabled.
>>
>> So I'm wondering how is the best way to clean up after failure ?
>>
>> Naively I would like to just unlink(filename), but IIUC, filename is
>> not guaranteed to refer to a local file, and AFAIK, there is not
>> bdrv_delete() method todo this portably.
>>
>> If we can't delete a file (because its a block device or network
>> volume), then we must at least blank out the just-written qcow2
>> header with zeros.
>>
>> Ideas / suggestions.
>=20
> Or just write the header as the last step?

Or even keep the current steps where we write portions of the header
early, but ensure that all the early writes do NOT set the magic number,
and only the final write to the file puts QFI\xfb into place.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pMIoSJoTVAjF5xFltKXHlRrnpd8daUPp3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaLQUAAoJEKeha0olJ0Nq5ywH/i01lLezqR/8BjchJ3kRmuoW
SfkJWgP1V+MeZJRG6f7Nx0WzsbnuejNrxusLVpauFj+XDiQGZfoRuhNEQ2yQ9WMp
Ov70bh+B8JXcdZD/IkrzzixOEXC3gqOCrhOXNis6pREnsO4lGwxQVxWXWrdoxQ29
qaLLiqB3DOl3HPzIJK3FVjNglM0DxggeMUDSMpHTdY4FUf65onBumAkt467PGMz/
YWlvM3nkP4SJ34Qw5/2MKMjDaUKssLq/oAoOQcQ7lp5k526KfziqiW+WpK+Jr/Cp
oCwJ6Ur710JLOZkLmK4xdw07zcbssTxGbqLPOyJzmgR7KiD3bdNNnKpCPi8X8Dc=
=+ULI
-----END PGP SIGNATURE-----

--pMIoSJoTVAjF5xFltKXHlRrnpd8daUPp3--
