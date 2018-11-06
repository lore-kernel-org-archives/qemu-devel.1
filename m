Received: from eggs.gnu.org ([2001:4830:134:3::10]:59116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK18O-0008Qn-IC
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK18N-00063M-DR
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:11:08 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK18N-00062c-7Z
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:11:07 -0500
Received: by mail-ot1-x32e.google.com with SMTP id z33so11203240otz.11
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 05:11:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181031003120.26771-12-ehabkost@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 13:10:45 +0000
Message-ID: <CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/15] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 31 October 2018 at 00:31, Eduardo Habkost <ehabkost@redhat.com> wrote:
> From: Cleber Rosa <crosa@redhat.com>
>
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
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Message-Id: <20181018153134.8493-2-crosa@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -12,6 +12,7 @@ check-help:
>         @echo " $(MAKE) check-block          Run block tests"
>         @echo " $(MAKE) check-tcg            Run TCG tests"
>         @echo " $(MAKE) check-report.html    Generates an HTML test repor=
t"
> +       @echo " $(MAKE) check-venv           Creates a Python venv for te=
sts"
>         @echo " $(MAKE) check-clean          Clean the tests"
>         @echo
>         @echo "Please note that HTML reports do not regenerate if the uni=
t tests"
> @@ -899,6 +900,30 @@ check-decodetree:
>            ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
>            TEST, decodetree.py)
>
> +# Python venv for running tests
> +
> +.PHONY: check-venv
> +
> +TESTS_VENV_DIR=3D$(BUILD_DIR)/tests/venv
> +TESTS_VENV_REQ=3D$(SRC_PATH)/tests/requirements.txt
> +
> +$(shell $(PYTHON) -c 'import sys; assert sys.version_info >=3D (3,0)' >/=
dev/null 2>&1)
> +ifeq ($(.SHELLSTATUS),0)
> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> +       $(call quiet-command, \
> +            $(PYTHON) -m venv --system-site-packages $@, \
> +            VENV, $@)
> +       $(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VE=
NV_REQ), \
> +            PIP, $(TESTS_VENV_REQ))
> +       $(call quiet-command, touch $@)
> +else
> +$(TESTS_VENV_DIR):
> +       $(error "venv directory for tests requires Python 3")
> +endif
> +
> +check-venv: $(TESTS_VENV_DIR)

Hi -- this seems to be causing one of the travis configs to fail:

https://travis-ci.org/qemu/qemu/jobs/451311466

The config includes "--python=3D/usr/bin/python3", but the build
fails with
     CHK version_gen.h
/home/travis/build/qemu/qemu/tests/Makefile.include:928: *** "venv
directory for tests requires Python 3". Stop.

Would you mind having a look at what's happening there ?

thanks
-- PMM
