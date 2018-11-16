Received: from eggs.gnu.org ([2001:4830:134:3::10]:52187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNehz-0005S4-J3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNehr-0004SG-KQ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 09:02:54 -0500
References: <20181011072135.588-1-famz@redhat.com>
	<20181011072135.588-3-famz@redhat.com>
	<w51tvkjkbmc.fsf@maestria.local.igalia.com>
	<8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
	<w51lg5tunti.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1baf27e0-fa37-0d84-5d08-c4dcd788a67e@redhat.com>
Date: Fri, 16 Nov 2018 15:02:26 +0100
MIME-Version: 1.0
In-Reply-To: <w51lg5tunti.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UnIvRHo1byuQxNWfUCmALd7dNvpp5dlxq"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 2/3] file-posix: Drop
 s->lock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UnIvRHo1byuQxNWfUCmALd7dNvpp5dlxq
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <1baf27e0-fa37-0d84-5d08-c4dcd788a67e@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 2/3] file-posix: Drop s->lock_fd
References: <20181011072135.588-1-famz@redhat.com>
 <20181011072135.588-3-famz@redhat.com>
 <w51tvkjkbmc.fsf@maestria.local.igalia.com>
 <8924431e-f533-70bc-4efa-848f9641fbc4@redhat.com>
 <w51lg5tunti.fsf@maestria.local.igalia.com>
In-Reply-To: <w51lg5tunti.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.11.18 14:58, Alberto Garcia wrote:
> On Fri 16 Nov 2018 02:34:25 PM CET, Max Reitz wrote:
>> To me that looks like a problem in the general reopen code.
>> raw_reopen_prepare() is called and succeeds.  Then
>> bdrv_reopen_prepare() notices the option wasn't handled and therefore
>> fails.  bdrv_reopen_multiple() thus doesn't set bs_entry->prepared to
>> true, which means raw_reopen_abort() won't be called.
>>
>> We should always call either BlockDriver.bdrv_reopen_commit() or
>> BlockDriver.bdrv_reopen_abort() when BlockDriver.bdrv_reopen_prepare()=

>> succeeded.
>=20
> So you mean getting rid of BlockReopenQueueEntry.prepared altogether?

I mean just calling .bdrv_reopen_abort() in bdrv_reopen_prepare() if
there was an error after .bdrv_reopen_prepare() succeeded.

I have a patch, I'm just trying to think of a useful test...

Max


--UnIvRHo1byuQxNWfUCmALd7dNvpp5dlxq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvuzfIACgkQ9AfbAGHV
z0BXUwf/X6m/FaeJKmU6gOCEUpI7FiuQNHFaElPW3yY2dmr9JoK9YmsD5yuQxLE+
Mi+IFoa8FlPc5Y6zkzeR17DGOeFBdeI5CMXIqM33xt055M3pLjcrIXMqbZ2/t5JE
rZTDv+fd9CsUEcJcY/wyJ6G/+Xpcr+NILKR1oWKBVP788Og8EJgLXzRdnz4oCLmT
HVvdyUkmuRtBBLDNBX7gQ9nEypjVT/IRHiUjN8b59y23077buO+0XbAxmleqpRbw
/wKKlRDIbMDDVSeNs/CblSfRX+0v00OCYmvd8vmCj1IUSRSc7dWs8xEvqOyOp+DT
/dirI5l5oW5oeAUo9hZduxMSA7Zc3A==
=1Z3F
-----END PGP SIGNATURE-----

--UnIvRHo1byuQxNWfUCmALd7dNvpp5dlxq--
