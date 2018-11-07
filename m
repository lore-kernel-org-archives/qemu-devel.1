Received: from eggs.gnu.org ([2001:4830:134:3::10]:33691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKGyK-00034M-C1
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKGyJ-00050J-CD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 01:05:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
Date: Wed, 07 Nov 2018 07:05:03 +0100
In-Reply-To: <20181106141302.GP12503@habkost.net> (Eduardo Habkost's message
	of "Tue, 6 Nov 2018 12:13:02 -0200")
Message-ID: <87efbxxw1c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Fix Python 3 detection
 on older GNU make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?= <philmd@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The $(SHELLSTATUS) variable requires GNU make >= 4.2, but Travis
> seems to provide an older version.  Change the existing rules to
> use command output instead of exit code, to make it compatible
> with older GNU make versions.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> I think that's the cause of the Travis failures.  I have
> submitted a test job right now, at:
>   https://travis-ci.org/ehabkost/qemu-hacks/jobs/451387962
> Let's see if it fixes the issue.
> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d2e577eabb..074eece558 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -913,8 +913,8 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>  # information please refer to "avocado --help".
>  AVOCADO_SHOW=none
>  
> -$(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
> -ifeq ($(.SHELLSTATUS),0)
> +PYTHON3 = $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_info >= (3, 0) else 0)')
> +ifeq ($(PYTHON3), 1)
>  $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>  	$(call quiet-command, \
>              $(PYTHON) -m venv --system-site-packages $@, \

PEP 394 recommends software distributions install Python 3 into the
default path as python3, and users use that instead of python, except
for programs that are source compatible with both 2 and 3.  So, is
finding out whether python is a Python 3 really appropriate?  Why can't
we just use python3 and be done with it?

If we can't: isn't this a configure problem?
