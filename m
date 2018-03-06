Received: from eggs.gnu.org ([2001:4830:134:3::10]:49151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etCaC-00026f-R2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etCa8-0001Fs-Re
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:24:44 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  6 Mar 2018 13:24:30 +0000
Message-Id: <20180306132430.32110-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] misc: don't use hwaddr as a type in trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Use types that are defined by QEMU in trace events caused build failures
for the UST trace backend:

  In file included from trace-ust-all.c:13:0:
  trace-ust-all.h:11844:206: error: unknown type name =E2=80=98hwaddr=E2=80=
=99

It only knows about C built-in types, and any types that are pulled in
from includs of qemu-common.h and lttng/tracepoint.h. This does not
include the 'hwaddr' type, so replace it with a uint64_t which is what
exec/hwaddr.h defines 'hwaddr' as. This fixes the build failure
introduced by

  commit 9eb8040c2d2b38e1a40bb6129b1b668fa178fcab
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Fri Mar 2 10:45:39 2018 +0000

    hw/misc/tz-ppc: Model TrustZone peripheral protection controller

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

For future work it might be good to have tracetool whitelist the
permitted data types that can be safely used in trace events...

 hw/misc/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index eb5ffcc0a8..b0cc047289 100644
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
PPC: port %d offset 0x%" HWADDR_PRIx " read (secure %d user %d) blocked"
+tz_ppc_write_blocked(int n, uint64_t offset, bool secure, bool user) "TZ=
 PPC: port %d offset 0x%" HWADDR_PRIx " write (secure %d user %d) blocked=
"
=20
 # hw/misc/iotkit-secctl.c
 iotkit_secctl_s_read(uint32_t offset, uint64_t data, unsigned size) "IoT=
Kit SecCtl S regs read: offset 0x%x data 0x%" PRIx64 " size %u"
--=20
2.14.3
