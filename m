Received: from eggs.gnu.org ([2001:4830:134:3::10]:47992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUJ-0002VL-Kn
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUI-0001ex-D4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUI-0001eK-4r
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:32 -0400
Message-Id: <20180608174733.4936-30-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/30] atapi: call ide_set_irq before
 ide_transfer_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

The ATAPI_INT_REASON_IO interrupt is raised when I/O starts, but in the
AHCI case ide_set_irq was actually called at the end of a mutual recursio=
n.
Move it early, with the side effect that ide_transfer_start becomes a tai=
l
call in ide_atapi_cmd_reply_end.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180606190955.20845-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/atapi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index c0509c8bf5..7168ff55a7 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -287,6 +287,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
         } else {
             /* a new transfer is needed */
             s->nsector =3D (s->nsector & ~7) | ATAPI_INT_REASON_IO;
+            ide_set_irq(s->bus);
             byte_count_limit =3D atapi_byte_count_limit(s);
             trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
             size =3D s->packet_transfer_size;
@@ -304,13 +305,12 @@ void ide_atapi_cmd_reply_end(IDEState *s)
                 if (size > (s->cd_sector_size - s->io_buffer_index))
                     size =3D (s->cd_sector_size - s->io_buffer_index);
             }
-            s->packet_transfer_size -=3D size;
-            s->elementary_transfer_size -=3D size;
-            s->io_buffer_index +=3D size;
-            ide_transfer_start(s, s->io_buffer + s->io_buffer_index - si=
ze,
-                               size, ide_atapi_cmd_reply_end);
-            ide_set_irq(s->bus);
             trace_ide_atapi_cmd_reply_end_new(s, s->status);
+            s->packet_transfer_size -=3D size;
+            s->elementary_transfer_size -=3D size;
+            s->io_buffer_index +=3D size;
+            ide_transfer_start(s, s->io_buffer + s->io_buffer_index - si=
ze,
+                               size, ide_atapi_cmd_reply_end);
         }
     }
 }
--=20
2.14.3
