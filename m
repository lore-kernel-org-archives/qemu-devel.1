Received: from eggs.gnu.org ([209.51.188.92]:60684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1goXV1-0006iC-6x
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1goXUw-0005tE-0t
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:48:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1goXUt-0005qg-TY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:48:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 499DA80F6C
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 17:48:26 +0000 (UTC)
References: <20190128174725.8809-1-ccarrara@redhat.com>
	<20190128174725.8809-2-ccarrara@redhat.com>
	<bc08dd05-82c5-a4e9-ca7f-883eb27c865e@redhat.com>
	<20190129113055.GA19301@localhost.localdomain>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <935ae139-4142-aa68-e05f-3cd99c113cbd@redhat.com>
Date: Tue, 29 Jan 2019 15:48:19 -0200
MIME-Version: 1.0
In-Reply-To: <20190129113055.GA19301@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/2] tests.acceptance: adds multi vm
 capability for acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>
Cc: crosa@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com


On 01/29/2019 09:30 AM, Caio Carrara wrote:
> Hi, Wainer.
>
> On Mon, Jan 28, 2019 at 05:42:24PM -0200, Wainer dos Santos Moschetta wrote:
>> On 01/28/2019 03:47 PM, Caio Carrara wrote:
>>> This change adds the possibility to write acceptance tests with multi
>>> virtual machine support. It's done keeping the virtual machines objects
>>> stored in a test attribute (dictionary). This dictionary shouldn't be
>>> accessed directly but through the new method added `get_vm`. This new
>>> method accept a list of args (that will be added as virtual machine
>>> arguments) and an optional name argument. The name is the key that
>>> identify a single virtual machine along the test machines available. If
>>> a name without a machine is informed a new machine will be instantiated.
>>>
>>> The current usage of vm in tests will not be broken by this change since
>>> it keeps a property called vm in the base test class. This property only
>>> calls the new method `get_vm` with default parameters (no args and
>>> 'default' as machine name).
>> I've checked that current tests does not break by this change. I also
>> checked the example you provided on docs/devel/testing.rst works too.
>>
>> So Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>
>>> Signed-off-by: Caio Carrara <ccarrara@redhat.com>
>>> ---
>>>    docs/devel/testing.rst                    | 40 ++++++++++++++++++++++-
>>>    tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++---
>>>    2 files changed, 60 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>>> index 18e2c0868a..b97c0368bc 100644
>>> --- a/docs/devel/testing.rst
>>> +++ b/docs/devel/testing.rst
>>> @@ -634,7 +634,45 @@ instance, available at ``self.vm``.  Because many tests will tweak the
>>>    QEMU command line, launching the QEMUMachine (by using ``self.vm.launch()``)
>>>    is left to the test writer.
>>> -At test "tear down", ``avocado_qemu.Test`` handles the QEMUMachine
>>> +The base test class has also support for tests with more than one
>>> +QEMUMachine. The way to get machines is through the ``self.get_vm()``
>>> +method which will return a QEMUMachine instance. The ``self.get_vm()``
>>> +method also accepts an optional `name` attribute so you can identify a
>>> +specific machine and get it more than once through the tests methods. A
>>> +simple and hypothetical example follows:
>> Since you explain the self.get_vm() optional name attribute, you also could
>> mention it accepts arguments to be passed to the newly created VM.
>>
>>> +
>>> +.. code::
>>> +
>>> +  from avocado_qemu import Test
>>> +
>>> +
>>> +  class MultipleMachines(Test):
>>> +      """
>>> +      :avocado: enable
>>> +      """
>>> +      def test_multiple_machines(self):
>>> +          first_machine = self.get_vm()
>>> +          second_machine = self.get_vm()
>>> +          self.get_vm(name='third_machine').launch()
>>> +
>>> +          first_machine.launch()
>>> +          second_machine.launch()
>>> +
>>> +          first_res = first_machine.command(
>>> +              'human-monitor-command',
>>> +              command_line='info version')
>>> +
>>> +          second_res = second_machine.command(
>>> +              'human-monitor-command',
>>> +              command_line='info version')
>>> +
>>> +          third_res = self.get_vm(name='third_machine').command(
>>> +              'human-monitor-command',
>>> +              command_line='info version')
>>> +
>>> +          self.assertEquals(first_res, second_res, third_res)
>>> +
>>> +At test "tear down", ``avocado_qemu.Test`` handles all the QEMUMachines
>>>    shutdown.
>>>    QEMUMachine
>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
>>> index 1e54fd5932..4c9e27feda 100644
>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>> @@ -10,6 +10,7 @@
>>>    import os
>>>    import sys
>>> +import uuid
>>>    import avocado
>>> @@ -42,13 +43,29 @@ def pick_default_qemu_bin():
>>>    class Test(avocado.Test):
>>>        def setUp(self):
>>> -        self.vm = None
>>> +        self._vms = {}
>>>            self.qemu_bin = self.params.get('qemu_bin',
>>>                                            default=pick_default_qemu_bin())
>>>            if self.qemu_bin is None:
>>>                self.cancel("No QEMU binary defined or found in the source tree")
>>> -        self.vm = QEMUMachine(self.qemu_bin)
>>> +
>>> +    def _new_vm(self, *args):
>>> +        vm = QEMUMachine(self.qemu_bin)
>>> +        if args:
>>> +            vm.add_args(*args)
>>> +        return vm
>>> +
>>> +    @property
>>> +    def vm(self):
>>> +        return self.get_vm(name='default')
>>> +
>>> +    def get_vm(self, *args, name=None):
>>> +        if not name:
>>> +            name = str(uuid.uuid4())
>> Beware that if you don't give a name to the VM, the only way to access it
>> later is to keep the reference returned by get_vm(). Do you think it is
>> something we should care about? or assume the test writer handle this
>> (unlikely?) case somehow?
> I think it's something e should assume the test writer is going to
> handle.

Fair enough.

- Wainer

>> - Wainer
>>
>>> +        if self._vms.get(name) is None:
>>> +            self._vms[name] = self._new_vm(*args)
>>> +        return self._vms[name]
>>>        def tearDown(self):
>>> -        if self.vm is not None:
>>> -            self.vm.shutdown()
>>> +        for vm in self._vms.values():
>>> +            vm.shutdown()
> Thanks,
>
