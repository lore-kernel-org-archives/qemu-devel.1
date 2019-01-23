Received: from eggs.gnu.org ([209.51.188.92]:33772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmLta-0007TN-T4
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmLtZ-0006Uq-7E
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:00:58 -0500
From: Max Reitz <mreitz@redhat.com>
Message-ID: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
Date: Wed, 23 Jan 2019 18:00:49 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q7J1XRd6HpBUT9SWtMqSS958W5chDoTXS"
Subject: [Qemu-devel] Consistency of iotests 093 and 136
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q7J1XRd6HpBUT9SWtMqSS958W5chDoTXS
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <271482fe-741a-6a15-15fd-181d4e55a8c4@redhat.com>
Subject: Consistency of iotests 093 and 136
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

093 and 136 seem really flaky to me.  I can reproduce that by running:

$ dd if=3D/dev/urandom of=3D/dev/null

in as many shells as I have CPU cores, and then run the tests:

$ while TEST_DIR=3D/tmp/t0 ./check -T -raw 93; do; done

or

$ while TEST_DIR=3D/tmp/t0 ./check -T -raw 136; do; done

which usually fail after one or two iterations.


The exact failures vary, but for 093 it's usually something that ends wit=
h:

[...]
    self.assertTrue(check_limit(params['iops'], rd_iops + wr_iops))
AssertionError: False is not true

Or:

[...]
    self.assertTrue(check_limit(params['iops_rd'], rd_iops))
AssertionError: False is not true

etc. -- so the 10 % error range doesn't seem to be enough, I'd say.  But
will just increasing it solve the problem?


And for 136 it's usually (always?):

[...]
  File "136", line 278, in do_test_stats
    self.check_values()
  File "136", line 204, in check_values
    self.assertLess(0, stats['idle_time_ns'])
AssertionError: 0 not less than 0


Any ideas on making these more reliable?


Max


--q7J1XRd6HpBUT9SWtMqSS958W5chDoTXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIncEACgkQ9AfbAGHV
z0CraAf+Ivty/yLCQRq4WM+PvY+j89L2ssQ4/csMC0CbUN6DNEawIS5DkArWA5QM
U/XjxwY4FlCBe4Jl2QHpopm1IUX7F4oWY/F3kKP5iLmF3hFWT2WyvRXxm5R5ihnq
aiEHNApev1bMSiR1iHO5kmFwJsdy0Rkquayd6rST2/H3m8muMStoqnvgjRQOc7gP
ONDq+iD+DrC1Rh/9V7W6WinNQkwgE4Y3D0ymCNl1do7OqpvOum4awLid4Y9BhrOL
iyFIAOeBYy3ADYEmUWziEzcVmbyQ/lZdFkm+Do3j70jl5T5SYZcdwD95IzqNMlYP
2rIpohpC3lqoDKPrhfX/ungxuJzzVg==
=3+Ab
-----END PGP SIGNATURE-----

--q7J1XRd6HpBUT9SWtMqSS958W5chDoTXS--
