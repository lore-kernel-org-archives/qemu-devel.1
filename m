Received: from eggs.gnu.org ([2001:4830:134:3::10]:56441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8VY-00086T-Cc
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8VU-0004Tb-6d
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:19:48 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:37432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8VT-0004RR-W2
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:19:44 -0400
Received: by mail-vk0-x244.google.com with SMTP id m144-v6so12041538vke.4
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:19:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <67acd251-53f8-fa57-449b-f82b5bb92382@amsat.org>
Date: Wed, 30 May 2018 18:19:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180530184156.15634-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/5] Add functional/acceptance tests
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>

Hi Cleber,

On 05/30/2018 03:41 PM, Cleber Rosa wrote:
> This patch adds the very minimum infrastructure necessary for writing
> and running functional/acceptance tests, including:
> 
>  * Documentation
>  * The avocado_qemu.Test base test class
>  * One example tests (version.py)
> 
> Additional functionality is expected to be added along the tests that
> require them.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/testing.rst                    | 192 ++++++++++++++++++++++
>  tests/acceptance/README.rst               |  10 ++
>  tests/acceptance/avocado_qemu/__init__.py |  54 ++++++
>  tests/acceptance/version.py               |  24 +++
>  4 files changed, 280 insertions(+)
>  create mode 100644 tests/acceptance/README.rst
>  create mode 100644 tests/acceptance/avocado_qemu/__init__.py
>  create mode 100644 tests/acceptance/version.py
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 0ca1a2d4b5..6cc04c6d78 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -484,3 +484,195 @@ supported. To start the fuzzer, run
>  
>  Alternatively, some command different from "qemu-img info" can be tested, by
>  changing the ``-c`` option.
> +
> +Acceptance tests using the Avocado Framework
> +============================================
> +
> +The ``tests/acceptance`` directory hosts functional tests, also known
> +as acceptance level tests.  They're usually higher level tests, and
> +may interact with external resources and with various guest operating
> +systems.
> +
> +These tests are written using the Avocado Testing Framework (which must
> +be installed separately) in conjunction with a the ``avocado_qemu.Test``
> +class, implemented at ``tests/acceptance/avocado_qemu``.
> +
> +Tests based on ``avocado_qemu.Test`` can easily:
> +
> + * Customize the command line arguments given to the convenience
> +   ``self.vm`` attribute (a QEMUMachine instance)
> +
> + * Interact with the QEMU monitor, send QMP commands and check
> +   their results
> +
> + * Interact with the guest OS, using the convenience console device
> +   (which may be useful to assert the effectiveness and correctness of
> +   command line arguments or QMP commands)
> +
> + * Interact with external data files that accompany the test itself
> +   (see ``self.get_data()``)
> +
> + * Donwload (and cache) remote data files, such as firmware and kernel
> +   images
> +
> + * Have access to a library of guest OS images (by means of the
> +   ``avocado.utils.vmimage`` library)
> +
> + * Make use of various other test related utilities available at the
> +   test class itself and at the utility library:
> +
> +   - http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.html#avocado.Test
> +   - http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado.utils.html
> +
> +Installation
> +------------
> +
> +To install Avocado and its dependencies, run:
> +
> +.. code::
> +
> +  pip install --user avocado-framework
> +
> +Alternatively, follow the instructions on this link:
> +
> +  http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
> +
> +Overview
> +--------
> +
> +This directory provides the ``avocado_qemu`` Python module, containing
> +the ``avocado_qemu.Test`` class.  Here's a simple usage example:
> +
> +.. code::
> +
> +  from avocado_qemu import Test
> +
> +
> +  class Version(Test):
> +      """
> +      :avocado: enable
> +      :avocado: tags=quick
> +      """
> +      def test_qmp_human_info_version(self):
> +          self.vm.launch()
> +          res = self.vm.command('human-monitor-command',
> +                                command_line='info version')
> +          self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
> +
> +To execute your test, run:
> +
> +.. code::
> +
> +  avocado run version.py
> +
> +Tests may be classified according to a convention by using docstring
> +directives such as ``:avocado: tags=TAG1,TAG2``.  To run all tests
> +in the current directory, tagged as "quick", run:
> +
> +.. code::
> +
> +  avocado run -t quick .
> +
> +The ``avocado_qemu.Test`` base test class
> +-----------------------------------------
> +
> +The ``avocado_qemu.Test`` class has a number of characteristics that
> +are worth being mentioned right away.
> +
> +First of all, it attempts to give each test a ready to use QEMUMachine
> +instance, available at ``self.vm``.  Because many tests will tweak the
> +QEMU command line, launching the QEMUMachine (by using ``self.vm.launch()``)
> +is left to the test writer.
> +
> +At test "tear down", ``avocado_qemu.Test`` handles the QEMUMachine
> +shutdown.
> +
> +QEMUMachine
> +~~~~~~~~~~~
> +
> +The QEMUMachine API is already widely used in the Python iotests,
> +device-crash-test and other Python scripts.  It's a wrapper around the
> +execution of a QEMU binary, giving its users:
> +
> + * the ability to set command line arguments to be given to the QEMU
> +   binary
> +
> + * a ready to use QMP connection and interface, which can be used to
> +   send commands and inspect its results, as well as asynchronous
> +   events
> +
> + * convenience methods to set commonly used command line arguments in
> +   a more succinct and intuitive way
> +
> +QEMU binary selection
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The QEMU binary used for the ``self.vm`` QEMUMachine instance will
> +primarily depend on the value of the ``qemu_bin`` parameter.  If it's
> +not explicitly set, its default value will be the result of a dynamic
> +probe in the same source tree.  A suitable binary will be one that
> +targets the architecture matching host machine.
> +
> +Based on this description, test writers will usually rely on one of
> +the following approaches:
> +
> +1) Set ``qemu_bin``, and use the given binary

This didn't work well for me. I suppose I didn't understood correctly
the doc and messed in how to set qemu_bin from command line.
Is this possible to set it from command line anyway?

I first tried setting the env var QTEST_QEMU_BINARY like C qtests, but
it didn't work, then I used the QEMU env var like in vm.BaseVM but this
didn't work neither, then I dig with 'git grep' and noticed we can not
set env var.

    To understand how Avocado parameters are accessed by tests, and how
    they can be passed to tests, please refer to::


http://avocado-framework.readthedocs.io/en/latest/WritingTests.html#accessing-test-parameters

I read this which led me to

http://avocado-framework.readthedocs.io/en/latest/TestParameters.html

I understood I have to use a mux via YAML file ... so I bailed out :P

I just wanted to run:

  $ avocado run --param qemu_bin=/tmp/qemu.elf
tests/acceptance/boot_linux_console.py

> +
> +2) Do not set ``qemu_bin``, and use a QEMU binary named like
> +   "${arch}-softmmu/qemu-system-${arch}", either in the current
> +   working directory, or in the current source tree.

This worked fine.

> +
> +The resulting ``qemu_bin`` value will be preserved in the
> +``avocado_qemu.Test`` as an attribute with the same name.
> +
> +Attribute reference
> +-------------------
> +
> +Besides the attributes and methods that are part of the base
> +``avocado.Test`` class, the following attributes are available on any
> +``avocado_qemu.Test`` instance.
> +
> +vm
> +~~
> +
> +A QEMUMachine instance, initially configured according to the given
> +``qemu_bin`` parameter.
> +
> +qemu_bin
> +~~~~~~~~
> +
> +The preserved value of the ``qemu_bin`` parameter or the result of the
> +dynamic probe for a QEMU binary in the current working directory or
> +source tree.
> +
> +Parameter reference
> +-------------------
> +
> +To understand how Avocado parameters are accessed by tests, and how
> +they can be passed to tests, please refer to::
> +
> +  http://avocado-framework.readthedocs.io/en/latest/WritingTests.html#accessing-test-parameters
> +
> +Parameter values can be easily seen in the log files, and will look
> +like the following:
> +
> +.. code::
> +
> +  PARAMS (key=qemu_bin, path=*, default=x86_64-softmmu/qemu-system-x86_64) => 'x86_64-softmmu/qemu-system-x86_64
> +
> +qemu_bin
> +~~~~~~~~
> +
> +The exact QEMU binary to be used on QEMUMachine.
> +
> +Uninstalling Avocado
> +--------------------
> +
> +If you've followed the installation instructions above, you can easily
> +uninstall Avocado.  Start by listing the packages you have installed::
> +
> +  pip list --user
> +
> +And remove any package you want with::
> +
> +  pip uninstall <package_name>
> diff --git a/tests/acceptance/README.rst b/tests/acceptance/README.rst
> new file mode 100644
> index 0000000000..89260faed6
> --- /dev/null
> +++ b/tests/acceptance/README.rst
> @@ -0,0 +1,10 @@
> +============================================
> +Acceptance tests using the Avocado Framework
> +============================================
> +
> +This directory contains functional tests, also known as acceptance
> +level tests.  They're usually higher level, and may interact with
> +external resources and with various guest operating systems.
> +
> +For more information, please refer to ``docs/devel/testing.rst``,
> +section "Acceptance tests using the Avocado Framework".
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> new file mode 100644
> index 0000000000..1e54fd5932
> --- /dev/null
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -0,0 +1,54 @@
> +# Test class and utilities for functional tests
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import sys
> +
> +import avocado
> +
> +SRC_ROOT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
> +SRC_ROOT_DIR = os.path.abspath(os.path.dirname(SRC_ROOT_DIR))
> +sys.path.append(os.path.join(SRC_ROOT_DIR, 'scripts'))
> +
> +from qemu import QEMUMachine
> +
> +def is_readable_executable_file(path):
> +    return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
> +
> +
> +def pick_default_qemu_bin():
> +    """
> +    Picks the path of a QEMU binary, starting either in the current working
> +    directory or in the source tree root directory.
> +    """
> +    arch = os.uname()[4]
> +    qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
> +                                          "qemu-system-%s" % arch)
> +    if is_readable_executable_file(qemu_bin_relative_path):
> +        return qemu_bin_relative_path
> +
> +    qemu_bin_from_src_dir_path = os.path.join(SRC_ROOT_DIR,
> +                                              qemu_bin_relative_path)
> +    if is_readable_executable_file(qemu_bin_from_src_dir_path):
> +        return qemu_bin_from_src_dir_path
> +
> +
> +class Test(avocado.Test):
> +    def setUp(self):
> +        self.vm = None
> +        self.qemu_bin = self.params.get('qemu_bin',
> +                                        default=pick_default_qemu_bin())
> +        if self.qemu_bin is None:
> +            self.cancel("No QEMU binary defined or found in the source tree")
> +        self.vm = QEMUMachine(self.qemu_bin)
> +
> +    def tearDown(self):
> +        if self.vm is not None:
> +            self.vm.shutdown()
> diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
> new file mode 100644
> index 0000000000..13b0a7440d
> --- /dev/null
> +++ b/tests/acceptance/version.py
> @@ -0,0 +1,24 @@
> +# Version check example test
> +#
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +
> +from avocado_qemu import Test
> +
> +
> +class Version(Test):
> +    """
> +    :avocado: enable
> +    :avocado: tags=quick
> +    """
> +    def test_qmp_human_info_version(self):
> +        self.vm.launch()
> +        res = self.vm.command('human-monitor-command',
> +                              command_line='info version')
> +        self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
> 

Good example test :) Tiny and effective.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
