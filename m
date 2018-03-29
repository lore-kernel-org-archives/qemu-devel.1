Received: from eggs.gnu.org ([2001:4830:134:3::10]:60864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGG-0001U9-Ke
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f1fGD-0007Mf-GG
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f1fGD-0007L8-8Z
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 17:39:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Mar 2018 18:38:39 -0300
Message-Id: <20180329213857.15499-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 00/18] QEMU validator: A method to specify QEMU
 crash-test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>, Amador Pahim <apahim@redhat.com>

Rationale
---------

Today we have a few test cases in the QEMU tree that just run
QEMU with a few command-line options, run some QMP or HMP
commands, and check if QEMU didn't crash.

Some examples:
* scripts/device-crash-test
* The test case suggested by Thomas at:
  Subject: [RFC PATCH] tests: Add a device_add/del HMP test
* Some test cases in tests/device-introspect-test.c
* tests/cpu-plug-test.c
* tests/display-vga-test.c
* tests/drive_del-test.c
* tests/machine-none-test.c
* tests/test-hmp.c
* Some device test skeletons: ac97-test.c, e1000-test.c,
  eepro100-test.c, es1370-test.c, i82801b11-test.c,
  intel-hda-test.c, ioh3420-test.c, ipoctal232-test.c,
  ne2000-test.c, nvme-test.c, pcnet-test.c, spapr-phb-test.c,
  test-netfilter.c, tpci200-test.c, usb-hcd-ohci-test.c,
  usb-hcd-xhci-test.c, virtio-balloon-test.c,
  virtio-console-test.c, virtio-serial-test.c, vmxnet3-test.c.

All of those test cases require lots of boilerplate code just to
run some combinations of QEMU command-line options and monitor
commands.

In addition to that, writing and reviewing test code like the
examples above is more complex than it could be.  Some past
examples from qemu-devel:
* Subject: [RFC 5/6] device-crash-test: Basic device_add support
* Subject: [RFC 6/6] device-crash-test: Multi-device device_add test
* Subject: [RFC PATCH] tests/device-introspect: Test devices with all machines,
           not only with "none"

The Proposal
------------

This series introduces the scripts/validator.py test runner, and
a set of example test specifications in tests/validator.

Each test specification is a YAML file containing the QEMU
command-line and monitor commands to run, and can contain
variables like $MACHINE, $DEVICE, $CPU, that can be expanded
automatically by the test runner.

This way, scripts/device-crash-test can be replaced by a one-line
test specification:

    command-line: '$QEMU -S -machine $MACHINE,accel=$ACCEL -device $DEVICE'

The device_add/device_del test case written by Thomas can be specified as:

    command-line: '$QEMU -S -machine $MACHINE,accel=$ACCEL'
    monitor-commands:
    - qmp:
      - execute: 'device_add'
        arguments:
          driver: '$DEVICE'
          id: 'test-device-for-$DEVICE'
      - execute: 'device_del'
        arguments:
          id: 'test-device-for-$DEVICE'

and the test runner will take care of running test cases with
with all valid machine-types, device-types, and accelerators.

For other examples, see the last patch in this series
("Collection of validator.py test cases").  Most of the examples
replace existing C or Python test cases with simple declarative
test specifications.

I expect this to be very useful when somebody is fixing a QEMU
crash and just want to add a very simple reproducer to ensure the
crash will never be introduced again.

(I actually suggest we _require_ people to include a
tests/validator test specifications every time they fix a crash
that can be reproduced using just QMP commands).

Features
--------

Current features:
* Automatic variable expansion, as described above
* A simple method to specify defaults (e.g. to test only
  "-machine none" or only "accel=kvm:tcg" unless running in --full mode)
* A simple method to represent expected failures (it can't
  replace the device-crash-test whitelist mechanism, yet)

Caveats
-------

The test runner code still needs some clean up.  I'm not happy with the current
variable enumeration/expansion code, and plan to make it cleaner.

How to test
-----------

You can run all example test cases on /usr/bin/qemu-system-x86_64 with:

  $ ./scripts/validator.py tests/validator/* -V QEMU=/usr/bin/qemu-system-x86_64

However, the device-crash-test.yaml test specification still
takes too long to run and reports too many false positives.  So I
suggest doing this instead:

  $ ./scripts/validator.py $(ls tests/validator/* | grep -v device-crash-test) \
        -V QEMU=/usr/bin/qemu-system-x86_64

On my system, this runs ~700 test cases in ~15 seconds.

What's out of scope?
--------------------

The following are _not_ goals of this system:
* Replacing the work done by the Avocado team to support
  Avocado-based tests.
* Making the YAML test specification a fully-featured imperative
  language.  Anything that requires extra logic still needs to be
  written in C or Python.

Future Plans
------------

Short term:
* Choose a better name for the test runner
* Support a list of known-failures similar to the whitelist
  in device-crash-test.
* Replace device-crash-test completely
* "make check" rules

Long term:
* stdout and QMP command output validation.
  I plan to use this to write machine-type/guest-ABI
  compatibility test cases that will detect guest ABI breakage as
  soon as possible.
* See if the Avocado multiplexer API can be used to implement
  variable expansion.
* See if we can make some of the features (e.g. automatic
  variable expansion) available to Python test cases
* Fuzzing QMP commands and QEMU command-line arguments.
* See if code can be shared with the iotests test
  runner (especially the variable expansion logic)

Eduardo Habkost (18):
  qmp.py: Make it safe to call close() any time
  qmp.py: Fix error handling for Python 3
  qmp.py: Cleanly handle unexpectedly closed socket
  qemu.py: Make _vm_monitor a method
  qemu.py: Split _base_args()
  qemu.py: Move _load_io_log() call to _post_shutdown()
  qemu.py: Use wait() logic inside shutdown()
  qemu.py: Close _qmp inside _post_shutdown()
  qemu.py: Make monitor optional
  qemu.py: Set _launched = False on _post_shutdown
  qemu.py: Log crashes inside _post_shutdown()
  qemu.py: Only wait for process if it's still running
  qemu.py: 'force' parameter on shutdown()
  qemu.py: Don't try to quit cleanly on exceptions
  qemu.py: qmp_obj() method
  qemu.py: is_launched() method
  validator.py script
  Collection of validator.py test cases

 scripts/qemu.py                        | 112 +++--
 scripts/qmp/qmp.py                     |  16 +-
 scripts/validator.py                   | 724 +++++++++++++++++++++++++++++++++
 tests/validator/cpu.yaml               |   5 +
 tests/validator/device-add.yaml        |  17 +
 tests/validator/device-crash-test.yaml |   7 +
 tests/validator/device-help.yaml       |   3 +
 tests/validator/device-introspect.yaml |  23 ++
 tests/validator/device-list.yaml       |  10 +
 tests/validator/just-help.yaml         |   3 +
 10 files changed, 876 insertions(+), 44 deletions(-)
 create mode 100755 scripts/validator.py
 create mode 100644 tests/validator/cpu.yaml
 create mode 100644 tests/validator/device-add.yaml
 create mode 100644 tests/validator/device-crash-test.yaml
 create mode 100644 tests/validator/device-help.yaml
 create mode 100644 tests/validator/device-introspect.yaml
 create mode 100644 tests/validator/device-list.yaml
 create mode 100644 tests/validator/just-help.yaml

-- 
2.14.3
