Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esoZ5-0007cL-AL
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esoZ4-0006vJ-Gd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:45:59 -0500
Date: Mon, 5 Mar 2018 11:45:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180305114533.GI7910@stefanha-x1.localdomain>
References: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <c0d7b993-b3b8-a753-21f5-e2257de27caf@kamp.de>
Subject: Re: [Qemu-devel] block migration and MAX_IN_FLIGHT_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, wency@cn.fujitsu.com, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 12:13:50PM +0100, Peter Lieven wrote:
> I stumbled across the MAX_INFLIGHT_IO field that was introduced in 2015 a=
nd was curious what was the reason
> to choose 512MB as readahead? The question is that I found that the sourc=
e VM gets very unresponsive I/O wise
> while the initial 512MB are read and furthermore seems to stay unreaspons=
ive if we choose a high migration speed
> and have a fast storage on the destination VM.
>=20
> In our environment I modified this value to 16MB which seems to work much=
 smoother. I wonder if we should make
> this a user configurable value or define a different rate limit for the b=
lock transfer in bulk stage at least?

I don't know if benchmarks were run when choosing the value.  From the
commit description it sounds like the main purpose was to limit the
amount of memory that can be consumed.

16 MB also fulfills that criteria :), but why is the source VM more
responsive with a lower value?

Perhaps the issue is queue depth on the storage device - the block
migration code enqueues up to 512 MB worth of reads, and guest I/O has
to wait?

Stefan

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanS3dAAoJEJykq7OBq3PItdcIAIqRmz4VPTNofM0sVL8AB5hv
SI6hedno+0XwlWmOS37vpVlfMnGF4RRBvSVGdlmjjEyQRORfHhArFIu63qe1knoq
c7L78KAdhKUjz6JtTAu5YznSjSX8NVGJG81OU3sla3WLnUcki6YVfvWCqd8Z8eaZ
fgNBLxyao80dIx7hll2a0VAi7a41hdrnzS4HkH8PT5whE9haZ776PHci3GoWfyHp
aBWOIVkdjs9eQlvQ1ag2GtNoy1r8gDbiWWN3ponuIikvhnDUAa3RaC6Qp9Djq2bc
oWW3n4onbIMaV1K1QLDlucnOvxeS71pDhRLVai7d/rYIHhl7u3Auv7kFLv9mafM=
=2pxa
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
