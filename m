Received: from eggs.gnu.org ([2001:4830:134:3::10]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJKiD-00040V-Ca
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJKiC-0006vY-C9
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:16:29 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-4-git-send-email-kwolf@redhat.com>
	<8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
	<20170609125831.GD4462@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea981c62-61c5-8870-3ba2-8469f8c4fa5f@redhat.com>
Date: Fri, 9 Jun 2017 09:16:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170609125831.GD4462@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TIlmDj6IM7f0AKlXM98hPmcUJAhOTMTjG"
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TIlmDj6IM7f0AKlXM98hPmcUJAhOTMTjG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <ea981c62-61c5-8870-3ba2-8469f8c4fa5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-4-git-send-email-kwolf@redhat.com>
 <8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
 <20170609125831.GD4462@noname.redhat.com>
In-Reply-To: <20170609125831.GD4462@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 07:58 AM, Kevin Wolf wrote:
> Am 09.06.2017 um 14:14 hat Eric Blake geschrieben:
>> On 06/09/2017 06:50 AM, Kevin Wolf wrote:
>>> When qemu is exited, all running jobs should be cancelled successfull=
y.
>>> This adds a test for this for all types of block jobs that currently
>>> exist in qemu.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

>>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "SHUTDOWN", "data": {"guest": false}}
>>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864=
, "offset": 524288, "speed": 65536, "type": "commit"}}
>>
>> I'm worried that if you don't sanitize at least offset, you will still=

>> be prone to some race conditions changing the output.  You may want to=

>> add in some additional filtering on the output to be safer.
>=20
> I considered that at first, but then I realised that these offsets are
> indeed predictable and we want to know if they change (it would likely
> mean that the throttling is broken).
>=20
> If you look at the individual cases, we have:
>=20
> * offset=3D512k for (intermediate) commit and streaming. This is exactl=
y
>   the buffer size for a single request and will be followed by a delay
>   of eight seconds before the next chunk is copied, so we will never ge=
t
>   a different value here.
>=20
> * offset=3D4M for active commit and mirror, because the mirror job has =
a
>   larger buffer size by default, so one request completes it all. This
>   number is already the maximum, so nothing is going to change here
>   either.
>=20
> * offset=3D64k for backup, which works cluster by cluster. We know that=

>   the cluster size is exactly 64k, and while we have only one second
>   of delay here, that's still plenty of time for the 'quit' command to
>   arrive.

These belong in comments in the test proper, because it is not obvious
otherwise.  But with comments added (so someone debugging a theoretical
test failure down the road knows what they are up against),

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TIlmDj6IM7f0AKlXM98hPmcUJAhOTMTjG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOq2rAAoJEKeha0olJ0NqSdAH/01C18Louwnd4H1ffZLt80hI
O5WQpzHdooBtOcZDgtOFXOuszSiTvezu8P60hndOpqCAURoJyY5K2+ykoACqCQa7
uJJYbjA61kDy2+ZPqlcdYWOXxrygx8zV6gBk0cgZRMrEZL3iIRaL22oGLNcVUOcf
+2qtx33eWOM8uNhfh9bRq+mdwDuveevbiRzp0lYhlOPIhJJc11psjb9TRfppKgx3
yupIOaY52x0fqRO55kvM2gu55Ph3dW0F94Px5vAYmOC5APeMfMf6r9nZFj4Bt7Y+
fOTSm8E6XGxivCYuhsiBGXvFQR6eVB1YlcHoLvKlHi4BrlPvTZQEA0driGJb6l4=
=G+02
-----END PGP SIGNATURE-----

--TIlmDj6IM7f0AKlXM98hPmcUJAhOTMTjG--
