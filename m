Received: from eggs.gnu.org ([2001:4830:134:3::10]:51333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEup5-0002Xp-K9
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEup2-0004TB-Cl
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eEup2-0004Qw-3w
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:21:32 -0500
Date: Wed, 15 Nov 2017 10:21:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171115102116.GD8130@stefanha-x1.localdomain>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-28-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <20171106094643.14881-28-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 27/27] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 06, 2017 at 05:46:43PM +0800, Peter Xu wrote:
> +    /*
> +     * Try a time-consuming command, following by a OOB command, make
> +     * sure we get OOB command before the time-consuming one (which is
> +     * run in the parser).
> +     *
> +     * When writting up this test script, the only command that
> +     * support OOB is migrate-incoming.  It's not the best command to
> +     * test OOB but we don't really have a choice here.  We will check
> +     * arriving order but not command errors, which does not really
> +     * matter to us.
> +     */
> +    qmp_async("{ 'execute': 'dump-guest-memory',"
> +              "  'arguments': { 'paging': true, "
> +              "                 'protocol': 'file:/dev/null' }, "
> +              "  'id': 'time-consuming-cmd'}");
> +    qmp_async("{ 'execute': 'migrate-incoming', "
> +              "  'control': { 'run-oob': true }, "
> +              "  'id': 'oob-cmd' }");
> +
> +    /* Ignore all events.  Wait for 2 acks */
> +    while (acks < 2) {
> +        resp = qmp_receive();
> +        if (qdict_haskey(resp, "event")) {
> +            /* Skip possible events */
> +            continue;
> +        }
> +        cmd_id = qdict_get_str(resp, "id");
> +        if (acks == 0) {
> +            /* Need to receive OOB response first */
> +            g_assert_cmpstr(cmd_id, ==, "oob-cmd");
> +        } else if (acks == 1) {
> +            g_assert_cmpstr(cmd_id, ==, "time-consuming-cmd");
> +        }
> +        acks++;
> +    }

This test is non-deterministic.  The dump-guest-memory command could
complete first on a fast machine.

On a slow machine this test might take a long time...

Please introduce a test command that is deterministic.  For example,
when 'x-oob-test' is invoked without 'run-oob': true it waits until
invoked again, this time with 'run-oob': true.

We have similar interfaces in the block layer for controlling the order
in which parallel I/O requests are processed.  This allows test cases to
deterministically take specific code paths.

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaDBUcAAoJEJykq7OBq3PIz+sIALO9G2Mlc1SfXs6SbXV/WLH0
WWEjPZraGNk12/5GE7+O/sZ684d+XVKn5HwpNd8eWWRUQ7ftaDCMsV2GbSgHXNLb
EdA0c7T5dkgsr2BBtIVRRj3adoDLVXAbZG/tuS5wOKksL8dYdqBzMnbIfJOsb/hU
yACwuLjk6Ex/VkidexjZxQ5aAFpIlJALyquqQa4h0aAevvxufieSaDgBw0UcdXVR
617Uu9qNIZbVefnrzYemkackCY+Z4WaygQTPIcmnWH7ZbyqTfq0hLVHc5+K+4FDh
2lippYWuon3iKmy6TlbtnGxYpbDD41x7vZ3Xvb4GMfVKJdB9o6j5Muzy1PSEnFI=
=bavv
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
