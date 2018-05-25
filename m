Received: from eggs.gnu.org ([208.118.235.92]:41491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMFO4-0003ik-QN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fMFNM-0000b4-Jn
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:16:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fMFNM-0000aF-6u
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:15:32 -0400
References: <20180525005839.11556-1-crosa@redhat.com>
	<20180525005839.11556-2-crosa@redhat.com>
	<20180525053358.GA28589@lemon.usersys.redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <fd13b0c9-c375-9781-626a-d3c0714defcb@redhat.com>
Date: Fri, 25 May 2018 12:15:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180525053358.GA28589@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] Add functional/acceptance tests
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Amador Pahim <amador@pahim.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 05/25/2018 01:33 AM, Fam Zheng wrote:
> On Thu, 05/24 20:58, Cleber Rosa wrote:
>> This patch adds the very minimum infrastructure necessary for writing
>> and running functional/acceptance tests, including:
>>
>>  * Documentation
>>  * The avocado_qemu.Test base test class
>>  * One example tests (test_version.py)
>>
>> Additional functionality is expected to be added along the tests that
>> require them.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/acceptance/README.rst               | 141 ++++++++++++++++++++++
> 
> Could you add the actual doc text to docs/devel/testing.rst and reference it
> here?
> 

Yes, sure.

>>  tests/acceptance/avocado_qemu/__init__.py |  45 +++++++
>>  tests/acceptance/test_version.py          |  13 ++
>>  3 files changed, 199 insertions(+)
>>  create mode 100644 tests/acceptance/README.rst
>>  create mode 100644 tests/acceptance/avocado_qemu/__init__.py
>>  create mode 100644 tests/acceptance/test_version.py
>>
>> diff --git a/tests/acceptance/README.rst b/tests/acceptance/README.rst
>> new file mode 100644
>> index 0000000000..f1434177da
>> --- /dev/null
>> +++ b/tests/acceptance/README.rst
>> @@ -0,0 +1,141 @@
>> +==============================================
>> + Acceptance tests using the Avocado Framework
>> +==============================================
>> +
>> +This directory hosts functional tests, also known as acceptance level
>> +tests.  They're usually higher level, and may interact with external
>> +resources and with various guest operating systems.
>> +
>> +The tests are written using the Avocado Testing Framework, in
>> +conjunction with a the ``avocado_qemu.Test`` class, distributed here.
>> +
>> +Installation
>> +============
>> +
>> +To install Avocado and its dependencies, run::
>> +
>> +  pip install --user avocado-framework
>> +
>> +Alternatively, follow the instructions on this link:
>> +
>> +  http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
>> +
>> +Overview
>> +========
>> +
>> +This directory provides the ``avocado_qemu`` Python module, containing
>> +the ``avocado_qemu.Test`` class.  Here's a simple usage example::
>> +
>> +  from avocado_qemu import Test
>> +
>> +
>> +  class Version(Test):
>> +      """
>> +      :avocado: enable
>> +      :avocado: tags=quick
>> +      """
>> +      def test_qmp_human_info_version(self):
>> +          self.vm.launch()
>> +          res = self.vm.command('human-monitor-command',
>> +                                command_line='info version')
>> +          self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
>> +
>> +To execute your test, run::
>> +
>> +  avocado run test_version.py
>> +
>> +To run all tests in the current directory, tagged in a particular way,
>> +run::
>> +
>> +  avocado run -t <TAG> .
>> +
>> +The ``avocado_qemu.Test`` base test class
>> +=========================================
>> +
>> +The ``avocado_qemu.Test`` class has a number of characteristics that
>> +are worth being mentioned right away.
>> +
>> +First of all, it attempts to give each test a ready to use QEMUMachine
>> +instance, available at ``self.vm``.  Because many tests will tweak the
>> +QEMU command line, launching the QEMUMachine (by using ``self.vm.launch()``)
>> +is left to the test writer.
>> +
>> +At test "tear down", ``avocado_qemu.Test`` handles the QEMUMachine
>> +shutdown.
>> +
>> +QEMUMachine
>> +-----------
>> +
>> +The QEMUMachine API should be somewhat familiar to QEMU hackers.  It's
>> +used in the Python iotests, device-crash-test and other Python scripts.
>> +
>> +QEMU binary selection
>> +---------------------
>> +
>> +The QEMU binary used for the ``self.vm`` QEMUMachine instance will
>> +primarily depend on the value of the ``qemu_bin`` parameter.  If it's
>> +not explicitly set, its default value will be the result of a dynamic
>> +probe in the same source tree.  A suitable binary will be one that
>> +targets the architecture matching host machine.
>> +
>> +Based on this description, test writers will usually rely on one of
>> +the following approaches:
>> +
>> +1) Set ``qemu_bin``, and use the given binary
>> +
>> +2) Do not set ``qemu_bin``, and use a QEMU binary named like
>> +   "${arch}-softmmu/qemu-system-${arch}", either in the current
>> +   working directory, or in the current source tree.
>> +
>> +The resulting ``qemu_bin`` value will be preserved in the
>> +``avocado_qemu.Test`` as an attribute with the same name.
>> +
>> +Attribute reference
>> +===================
>> +
>> +Besides the attributes and methods that are part of the base
>> +``avocado.Test`` class, the following attributes are available on any
>> +``avocado_qemu.Test`` instance.
>> +
>> +vm
>> +--
>> +
>> +A QEMUMachine instance, initially configured according to the given
>> +``qemu_bin`` parameter.
>> +
>> +qemu_bin
>> +--------
>> +
>> +The preserved value of the ``qemu_bin`` parameter or the result of the
>> +dynamic probe for a QEMU binary in the current working directory or
>> +source tree.
>> +
>> +Parameter reference
>> +===================
>> +
>> +To understand how Avocado parameters are accessed by tests, and how
>> +they can be passed to tests, please refer to::
>> +
>> +  http://avocado-framework.readthedocs.io/en/latest/WritingTests.html#accessing-test-parameters
>> +
>> +Parameter values can be easily seen in the log files, and will look
>> +like the following::
>> +
>> +  PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
>> +
>> +qemu_bin
>> +--------
>> +
>> +The exact QEMU binary to be used on QEMUMachine.
>> +
>> +Uninstalling Avocado
>> +====================
>> +
>> +If you've followed the installation instructions above, you can easily
>> +uninstall Avocado.  Start by listing the packages you have installed::
>> +
>> +  pip list --user
>> +
>> +And remove any package you want with::
>> +
>> +  pip uninstall <package_name>
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
>> new file mode 100644
>> index 0000000000..dcd58047a3
>> --- /dev/null
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -0,0 +1,45 @@
> 
> A copy right header is necessary here.
> 

OK.

>> +import os
>> +import sys
>> +
>> +import avocado
>> +
>> +SRC_ROOT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
>> +SRC_ROOT_DIR = os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
>> +sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
>> +
>> +from qemu import QEMUMachine
>> +
>> +def is_readable_executable_file(path):
>> +    return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>> +
>> +
>> +def pick_default_qemu_bin():
>> +    """
>> +    Picks the path of a QEMU binary, starting either in the current working
>> +    directory or in the source tree root directory.
>> +    """
>> +    arch = os.uname()[4]
>> +    qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>> +                                          "qemu-system-%s" % arch)
>> +    if is_readable_executable_file(qemu_bin_relative_path):
>> +        return qemu_bin_relative_path
>> +
>> +    qemu_bin_from_src_dir_path = os.path.join(SRC_ROOT_DIR,
>> +                                              qemu_bin_relative_path)
>> +    if is_readable_executable_file(qemu_bin_from_src_dir_path):
>> +        return qemu_bin_from_src_dir_path
>> +
>> +
>> +class Test(avocado.Test):
>> +    def setUp(self):
>> +        self.vm = None
>> +        self.qemu_bin = None
>> +        self.qemu_bin = self.params.get('qemu_bin',
>> +                                        default=pick_default_qemu_bin())
>> +        if self.qemu_bin is None:
>> +            self.cancel("No QEMU binary defined or found in the source tree")
>> +        self.vm = QEMUMachine(self.qemu_bin)
>> +
>> +    def tearDown(self):
>> +        if self.vm is not None:
>> +            self.vm.shutdown()
>> diff --git a/tests/acceptance/test_version.py b/tests/acceptance/test_version.py
>> new file mode 100644
>> index 0000000000..e397f07d83
>> --- /dev/null
>> +++ b/tests/acceptance/test_version.py
>> @@ -0,0 +1,13 @@
>> +from avocado_qemu import Test
> 
> Same here.
> 

Sure.

- Cleber.

>> +
>> +
>> +class Version(Test):
>> +    """
>> +    :avocado: enable
>> +    :avocado: tags=quick
>> +    """
>> +    def test_qmp_human_info_version(self):
>> +        self.vm.launch()
>> +        res = self.vm.command('human-monitor-command',
>> +                              command_line='info version')
>> +        self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
>> -- 
>> 2.17.0
>>
> 
