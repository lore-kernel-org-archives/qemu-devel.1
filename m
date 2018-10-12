Received: from eggs.gnu.org ([2001:4830:134:3::10]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB51E-0002UE-DR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gB51A-0001xf-Eo
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:30:48 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gB51A-0001xH-7j
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 17:30:44 -0400
Received: by mail-wr1-f52.google.com with SMTP id n11-v6so14736729wru.13
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 14:30:44 -0700 (PDT)
References: <20181012165347.2117-1-crosa@redhat.com>
	<20181012165347.2117-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <94f7da55-eaa1-6e63-333c-894831b9d66e@redhat.com>
Date: Fri, 12 Oct 2018 23:30:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181012165347.2117-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi Cleber,

On 12/10/2018 18:53, Cleber Rosa wrote:
> A number of QEMU tests are written in Python, and may benefit
> from an untainted Python venv.
> 
> By using make rules, tests that depend on specific Python libs
> can set that rule as a requirement, along with rules that require
> the presence or installation of specific libraries.
> 
> The tests/venv-requirements.txt is supposed to contain the
> Python requirements that should be added to the venv created
> by check-venv.

Maybe you (or Eduardo...) what you wrote in the cover:

 There's one current caveat: it requires Python 3, as it's based on the
 venv module.

To explain:

$ make check-acceptance
/usr/bin/python2: No module named venv
make: *** [/home/phil/source/qemu/tests/Makefile.include:1033:] Error 1

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/Makefile.include      | 20 ++++++++++++++++++++
>  tests/venv-requirements.txt |  3 +++
>  2 files changed, 23 insertions(+)
>  create mode 100644 tests/venv-requirements.txt
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 5eadfd52f9..b66180efa1 100644
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
> @@ -1017,6 +1018,24 @@ check-decodetree:
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
> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> +	$(call quiet-command, \
> +            $(PYTHON) -m venv --system-site-packages $@, \
> +            VENV, $@)
> +	$(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV_REQ), \
> +            PIP, $(TESTS_VENV_REQ))
> +	$(call quiet-command, touch $@)

Hmm maybe we should print something like:

  "You can now activate this virtual environment using:
    source $(TESTS_VENV_DIR)/tests/venv/bin/activate"

> +
> +check-venv: $(TESTS_VENV_DIR)
> +
>  # Consolidated targets
>  
>  .PHONY: check-qapi-schema check-qtest check-unit check check-clean
> @@ -1030,6 +1049,7 @@ check-clean:
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

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
