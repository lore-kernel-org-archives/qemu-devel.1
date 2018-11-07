Received: from eggs.gnu.org ([2001:4830:134:3::10]:43409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKLy6-0007kX-2U
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKLy5-0001Vy-0G
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:25:54 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKLy4-0001Sl-L3
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 06:25:52 -0500
Received: by mail-ot1-x342.google.com with SMTP id c32so14414194otb.8
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 03:25:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87efbxxw1c.fsf@dusky.pond.sub.org>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Nov 2018 11:25:31 +0000
Message-ID: <CAFEAcA9Qtu2UySD+CYawJea+diOUw9Vht_YPmL+dNv-ndtKRyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 7 November 2018 at 06:05, Markus Armbruster <armbru@redhat.com> wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>
>> The $(SHELLSTATUS) variable requires GNU make >= 4.2, but Travis
>> seems to provide an older version.  Change the existing rules to
>> use command output instead of exit code, to make it compatible
>> with older GNU make versions.
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>> I think that's the cause of the Travis failures.  I have
>> submitted a test job right now, at:
>>   https://travis-ci.org/ehabkost/qemu-hacks/jobs/451387962
>> Let's see if it fixes the issue.
>> ---
>>  tests/Makefile.include | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index d2e577eabb..074eece558 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -913,8 +913,8 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>>  # information please refer to "avocado --help".
>>  AVOCADO_SHOW=none
>>
>> -$(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
>> -ifeq ($(.SHELLSTATUS),0)
>> +PYTHON3 = $(shell $(PYTHON) -c 'import sys; print(1 if sys.version_info >= (3, 0) else 0)')
>> +ifeq ($(PYTHON3), 1)
>>  $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>>       $(call quiet-command, \
>>              $(PYTHON) -m venv --system-site-packages $@, \
>
> PEP 394 recommends software distributions install Python 3 into the
> default path as python3, and users use that instead of python, except
> for programs that are source compatible with both 2 and 3.  So, is
> finding out whether python is a Python 3 really appropriate?  Why can't
> we just use python3 and be done with it?
>
> If we can't: isn't this a configure problem?

You can't just use python3 and be done with it because python3
might not exist, and because (as with python 2) the user might
want to tell us the path to it. You could have configure detect
whether python3 exists and set a PYTHON3 as well as a PYTHON
(plus I guess support for the user to say "my python3 is this
binary"), and then have this code in Makefile.include handle
"PYTHON3 is not set" to mean "python 3 isn't available".

thanks
-- PMM
