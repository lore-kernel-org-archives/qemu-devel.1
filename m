Received: from eggs.gnu.org ([2001:4830:134:3::10]:50714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkQZ-0001As-6e
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkM8-0000k5-81
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:25:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Aug 2018 16:24:37 +0200
Message-Id: <20180831142446.22264-3-mreitz@redhat.com>
In-Reply-To: <20180831142446.22264-1-mreitz@redhat.com>
References: <20180831142446.22264-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/11] tests: fix bdrv-drain leak
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Spotted by ASAN:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D5378=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 65536 byte(s) in 1 object(s) allocated from:
    #0 0x7f788f83bc48 in malloc (/lib64/libasan.so.5+0xeec48)
    #1 0x7f788c9923c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
    #2 0x5622a1fe37bc in coroutine_trampoline /home/elmarco/src/qq/util/c=
oroutine-ucontext.c:116
    #3 0x7f788a15d75f in __correctly_grouped_prefixwc (/lib64/libc.so.6+0=
x4c75f)

(Broken in commit 4c8158e359d.)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180809114417.28718-3-marcandre.lureau@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-bdrv-drain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 17bb8508ae..abc8bbe6f0 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -948,6 +948,7 @@ static void coroutine_fn test_co_delete_by_drain(void=
 *opaque)
     }
=20
     dbdd->done =3D true;
+    g_free(buffer);
 }
=20
 /**
--=20
2.17.1
