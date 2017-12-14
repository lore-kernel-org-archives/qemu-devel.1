Received: from eggs.gnu.org ([2001:4830:134:3::10]:46965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePUfv-00058w-Ab
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePUfr-0003Fb-Av
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:39:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePUfr-0003F1-3i
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:39:47 -0500
Date: Thu, 14 Dec 2017 14:39:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214143934.GN14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-26-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s8J8qjRpxLkp1Gun"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-26-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 25/26] tests: qmp-test: verify command
 batching
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


--s8J8qjRpxLkp1Gun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:59PM +0800, Peter Xu wrote:
> OOB introduced DROP event for flow control.  This should not affect old
> QMP clients.  Add a command batching check to make sure of it.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qmp-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 292c5f135a..729ec59b0a 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -78,6 +78,7 @@ static void test_qmp_protocol(void)
>      QList *capabilities;
>      const QListEntry *entry;
>      QString *qstr;
> +    int i;
> =20
>      global_qtest =3D qtest_init_without_qmp_handshake(common_args);
> =20
> @@ -135,6 +136,24 @@ static void test_qmp_protocol(void)
>      g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 2);
>      QDECREF(resp);
> =20
> +    /*
> +     * Test command batching.  In current test OOB is not enabled, we
> +     * should be able to run as many commands in batch as we like.
> +     * Using 16 (>8, which is OOB queue length) to make sure OOB
> +     * won't break existing clients.
> +     */

It's possible that QEMU processes the command and responds before the
test case submits the next one.  Please add:

  Note: this test does not control the scheduling of QEMU's QMP command
  processing threads so it may not really trigger batching inside QEMU.
  This is just a best-effort test.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--s8J8qjRpxLkp1Gun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMo0mAAoJEJykq7OBq3PInGQIAMr8mMPTDB3m97YfoBplmBZM
7dO0xT+t7DPUXuZVDdwhb88R7kb51U6GCVMWxJA6cE4vvAun4rUobjZQEu5YzcYu
RQ4fcaG5UgBeux9VGBWB/YfEVyCibjdDLtdHbAP7KbZg9FGprFHGYPI3mekSYZ2I
q1AlD8awMubs6ea+hOu5f6I4J0ow2a0MFyrC/quTztZYyQN9hujxkkRwJiY/CmmT
N0xZE9X1mQw6J4jQd8BkV6tZcPSbTxNlPH5S88mf3tLG4y4utCfVSSJz9WKPRLXu
vF0DjR3OMzw+LUoAQXVLQGtangxzVPtZ/0CdhnXbtFuKk7zp7qyW+czjeksUomU=
=gjKG
-----END PGP SIGNATURE-----

--s8J8qjRpxLkp1Gun--
