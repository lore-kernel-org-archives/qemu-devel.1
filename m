Received: from eggs.gnu.org ([209.51.188.92]:35704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoSJ-0006SV-TQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoSI-0007xl-Nv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:19:15 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 01:18:33 +0100
Message-Id: <20190205001835.25660-7-philmd@redhat.com>
In-Reply-To: <20190205001835.25660-1-philmd@redhat.com>
References: <20190205001835.25660-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/8] RFC iotests: Disable 208 on OpenBSD
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

This test explodes on OpenBSD:

  $ gmake check-block
  [...]
  208                [14:46:03] [14:46:03] [failed, exit status 1] - outp=
ut mismatch (see 208.out.bad)
  --- /tmp/qemu-test.9cUFe0/tests/qemu-iotests/208.out    Tue Jan 29 13:3=
3:43 2019
  +++ /tmp/qemu-test.9cUFe0/tests/qemu-iotests/208.out.bad        Tue Jan=
 29 14:46:03 2019
  @@ -1,9 +1,23 @@
  +WARNING:qemu:qemu received signal 9: /tmp/qemu-test.9cUFe0/tests/qemu-=
iotests/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=3Dmon,=
path=3D/tmp/qemu-iotests-quick-38268/tmpjdovgo/qemu-66480-monitor.sock -m=
on chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest unix:path=3D=
/tmp/qemu-iotests-quick-38268/qemu-66480-qtest.sock -machine accel=3Dqtes=
t -nodefaults -machine accel=3Dqtest -drive if=3Dnone,id=3Ddrive0,file=3D=
/tmp/qemu-iotests-quick-38268/66480-disk.img,format=3Dqcow2,cache=3Dwrite=
back,node-name=3Ddrive0-node
  +WARNING:qemu:qemu received signal 9: /tmp/qemu-test.9cUFe0/tests/qemu-=
iotests/../../x86_64-softmmu/qemu-system-x86_64 -chardev socket,id=3Dmon,=
path=3D/tmp/qemu-iotests-quick-38268/tmpjdovgo/qemu-66480-monitor.sock -m=
on chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest unix:path=3D=
/tmp/qemu-iotests-quick-38268/qemu-66480-qtest.sock -machine accel=3Dqtes=
t -nodefaults -machine accel=3Dqtest -drive if=3Dnone,id=3Ddrive0,file=3D=
/tmp/qemu-iotests-quick-38268/66480-disk.img,format=3Dqcow2,cache=3Dwrite=
back,node-name=3Ddrive0-node
   Launching VM...
  -Starting NBD server...
  -{"return": {}}
  -Adding NBD export...
  -{"return": {}}
  -Creating external snapshot...
  -{"return": {}}
  -Stopping NBD server...
  -{"return": {}}
  +Traceback (most recent call last):
  +  File "208", line 36, in <module>
  +    (vm.add_drive(disk_img_path, 'node-name=3Ddrive0-node', interface=3D=
'none')
  +  File "/tmp/qemu-test.9cUFe0/tests/qemu-iotests/../../scripts/qemu.py=
", line 295, in launch
  +    self._launch()
  +  File "/tmp/qemu-test.9cUFe0/tests/qemu-iotests/../../scripts/qemu.py=
", line 321, in _launch
  +    self._post_launch()
  +  File "/tmp/qemu-test.9cUFe0/tests/qemu-iotests/../../scripts/qtest.p=
y", line 100, in _post_launch
  +    super(QEMUQtestMachine, self)._post_launch()
  +  File "/tmp/qemu-test.9cUFe0/tests/qemu-iotests/../../scripts/qemu.py=
", line 266, in _post_launch
  +    self._qmp.accept()
  +  File "/tmp/qemu-test.9cUFe0/tests/qemu-iotests/../../scripts/qmp/qmp=
.py", line 157, in accept
  +    return self.__negotiate_capabilities()
  +  File "/tmp/qemu-test.9cUFe0/tests/qemu-iotests/../../scripts/qmp/qmp=
.py", line 71, in __negotiate_capabilities
  +    greeting =3D self.__json_read()
  +  File "/tmp/qemu-test.9cUFe0/tests/qemu-iotests/../../scripts/qmp/qmp=
.py", line 82, in __json_read
  +    data =3D self.__sockfile.readline()
  +  File "/usr/local/lib/python2.7/socket.py", line 451, in readline
  +    data =3D self._sock.recv(self._rbufsize)
  +socket.error: [Errno 35] Resource temporarily unavailable

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/208 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 1e202388dc..2a13259fe4 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -23,6 +23,7 @@
 import iotests
=20
 iotests.verify_image_format(supported_fmts=3D['generic'])
+iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
=20
 with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
--=20
2.20.1
