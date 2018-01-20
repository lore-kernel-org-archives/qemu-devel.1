Received: from eggs.gnu.org ([2001:4830:134:3::10]:51493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ecvJf-0004N3-T5
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 10:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ecvJe-0008FY-R4
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 10:44:23 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 20 Jan 2018 16:44:06 +0100
Message-Id: <20180120154412.9990-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

Currently, we try to rewrite every occurrence of "backing": null into
"backing": "" in qmp_blockdev_add().  However, that breaks using the
same "backing": null construction in json:{} file names (which do not go
through qmp_blockdev_add()).  Currently, these then just behave as if
the option has not been specified.

Since there is actually only one place where we evaluate the @backing
option to find out whether not to use a backing file, we can instead
just check for null there.  It doesn't matter that this changes the
runtime state of the option from "" to null, because nobody really does
anything with that runtime state anyway (except put it into qemu again,
but qemu doesn't care whether it's "" or null).

And in the future, it's much better if we get it to be null in that
runtime state sooner than later -- see patch 6.


v2: Add qobject_to() macro instead of qdict_is_null() (and then we can
    do qobject_to(qdict_get(...), QNull) != NULL instead) [Markus]
    - I'm not sure what I came up with is what Markus intended me to,
      and if it is not, I'm inclined to go back to qdict_is_null() (or
      qdict_entry_is_null(), as Berto has proposed);
      or, alternatively, add a qobject_to_qnull() function and drop
      patches 2 through 4.


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/6:[down] 'qapi: Add qobject_to()'
002/6:[down] 'qapi: Replace qobject_to_X(o) by qobject_to(o, X)'
003/6:[down] 'qapi: Remove qobject_to_X() functions'
004/6:[down] 'qapi: Make more of qobject_to()'
005/6:[0004] [FC] 'block: Handle null backing link'
006/6:[----] [-C] 'block: Deprecate "backing": ""'


Max Reitz (6):
  qapi: Add qobject_to()
  qapi: Replace qobject_to_X(o) by qobject_to(o, X)
  qapi: Remove qobject_to_X() functions
  qapi: Make more of qobject_to()
  block: Handle null backing link
  block: Deprecate "backing": ""

 qapi/block-core.json                |  4 +--
 include/qapi/qmp/qbool.h            |  1 -
 include/qapi/qmp/qdict.h            |  1 -
 include/qapi/qmp/qlist.h            |  1 -
 include/qapi/qmp/qnum.h             |  1 -
 include/qapi/qmp/qobject.h          | 32 ++++++++++++++++++
 include/qapi/qmp/qstring.h          |  1 -
 block.c                             | 10 ++++--
 block/qapi.c                        | 12 +++----
 block/rbd.c                         |  8 ++---
 blockdev.c                          | 21 +++---------
 hw/i386/acpi-build.c                | 14 ++++----
 monitor.c                           |  8 ++---
 qapi/qmp-dispatch.c                 |  2 +-
 qapi/qobject-input-visitor.c        | 24 +++++++-------
 qapi/qobject-output-visitor.c       |  4 +--
 qga/main.c                          |  2 +-
 qmp.c                               |  2 +-
 qobject/json-parser.c               | 13 ++++----
 qobject/qbool.c                     | 15 ++-------
 qobject/qdict.c                     | 65 ++++++++++++++++---------------------
 qobject/qjson.c                     | 10 +++---
 qobject/qlist.c                     | 17 ++--------
 qobject/qlit.c                      | 10 +++---
 qobject/qnum.c                      | 17 ++--------
 qobject/qstring.c                   | 17 ++--------
 qom/object.c                        |  8 ++---
 target/i386/cpu.c                   |  2 +-
 target/s390x/cpu_models.c           |  2 +-
 tests/check-qdict.c                 | 20 ++++++------
 tests/check-qjson.c                 | 41 +++++++++++------------
 tests/check-qlist.c                 |  4 +--
 tests/check-qlit.c                  |  2 +-
 tests/check-qnum.c                  |  4 +--
 tests/check-qobject.c               |  2 +-
 tests/check-qstring.c               |  2 +-
 tests/device-introspect-test.c      | 14 ++++----
 tests/libqtest.c                    |  6 ++--
 tests/numa-test.c                   |  8 ++---
 tests/qom-test.c                    |  4 +--
 tests/test-char.c                   |  2 +-
 tests/test-keyval.c                 |  8 ++---
 tests/test-qga.c                    | 19 ++++++-----
 tests/test-qmp-commands.c           | 12 +++----
 tests/test-qmp-event.c              | 16 ++++-----
 tests/test-qobject-input-visitor.c  | 10 +++---
 tests/test-qobject-output-visitor.c | 54 +++++++++++++++---------------
 tests/test-x86-cpuid-compat.c       | 17 +++++-----
 util/keyval.c                       |  4 +--
 util/qemu-config.c                  |  2 +-
 util/qemu-option.c                  |  6 ++--
 qemu-doc.texi                       |  7 ++++
 qemu-options.hx                     |  4 +--
 tests/qemu-iotests/089              | 20 ++++++++++++
 tests/qemu-iotests/089.out          |  8 +++++
 55 files changed, 313 insertions(+), 307 deletions(-)

-- 
2.14.3
