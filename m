Received: from eggs.gnu.org ([209.51.188.92]:54822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gn6Cd-000544-QV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gn6Cc-0003Co-OR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:27:43 -0500
Received: from speedy.comstyle.com ([206.51.28.2]:10504 helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gn6Cb-00039m-Oz
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:27:42 -0500
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
	<f4ede6c1-ba9e-777d-8b82-5776cd897943@gmx.com>
	<4bf0c77e-ea8f-1813-a6a4-6ab6eb857cd0@redhat.com>
	<20190124165253.GT7953@redhat.com>
	<509cf069-5d03-8e2e-fb3c-5828d32f38e1@comstyle.com>
	<6e71d755-8dcd-5275-d635-f238271cf459@tuxfamily.org>
From: Brad Smith <brad@comstyle.com>
Message-ID: <1284f2c4-57ad-061a-c920-c21cd7e142d4@comstyle.com>
Date: Fri, 25 Jan 2019 13:27:30 -0500
MIME-Version: 1.0
In-Reply-To: <6e71d755-8dcd-5275-d635-f238271cf459@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 1/25/2019 1:24 AM, Thomas Huth wrote:

> On 2019-01-25 01:48, Brad Smith wrote:
>> On 1/24/2019 11:52 AM, Daniel P. Berrang=C3=A9 wrote:
>>
>>> On Thu, Jan 24, 2019 at 05:10:19PM +0100, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>> On 1/24/19 4:56 PM, Kamil Rytarowski wrote:
>>>>> On 24.01.2019 16:52, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> On 8/16/17 9:21 AM, Fam Zheng wrote:
>>>>>>> The image is prepared following instructions as in:
>>>>>>>
>>>>>>> https://wiki.qemu.org/Hosts/BSD
>>>>>>>
>>>>>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>>>>>> ---
>>>>>>>  =C2=A0 tests/vm/openbsd | 45 +++++++++++++++++++++++++++++++++++=
++++++++++
>>>>>>>  =C2=A0 1 file changed, 45 insertions(+)
>>>>>>>  =C2=A0 create mode 100755 tests/vm/openbsd
>>>>>>>
>>>>>>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>>>>>>> new file mode 100755
>>>>>>> index 0000000000..d37ff83a59
>>>>>>> --- /dev/null
>>>>>>> +++ b/tests/vm/openbsd
>>>>>>> @@ -0,0 +1,45 @@
>>>>>>> +#!/usr/bin/env python
>>>>>>> +#
>>>>>>> +# OpenBSD VM image
>>>>>>> +#
>>>>>>> +# Copyright (C) 2017 Red Hat Inc.
>>>>>>> +#
>>>>>>> +# Authors:
>>>>>>> +#=C2=A0 Fam Zheng <famz@redhat.com>
>>>>>>> +#
>>>>>>> +# This work is licensed under the terms of the GNU GPL, version
>>>>>>> 2.=C2=A0 See
>>>>>>> +# the COPYING file in the top-level directory.
>>>>>>> +#
>>>>>>> +
>>>>>>> +import os
>>>>>>> +import sys
>>>>>>> +import logging
>>>>>>> +import subprocess
>>>>>>> +import tempfile
>>>>>>> +import time
>>>>>>> +import basevm
>>>>>>> +
>>>>>>> +class OpenBSDVM(basevm.BaseVM):
>>>>>>> +=C2=A0=C2=A0=C2=A0 name =3D "openbsd"
>>>>>>> +=C2=A0=C2=A0=C2=A0 BUILD_SCRIPT =3D """
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set -e;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cd $(mktemp -d /var/t=
mp/qemu-test.XXXXXX);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tar -xf /dev/rsd1c;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./configure --cc=3Dx8=
6_64-unknown-openbsd6.1-gcc-4.9.4
>>>>>>> --python=3Dpython2.7 {configure_opts};
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gmake -j{jobs};
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # XXX: "gmake check" =
seems to always hang or fail
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #gmake check;
>>>>>> OK, Now it makes more sense...
>>>>>>
>>>>>> After spending various hours trying to fix various issues on
>>>>>> OpenBSD, I
>>>>>> notice that we never ran tests on this OS.
>>>>>> The only binary I can run is qemu-img, the rest seems useless.
>>>>>> I'll summarize in a different thread.
>>>>>>
>>>>> Is this W^X related?
>>>> Part of it could be but I'm not sure.
>>>>
>>>> The 6.1 VM provided by Fam has /usr/local mounted with wxallowed, I
>>>> tried building/running there and nothing changed, mmap() still retur=
ns
>>>> ENOTSUP:
>>> ENOTSUP from mmap is certainly what you'd expect from the W^X=C2=A0 s=
cenario
>>>
>>>  =C2=A0=C2=A0 https://undeadly.org/cgi?action=3Darticle&sid=3D2016052=
7203200
>>>
>>>  =C2=A0 "W^X violations are no longer permitted by default.=C2=A0 A k=
ernel log
>>> message
>>>  =C2=A0=C2=A0 is generated, and mprotect/mmap return ENOTSUP.=C2=A0 I=
f the sysctl(8) flag
>>>  =C2=A0=C2=A0 kern.wxabort is set then a SIGABRT occurs instead, for =
gdb use or
>>> coredump
>>>  =C2=A0=C2=A0 creation."
>> Yes, this policy change was introduced with 6.0.
>>
>> Our ports tree has an option which results in the QEMU binaries being
>> linked with "-z wxneeded".
> Then it's maybe high time to send such changes upstream now ;-)


I have not considered submitting such a patch as it's just a workaround=20
for an
issue within QEMU. Everything else that we had as local patches or local=20
build
fiddling to build things properly has been integrated in some manner.
