Received: from eggs.gnu.org ([2001:4830:134:3::10]:45383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGWw-0007UI-UH
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRGWv-0004Wc-P6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:30:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 09:29:42 -0300
Message-Id: <20180608122952.2009-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/10] python: futurize --stage1 (Python 3
 compatibility)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2 note (v1 was RFC):

  Except for a trivial change in patch 02/10, this series is the
  same as the RFC I sent previously.  I plan to merge it and
  include it in a pull request soon.

>From the futurize[1] documentation:

> This applies fixes that modernize Python 2 code without
> changing the effect of the code.  With luck, this will not
> introduce any bugs into the code, or will at least be trivial
> to fix. The changes are those that bring the Python code
> up-to-date without breaking Py2 compatibility.  The resulting
> code will be modern Python 2.6-compatible code plus __future__
> imports from the following set:
>
>     from __future__ import absolute_import
>     from __future__ import division
>     from __future__ import print_function
>
[...]
> The goal for this stage is to create most of the diff for the
> entire porting process, but without introducing any bugs.  It
> should be uncontroversial and safe to apply to every Python 2
> package.  The subsequent patches introducing Python 3
> compatibility should then be shorter and easier to review.

This series run all the fixers from futurize --stage1 on all
Python code in the tree.  To make review and testing easier, I
have run the fixers separately instead of doing all changes in a
single patch.

[1] http://python-future.org/automatic_conversion.html

Eduardo Habkost (10):
  python: futurize -f libfuturize.fixes.fix_print_with_import
  python: futurize -f libfuturize.fixes.fix_absolute_import
  python: futurize -f libfuturize.fixes.fix_next_call
  python: futurize -f lib2to3.fixes.fix_has_key
  python: futurize -f lib2to3.fixes.fix_standarderror
  python: futurize -f lib2to3.fixes.fix_reduce
  python: futurize -f lib2to3.fixes.fix_tuple_params
  python: futurize -f lib2to3.fixes.fix_renames
  python: futurize -f lib2to3.fixes.fix_except
  python: futurize -f lib2to3.fixes.fix_numliterals

 scripts/analyse-9p-simpletrace.py        | 89 ++++++++++++------------
 scripts/analyse-locks-simpletrace.py     |  3 +-
 scripts/analyze-migration.py             | 11 +--
 scripts/dump-guest-memory.py             |  1 +
 scripts/ordereddict.py                   |  4 +-
 scripts/replay-dump.py                   | 21 +++---
 scripts/signrom.py                       |  1 +
 scripts/simpletrace.py                   |  5 +-
 scripts/vmstate-static-checker.py        | 89 ++++++++++++------------
 scripts/device-crash-test                |  3 +-
 scripts/kvm/kvm_flightrecorder           | 21 +++---
 scripts/kvm/vmxcap                       |  1 +
 scripts/qmp/qemu-ga-client               | 10 +--
 scripts/qmp/qmp                          | 24 ++++---
 scripts/qmp/qmp-shell                    | 40 ++++++-----
 scripts/qmp/qom-fuse                     | 11 +--
 scripts/qmp/qom-get                      | 12 ++--
 scripts/qmp/qom-list                     | 16 +++--
 scripts/qmp/qom-set                      | 10 +--
 scripts/qmp/qom-tree                     | 16 +++--
 tests/docker/docker.py                   | 11 +--
 tests/docker/travis.py                   | 15 ++--
 tests/guest-debug/test-gdbstub.py        |  1 +
 tests/image-fuzzer/qcow2/__init__.py     |  3 +-
 tests/image-fuzzer/qcow2/fuzz.py         |  1 +
 tests/image-fuzzer/qcow2/layout.py       |  3 +-
 tests/image-fuzzer/runner.py             | 42 +++++------
 tests/migration/guestperf/engine.py      | 29 ++++----
 tests/migration/guestperf/plot.py        | 17 ++---
 tests/migration/guestperf/shell.py       | 19 ++---
 tests/qemu-iotests/093                   |  2 +-
 tests/qemu-iotests/096                   |  4 +-
 tests/qemu-iotests/118                   | 24 +++----
 tests/qemu-iotests/136                   |  2 +-
 tests/qemu-iotests/149                   |  3 +-
 tests/qemu-iotests/165                   |  3 +-
 tests/qemu-iotests/iotests.py            |  5 +-
 tests/qemu-iotests/nbd-fault-injector.py |  7 +-
 tests/qemu-iotests/qcow2.py              | 39 ++++++-----
 tests/qemu-iotests/qed.py                | 17 ++---
 tests/vm/basevm.py                       |  3 +-
 41 files changed, 337 insertions(+), 301 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
