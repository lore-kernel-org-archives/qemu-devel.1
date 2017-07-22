Received: from eggs.gnu.org ([2001:4830:134:3::10]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dYqKY-0000iq-PP
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dYqKX-0002c0-He
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:04:10 -0400
Date: Sat, 22 Jul 2017 12:03:47 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170722090347.su6o6xz542p73ghq@postretch>
References: <20170721093416.17816-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmlzctybx54lq3ag"
Content-Disposition: inline
In-Reply-To: <20170721093416.17816-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: add a "how to"
 to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-block@nongnu.org


--bmlzctybx54lq3ag
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 10:34:16AM +0100, Stefan Hajnoczi wrote:
>There is not much getting started documentation for qemu-iotests.  This
>patch explains how to create a new test and covers the overall testing
>approach.
>
>Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> tests/qemu-iotests/README | 83 ++++++++++++++++++++++++++++++++++++++++++=
+++++
> 1 file changed, 83 insertions(+)
>
>diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
>index 6079b40..8259b9f 100644
>--- a/tests/qemu-iotests/README
>+++ b/tests/qemu-iotests/README
>@@ -14,8 +14,91 @@ Just run ./check to run all tests for the raw image for=
mat, or ./check
> -qcow2 to test the qcow2 image format.  The output of ./check -h explains
> additional options to test further image formats or I/O methods.
>
>+* Testing approach
>+
>+Each test is an executable file (usually a bash script) that is run by the
>+./check test harness.  Standard out and standard error are captured to an
>+output file.  If the output file differs from the "golden master" output =
file
>+for the test then it fails.
>+
>+Tests are simply a sequence of commands that produce output and the test =
itself
>+does not judge whether it passed or failed.  If you find yourself writing
>+checks to determine success or failure then you should rethink the test a=
nd
>+rely on output diffing instead.
>+
>+** Filtering volatile output
>+
>+When output contains absolute file paths, timestamps, process IDs, hostna=
mes,
>+or other volatile strings, the diff against golden master output will fai=
l.
>+Such output must be filtered to replace volatile strings with fixed
>+placeholders.
>+
>+For example, the path to the temporary working directory changes between =
test
>+runs so it must be filtered:
>+
>+  sed -e "s#$TEST_DIR/#TEST_DIR/#g"
>+
>+Commonly needed filters are available in ./common.filter.
>+
>+** Python tests
>+
>+Most tests are implemented in bash but it is difficult to interact with t=
he QMP
>+monitor.  A Python module called 'iotests' is available for tests that re=
quire
>+JSON and interacting with QEMU.
>+
>+* How to create a test
>+
>+1. Choose an unused test number
>+
>+Tests are identified by a unique number.  Look for the highest test case =
number
>+by looking at the test files.  Then search the qemu-devel@nongnu.org mail=
ing
>+list to check if anyone has already sent patches using the next available
>+number.  You may need to increment the number a few times to reach an unu=
sed
>+number.
>+
>+2. Create the test file
>+
>+Copy an existing test (one that most closely resembles what you wish to t=
est)
>+to the new test number:
>+
>+  cp 001 <test-number>
>+
>+3. Assign groups to the test
>+
>+Add your test to the ./group file.  This file is the index of tests and a=
ssigns
>+them to functional groups like "rw" for read-write tests.  Most tests bel=
ong to
>+the "rw" and "auto" groups.  "auto" means the test runs when ./check is i=
nvoked
>+without a -g argument.
>+
>+Consider adding your test to the "quick" group if it executes quickly (<1=
s).
>+This group is run by "make check-block" and is often included as part of =
build
>+tests in continuous integration systems.
>+
>+4. Write the test
>+
>+Edit the test script.  Look at existing tests for examples.
>+
>+5. Generate the golden master file
>+
>+Run your test with "./check <test-number>".  You may need to pass additio=
nal
>+options to use an image format or protocol.
>+
>+The test will fail because there is no golden master yet.  Inspect the ou=
tput
>+that your test generated with "cat <test-number>.out.bad".
>+
>+Verify that the output is as expected and contains no volatile strings li=
ke
>+timestamps.  You may need to add filters to your test to remove volatile
>+strings.
>+
>+Once you are happy with the test output it can be used as the golden mast=
er
>+with "mv <test-number>.out.bad <test-number>.out".  Rerun the test to ver=
ify
>+that it passes.
>+
>+Congratulations, you've created a new test!
>+
> * Feedback and patches
>
> Please send improvements to the test suite, general feedback or just
> reports of failing tests cases to qemu-devel@nongnu.org with a CC:
> to qemu-block@nongnu.org.
>+
>--=20
>2.9.4
>
>
>

It is mentioned in the existing README that ./check runs just the raw=20
format but it might be a good idea to mention that it's the default in=20
the Howto as well. For this patch though:
Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

While we're on the topic of qemu-iotests, it'd be a nice thing to=20
parallelize the tests with a Makefile.

--bmlzctybx54lq3ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllzFPMACgkQc2J8L2kN
9xAeiw//UqjH7QmR61Q8ldcaXf4fcC/1AIkwwBpGgoV0wiRwnrYQTlEn7N097vOl
apHm9DhO1yaZny5bjL3J5Pj0WXUcEPbzpYJpLr1660AhRbE73UVEdE8cqoIVhRkP
HxSryA8wGvZtJsmPNauDkDeUDvS+nUfc1tzZ1Pu9JLRigRwbLV4o0jeIVlZWiW7B
Fhota2QhteRE1leggOhgArQCdOhJBkqinF82sHJ44pJwQFZkk6l/euJ55NftPoOd
YXJVNw0FAV60tsr1YTQ6YXoEbcSAep6zzXoCsKD60CKH7W/VQEnDFGlbqS6JbSnd
4rIZ7BJTU8h1XQffcx5ZPda5oVs6jldYE91AbOxUJ7NsiRmfS1jnco/f3pKWNzho
dHseeo1/86KLPt3Eo/QWcecNX+3353yc1tI9lINynIvyu6DfuHlCvvXagYS3+aK9
M/ys/+9tOYtzoe9DtgHIH/KjjCuIB7O4zHwejhWqMl5vl9lA7cJ+SuSkfTiauXtn
9guAunK7R8k5CfkrO3w1lA8Tp/8gVrsBdm/N1HPK9oi7suyTlkYVzV8cDct3msGb
8+UyNM48a55Awar95iL5xU9n/X20BG0vQlyvZXkWzM/wbuYaFzUQh7oyb8gTIGvL
gv5ca9TjiOYzEIKtUFIdrcyFjejCk49SuCA7ZBKna3pSefQcNOA=
=PAm6
-----END PGP SIGNATURE-----

--bmlzctybx54lq3ag--
