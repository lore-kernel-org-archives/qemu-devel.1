Received: from eggs.gnu.org ([2001:4830:134:3::10]:51826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gKYtJ-0001pC-9H
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gKYtB-00049x-Uj
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:13:46 -0500
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8ecdbb0e-aaf8-ddc5-6442-87977585d9d8@redhat.com>
Date: Wed, 7 Nov 2018 20:13:19 -0500
MIME-Version: 1.0
In-Reply-To: <87efbxxw1c.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>



On 11/7/18 1:05 AM, Markus Armbruster wrote:
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
>>  	$(call quiet-command, \
>>              $(PYTHON) -m venv --system-site-packages $@, \
> 
> PEP 394 recommends software distributions install Python 3 into the
> default path as python3, and users use that instead of python, except
> for programs that are source compatible with both 2 and 3.  So, is
> finding out whether python is a Python 3 really appropriate?  Why can't
> we just use python3 and be done with it?
> 

I mentioned that before, when you pointed out the issue you fix here,
that configure may be the best place to get the Python version (not only
the major version) and make it available elsewhere.  Even if not used
for other purposes, it is IMO important information to show on the
resulting "configure" output.

I'm sending patches to do that in a few.

> If we can't: isn't this a configure problem?
> 

I believe adhering to PEP394 is a good thing, but even that document
recognizes that the real world is not a perfect place: "however, end
users should be aware that python refers to python3 on at least Arch
Linux".  And it only covers *nix systems, so if we hope to care for
non-*nix systems, we have to check the Python version manually.

So, I guess the safest approach from QEMU's side is to check for the
version indeed.

- Cleber.
