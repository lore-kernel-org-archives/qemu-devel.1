Received: from eggs.gnu.org ([2001:4830:134:3::10]:35583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQBtK-00089s-AU
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQBtJ-000800-Dc
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:16:18 -0400
Date: Wed, 28 Jun 2017 15:15:30 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170628121530.zdhob4iq37x3qv4i@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-3-el13635@mail.ntua.gr>
	<20170628112736.GD5378@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7al5muedogfcc3pt"
Content-Disposition: inline
In-Reply-To: <20170628112736.GD5378@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/8] block: Add aio_context field in
 ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--7al5muedogfcc3pt
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 01:27:36PM +0200, Kevin Wolf wrote:
>Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
>> timer_cb() needs to know about the current Aio context of the throttle
>> request that is woken up. In order to make ThrottleGroupMember backend
>> agnostic, this information is stored in an aio_context field instead of
>> accessing it from BlockBackend.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>
>You're copying the AioContext when the BlockBackend is registered for
>the throttle group, but what keeps both sides in sync when the context
>is changed later on? Don't we need to update the ThrottleGroupMember in
>blk_set_aio_context?

blk_set_aio_context calls throttle_timers_attach_aio_context which=20
updates this. Though as Alberto said util/throttle.c should not know=20
about ThrottleGroupMember. This is not needed in the later patches=20
because the ThrottleGroupMember's aio_context gets updated as a node in=20
the driver's bdrv_attach_aio_context

We can add a new function in block/throttle.c that updates a member's=20
aio context but I'm not sure if it's really needed if members are only=20
used in throttle nodes.

--7al5muedogfcc3pt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllTneIACgkQc2J8L2kN
9xDX8g//VozmMZe5L4LdCmH7ygtcDqgmPXtpDiBTDhdutWnKhVEsCmb3dMW2p7M3
nU4tL14hNiWBHvEcCSUkBfdjHgrAX46gg5imrkwWUbVQ+gLRHkEIIOh0CL9hP7/L
TzU5GRRYLEu3lkY3MWseUU8cUw+s7HzDeRjKaSVvVvaNvOK0nn/iVAN+/obyuehy
XvsL32ZTEURBiDtb5acLU+SVtTRcIz4s94ccuB4NDIKDdwGK80ukQbWjHcmVfHXF
/JDxKeT3OyXxLaqmtVkIGjmvAEqT/EFuYtSEeNrwZcgJ7UnvESdG8KERGR06nTWB
DnNh7FB0b2e3AEe4vGxda0RYr/FVFZsgF3AOz6FIno5ddU+4j010T+WExIOb849n
HNeyoUiiXtUu+F4uB2ipKSAdWMDwZ1Z2hGM0dTE/rQ828MmmzcuzJHQnUC3lY5SX
FaJk5RL30MImolHO+U14icVnMkWqgwMXOd58J5yHRZbx/d9VB4tvgRDlEuh4+Bzc
1fnir4YU3EAymvVDcdNFbTRvmAXoGyYJ83Y7bCGCtR8vUWm6bImXfHh6+2JFjb3S
PAmmCjRwQPK9KNrf531XVr3BS9OnKsaoL12fMZcWkiB1OdgVSlHYwg5GOo/U1AVH
uSonobUm9+fZBgOcQbxZq70NDoIcqlAZhpGSqUden+eEBhmVrco=
=DkkH
-----END PGP SIGNATURE-----

--7al5muedogfcc3pt--
