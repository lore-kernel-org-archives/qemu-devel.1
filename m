Received: from eggs.gnu.org ([2001:4830:134:3::10]:60252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffZXj-0000qP-TP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 19:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffZXg-0004Ey-OX
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 19:38:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7a6766fc-9fac-79a5-d53c-b5209abccaae@amsat.org>
Date: Tue, 17 Jul 2018 20:37:58 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] qemu-iotests: workaround to avoid Python3 while
 running tests on Fedora Docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

I noticed this while running "make docker-test-block@fedora":

$ make docker-test-block@fedora NETWORK=1
  BUILD   fedora
    RUN test-block in qemu:fedora
Configure options:
--enable-werror --prefix=/tmp/qemu-test/install
--python=/usr/bin/python3 --target-list=x86_64-softmmu
...
python            /usr/bin/python3 -B
...

194         - output mismatch (see 194.out.bad)
--- /tmp/qemu-test/src/tests/qemu-iotests/194.out       2018-07-17
22:51:10.000000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/194.out.bad 2018-07-17
22:58:01.646916625 +0000
@@ -1,18 +1,18 @@
 Launching VMs...
 Launching NBD server on destination...
-{u'return': {}}
-{u'return': {}}
+{'return': {}}
+{'return': {}}

and many more errors, until:

Failures: 045 132 148 152 162 169 194 205 208 218 222
Failed 11 of 49 tests
Test failed: iotests raw

All failures are due to Python2 syntax.
I started to fix but noticed there are too many and this isn't to
correct fix for this release.

I suppose we don't want to use Py3 for iotests.

The bisect was obvious =)

  commit 356dc290f0ef930a24b6af3a0908b1cb58ad47c9
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Tue Jan 16 13:42:17 2018 +0000

    docker: change Fedora images to run with python3

    Fedora has switched to Python 3 by default, so it
    makes sense to use that for testing QEMU builds,
    so we get testing of Python 3 compatibility.

    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

which added:

ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3

I then figured out we can use EXTRA_CONFIGURE_OPTS:

$ make docker-test-block@fedora NETWORK=1 \
  EXTRA_CONFIGURE_OPTS=--python=/usr/bin/python2
  COPY    RUNNER
    RUN test-block in qemu:fedora
Configure options:
--enable-werror --prefix=/tmp/qemu-test/install
--python=/usr/bin/python3 --python=/usr/bin/python2
--target-list=x86_64-softmmu
...
python            /usr/bin/python2 -B
...
Passed all 48 tests
PLATFORM      -- Linux/aarch64 757be6ea0325 4.15.0-20-generic

So let's use this simple workaround :)

  EXTRA_CONFIGURE_OPTS=--python=/usr/bin/python2

Regards,

Phil.
