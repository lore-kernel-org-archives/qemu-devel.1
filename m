Received: from eggs.gnu.org ([2001:4830:134:3::10]:38373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da2es-0000Gw-Ty
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da2er-0001hr-Hx
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:26:06 -0400
References: <20170725153645.26412-1-stefanha@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a42739b2-23d6-17a6-8f3c-f554d262e606@redhat.com>
Date: Tue, 25 Jul 2017 12:25:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170725153645.26412-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 07/25/2017 11:36 AM, Stefan Hajnoczi wrote:
> There is not much getting started documentation for qemu-iotests.  This
> patch explains how to create a new test and covers the overall testing
> approach.
>=20
> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>   * Added missing "touch <test-number>.out" step [Kevin]
>   * Added reference to SubmitAPatch wiki page [Eric & Philippe]
> ---
>   tests/qemu-iotests/README | 94 ++++++++++++++++++++++++++++++++++++++=
+++++++++
>   1 file changed, 94 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
> index 6079b401ae..245f509b14 100644
> --- a/tests/qemu-iotests/README
> +++ b/tests/qemu-iotests/README
> @@ -14,8 +14,102 @@ Just run ./check to run all tests for the raw image=
 format, or ./check
>   -qcow2 to test the qcow2 image format.  The output of ./check -h expl=
ains
>   additional options to test further image formats or I/O methods.
>  =20
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
> +to the new test number:
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
> +Create an empty golden master file:
> +
> +  touch <test-number>.out
> +
> +Then run your test:
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
> +
>   * Feedback and patches
>  =20
>   Please send improvements to the test suite, general feedback or just
>   reports of failing tests cases to qemu-devel@nongnu.org with a CC:
>   to qemu-block@nongnu.org.
> +
>=20

Nice!

Unfortunately this does highlight how ridiculous our test number=20
procurement process is, but at least it's documented.

Reviewed-by: John Snow <jsnow@redhat.com>
