Received: from eggs.gnu.org ([209.51.188.92]:49681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gt4Ui-0001ut-O4
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 00:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gt4Uh-0002TJ-MH
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 00:51:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gt4Uh-0002SM-Gw
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 00:51:03 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 11 Feb 2019 13:50:33 +0800
Message-Id: <20190211055040.13528-3-stefanha@redhat.com>
In-Reply-To: <20190211055040.13528-1-stefanha@redhat.com>
References: <20190211055040.13528-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] qemugdb/coroutine: fix arch_prctl has
 unknown return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

qemu coroutine command results in following error output:

Python Exception <class 'gdb.error'> 'arch_prctl' has unknown return
type; cast the call to its declared return type: Error occurred in
Python command: 'arch_prctl' has unknown return type; cast the call to
its declared return type

Fix it by giving it what it wants: arch_prctl return type.

Information on the topic:
   https://sourceware.org/gdb/onlinedocs/gdb/Calling.html

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190206151425.105871-1-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/coroutine.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index ab699794ab..81f811ac00 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -22,7 +22,7 @@ def get_fs_base():
        pthread_self().'''
     # %rsp - 120 is scratch space according to the SystemV ABI
     old =3D gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('call arch_prctl(0x1003, $rsp - 120)', False, True)
+    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
     fs_base =3D gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
     gdb.execute('set *(uint64_t*)($rsp - 120) =3D %s' % old, False, True=
)
     return fs_base
--=20
2.20.1
