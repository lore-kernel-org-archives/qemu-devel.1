Received: from eggs.gnu.org ([2001:4830:134:3::10]:60347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcEHb-0004z8-5t
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dcEHZ-00042e-PO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 13:15:07 -0400
Date: Mon, 31 Jul 2017 13:14:53 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170731171453.GE26485@localhost.localdomain>
References: <20170731162641.24160-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170731162641.24160-1-stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, eblake@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

On Mon, Jul 31, 2017 at 05:26:41PM +0100, Stefan Hajnoczi wrote:
> There is not much getting started documentation for qemu-iotests.  This
> patch explains how to create a new test and covers the overall testing
> approach.
>=20
> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>



Reviewed-by: Jeff Cody <jcody@redhat.com>



> ---
> v3:
>  * Explicitly mention source and build trees so that out-of-tree builds
>    work [Peter]
>  * Mention common.qemu library for bash tests [Jeff]
> v2:
>  * Added missing "touch <test-number>.out" step [Kevin]
>  * Added reference to SubmitAPatch wiki page [Eric & Philippe]
> ---
>  tests/qemu-iotests/README | 109 ++++++++++++++++++++++++++++++++++++++=
++++++--
>  1 file changed, 106 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
> index 6079b401ae..6c71f9005c 100644
> --- a/tests/qemu-iotests/README
> +++ b/tests/qemu-iotests/README
> @@ -10,12 +10,115 @@ but no actual block drivers like ide, scsi or virt=
io.
> =20
>  * Usage
> =20
> -Just run ./check to run all tests for the raw image format, or ./check
> --qcow2 to test the qcow2 image format.  The output of ./check -h expla=
ins
> -additional options to test further image formats or I/O methods.
> +Just run ./check from the build tree to run all tests for the raw imag=
e format,
> +or ./check -qcow2 to test the qcow2 image format.  The output of ./che=
ck -h
> +explains additional options to test further image formats or I/O metho=
ds.
> +
> +* Testing approach
> +
> +Each test is an executable file (usually a bash script) that is run by=
 the
> +./check test harness.  Standard out and standard error are captured to=
 an
> +output file.  If the output file differs from the "golden master" outp=
ut file
> +for the test then it fails.
> +
> +Tests are simply a sequence of commands that produce output and the te=
st itself
> +does not judge whether it passed or failed.  If you find yourself writ=
ing
> +checks to determine success or failure then you should rethink the tes=
t and
> +rely on output diffing instead.
> +
> +** Filtering volatile output
> +
> +When output contains absolute file paths, timestamps, process IDs, hos=
tnames,
> +or other volatile strings, the diff against golden master output will =
fail.
> +Such output must be filtered to replace volatile strings with fixed
> +placeholders.
> +
> +For example, the path to the temporary working directory changes betwe=
en test
> +runs so it must be filtered:
> +
> +  sed -e "s#$TEST_DIR/#TEST_DIR/#g"
> +
> +Commonly needed filters are available in ./common.filter.
> +
> +** Bash tests
> +
> +Tests are usually bash scripts that perform a sequence of qemu-img and=
 qemu-io
> +commands.
> +
> +If you wish to create a test in Bash that interacts with the QMP monit=
or,
> +'common.qemu' provides functions for interacting with multiple QEMU
> +processes.
> +
> +** Python tests
> +
> +Most tests are implemented in bash but it is difficult to interact wit=
h the QMP
> +monitor.  A Python module called 'iotests' is available for tests that=
 require
> +JSON and interacting with QEMU.
> +
> +* How to create a test
> +
> +1. Choose an unused test number
> +
> +Tests are identified by a unique number.  Look for the highest test ca=
se number
> +by looking at the test files.  Then search the qemu-devel@nongnu.org m=
ailing
> +list to check if anyone has already sent patches using the next availa=
ble
> +number.  You may need to increment the number a few times to reach an =
unused
> +number.
> +
> +2. Create the test file
> +
> +Copy an existing test (one that most closely resembles what you wish t=
o test)
> +to the new test number in the source tree:
> +
> +  cp 001 <test-number>
> +
> +3. Assign groups to the test
> +
> +Add your test to the ./group file.  This file is the index of tests an=
d assigns
> +them to functional groups like "rw" for read-write tests.  Most tests =
belong to
> +the "rw" and "auto" groups.  "auto" means the test runs when ./check i=
s invoked
> +without a -g argument.
> +
> +Consider adding your test to the "quick" group if it executes quickly =
(<1s).
> +This group is run by "make check-block" and is often included as part =
of build
> +tests in continuous integration systems.
> +
> +4. Write the test
> +
> +Edit the test script.  Look at existing tests for examples.
> +
> +5. Generate the golden master file
> +
> +Create an empty golden master file in the source tree:
> +
> +  touch <test-number>.out
> +
> +Then run your test from the build tree:
> +
> +  ./check <test-number>
> +
> +You may need additional command-line options to use an image format or
> +protocol like -qcow2.
> +
> +The test will fail because there is no golden master yet.  Inspect the=
 output
> +that your test generated with "cat <test-number>.out.bad".
> +
> +Verify that the output is as expected and contains no volatile strings=
 like
> +timestamps.  You may need to add filters to your test to remove volati=
le
> +strings.
> +
> +Once you are happy with the test output it can be used as the golden m=
aster
> +with "mv <test-number>.out.bad <test-number>.out".  Rerun the test to =
verify
> +that it passes.
> +
> +Congratulations, you've created a new test!
> +
> +To contribute your test to qemu.git please follow the guidelines here:
> +http://wiki.qemu.org/Contribute/SubmitAPatch
> =20
>  * Feedback and patches
> =20
>  Please send improvements to the test suite, general feedback or just
>  reports of failing tests cases to qemu-devel@nongnu.org with a CC:
>  to qemu-block@nongnu.org.
> +
> --=20
> 2.13.3
>=20
