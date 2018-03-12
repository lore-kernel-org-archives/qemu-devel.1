Received: from eggs.gnu.org ([2001:4830:134:3::10]:41989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evS6J-0002T8-Mg
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evS6G-0000BV-Hu
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evS6G-0000B9-CC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:23:08 -0400
Date: Mon, 12 Mar 2018 15:23:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180312182305.GC28578@localhost.localdomain>
References: <20180309202827.12085-1-ehabkost@redhat.com>
	<20180309202827.12085-9-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309202827.12085-9-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] tests: Run device-crash-test on "make
 check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Mar 09, 2018 at 05:28:27PM -0300, Eduardo Habkost wrote:
> Run a subset of tests using device-crash-test on "make check", to
> help us catch device crashes earlier.
> 
> This also add a "check-device-crash-test-full" rule, that will
> check all machine/device combinations.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/Makefile.include | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ef9b88c369..0ba641b8d4 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -942,6 +942,17 @@ check-decodetree:
>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
>            TEST, decodetree.py)
>  
> +CRASH_TEST = $(SRC_PATH)/scripts/device-crash-test
> +CRASH_TEST_OPTIONS = $(if $(V),-v,-q)
> +CRASH_TEST_BINARIES = $(foreach TARGET,$(TARGETS), $(TARGET)-softmmu/qemu-system-$(TARGET))
> +
> +.PHONY: check-device-crash-quick
> +check-device-crash-quick:
> +	$(CRASH_TEST) $(CRASH_TEST_OPTIONS) -t machine=DEFAULT accel=tcg -- $(CRASH_TEST_BINARIES)
> +
> +check-device-crash-full:
> +	$(CRASH_TEST) $(CRASH_TEST_OPTIONS) -F $(CRASH_TEST_BINARIES)
> +
>  # Consolidated targets
>  
>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
> @@ -950,7 +961,7 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  check-unit: $(patsubst %,check-%, $(check-unit-y))
>  check-speed: $(patsubst %,check-%, $(check-speed-y))
>  check-block: $(patsubst %,check-%, $(check-block-y))
> -check: check-qapi-schema check-unit check-qtest check-decodetree
> +check: check-qapi-schema check-unit check-qtest check-decodetree check-device-crash-quick

Making device-crash-test work with Python 3 will take more work
than I have expected, so I won't try to include it on "make
check" yet.

I will send a version that only adds the "check-device-crash-*"
rules, so people can start running "make check-device-crash-quick"
on their scripts if they know the host has Python 2.7 available.

-- 
Eduardo
