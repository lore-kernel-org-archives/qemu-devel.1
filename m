Received: from eggs.gnu.org ([2001:4830:134:3::10]:35312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1egslx-0000iI-MM
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1egslt-0004P3-F8
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1egslt-0004ON-6o
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:49:53 -0500
Date: Wed, 31 Jan 2018 14:49:42 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180131134942.a2cupkloo4cp33bc@kamzik.brq.redhat.com>
References: <20180131032800.25578-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131032800.25578-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, thuth@redhat.com, alex.bennee@linaro.org, f4bug@amsat.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, armbru@redhat.com

On Wed, Jan 31, 2018 at 11:28:00AM +0800, Fam Zheng wrote:
> To make our efforts on QEMU testing easier to consume by contributors,
> let's add a document. For example, Patchew reports build errors on
> patches that should be relatively easy to reproduce with a few steps, and
> it is much nicer if there is such a documentation that it can refer to.
> 
> This focuses on how to run existing tests and how to write new test
> cases, without going into the frameworks themselves.
> 
> The VM based testing section is moved from tests/vm/README which now
> is a single line pointing to the new doc.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> v2: Fix spelling errors and improve wordings. [Stefan, Eric, Thomas]
>     Example test name "test-foo -> foo-test". The mass renaming will be
>     done in another series. [Thomas, Eric]
>     Document how to debug unit tests and qtests. [Eric]
>     Document group permission setup for docker, and the privilege risks.
>     [Alex]
>     Update tests/vm/README.
> ---
>  docs/devel/testing.rst | 486 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/vm/README        |  90 +--------
>  2 files changed, 487 insertions(+), 89 deletions(-)
>  create mode 100644 docs/devel/testing.rst
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> new file mode 100644
> index 0000000000..795df60dcd
> --- /dev/null
> +++ b/docs/devel/testing.rst
> @@ -0,0 +1,486 @@
> +===============
> +Testing in QEMU
> +===============
> +
> +This document describes the testing infrastructure in QEMU.
> +
> +Testing with "make check"
> +=========================
> +
> +The "make check" testing family includes most of the C based tests in QEMU. For
> +a quick help, run ``make check-help`` from the source tree.
> +
> +The usual way to run these tests is:
> +
> +.. code::
> +
> +  make check
> +
> +which includes QAPI schema tests, unit tests, and QTests. Different sub-types
> +of "make check" testings will be explained below.
> +
> +Before running tests, it is best to build QEMU programs first. Some tests
> +expect the executables to exist and will fail with obscure messages if they
> +cannot find them.
> +
> +Unit tests
> +----------
> +
> +Unit tests, which can be invoked with ``make check-unit``, are simple C tests
> +that typically link to individual QEMU object files and exercise them by
> +calling exported functions.
> +
> +If you are writing new code in QEMU, consider adding a unit test, especially
> +for utility modules that are relatively stateless or have few dependencies. To
> +add a new unit test:
> +
> +1. Create a new source file. For example, ``tests/foo-test.c``.
> +
> +2. Write the test. Normally you would include the header file which exports
> +   the module API, then verify the interface behaves as expected from your
> +   test. The test code should be organized with the glib testing framework.
> +   Copying and modifying an existing test is usually a good idea.
> +
> +3. Add the test to ``tests/Makefile.include``. First, name the unit test
> +   program and add it to ``$(check-unit-y)``; then add a rule to build the
> +   executable. Optionally, you can add a magical variable to support ``gcov``.
> +   For example:
> +
> +.. code::
> +
> +  check-unit-y += tests/foo-test$(EXESUF)
> +  tests/foo-test$(EXESUF): tests/foo-test.o $(test-util-obj-y)
> +  ...
> +  gcov-files-foo-test-y = util/foo.c
> +
> +Since unit tests don't require environment variables, the simplest way to debug
> +a unit test failure is often directly invoking it or even running it under
> +``gdb``. However there can still be differences in behavior between ``make``
> +invocations and your manual run, due to ``$MALLOC_PERTURB_`` environment
> +variable (which affects memory reclaimation and catches invalid pointers
> +better) and gtester options. If necessary, you can run
> +
> +.. code::
> +  make check-unit V=1
> +
> +and copy the actual command line which executes the unit test, then run
> +it from the command line.
> +
> +QTest
> +-----
> +
> +QTest is a device emulation testing framework.  It can be very useful to test
> +device models; it could also control certain aspects of QEMU (such as virtual
> +clock stepping), with a special purpose "qtest" protocol.  Refer to the
> +documentation in ``qtest.c`` for more details of the protocol.
> +
> +QTest cases can be executed with
> +
> +.. code::
> +
> +   make check-qtest
> +
> +The QTest library is implemented by ``tests/libqtest.c`` and the API is defined
> +in ``tests/libqtest.h``.
> +
> +Consider adding a new QTest case when you are introducing a new virtual
> +hardware, or extending one if you are adding functionalities to an existing
> +virtual device.
> +
> +On top of libqtest, a higher level library, ``libqos``, was created to
> +encapsulate common tasks of device drivers, such as memory management and
> +communicating with system buses or devices. Many virtual device tests use
> +libqos instead of directly calling into libqos.
                                           ^^ libqtest?

Thanks,
drew
