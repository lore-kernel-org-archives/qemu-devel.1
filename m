Received: from eggs.gnu.org ([2001:4830:134:3::10]:52246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK2Ke-00054m-89
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK2Ka-0001Hj-6K
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:27:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gK2KZ-0000rd-VK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 09:27:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so13710634wrb.13
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 06:27:29 -0800 (PST)
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5586b504-2111-d3af-e0e1-ee590ef40f5d@redhat.com>
Date: Tue, 6 Nov 2018 15:27:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181106141302.GP12503@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: Fix Python 3 detection on older GNU
 make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 6/11/18 15:13, Eduardo Habkost wrote:
> The $(SHELLSTATUS) variable requires GNU make >= 4.2, but Travis
> seems to provide an older version.  Change the existing rules to
> use command output instead of exit code, to make it compatible
> with older GNU make versions.

You were quicker, I just found out :)

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> I think that's the cause of the Travis failures.  I have
> submitted a test job right now, at:
>    https://travis-ci.org/ehabkost/qemu-hacks/jobs/451387962
> Let's see if it fixes the issue.

You can run it locally:

$ make docker-image-travis
...
$ docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) \
     -u 0 --entrypoint=/bin/bash qemu:travis
root@ede09efe22fd:qemu# cd build/docker_travis/
root@ede09efe22fd:qemu/build/docker_travis# make AVOCADO_SHOW=app 
check-acceptance
   VENV    qemu/build/docker_travis/tests/venv
The virtual environment was not created successfully because ensurepip 
is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

     apt-get install python3-venv

You may need to use sudo with that command.  After installing the 
python3-venv
package, recreate your virtual environment.

root@ede09efe22fd:qemu/build/docker_travis# apt install python3-pip 
python3.4-venv
root@ede09efe22fd:qemu/build/docker_travis# make AVOCADO_SHOW=app 
check-acceptance
   VENV    qemu/build/docker_travis/tests/venv
   PIP     qemu/tests/requirements.txt
   AVOCADO tests/acceptance
JOB ID     : 5e5529e79456c388e80323acdc71f3887341a498
JOB LOG    : 
qemu/build/docker_travis/tests/results/job-2018-11-06T14.26-5e5529e/job.log
  (1/6) 
qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test: 
CANCEL: No QEMU binary defined or found in the source tree (0.01 s)
  (2/6) 
qemu/tests/acceptance/version.py:Version.test_qmp_human_info_version: 
CANCEL: No QEMU binary defined or found in the source tree (0.01 s)
  (3/6) qemu/tests/acceptance/vnc.py:Vnc.test_no_vnc: CANCEL: No QEMU 
binary defined or found in the source tree (0.00 s)
  (4/6) qemu/tests/acceptance/vnc.py:Vnc.test_no_vnc_change_password: 
CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
  (5/6) 
qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_password: 
CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
  (6/6) qemu/tests/acceptance/vnc.py:Vnc.test_vnc_change_password: 
CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | 
CANCEL 6
JOB TIME   : 0.45 s

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   tests/Makefile.include | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d2e577eabb..074eece558 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -913,8 +913,8 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>   # information please refer to "avocado --help".
>   AVOCADO_SHOW=none
>   
> -$(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
> -ifeq ($(.SHELLSTATUS),0)
> +PYTHON3 = $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_info >= (3, 0) else 0)')
> +ifeq ($(PYTHON3), 1)
>   $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>   	$(call quiet-command, \
>               $(PYTHON) -m venv --system-site-packages $@, \
> 
