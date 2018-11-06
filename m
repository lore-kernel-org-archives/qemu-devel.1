Received: from eggs.gnu.org ([2001:4830:134:3::10]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK1XK-0000ds-02
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:36:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK1XF-00074L-2X
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:36:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gK1XE-000718-S3
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:36:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id y3-v6so13222286wrh.10
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 05:36:48 -0800 (PST)
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1bd429f-198a-ee27-9184-636692332816@redhat.com>
Date: Tue, 6 Nov 2018 14:34:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 11/15] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 6/11/18 14:10, Peter Maydell wrote:
> On 31 October 2018 at 00:31, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> From: Cleber Rosa <crosa@redhat.com>
>>
>> A number of QEMU tests are written in Python, and may benefit
>> from an untainted Python venv.
>>
>> By using make rules, tests that depend on specific Python libs
>> can set that rule as a requirement, along with rules that require
>> the presence or installation of specific libraries.
>>
>> The tests/requirements.txt is supposed to contain the Python
>> requirements that should be added to the venv created by check-venv.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Acked-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
>> Message-Id: <20181018153134.8493-2-crosa@redhat.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -12,6 +12,7 @@ check-help:
>>          @echo " $(MAKE) check-block          Run block tests"
>>          @echo " $(MAKE) check-tcg            Run TCG tests"
>>          @echo " $(MAKE) check-report.html    Generates an HTML test report"
>> +       @echo " $(MAKE) check-venv           Creates a Python venv for tests"
>>          @echo " $(MAKE) check-clean          Clean the tests"
>>          @echo
>>          @echo "Please note that HTML reports do not regenerate if the unit tests"
>> @@ -899,6 +900,30 @@ check-decodetree:
>>             ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
>>             TEST, decodetree.py)
>>
>> +# Python venv for running tests
>> +
>> +.PHONY: check-venv
>> +
>> +TESTS_VENV_DIR=$(BUILD_DIR)/tests/venv
>> +TESTS_VENV_REQ=$(SRC_PATH)/tests/requirements.txt
>> +
>> +$(shell $(PYTHON) -c 'import sys; assert sys.version_info >= (3,0)' >/dev/null 2>&1)
>> +ifeq ($(.SHELLSTATUS),0)
>> +$(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
>> +       $(call quiet-command, \
>> +            $(PYTHON) -m venv --system-site-packages $@, \
>> +            VENV, $@)
>> +       $(call quiet-command, \
>> +            $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV_REQ), \
>> +            PIP, $(TESTS_VENV_REQ))
>> +       $(call quiet-command, touch $@)
>> +else
>> +$(TESTS_VENV_DIR):
>> +       $(error "venv directory for tests requires Python 3")
>> +endif
>> +
>> +check-venv: $(TESTS_VENV_DIR)
> 
> Hi -- this seems to be causing one of the travis configs to fail:
> 
> https://travis-ci.org/qemu/qemu/jobs/451311466
> 
> The config includes "--python=/usr/bin/python3", but the build
> fails with
>       CHK version_gen.h
> /home/travis/build/qemu/qemu/tests/Makefile.include:928: *** "venv
> directory for tests requires Python 3". Stop.
> 
> Would you mind having a look at what's happening there ?

I tested the failure using 'make check-venv PYTHON=python2' and the 
success using 'make check-venv PYTHON=python3' but didn't think of the 
default...

The quicker fix is to force PYTHON in .travis.yml, I'll prepare a patch.

> 
> thanks
> -- PMM
> 
