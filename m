Received: from eggs.gnu.org ([2001:4830:134:3::10]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePAh7-0003vH-3T
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePAh3-0000w5-V0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:19:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePAh3-0000vU-OB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:19:41 -0500
Date: Wed, 13 Dec 2017 17:19:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213171934.GC8317@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-13-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 12/26] qmp: negociate QMP capabilities
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


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:46PM +0800, Peter Xu wrote:
> @@ -1037,8 +1038,42 @@ static void monitor_init_qmp_commands(void)
>                           qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
>  }
> =20
> -void qmp_qmp_capabilities(Error **errp)
> +static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
> +                           Error **errp)
> +{
> +    for (; list; list =3D list->next) {
> +        assert(list->value < QMP_CAPABILITY__MAX);
> +        switch (list->value) {
> +        case QMP_CAPABILITY_OOB:
> +            if (!mon->use_io_thr) {
> +                /*
> +                 * Out-Of-Band only works with monitors that are
> +                 * running on dedicated IOThread.
> +                 */
> +                error_setg(errp, "This monitor does not support "
> +                           "Out-Of-Band (OOB)");
> +                return;
> +            }
> +            break;

QEMU always offers the 'oob' capability, even if the monitor does not
support it.  Should it send 'oob' only when mon->use_io_thr to make
things easier for clients?

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMWElAAoJEJykq7OBq3PICTMH+wVW7GXCynLn3cbOhrpJTiqi
kA+Bd6k31CqevvVwoH1U1jGeRx4663Thf40ur5Ptr4M00hNYKreO7eU099d4TZhy
52VcF+SQbJsnGm792OGsAnbNct73KviXAYzTTfCbIP/bkBI52NfrvQOlxo2GPmaw
Q4bnazQWfTy2x4DJYEhPnAHf7l5WemqPahzmA4UTNKsIMV+GJV8tfgD4QP/lmN8n
Bte56PAvpppbxcqyPWbUvlFi5n3t7z54xh5TlP+1SjIwe1reB3JbiHzGHdxmhDEm
CsjnmtCGvPi/3amHRVcXgkE9+mFgASEWWIwlde6mjbc4/Q1saSz7FFdZTwQ2jO0=
=PQT/
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
