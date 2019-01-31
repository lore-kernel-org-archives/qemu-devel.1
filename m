Received: from eggs.gnu.org ([209.51.188.92]:44511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gp9c8-0001LL-HT
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gp9c5-000333-3G
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:30:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gp9c2-0002wW-N2
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:30:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so2640164wrt.7
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 02:30:20 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-19-crosa@redhat.com>
	<f0426dd5-fd7a-daf0-9c0d-bd48bb36d8a7@redhat.com>
	<af8f29c0-0b2b-ef65-2242-6b2c8ea08a3f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9400afcf-7c67-fd69-0b0d-1f7449ffc35c@redhat.com>
Date: Thu, 31 Jan 2019 11:30:17 +0100
MIME-Version: 1.0
In-Reply-To: <af8f29c0-0b2b-ef65-2242-6b2c8ea08a3f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/18] Boot Linux Console Test: add a test
 for alpha + clipper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 1/31/19 3:53 AM, Cleber Rosa wrote:
> On 1/22/19 5:52 AM, Philippe Mathieu-Daudé wrote:
>> On 1/17/19 7:56 PM, Cleber Rosa wrote:
>>> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
>>> board and verify the serial is working.  One extra command added to
>>> the QEMU command line is '-vga std', because the kernel used is
>>> known to crash without it.
>>>
>>> If alpha is a target being built, "make check-acceptance" will
>>> automatically include this test by the use of the "arch:alpha" tags.
>>>
>>> Alternatively, this test can be run using:
>>>
>>>     $ avocado run -t arch:alpha tests/acceptance
>>>     $ avocado run -t machine:clipper tests/acceptance
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  .travis.yml                            |  2 +-
>>>  scripts/qemu.py                        |  1 -
>>>  tests/acceptance/boot_linux_console.py | 22 ++++++++++++++++++++++
>>>  3 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 0d5a4b104b..73a113af87 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -187,7 +187,7 @@ matrix:
>>>  
>>>      # Acceptance (Functional) tests
>>>      - env:
>>> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu"
>>> +        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>>>          - TEST_CMD="make check-acceptance"
>>>        addons:
>>>          apt:
>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>> index 1531e28fc1..a704da418a 100644
>>> --- a/scripts/qemu.py
>>> +++ b/scripts/qemu.py
>>> @@ -34,7 +34,6 @@ def kvm_available(target_arch=None):
>>>  
>>>  #: Maps machine types to the preferred console device types
>>>  CONSOLE_DEV_TYPES = {
>>> -    r'^clipper$': 'isa-serial',
>>
>> Why this change?
>>
> 
> Because we've come to conclusion (I believe :) that's better, whenever
> possible, to let QEMU pick the default device type by machine.  The
> discussion happened here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04582.html

I was expecting this change to be global (in a single patch previous to
the target-specific patches). If you prefer to do it a target at a time
I'm OK with it but you should add a comment about it in the commit IMHO.

Regards,

Phil.
