Received: from eggs.gnu.org ([2001:4830:134:3::10]:34775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb8A2-0000C6-BU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb89z-0006NM-4r
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:03:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb89y-0006Mk-Sc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:02:59 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 17:02:30 +0000
Message-Id: <20180115170243.24578-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 00/13] Support building with py2 or py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an update for my previously posted series:

 v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06528.html

This series enables some level of CI testing for py3 so that our CI jobs =
will
get coverage of both py2 and py3 builds to avoid bitrot.

I did a test travis build with py 3.0 and py 3.6 and got success:

  https://travis-ci.org/berrange/qemu/builds/328223261

The goal was to achieve the following

  ./configure --python=3D/usr/bin/python3
  make
  make check

This still requires passing python path to configure explicitly. A
further improvement would be for configure to automatically detect
a pythjon 3 binary and use it preferentially to python 2.

I have not attempted to fix/validate the block I/O tests. I would expect
them to be broken, but easily fixable with the similar kind of scope
changes as seen here. I felt it better to tackle that separately to
avoid this initial series getting too large.

Although the Python 2 EOL date is 2020, we already have distros which
are not shipping Python 2 by default (Fedora >=3D 26 has dropped Py2 from
the default install). Any new releases of long life and/or enterprise
distros may well not ship Python 2 given that it would go EOL long
before the EOL of the distro itself. IOW QEMU does have a fairly pressing
need to be able to support Python 3 for building.

A request for py3 is tracked here:

   https://bugs.launchpad.net/qemu/+bug/1708462

NB, Patch 10 here is not related to python 3 work - it was just a
temporary pre-requisite of pulling in the keycodemapdb update.

Changes since v3:

 - Remove space before '(' in print() function calls (Phillippe)
 - Force use of en_US.UTF-8 for QAPI code generation (Patchew)

Changes since v2:

 - Pull in fix for keycodemapdb
 - Enable testing with Travis
 - Enable testing with Fedora Docker images
 - Fix for sort ordering to fix 'make check-qapi-schema'
 - Fix for signrom data

Daniel P. Berrange (12):
  qapi: use items()/values() intead of iteritems()/itervalues()
  qapi: Use OrderedDict from standard library if available
  qapi: adapt to moved location of StringIO module in py3
  qapi: Adapt to moved location of 'maketrans' function in py3
  qapi: remove '-q' arg to diff when comparing QAPI output
  qapi: ensure stable sort ordering when checking QAPI entities
  qapi: force a UTF-8 locale for running Python
  scripts: ensure signrom treats data as bytes
  configure: allow use of python 3
  ui: update keycodemapdb to get py3 fixes
  travis: improve python version test coverage
  docker: change Fedora images to run with python3

Miika S (1):
  input: add missing JIS keys to virtio input

 .travis.yml                            | 14 +++++++----
 Makefile                               | 22 +++++++++--------
 configure                              |  5 ++--
 hw/input/virtio-input-hid.c            |  7 ++++++
 qapi/ui.json                           |  5 +++-
 scripts/qapi.py                        | 43 ++++++++++++++++++++--------=
------
 scripts/qapi2texi.py                   | 11 +++++----
 scripts/signrom.py                     |  4 ++--
 tests/Makefile.include                 |  6 ++---
 tests/docker/dockerfiles/fedora.docker |  3 ++-
 tests/qapi-schema/test-qapi.py         | 43 +++++++++++++++++-----------=
------
 ui/keycodemapdb                        |  2 +-
 12 files changed, 96 insertions(+), 69 deletions(-)

--=20
2.14.3
