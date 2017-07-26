Received: from eggs.gnu.org ([2001:4830:134:3::10]:34498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1daRGQ-0007oA-ML
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1daRGP-0007qY-Ah
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:42:30 -0400
Date: Wed, 26 Jul 2017 14:42:17 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170726184217.GE6240@localhost.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

On Fri, Jul 21, 2017 at 10:34:16AM +0100, Stefan Hajnoczi wrote:
> There is not much getting started documentation for qemu-iotests.  This
> patch explains how to create a new test and covers the overall testing
> approach.
> 
> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/README | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/tests/qemu-iotests/README b/tests/qemu-iotests/README
> index 6079b40..8259b9f 100644
> --- a/tests/qemu-iotests/README
> +++ b/tests/qemu-iotests/README
> @@ -14,8 +14,91 @@ Just run ./check to run all tests for the raw image format, or ./check
>  -qcow2 to test the qcow2 image format.  The output of ./check -h explains
>  additional options to test further image formats or I/O methods.
>  
> +* Testing approach
> +
> +Each test is an executable file (usually a bash script) that is run by the
> +./check test harness.  Standard out and standard error are captured to an
> +output file.  If the output file differs from the "golden master" output file
> +for the test then it fails.
> +
> +Tests are simply a sequence of commands that produce output and the test itself
> +does not judge whether it passed or failed.  If you find yourself writing
> +checks to determine success or failure then you should rethink the test and
> +rely on output diffing instead.
> +
> +** Filtering volatile output
> +
> +When output contains absolute file paths, timestamps, process IDs, hostnames,
> +or other volatile strings, the diff against golden master output will fail.
> +Such output must be filtered to replace volatile strings with fixed
> +placeholders.
> +
> +For example, the path to the temporary working directory changes between test
> +runs so it must be filtered:
> +
> +  sed -e "s#$TEST_DIR/#TEST_DIR/#g"
> +
> +Commonly needed filters are available in ./common.filter.
> +
> +** Python tests
> +
> +Most tests are implemented in bash but it is difficult to interact with the QMP
> +monitor.  A Python module called 'iotests' is available for tests that require
> +JSON and interacting with QEMU.
> +

There are some that prefer the bash tests still, and we do have a 'standard'
way to do so... so perhaps add as well:


** Bash tests

If you wish to create a test in Bash that interacts with the QMP monitor,
'common.qemu' provides functions for interacting with multiple QEMU
processes.


> +* How to create a test
> +
> +1. Choose an unused test number
> +
> +Tests are identified by a unique number.  Look for the highest test case number
> +by looking at the test files.  Then search the qemu-devel@nongnu.org mailing
> +list to check if anyone has already sent patches using the next available
> +number.  You may need to increment the number a few times to reach an unused
> +number.
> +
> +2. Create the test file
> +
> +Copy an existing test (one that most closely resembles what you wish to test)
> +to the new test number:
> +
> +  cp 001 <test-number>
> +
> +3. Assign groups to the test
> +
> +Add your test to the ./group file.  This file is the index of tests and assigns
> +them to functional groups like "rw" for read-write tests.  Most tests belong to
> +the "rw" and "auto" groups.  "auto" means the test runs when ./check is invoked
> +without a -g argument.
> +
> +Consider adding your test to the "quick" group if it executes quickly (<1s).
> +This group is run by "make check-block" and is often included as part of build
> +tests in continuous integration systems.
> +
> +4. Write the test
> +
> +Edit the test script.  Look at existing tests for examples.
> +
> +5. Generate the golden master file
> +
> +Run your test with "./check <test-number>".  You may need to pass additional
> +options to use an image format or protocol.
> +
> +The test will fail because there is no golden master yet.  Inspect the output
> +that your test generated with "cat <test-number>.out.bad".
> +
> +Verify that the output is as expected and contains no volatile strings like
> +timestamps.  You may need to add filters to your test to remove volatile
> +strings.
> +
> +Once you are happy with the test output it can be used as the golden master
> +with "mv <test-number>.out.bad <test-number>.out".  Rerun the test to verify
> +that it passes.
> +
> +Congratulations, you've created a new test!
> +
>  * Feedback and patches
>  
>  Please send improvements to the test suite, general feedback or just
>  reports of failing tests cases to qemu-devel@nongnu.org with a CC:
>  to qemu-block@nongnu.org.
> +
> -- 
> 2.9.4
> 
> 
