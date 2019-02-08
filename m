Received: from eggs.gnu.org ([209.51.188.92]:53568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gsA3i-0006z9-EA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gsA3h-00018N-MZ
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:35:26 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:44628
	helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gsA3h-00013E-GL
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 12:35:25 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
	by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 5C50A5FCAB
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 18:35:20 +0100 (CET)
From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Date: Fri,  8 Feb 2019 19:35:20 +0200
Message-Id: <20190208173520.15007-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] linux-user: check valid address in access_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This works around the LTP crash, but there are problably better ways to
go about it.

Signed-off-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
Cc: <lvivier@redhat.com>
---
 linux-user/qemu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ef400cb78a..1d222a0cce 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -457,7 +457,8 @@ extern unsigned long guest_stack_size;
=20
 static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
 {
-    return page_check_range((target_ulong)addr, size,
+    return guest_addr_valid(addr) && guest_addr_valid(addr + size) &&
+           page_check_range((target_ulong)addr, size,
                             (type =3D=3D VERIFY_READ) ? PAGE_READ : (PAG=
E_READ | PAGE_WRITE)) =3D=3D 0;
 }
=20
--=20
2.20.1
