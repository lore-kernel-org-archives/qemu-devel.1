Received: from eggs.gnu.org ([2001:4830:134:3::10]:53700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9s1K-0007CJ-1M
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9s1G-0007U3-KO
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:25:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9s1G-0007KH-7c
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:25:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id l6-v6so1415211wrt.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 06:25:47 -0700 (PDT)
References: <20181009041826.19462-1-crosa@redhat.com>
	<20181009041826.19462-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55a1c7a3-0381-f426-edca-d95c04180326@redhat.com>
Date: Tue, 9 Oct 2018 15:25:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181009041826.19462-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Hi Cleber,

On 09/10/2018 06:18, Cleber Rosa wrote:
> A number of QEMU tests are written in Python, and may benefit
> from an untainted Python venv.
> 
> By using make rules, tests that depend on specific Python libs
> can set that rule as a requiment, along with rules that require
> the presence or installation of specific libraries.
> 
> The tests/venv-requirements.txt is supposed to contain the
> Python requirements that should be added to the venv created
> by check-venv.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/Makefile.include      | 19 +++++++++++++++++++
>  tests/venv-requirements.txt |  3 +++
>  2 files changed, 22 insertions(+)
>  create mode 100644 tests/venv-requirements.txt
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7a3059bf6c..68af79927d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -12,6 +12,7 @@ check-help:
>  	@echo " $(MAKE) check-block          Run block tests"
>  	@echo " $(MAKE) check-tcg            Run TCG tests"
>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
> +	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>  	@echo " $(MAKE) check-clean          Clean the tests"
>  	@echo
>  	@echo "Please note that HTML reports do not regenerate if the unit tests"
> @@ -1015,6 +1016,23 @@ check-decodetree:
>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
>            TEST, decodetree.py)
>  
> +# Python venv for running tests
> +
> +.PHONY: check-venv
> +
> +TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
> +TESTS_VENV_REQ=$(SRC_PATH)/tests/venv-requirements.txt
> +
> +$(TESTS_VENV_DIR):
> +	$(call quiet-command, \
> +            $(PYTHON) -m venv --system-site-packages $@, \

Why do we want the '--system-site-packages' flag?

> +            VENV, $@)
> +	$(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/pip -q install -r $(TESTS_VENV_REQ), \

On Ubuntu I have to use (after installing python3-pip + python3.4-venv):

               $(PYTHON) -m pip -q install -r $(TESTS_VENV_REQ), \

> +            PIP, $(TESTS_VENV_REQ))
> +
> +check-venv: $(TESTS_VENV_DIR)

Same problem from v1: if check-venv failed and the directory exists, the
rule succeeds.

> +
>  # Consolidated targets
>  
>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
> @@ -1028,6 +1046,7 @@ check-clean:
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>  	rm -f tests/test-qapi-gen-timestamp
> +	rm -rf $(TESTS_VENV_DIR)
>  
>  clean: check-clean
>  
> diff --git a/tests/venv-requirements.txt b/tests/venv-requirements.txt
> new file mode 100644
> index 0000000000..d39f9d1576
> --- /dev/null
> +++ b/tests/venv-requirements.txt
> @@ -0,0 +1,3 @@
> +# Add Python module requirements, one per line, to be installed
> +# in the tests/venv Python virtual environment. For more info,
> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> 
