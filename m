Received: from eggs.gnu.org ([2001:4830:134:3::10]:37013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYf0a-0006uY-E1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYf0V-0005I0-O3
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:03:20 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYf0V-0005Gk-Ii
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 18:03:15 -0400
Received: by mail-qt0-x243.google.com with SMTP id h5-v6so6188292qtm.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 15:03:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-2-f4bug@amsat.org> <87k1qivqm5.fsf@linaro.org>
	<87a7revapy.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8c3ed3c-8dac-d596-208a-e8f72797c784@amsat.org>
Date: Thu, 28 Jun 2018 19:03:11 -0300
MIME-Version: 1.0
In-Reply-To: <87a7revapy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/6] avocado: Add a Test.arch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On 06/28/2018 06:54 PM, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>>> Tests can change this property to run tests in other
>>> architectures than the host one.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  tests/acceptance/avocado_qemu/__init__.py | 17 +++++++++++++----
>>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
>>> index 1e54fd5932..6e9601f5e9 100644
>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>> @@ -13,6 +13,7 @@ import sys
>>>
>>>  import avocado
>>>
>>> +HOST_ARCH = os.uname()[4]
>>
>> The python docs seem to point to platform as a more stable way of
>> querying this stuff:
>>
>>   platform.machine() => 'x86_64' or 'aarch64'
>>
>>>  SRC_ROOT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
>>>  SRC_ROOT_DIR = os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
>>>  sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
>>> @@ -23,12 +24,11 @@ def is_readable_executable_file(path):
>>>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>>>
>>>
>>> -def pick_default_qemu_bin():
>>> +def pick_default_qemu_bin(arch):
>>>      """
>>>      Picks the path of a QEMU binary, starting either in the current working
>>>      directory or in the source tree root directory.
>>>      """
>>> -    arch = os.uname()[4]
>>>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>>>                                            "qemu-system-%s" % arch)
>>>      if is_readable_executable_file(qemu_bin_relative_path):
>>> @@ -41,10 +41,19 @@ def pick_default_qemu_bin():
>>>
>>>
>>>  class Test(avocado.Test):
>>> +    _arch = HOST_ARCH
> 
> But actually this is wrong - because the host arch may not boot machines
> defined in the tests. I suspect each superclass needs to explicitly set
> it's arch and we should assert it has done so here.

Hmm but arch-specific tests are protected by the 'arch' tag:

class BootLinuxConsoleMips(Test):
    """
    :avocado: enable
    :avocado: tags=endian:big
    :avocado: tags=arch:mips
    :avocado: tags=board:malta
    """

Oh no they aren't, it is just a way to filter which selection of tests
to run :|

Cleber can you help us here?

>>> +
>>> +    @property
>>> +    def arch(self):
>>> +        """
>>> +        Returns the architecture required to run the current test
>>> +        """
>>> +        return self._arch
>>> +> 
> 
> --
> Alex Bennée
> 
>>>      def setUp(self):
>>>          self.vm = None
>>> -        self.qemu_bin = self.params.get('qemu_bin',
>>> -                                        default=pick_default_qemu_bin())
>>> +        qemu_bin = pick_default_qemu_bin(self.arch)
>>> +        self.qemu_bin = self.params.get('qemu_bin', default=qemu_bin)
>>>          if self.qemu_bin is None:
>>>              self.cancel("No QEMU binary defined or found in the source tree")
>>>          self.vm = QEMUMachine(self.qemu_bin)
