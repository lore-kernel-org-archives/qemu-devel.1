Received: from eggs.gnu.org ([2001:4830:134:3::10]:47561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDI6X-0001m3-Fy
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 19:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDI6G-0007zl-UT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 19:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDI6D-0007sE-5O
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 19:53:08 -0400
References: <20181018162057.19348-1-wainersm@redhat.com>
	<f53ae31c-a0e6-9370-2b77-26d313380f3a@redhat.com>
	<20181018220922.GA31060@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <59005eb9-98cd-a614-46fb-d6627056352a@redhat.com>
Date: Thu, 18 Oct 2018 19:52:58 -0400
MIME-Version: 1.0
In-Reply-To: <20181018220922.GA31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, lizhijian@cn.fujitsu.com, ccarrara@redhat.com, philmd@redhat.com



On 10/18/18 6:09 PM, Eduardo Habkost wrote:
> On Thu, Oct 18, 2018 at 05:45:56PM -0400, Cleber Rosa wrote:
>>
>>
>> On 10/18/18 12:20 PM, Wainer dos Santos Moschetta wrote:
>>> QEMU used to exits with a not accurate error message when
>>> an initrd >= 2GB was passed. That was fixed on patch:
>>>
>>> 	commit f3839fda5771596152b75dd1e1a6d050e6e6e380
>>> 	Author: Li Zhijian <lizhijian@cn.fujitsu.com>
>>> 	Date:   Thu Sep 13 18:07:13 2018 +0800
>>>
>>>     	change get_image_size return type to int64_t
>>>
>>> This change adds a regression test for that fix. It starts
>>> QEMU with a 2GB dummy initrd, and check it evaluates the file
>>> size correctly and prints accurate message.
>>>
>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> ---
>>>  tests/acceptance/linux_initrd.py | 47 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 47 insertions(+)
>>>  create mode 100644 tests/acceptance/linux_initrd.py
>>>
>>> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
>>> new file mode 100644
>>> index 0000000000..7d9e5862cd
>>> --- /dev/null
>>> +++ b/tests/acceptance/linux_initrd.py
>>> @@ -0,0 +1,47 @@
>>> +# Linux initrd acceptance test.
>>> +#
>>> +# Copyright (c) 2018 Red Hat, Inc.
>>> +#
>>> +# Author:
>>> +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.  See the COPYING file in the top-level directory.
>>> +
>>> +import tempfile
>>> +
>>> +from avocado_qemu import Test
>>> +from avocado.utils.process import run
>>> +
>>> +
>>> +class LinuxInitrd(Test):
>>> +    """
>>> +    Checks QEMU evaluates correctly the initrd file passed as -initrd option.
>>> +
>>> +    :avocado: enable
>>> +    :avocado: tags=x86_64
>>> +    """
>>> +
>>> +    timeout = 60
>>> +
>>> +    def test_with_2GB_file_should_exit_error_msg(self):
>>> +        """
>>> +        Pretends to boot QEMU with an initrd file with size of 2GB
>>> +        and expect it exits with error message.
>>> +        Regression test for bug fixed on commit f3839fda5771596152.
>>> +        """
>>> +        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
>>> +                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
>>> +        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
>>> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>>> +
>>> +        with tempfile.NamedTemporaryFile() as initrd:
>>> +            initrd.seek(2048*(1024**2) -1)
>>
>> It's a style issue, but I'd go with spaces between operators:
>>
>>         initrd.seek(2048 * (1024 ** 2) - 1)
>>
>> One other possibility that may improve code readability is:
>>
>>         from avocado.utils.data_structures import DataSize
>>         initrd.seek(DataSize('2G').b - 1)
>>
> 
> I'd agree if "2G" weren't ambiguous (I would expect it to mean
> 2,000,000,000, not 1,073,741,824).
> 
> I can live with the ambiguity of 2GB in the commit message, class
> name, and docstring.  But having to look for the
> avocado.utils.data_structures.DataSize documentation to find out
> what's the file size makes the code less readable to me.
> 
> 

Fair enough.  The "G" here isn't clear about gibibyte/gigabyte.

>> Or finally, just set a "max_size" variable to the 2GB literal value.
>>
>>> +            initrd.write(b'\0')
>>> +            initrd.flush()
>>> +            cmd = "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_path,
>>> +                                                initrd.name)
>>> +            res = run(cmd, ignore_status=True)
>>> +            self.assertNotEqual(res.exit_status, 0)
> 
> I would prefer to ensure exit code is 1.  We don't want the test
> to pass if QEMU crashed with a signal, for example.
> 
> 

Agreed.

>>> +            expected_msg = r'.*initrd is too large.*max: \d+, need \d+.*'
>>
>> I'd be a bit more assertive here and do something like:
>>
>>       expected_msg = r'.*initrd is too large.*max: \d+, need %d\)' %
>> max_size
>>
>> And if "134053887" (which appears in "max"), is a QEMU constant, that
>> can be added there as well.
> 
> I was going to suggest the opposite: just checking if the error
> message contains "initrd is too large".  If we ensure the exit
> status is 1, the exact format of the error message isn't very
> important.
> 

It's certainly a matter of style here, and both are fine to me, but I'd
rather have someone touching that part of the code to also have to touch
the test if the message changes.

Note that I can't predict if this will eventually catch a regression
that the simpler message you suggest wouldn't, but, I, personally,
prefer to be safe than sorry.

- Cleber.
