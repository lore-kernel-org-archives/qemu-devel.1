Received: from eggs.gnu.org ([2001:4830:134:3::10]:49158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcE-0007MX-2Z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcD-0004w8-5r
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcD-0004w4-1J
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:02 -0500
Message-Id: <20180327143014.1767669-3-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] tests: Silence false positive warning on
 generated test name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Running 'make check' on rawhide with gcc 8.0.1 fails:

tests/test-visitor-serialization.c: In function 'main':
tests/test-visitor-serialization.c:1127:34: error: '/primitives/' directi=
ve writing 12 bytes into a region of size between 1 and 128 [-Werror=3Dfo=
rmat-overflow=3D]

The warning is a false positive (we have two buffers of size 128,
so yes, if we FULLY used the first buffer, then sprint'ing it into
the second will overflow the second).  But in practice, our first
buffer will not be longer than "/visitor/serialization/String",
so sizing it smaller is enough to let gcc see that we don't
overflow the second.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180323204341.1501664-1-eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-visitor-serialization.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-seri=
alization.c
index 438c18a0d64..d18d90db2c7 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -1115,7 +1115,7 @@ static const SerializeOps visitors[] =3D {

 static void add_visitor_type(const SerializeOps *ops)
 {
-    char testname_prefix[128];
+    char testname_prefix[32];
     char testname[128];
     TestArgs *args;
     int i =3D 0;
--=20
2.14.3
