Received: from eggs.gnu.org ([209.51.188.92]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gmGn9-0002rE-1J
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gmGn7-0006Wu-Rx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:33:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gmGn7-0006WK-Ga
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:33:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AB7380F82
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 11:26:48 +0000 (UTC)
References: <20190114155510.23358-1-ccarrara@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <7e41a167-696a-963f-8077-0ba3dcf82e0b@redhat.com>
Date: Wed, 23 Jan 2019 06:26:39 -0500
MIME-Version: 1.0
In-Reply-To: <20190114155510.23358-1-ccarrara@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests.acceptance: adds multi vm capability
 for acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org
Cc: wainersm@redhat.com, ehabkost@redhat.com, philmd@redhat.com



On 1/14/19 10:55 AM, Caio Carrara wrote:
> This change adds the possibility to write acceptance tests with multi
> virtual machine support. It's done keeping the virtual machines objects
> stored in a test attribute (dictionary). This dictionary shouldn't be
> accessed directly but through the new method added `get_vm`. This new
> method accept a list of args (that will be added as virtual machine
> arguments) and an optional name argument. The name is the key that
> identify a single virtual machine along the test machines available. If
> a name without a machine is informed a new machine will be instantiated.
> 
> The current usage of vm in tests will not be broken by this change since
> it keeps a property called vm in the base test class. This property only
> calls the new method `get_vm` with default parameters (no args and
> 'default' as machine name).
> 
> Signed-off-by: Caio Carrara <ccarrara@redhat.com>
> ---
>  docs/devel/testing.rst                    | 40 ++++++++++++++++++++++-
>  tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++---
>  2 files changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 18e2c0868a..b97c0368bc 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -634,7 +634,45 @@ instance, available at ``self.vm``.  Because many tests will tweak the
>  QEMU command line, launching the QEMUMachine (by using ``self.vm.launch()``)
>  is left to the test writer.
>  
> -At test "tear down", ``avocado_qemu.Test`` handles the QEMUMachine
> +The base test class has also support for tests with more than one
> +QEMUMachine. The way to get machines is through the ``self.get_vm()``
> +method which will return a QEMUMachine instance. The ``self.get_vm()``
> +method also accepts an optional `name` attribute so you can identify a
> +specific machine and get it more than once through the tests methods. A
> +simple and hypothetical example follows:
> +
> +.. code::
> +
> +  from avocado_qemu import Test
> +
> +
> +  class MultipleMachines(Test):
> +      """
> +      :avocado: enable
> +      """
> +      def test_multiple_machines(self):
> +          first_machine = self.get_vm()
> +          second_machine = self.get_vm()
> +          self.get_vm(name='third_machine').launch()
> +
> +          first_machine.launch()
> +          second_machine.launch()
> +
> +          first_res = first_machine.command(
> +              'human-monitor-command',
> +              command_line='info version')
> +
> +          second_res = second_machine.command(
> +              'human-monitor-command',
> +              command_line='info version')
> +
> +          third_res = self.get_vm(name='third_machine').command(
> +              'human-monitor-command',
> +              command_line='info version')
> +
> +          self.assertEquals(first_res, second_res, third_res)
> +
> +At test "tear down", ``avocado_qemu.Test`` handles all the QEMUMachines
>  shutdown.
>  
>  QEMUMachine
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 1e54fd5932..4c9e27feda 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -10,6 +10,7 @@
>  
>  import os
>  import sys
> +import uuid
>  
>  import avocado
>  
> @@ -42,13 +43,29 @@ def pick_default_qemu_bin():
>  
>  class Test(avocado.Test):
>      def setUp(self):
> -        self.vm = None
> +        self._vms = {}
>          self.qemu_bin = self.params.get('qemu_bin',
>                                          default=pick_default_qemu_bin())
>          if self.qemu_bin is None:
>              self.cancel("No QEMU binary defined or found in the source tree")
> -        self.vm = QEMUMachine(self.qemu_bin)
> +
> +    def _new_vm(self, *args):
> +        vm = QEMUMachine(self.qemu_bin)
> +        if args:
> +            vm.add_args(*args)
> +        return vm
> +
> +    @property
> +    def vm(self):
> +        return self.get_vm(name='default')
> +
> +    def get_vm(self, *args, name=None):
> +        if not name:
> +            name = str(uuid.uuid4())
> +        if self._vms.get(name) is None:
> +            self._vms[name] = self._new_vm(*args)
> +        return self._vms[name]
>  
>      def tearDown(self):
> -        if self.vm is not None:
> -            self.vm.shutdown()
> +        for vm in self._vms.values():
> +            vm.shutdown()
> 

Hi Caio,

I approached the newly added API purely from a user perspective, and I'm
quite happy with the results.  I've written a simple migration test
based on the API you're proposing:

https://github.com/clebergnu/qemu/commit/311ad8c8e06382616aa12403da02d001014712af

While I don't see any problems with this patch, I'd recommend you to
send another version with some concrete tests (feel free to pick that
commit above and include in your series).

Ideally, I'd also like to see some coverage for the use case of "getting
vms by name", that is:

   self.get_vm("name").make_sure_its_new()
   self.get_vm("name").do_stuff()
   other_code()
   self.get_vm("name").make_sure_its_the_same()

But that would be better done in tests for the test infrastructure code,
instead of a QEMU test.  Hopefully when get to the point of having a
formal Python module, we'll have the right place to add those.

Regards,
- Cleber.
