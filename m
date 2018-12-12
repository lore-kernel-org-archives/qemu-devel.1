Received: from eggs.gnu.org ([2001:4830:134:3::10]:46928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZO-0003fN-R7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZN-0001uu-Q1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:35 +0100
Message-Id: <20181212132735.16080-42-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 41/41] iotests: make 235 work on s390 (and
 others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

"-machine pc" will not work all architectures. Lets fall back to the
default machine by not specifying it.

In addition we also need to specify -no-shutdown on s390 as qemu will
exit otherwise.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/235 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index da044ed34e..d6edd97ab4 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -49,7 +49,9 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocat=
ion=3Dmetadata', disk,
                 str(size))
=20
 vm =3D QEMUMachine(iotests.qemu_prog)
-vm.add_args('-machine', 'pc,accel=3Dkvm')
+vm.add_args('-machine', 'accel=3Dkvm')
+if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
+        vm.add_args('-no-shutdown')
 vm.add_args('-drive', 'id=3Dsrc,file=3D' + disk)
 vm.launch()
=20
--=20
2.19.2
