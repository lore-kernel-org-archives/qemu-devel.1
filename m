Received: from eggs.gnu.org ([2001:4830:134:3::10]:36747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyesT-0003qN-D9
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eyesQ-000187-I0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eyesQ-00017m-EG
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:38:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 15:37:54 +0100
Message-Id: <20180321143754.5606-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180321143754.5606-1-marcandre.lureau@redhat.com>
References: <20180321143754.5606-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] dump-guest-memory: more descriptive
 lookup_type failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Andrew Jones <drjones@redhat.com>

We've seen a few reports of

 (gdb) source /usr/share/qemu-kvm/dump-guest-memory.py
 Traceback (most recent call last):
   File "/usr/share/qemu-kvm/dump-guest-memory.py", line 19, in <module>
     UINTPTR_T =3D gdb.lookup_type("uintptr_t")
 gdb.error: No type named uintptr_t.

This occurs when symbols haven't been loaded first, i.e. neither a
QEMU binary was loaded nor a QEMU process was attached first. Let's
better inform the user of how to fix the issue themselves in order
to avoid more reports.

Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-Id: <20180314153820.18426-1-drjones@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/dump-guest-memory.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 51acfcd0c0..276eebf0c2 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -16,7 +16,12 @@ the COPYING file in the top-level directory.
 import ctypes
 import struct
=20
-UINTPTR_T =3D gdb.lookup_type("uintptr_t")
+try:
+    UINTPTR_T =3D gdb.lookup_type("uintptr_t")
+except Exception as inst:
+    raise gdb.GdbError("Symbols must be loaded prior to sourcing dump-gu=
est-memory.\n"
+                       "Symbols may be loaded by 'attach'ing a QEMU proc=
ess id or by "
+                       "'load'ing a QEMU binary.")
=20
 TARGET_PAGE_SIZE =3D 0x1000
 TARGET_PAGE_MASK =3D 0xFFFFFFFFFFFFF000
--=20
2.16.2.521.g9aa15f885a
