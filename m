Received: from eggs.gnu.org ([209.51.188.92]:49904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn60R-0001r9-Uw
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn60Q-0004uN-2y
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:15:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn60O-0004sg-3t
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:15:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so11329934wrb.2
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:15:02 -0800 (PST)
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
	<f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
	<4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
	<20190124165253.GT7953@redhat.com>
	<509cf069-5d03-8e2e-fb3c-5828d32f38e1@comstyle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b56e9a1-5844-3b36-2938-ef63985d54f4@redhat.com>
Date: Fri, 25 Jan 2019 19:15:00 +0100
MIME-Version: 1.0
In-Reply-To: <509cf069-5d03-8e2e-fb3c-5828d32f38e1@comstyle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Kamil Rytarowski <n54@gmx.com>, Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com

On 1/25/19 1:48 AM, Brad Smith wrote:
> On 1/24/2019 11:52 AM, Daniel P. Berrangé wrote:
> 
>> On Thu, Jan 24, 2019 at 05:10:19PM +0100, Philippe Mathieu-Daudé wrote:
>>> On 1/24/19 4:56 PM, Kamil Rytarowski wrote:
>>>> On 24.01.2019 16:52, Philippe Mathieu-Daudé wrote:
>>>>> On 8/16/17 9:21 AM, Fam Zheng wrote:
>>>>>> The image is prepared following instructions as in:
>>>>>>
>>>>>> https://wiki.qemu.org/Hosts/BSD
>>>>>>
>>>>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>>>>> ---
>>>>>>   tests/vm/openbsd | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>   1 file changed, 45 insertions(+)
>>>>>>   create mode 100755 tests/vm/openbsd
>>>>>>
>>>>>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>>>>>> new file mode 100755
>>>>>> index 0000000000..d37ff83a59
>>>>>> --- /dev/null
>>>>>> +++ b/tests/vm/openbsd
>>>>>> @@ -0,0 +1,45 @@
>>>>>> +#!/usr/bin/env python
>>>>>> +#
>>>>>> +# OpenBSD VM image
>>>>>> +#
>>>>>> +# Copyright (C) 2017 Red Hat Inc.
>>>>>> +#
>>>>>> +# Authors:
>>>>>> +#  Fam Zheng <famz@redhat.com>
>>>>>> +#
>>>>>> +# This work is licensed under the terms of the GNU GPL, version
>>>>>> 2.  See
>>>>>> +# the COPYING file in the top-level directory.
>>>>>> +#
>>>>>> +
>>>>>> +import os
>>>>>> +import sys
>>>>>> +import logging
>>>>>> +import subprocess
>>>>>> +import tempfile
>>>>>> +import time
>>>>>> +import basevm
>>>>>> +
>>>>>> +class OpenBSDVM(basevm.BaseVM):
>>>>>> +    name = "openbsd"
>>>>>> +    BUILD_SCRIPT = """
>>>>>> +        set -e;
>>>>>> +        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>>>>>> +        tar -xf /dev/rsd1c;
>>>>>> +        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4
>>>>>> --python=python2.7 {configure_opts};
>>>>>> +        gmake -j{jobs};
>>>>>> +        # XXX: "gmake check" seems to always hang or fail
>>>>>> +        #gmake check;
>>>>> OK, Now it makes more sense...
>>>>>
>>>>> After spending various hours trying to fix various issues on
>>>>> OpenBSD, I
>>>>> notice that we never ran tests on this OS.
>>>>> The only binary I can run is qemu-img, the rest seems useless.
>>>>> I'll summarize in a different thread.
>>>>>
>>>> Is this W^X related?
>>> Part of it could be but I'm not sure.
>>>
>>> The 6.1 VM provided by Fam has /usr/local mounted with wxallowed, I
>>> tried building/running there and nothing changed, mmap() still returns
>>> ENOTSUP:
>> ENOTSUP from mmap is certainly what you'd expect from the W^X  scenario
>>
>>    https://undeadly.org/cgi?action=article&sid=20160527203200
>>
>>   "W^X violations are no longer permitted by default.  A kernel log
>> message
>>    is generated, and mprotect/mmap return ENOTSUP.  If the sysctl(8) flag
>>    kern.wxabort is set then a SIGABRT occurs instead, for gdb use or
>> coredump
>>    creation."
> 
> Yes, this policy change was introduced with 6.0.
> 
> Our ports tree has an option which results in the QEMU binaries being
> linked with "-z wxneeded".

I was preparing a draft about deprecating/removing OpenBSD support
because it is broken/untested... For sure it is untested.
/me feeling he lost 2 days...
