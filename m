Received: from eggs.gnu.org ([2001:4830:134:3::10]:42437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYupb-00022g-QD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYupW-0008TS-Np
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:24:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYupW-0008T7-Go
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:24:42 -0500
Date: Tue, 9 Jan 2018 14:24:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109142435.GG31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-23-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-23-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 22/27] qmp: isolate responses into io
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 19, 2017 at 04:45:52PM +0800, Peter Xu wrote:
> +static void monitor_qmp_bh_responder(void *opaque)
> +{
> +    QMPResponse response;
> +
> +    while (true) {
> +        response = monitor_qmp_response_pop_one();
> +        if (!response.data) {
> +            break;
> +        }
> +        monitor_json_emitter_raw(response.mon, response.data);

Have you audited all mon->out_lock users to ensure that guest memory is
never touched while the lock is held?

If guest memory is touched then the main loop could be blocked due to
postcopy and when the IOThread executes monitor_qmp_bh_responder() ->
monitor_json_emitter_raw() -> monitor_puts() it will also hang!

Please add a comment above the out_lock declaration letting users know
that they must not touch guest memory while holding the lock.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVNCjAAoJEJykq7OBq3PIAJ0H/1WjBGzi5lTj7Sdf+AqNoCZY
QvBGJkc38mdTMK1cCZL1EsvJ+m7jKXaFNfdEyjvI1KOCYWt3MV1e0U00dTLBBUD+
mN8G4vI/IY3UKdhcoyYz/dA+NKmdcFKtLgdm4c6gujrksMoVL42lrtJ7JpPjowMt
xcFKuhsFcOQ2rRmMYdtc4jc+0RyCqcbfGnB0pPSvfOMrWPuJE9Pm3mF1rdk/KKjm
z8+XUeoTky37SjRP4r4nwfINRSvUDEQHACFomYCzmG1nDQtDZ8rHXlAODnFQlWAf
DgKrCsIp6cEGCiaTEG2VEx9m1mJyH8dp3dUCW8f/cdafhfQxHlfW7xrPunD1yhU=
=jc6X
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
