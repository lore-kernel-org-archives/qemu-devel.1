Received: from eggs.gnu.org ([2001:4830:134:3::10]:57306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gErkj-0002up-Ig
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gErZY-0004i1-Da
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:57:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gErZY-0004hQ-6Z
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:57:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so686424wma.4
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:57:52 -0700 (PDT)
References: <20181018153134.8493-1-crosa@redhat.com>
	<20181018153134.8493-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a0b13130-8371-89a8-5cd1-bac7fc9d23cd@redhat.com>
Date: Tue, 23 Oct 2018 09:56:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181018153134.8493-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18/10/18 17:31, Cleber Rosa wrote:
> A number of QEMU tests are written in Python, and may benefit
> from an untainted Python venv.
> 
> By using make rules, tests that depend on specific Python libs
> can set that rule as a requirement, along with rules that require
> the presence or installation of specific libraries.
> 
> The tests/requirements.txt is supposed to contain the Python
> requirements that should be added to the venv created by check-venv.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   tests/Makefile.include | 26 ++++++++++++++++++++++++++
>   tests/requirements.txt |  3 +++
>   2 files changed, 29 insertions(+)
>   create mode 100644 tests/requirements.txt
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7fe8578972..004a86f274 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -12,6 +12,7 @@ check-help:
>   	@echo " $(MAKE) check-block          Run block tests"
>   	@echo " $(MAKE) check-tcg            Run TCG tests"
>   	@echo " $(MAKE) check-report.html    Generates an HTML test report"
> +	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>   	@echo " $(MAKE) check-clean          Clean the tests"
>   	@echo
>   	@echo "Please note that HTML reports do not regenerate if the unit tests"
> @@ -899,6 +900,30 @@ check-decodetree:
>             ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
>             TEST, decodetree.py)
>   
> +# Python venv for running tests
> +
> +.PHONY: check-venv
> +
> +TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
> +TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
> +
> +$(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
> +ifeq ($(.SHELLSTATUS),0)
> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> +	$(call quiet-command, \
> +            $(PYTHON) -m venv --system-site-packages $@, \
> +            VENV, $@)
> +	$(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV_REQ), \
> +            PIP, $(TESTS_VENV_REQ))
> +	$(call quiet-command, touch $@)
> +else
> +$(TESTS_VENV_DIR):
> +	$(error "venv directory for tests requires Python 3")
> +endif
> +
> +check-venv: $(TESTS_VENV_DIR)
> +
>   # Consolidated targets
>   
>   .PHONY: check-qapi-schema check-qtest check-unit check check-clean
> @@ -912,6 +937,7 @@ check-clean:
>   	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>   	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>   	rm -f tests/test-qapi-gen-timestamp
> +	rm -rf $(TESTS_VENV_DIR)
>   
>   clean: check-clean
>   
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> new file mode 100644
> index 0000000000..d39f9d1576
> --- /dev/null
> +++ b/tests/requirements.txt
> @@ -0,0 +1,3 @@
> +# Add Python module requirements, one per line, to be installed
> +# in the tests/venv Python virtual environment. For more info,
> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> 
