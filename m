Received: from eggs.gnu.org ([2001:4830:134:3::10]:47197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhXDM-0004lD-DX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhXDJ-0006AU-8s
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhXDJ-0006AD-2Y
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:28:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1671C7791F
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:28:36 +0000 (UTC)
Date: Tue, 15 Aug 2017 09:28:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170815082834.GC32702@stefanha-x1.localdomain>
References: <20170814162142.29666-1-stefanha@redhat.com>
	<20170814163908.GG8506@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20170814163908.GG8506@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] trace: fix simpletrace.stp
 flight recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 05:39:08PM +0100, Daniel P. Berrange wrote:
> On Mon, Aug 14, 2017 at 05:21:40PM +0100, Stefan Hajnoczi wrote:
> > The SystemTap flight recorder mode no longer works with simpletrace.stp=
 because
> > the event ID mapping records are emitted the first time an event fires.
> > Chances are, the event ID mapping record will not be in ring buffer whe=
n the
> > users wants to print the trace.
> >=20
> > This series solves the issue by using the trace-events-all global event
> > ordering for event IDs for simpletrace.stp.
>=20
> I see the way you've written it means it'll still honour the event
> id mappings in the header, if present, but I wonder what's the point
> of keeping that anymore ? If we need to support this ring-buffer mode,
> there's no way we can take advantage of having the ID mappings dynamically
> defined - we must always guarantee a stable mapping.
>=20
> IOW, should we just revert
>=20
>   commit 7f1b588f20d027730676e627713ae3bbf6baab04
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Tue Oct 4 14:35:50 2016 +0100
>=20
>     trace: emit name <-> ID mapping in simpletrace header
>    =20
> entirely ?

Follow-up to my reply:

We can revert just the changes to simpletrace_stap.py.  This means:

1. Event ID mapping records are no longer emitted.
2. No simpletrace file header is emitted.

I like this idea because it's simpler than my current patch.  Users will
have to use the ./simpletrace.py --no-header option again when printing
simpletrace.stp traces, but that isn't a problem.

Stefan

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZkrCyAAoJEJykq7OBq3PI5Q4H/i9hJpihKCOZg83ryvV5fM+y
Qp2hkkhNVlgk8PQNGgLsum0nuIBD8W7vxdzocO283Pofu0UiMo93ZRezH+dekmuR
1aAdPTCy/2SyzVUYjNT5VQEiHB49OTr88QgtisW/OUin25hPSVh3Svl/K8eFxADN
63AhAtMvBFdCF4Fpnjyyjn/ZH+cZgz2Wu0QpnSfTHLgkX+eieXeYlTz9KB7H1MPV
9+gENgWufRVUCBdqew2jRJZUyig3LBQkKpzhQuJEdFnCYwtDuOHGDVbUeoOVrSmh
LQ8BAz0WoV0Ek5oFpS0bUytAsZIqPkPJyybK4jSpyFgzTpihzRAWoS2db3BK7Is=
=8x++
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
