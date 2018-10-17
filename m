Received: from eggs.gnu.org ([2001:4830:134:3::10]:41865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gCrXL-0003Uf-3a
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gCrXG-0007M5-Bm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:31:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gCrXG-0007Lf-2Y
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 15:31:14 -0400
References: <20181017160539.12316-1-crosa@redhat.com>
	<20181017160539.12316-2-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <4b90a68f-708c-b14d-795a-3d2bce74989e@redhat.com>
Date: Wed, 17 Oct 2018 16:30:53 -0300
MIME-Version: 1.0
In-Reply-To: <20181017160539.12316-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


On 10/17/2018 01:05 PM, Cleber Rosa wrote:
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
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/Makefile.include | 26 ++++++++++++++++++++++++++
>   tests/requirements.txt |  3 +++
>   2 files changed, 29 insertions(+)
>   create mode 100644 tests/requirements.txt
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 5eadfd52f9..4b88a119e0 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -12,6 +12,7 @@ check-help:
>   	@echo " $(MAKE) check-block          Run block tests"
>   	@echo " $(MAKE) check-tcg            Run TCG tests"
>   	@echo " $(MAKE) check-report.html    Generates an HTML test report"
> +	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>   	@echo " $(MAKE) check-clean          Clean the tests"
>   	@echo
>   	@echo "Please note that HTML reports do not regenerate if the unit t=
ests"
> @@ -1017,6 +1018,30 @@ check-decodetree:
>             ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py",=
 \
>             TEST, decodetree.py)
>  =20
> +# Python venv for running tests
> +
> +.PHONY: check-venv
> +
> +TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
> +TESTS_VENV_REQ=3D$(SRC_PATH)/tests/requirements.txt
> +
> +PYTHON_VER :=3D $(findstring Python 3,$(shell $(PYTHON) -V))
> +ifeq ($(PYTHON_VER),Python 3)
> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> +	$(call quiet-command, \
> +            $(PYTHON) -m venv --system-site-packages $@, \
> +            VENV, $@)
> +	$(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_=
VENV_REQ), \
> +            PIP, $(TESTS_VENV_REQ))
> +	$(call quiet-command, touch $@)
> +else
> +$(TESTS_VENV_DIR):
> +       $(error "venv directory for tests requires Python 3")

Above line is indented with space instead of tab. Thus, it breaks the bui=
ld:

# make -j4
Python 2.7.15
/root/qemu/tests/Makefile.include:1040: *** "venv directory for tests=20
requires Python 3".=C2=A0 Stop.

Also make check-help prints python's version when the build was=20
configured with py2 (or the system lacks py3):

# make check-help
Python 2.7.15
Regression testing targets:

 =C2=A0make check=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Run all tests
 =C2=A0make check-qtest-TARGET=C2=A0=C2=A0 Run qtest tests for given targ=
et
<output omitted>

I tested this patch series on Fedora 28 x86_64. It works fine except for=20
above issues, so once fixing them:

Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


> +endif
> +
> +check-venv: $(TESTS_VENV_DIR)
> +
>   # Consolidated targets
>  =20
>   .PHONY: check-qapi-schema check-qtest check-unit check check-clean
> @@ -1030,6 +1055,7 @@ check-clean:
>   	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>   	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-=
$(target)-y)) $(check-qtest-generic-y))
>   	rm -f tests/test-qapi-gen-timestamp
> +	rm -rf $(TESTS_VENV_DIR)
>  =20
>   clean: check-clean
>  =20
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> new file mode 100644
> index 0000000000..d39f9d1576
> --- /dev/null
> +++ b/tests/requirements.txt
> @@ -0,0 +1,3 @@
> +# Add Python module requirements, one per line, to be installed
> +# in the tests/venv Python virtual environment. For more info,
> +# refer to: https://pip.pypa.io/en/stable/user_guide/#id1
