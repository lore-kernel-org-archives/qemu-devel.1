Received: from eggs.gnu.org ([209.51.188.92]:44281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJOvJ-0001BH-IM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 16:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJOiy-0006Ft-Ly
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 16:42:37 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6b284aaa-353c-92c1-b01b-21882e7ff9ef@redhat.com>
Date: Wed, 24 Apr 2019 17:42:14 -0300
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-6-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

Hi Thomas,


On 04/24/2019 07:37 AM, Thomas Huth wrote:
> People often forget to run the iotests before submitting patches or
> pull requests - this is likely due to the fact that we do not run the
> tests during our mandatory "make check" tests yet. Now that we've got
> a new "ci" group of iotests that should be fine to run in every environ-
> ment, it should be OK to enable the iotests during "make check" again.
> Thus we now run the "ci" tests by default from the qemu-iotests-quick.sh
> script, and only use the former "quick" group (that contains some tests
> that are failing in some environments) when the user decided to run
> "make check SPEED=thorough" or something similar.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include      |  2 +-
>   tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
>   2 files changed, 17 insertions(+), 2 deletions(-)

One of Patchew's runners failed with this patch series:
https://patchew.org/QEMU/20190424103747.10173-1-thuth@redhat.com/

I encountered same failures with `make check` locally on Fedora 29 
x86_64 (pulled latest qemu, and configured with defaults and 
x86_64-softmmu target):
---
Not run: 233
Failures: 069 103 114 133 140 143 197 215 226 244
Failed 10 of 91 tests
---

Let me know if you need more details.

- Wainer

>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 36fc73fef5..eb6a7a41e2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1168,7 +1168,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>   check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
>   check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>   check-block: $(patsubst %,check-%, $(check-block-y))
> -check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
> +check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree check-block
>   check-clean:
>   	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>   	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
> index 0e554bb972..416b3fc48b 100755
> --- a/tests/qemu-iotests-quick.sh
> +++ b/tests/qemu-iotests-quick.sh
> @@ -1,8 +1,23 @@
>   #!/bin/sh
>   
> +# Honor the SPEED environment variable, just like we do it for the qtests.
> +# The default is to run all tests that still work fine in a CI environments,
> +# but if the user set SPEED=slow or SPEED=thorough, we also run all other
> +# tests that are still marked as "quick"
> +if [ "$SPEED" = "slow" -o "$SPEED" = "thorough" ]; then
> +    group=quick
> +else
> +    group=ci
> +fi
> +
> +if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +    echo "No qemu-system binary available. Skipped qemu-iotests."
> +    exit 0
> +fi
> +
>   cd tests/qemu-iotests
>   
>   ret=0
> -TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g quick || ret=1
> +TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g "$group" || ret=1
>   
>   exit $ret
