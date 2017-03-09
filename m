Received: from eggs.gnu.org ([2001:4830:134:3::10]:51952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herbie.robinson@stratus.com>) id 1cm3LO-0001rB-Pi
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herbie.robinson@stratus.com>) id 1cm3LJ-00014j-QH
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:03:22 -0500
Received: from us-smtp-delivery-131.mimecast.com ([63.128.21.131]:43404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <herbie.robinson@stratus.com>)
	id 1cm3LJ-00014R-Kc
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 14:03:17 -0500
From: Herbie Robinson <Herbie.Robinson@stratus.com>
Date: Thu, 9 Mar 2017 13:48:22 -0500
Message-Id: <20170309190313.DFE5240827A6@vostest4.mno.stratus.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] SGABIOS: fix wrong video attrs for int 10h,
 ah==13h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>

Fix Bug #1670509: wrong video attrs for int 10h, ah=3D=3D13h
The subroutine set_cursor_position is trashing %bx.
Unfortunately, %bl contains the video attribute for write_string.

The fix saves %bx in the function prolog and restores it in
the epilog.  Also, remove save and restore in set_current_cursor,
because set_cursor_position does it.

Signed-off-by: Herbie Robinson <Herbie.Robinson@stratus.com>
---
Removed incorrect code deletions from set_current_cursor.

 sgabios.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sgabios.S b/sgabios.S
index 275d063..96c4e23 100644
--- a/sgabios.S
+++ b/sgabios.S
@@ -1728,6 +1728,7 @@ write_string_tail:
=20
 set_cursor_position:
   pushw %ax
+  pushw %bx
   pushw %ds
   pushw $BDA_SEG
   popw %ds                             /* ds =3D 0x40 */
@@ -1738,6 +1739,7 @@ set_cursor_position:
   movw %ax, %bx                        /* bx =3D cursor save offset */
   movw %dx, (%bx)                      /* save new cursor value */
   popw %ds
+  popw %bx
   popw %ax
   ret
=20
--=20
1.8.3.1
