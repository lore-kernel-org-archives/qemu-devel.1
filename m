Received: from eggs.gnu.org ([2001:4830:134:3::10]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9adm-0004Pe-5z
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9adi-0004EO-Gp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9adi-0004DA-8H
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:20:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:27 -0300
Message-Id: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 00/24] Avocado-based functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A few months ago, Cleber started a thread[1] about the system for
Avocado-based tests.  He invited people to take a look at it, we
got some interesting feedback.

However, I saw no feedback on the actual code itself, and I don't
know what needs to be done to get this merged.

To make sure we're having a discussion about the implementation
of avocado_qemu and to figure out what's still necessary to get
it included, I am sending all the commits from Amador's
avocado_qemu branch[2] as a RFC.

Note that I didn't review most of this code yet, and I will
probably send comments and questions as replies to this RFC
later.

Also, many of the patches in this series probably can be squashed
together, but I decided to not do that before getting some
feedback on the changes.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg506859.html
[2] https://github.com/apahim/qemu/commits/avocado_qemu

README
=3D=3D=3D=3D=3D=3D

Below, I'm copying the raw contents of tests/avocado/README.rst,
for reference:

----------------------------------------------------------------------

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 QEMU tests using the Avocado Framework
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This directory [tests/avocado] hosts functional tests written
using Avocado Testing Framework.

Installation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

To install Avocado and the dependencies needed for these tests, run::

    pip install --user avocado-framework avocado-framework-plugin-variant=
er-yaml-to-mux aexpect

Alternatively, follow the instructions on this link::

    http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.htm=
l#installing-avocado

Overview
=3D=3D=3D=3D=3D=3D=3D=3D

In this directory [tests/avocado], an ``avocado_qemu`` package is
provided, containing the ``test`` module, which inherits from
``avocado.Test`` and provides a builtin and easy-to-use Qemu
virtual machine. Here's a template that can be used as reference
to start writing your own tests::

    from avocado_qemu import test

    class MyTest(test.QemuTest):
        """
        :avocado: enable
        """

        def setUp(self):
            self.vm.args.extend(['-m', '512'])
            self.vm.launch()

        def test_01(self):
            res =3D self.vm.qmp('human-monitor-command',
                              command_line=3D'info version')
            self.assertIn('v2.9.0', res['return'])

        def tearDown(self):
            self.vm.shutdown()

To execute your test, run::

    avocado run test_my_test.py

To execute all tests, run::

    avocado run .

If you don't specify the Qemu binary to use, the ``avocado_qemu``
package will automatically probe it. The probe will try to use the Qemu
binary from the git tree build directory, using the same architecture as
the local system (if the architecture is not specified). If the Qemu
binary is not available in the git tree build directory, the next try is
to use the system installed Qemu binary.

You can define a number of optional parameters, providing them via YAML
file using the Avocado parameters system:

- ``qemu_bin``: Use a given Qemu binary, skipping the automatic
  probe. Example: ``qemu_bin: /usr/libexec/qemu-kvm``.
- ``qemu_dst_bin``: Use a given Qemu binary to create the destination VM
  when the migration process takes place. If it's not provided, the same
  binary used in the source VM will be used for the destination VM.
  Example: ``qemu_dst_bin: /usr/libexec/qemu-kvm-binary2``.
- ``arch``: Probe the Qemu binary from a given architecture. It has no
  effect if ``qemu_bin`` is specified. If not provided, the binary probe
  will use the system architecture. Example: ``arch: x86_64``
- ``image_path``: When a test requires (usually a bootable) image, this
  parameter is used to define where the image is located. When undefined
  it uses ``$QEMU_ROOT/bootable_image_$arch.qcow2``. The image is added
  to the qemu command __only__ when the test requires an image. By
  default ``,snapshot=3Don`` is used, but it can be altered by
  ``image_snapshot`` parameter.
- ``image_user`` and ``image_pass``: When using a ``image_path``, if you
  want to get the console from the Guest OS you have to define the Guest
  OS credentials. Example: ``image_user: avocado`` and
  ``image_pass: p4ssw0rd``. Both parameters have defaults to ``avocado``.
- ``machine_type``: Use this option to define a machine type for the VM.
  Example: ``machine_type: pc``
- ``machine_accel``: Use this option to define a machine acceleration
  for the VM. Example: ``machine_accel: kvm``.
- ``machine_kvm_type``: Use this option to select the KVM type when the
  ``accel`` is ``kvm`` and there are more than one KVM types available.
  Example: ``machine_kvm_type: PR``

Run the test with::

    $ avocado run test_my_test.py -m parameters.yaml

Additionally, you can use a variants file to to set different values
for each parameter. Using the YAML tag ``!mux`` Avocado will execute the
tests once per combination of parameters. Example::

    $ cat variants.yaml
    architecture: !mux
        x86_64:
            arch: x86_64
        i386:
            arch: i386

Run it the with::

    $ avocado run test_my_test.py -m variants.yaml

You can use both the parameters file and the variants file in the same
command line::

    $ avocado run test_my_test.py -m parameters.yaml variants.yaml

Avocado will then merge the parameters from both files and create the
proper variants.

See ``avocado run --help`` and ``man avocado`` for several other
options, such as ``--filter-by-tags``, ``--show-job-log``,
``--failfast``, etc.

Uninstallation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If you've followed the installation instructions above, you can easily
uninstall Avocado.  Start by listing the packages you have installed::

    pip list --user

And remove any package you want with::

    pip uninstall <package_name>

Amador Pahim (12):
  qemu.py: Introduce _create_console() method
  Introduce the basic framework to run Avocado tests
  avocado_qemu: Fix exception name in caller
  avocado_qemu: Improve migration error message
  avocado_qemu: Functional test for RHBZ#1431939
  avocado_qemu: Functional test for RHBZ#1447027
  avocado_qemu: Functional test for RHBZ#1436616
  avocado_qemu: Clean unneeded 'pass'
  avocado_qemu: Set QMP log level to INFO
  avocado_qemu: Introduce the add_image() VM API
  avocado_qemu: Tests fixes
  avocado_qemu: Force vmimage distro

Cleber Rosa (3):
  avocado_qemu: Remove duplicate PortTracker implementation
  avocado_qemu: Simplify the installation instructions
  avocado_qemu: Add a few VNC related tests

Luk=C3=A1=C5=A1 Doktor (9):
  avocado_qemu: Improve handle_prompts to allow login after booted vm
  avocado_qemu: Be lenient towards poluted serial console
  avocado_qemu: Increase the login timeout to 60s
  avocado_qemu: Add " " after the default prompt regexp
  avocado_qemu: Store "arch" in VM
  avocado_qemu: Provide defaults for user and pass
  avocado_qemu: Ignore kernel messages on get_console
  avocado_qemu: Add support to request image for testing
  avocado_qemu: Functional test for RHBZ1473203

 scripts/qemu.py                                    |  59 ++-
 tests/avocado/README.rst                           | 132 +++++++
 tests/avocado/avocado_qemu/__init__.py             |   0
 tests/avocado/avocado_qemu/test.py                 | 418 +++++++++++++++=
++++++
 tests/avocado/parameters.yaml                      |  19 +
 tests/avocado/test_info_memdev_host_nodes.py       |  66 ++++
 tests/avocado/test_nec-usb-xhci.py                 |  63 ++++
 .../test_nec-usb-xhci.py.data/parameters.yaml      |   4 +
 tests/avocado/test_numa_hotplug.py                 | 120 ++++++
 tests/avocado/test_ovmf_with_240_vcpus.py          |  70 ++++
 .../parameters.yaml                                |   2 +
 tests/avocado/test_vnc.py                          |  58 +++
 tests/avocado/variants.yaml                        |  62 +++
 tests/qemu-iotests/iotests.py                      |  28 +-
 14 files changed, 1077 insertions(+), 24 deletions(-)
 create mode 100644 tests/avocado/README.rst
 create mode 100644 tests/avocado/avocado_qemu/__init__.py
 create mode 100644 tests/avocado/avocado_qemu/test.py
 create mode 100644 tests/avocado/parameters.yaml
 create mode 100644 tests/avocado/test_info_memdev_host_nodes.py
 create mode 100644 tests/avocado/test_nec-usb-xhci.py
 create mode 100644 tests/avocado/test_nec-usb-xhci.py.data/parameters.ya=
ml
 create mode 100644 tests/avocado/test_numa_hotplug.py
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py
 create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py.data/parame=
ters.yaml
 create mode 100644 tests/avocado/test_vnc.py
 create mode 100644 tests/avocado/variants.yaml

--=20
2.14.3
