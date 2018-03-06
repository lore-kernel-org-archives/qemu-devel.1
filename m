Received: from eggs.gnu.org ([2001:4830:134:3::10]:50972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etGIt-0003W4-7v
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etGIo-0006Jy-D5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:23:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1etGIo-0006Js-9G
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:23:02 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  6 Mar 2018 17:22:50 +0000
Message-Id: <20180306172250.3049-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] trace: fix ARM TrustZone PPC hwaddr type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Commit 9eb8040c2d2b ("hw/misc/tz-ppc: Model TrustZone peripheral
protection controller") added trace events with hwaddr type arguments.

This is not allowed and leads to the following compiler errors when
building with ./configure --enable-trace-backends=3Dust:

  trace-ust-all.h:11847:20: error: unknown type name =E2=80=98hwaddr=E2=80=
=99; did you mean =E2=80=98h_addr=E2=80=99?
    TP_ARGS(int, n, hwaddr, offset, bool, secure, bool, user),

Generated LTTng UST tracepoint definitions cannot include declarations
for all QEMU types and therefore docs/devel/tracing.txt requires using
only primitive or stdint.h types.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/misc/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index eb5ffcc0a8..562d9ed005 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -92,8 +92,8 @@ tz_ppc_cfg_sec_resp(int level) "TZ PPC: cfg_sec_resp =3D=
 %d"
 tz_ppc_irq_enable(int level) "TZ PPC: int_enable =3D %d"
 tz_ppc_irq_clear(int level) "TZ PPC: int_clear =3D %d"
 tz_ppc_update_irq(int level) "TZ PPC: setting irq line to %d"
-tz_ppc_read_blocked(int n, hwaddr offset, bool secure, bool user) "TZ PP=
C: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) blocked"
-tz_ppc_write_blocked(int n, hwaddr offset, bool secure, bool user) "TZ P=
PC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) blocked"
+tz_ppc_read_blocked(int n, uint64_t offset, bool secure, bool user) "TZ =
PPC: port %d offset 0x%" PRIx64 " read (secure %d user %d) blocked"
+tz_ppc_write_blocked(int n, uint64_t offset, bool secure, bool user) "TZ=
 PPC: port %d offset 0x%" PRIx64 " write (secure %d user %d) blocked"
=20
 # hw/misc/iotkit-secctl.c
 iotkit_secctl_s_read(uint32_t offset, uint64_t data, unsigned size) "IoT=
Kit SecCtl S regs read: offset 0x%x data 0x%" PRIx64 " size %u"
--=20
2.14.3
