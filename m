Received: from eggs.gnu.org ([209.51.188.92]:38860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1goy9H-0001gw-Nb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1goy9G-0008Oe-Qt
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:15:59 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-7-crosa@redhat.com>
	<20190118113855.020dc3c0.cohuck@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <95c86657-9d71-6f4b-b960-7d4939138a78@redhat.com>
Date: Wed, 30 Jan 2019 17:15:48 -0500
MIME-Version: 1.0
In-Reply-To: <20190118113855.020dc3c0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/18] Acceptance tests: use "arch:" tag to
 filter target specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 1/18/19 5:38 AM, Cornelia Huck wrote:
> On Thu, 17 Jan 2019 13:56:16 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
> 
>> Currently, the only test that contains some target architecture
>> information is "boot_linux_console.py" which test contains a "x86_64"
>> tag.  But that tag is not respected in the default execution, that is,
>> "make check-acceptance" doesn't do anything with it.
>>
>> That said, even the target architecture handling currently present in
>> the "avocado_qemu.Test" class, class is pretty limited.  For instance,
>> by default, it chooses a target based on the host architecture.
>>
>> Because the original implementation of the tags feature in Avocado did
>> not include any time of namespace or "key:val" mechanism, no tag has
>> relation to another tag.  The new implementation of the tags feature
>> from version 67.0 onwards, allows "key:val" tags, and because of that,
>> a test can be classified with a tag in a given key.  For instance, the
>> new proposed version of the "boot_linux_console.py" test, which
>> downloads and attempts to run a x86_64 kernel, is now tagged as:
>>
>>   :avocado: tags=arch:x86_64
>>
>> This means that it can be filtered (out) when no x86_64 target is
>> available.  At the same time, tests that don't have a "arch:" tag,
>> will not be filtered out.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/Makefile.include                 | 3 +++
>>  tests/acceptance/boot_linux_console.py | 2 +-
>>  tests/requirements.txt                 | 2 +-
>>  3 files changed, 5 insertions(+), 2 deletions(-)
>>
> 
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 98324f7591..46b20bdfe2 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -19,7 +19,7 @@ class BootLinuxConsole(Test):
>>      and the kernel command line is properly passed from QEMU to the kernel
>>  
>>      :avocado: enable
>> -    :avocado: tags=x86_64
>> +    :avocado: tags=arch:x86_64
>>      """
>>  
>>      timeout = 60
> 
> You probably want to do the same change in virtio_version.py;
> otherwise, if I run the acceptance tests on s390x, it will run into
> timeouts (it looks like that test is intended to be run with x86
> machines anyway.)
> 

Right, good catch.  Also, the same applies to the "linux_initrd.py"
test, merged after this version.

- Cleber.
