Received: from eggs.gnu.org ([209.51.188.92]:37919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0j1-0000QU-Ok
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0iz-0000Zu-0P
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:01:03 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:44 +0100
Message-Id: <20190131005945.20149-13-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/13] iotests: Bind qemu-nbd to localhost in 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

By default, qemu-nbd binds to 0.0.0.0.  However, we then proceed to
connect to "localhost".  Usually, this works out fine; but if this test
is run concurrently, some other test function may have bound a different
server to ::1 (on the same port -- you can bind different serves to the
same port, as long as one is on IPv4 and the other on IPv6).

So running qemu-nbd works, it can bind to 0.0.0.0:NBD_PORT.  But
potentially a concurrent test has successfully taken [::1]:NBD_PORT.  In
this case, trying to connect to "localhost" will lead us to the IPv6
instance, where we do not want to end up.

Fix this by just binding to "localhost".  This will make qemu-nbd error
out immediately and not give us cryptic errors later.

(Also, it will allow us to just try a different port as of a future
patch.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20181221234750.23577-3-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/147 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 05b374b7d3..3e10a9969e 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -92,7 +92,7 @@ class QemuNBD(NBDBlockdevAddBase):
         self.assertEqual(qemu_nbd('-f', imgfmt, test_img, *args), 0)
=20
     def test_inet(self):
-        self._server_up('-p', str(NBD_PORT))
+        self._server_up('-b', 'localhost', '-p', str(NBD_PORT))
         address =3D { 'type': 'inet',
                     'data': {
                         'host': 'localhost',
--=20
2.20.1
