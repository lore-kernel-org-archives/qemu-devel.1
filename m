Received: from eggs.gnu.org ([209.51.188.92]:35723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoSN-0006Vg-Jw
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoSL-0007yz-FQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:19:19 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 01:18:35 +0100
Message-Id: <20190205001835.25660-9-philmd@redhat.com>
In-Reply-To: <20190205001835.25660-1-philmd@redhat.com>
References: <20190205001835.25660-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 8/8] RFC iotests: Disable 236 and 238 on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

These tests explode on OpenBSD:

  $ gmake check-block
  [...]
  238                [17:16:09] [17:16:09] [failed, exit status 1] - outp=
ut mismatch (see 238.out.bad)
  --- /tmp/qemu-test.VKNS07/tests/qemu-iotests/238.out    Tue Jan 29 17:0=
9:03 2019
  +++ /tmp/qemu-test.VKNS07/tests/qemu-iotests/238.out.bad        Tue Jan=
 29 17:16:09 2019
  @@ -1,6 +1,14 @@
  -{"return": {}}
  -{"return": {}}
  -{"return": {}}
  -{"return": {}}
  -{"return": {}}
  -{"return": {}}
  +Traceback (most recent call last):
  +  File "238", line 37, in <module>
  +    vm.launch()
  +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.py=
", line 295, in launch
  +    self._launch()
  +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.py=
", line 321, in _launch
  +    self._post_launch()
  +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.py=
", line 266, in _post_launch
  +    self._qmp.accept()
  +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qmp/qmp=
.py", line 157, in accept
  +    return self.__negotiate_capabilities()
  +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qmp/qmp=
.py", line 73, in __negotiate_capabilities
  +    raise QMPConnectError
  +qmp.qmp.QMPConnectError

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
This might be due to these tests requiring KVM?...
Maybe we need a has_kvm argument to iotests.verify_platform()?
---
 tests/qemu-iotests/236 | 1 +
 tests/qemu-iotests/238 | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 79a6381f8e..b98df35ca4 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -23,6 +23,7 @@ import iotests
 from iotests import log
=20
 iotests.verify_image_format(supported_fmts=3D['generic'])
+iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
 size =3D 64 * 1024 * 1024
 granularity =3D 64 * 1024
=20
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index f81ee1112f..c62ff9a6dc 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -23,6 +23,8 @@ import os
 import iotests
 from iotests import log
=20
+iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
+
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
=20
 from qemu import QEMUMachine
--=20
2.20.1
