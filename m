Received: from eggs.gnu.org ([2001:4830:134:3::10]:59620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <PSIRT@huawei.com>) id 1cE4zz-0004dk-9E
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 20:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <PSIRT@huawei.com>) id 1cE4zw-0002kv-8A
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 20:56:51 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:1242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <PSIRT@huawei.com>) id 1cE4zv-0002jc-L2
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 20:56:48 -0500
From: Huawei PSIRT <psirt@huawei.com>
References: <cb06a932a7c6b29bc6eb0d35f31766bfb0bba47f.1480962799.git.alistair.francis@xilinx.com>
In-Reply-To: <cb06a932a7c6b29bc6eb0d35f31766bfb0bba47f.1480962799.git.alistair.francis@xilinx.com>
Date: Tue, 6 Dec 2016 09:56:14 +0800
Message-ID: <002301d24f63$ee1a8e00$ca4faa00$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Content-Language: zh-cn
Subject: Re: [Qemu-devel] [PATCH for 2.8 v3 1/1] cadence_uart: Check baud
 rate generator and divider values on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair.francis@xilinx.com, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair23@gmail.com, pjp@fedoraproject.org, "Jiangxin (hunter, SCC)" <jiangxin1@huawei.com>, Huawei PSIRT <PSIRT@huawei.com>, "Wanglijun (PSIRT)" <wanglijun.wanglijun@huawei.com>

Dear Alistair francis,

As the issue is found by Jiangxin from Huawei test team, could you =
please
change the "Reported-by" to Jiangxin <jiangxin1@huawei.com>, thank you.
And keep Jiangxin <jiangxin1@huawei.com> in the email loop, thank you.

Best regards,
Huawei PSIRT

-----=D3=CA=BC=FE=D4=AD=BC=FE-----
=B7=A2=BC=FE=C8=CB: Alistair Francis =
[mailto:alistair.francis@xilinx.com]=20
=B7=A2=CB=CD=CA=B1=BC=E4: 2016=C4=EA12=D4=C26=C8=D5 2:35
=CA=D5=BC=FE=C8=CB: qemu-devel@nongnu.org; peter.maydell@linaro.org
=B3=AD=CB=CD: alistair.francis@xilinx.com; alistair23@gmail.com;
pjp@fedoraproject.org; psirt@huawei.com
=D6=F7=CC=E2: [PATCH for 2.8 v3 1/1] cadence_uart: Check baud rate =
generator and
divider values on migration

The Cadence UART device emulator calculates speed by dividing the baud =
rate
by a 'baud rate generator' & 'baud rate divider' value.
The device specification defines these register values to be non-zero =
and
within certain limits. Checks were recently added when writing to these
registers but not when restoring from migration.

This patch adds checks when restoring from migration to avoid divide by =
zero
errors.

Reported-by: Huawei PSIRT <psirt@huawei.com>
Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
It would be nice to squeeze this into 2.8 if possible.

V3:
 - Fix broken migration logic
 - Manually double checked and it passes migration.
V2:
 - Abort the migration if the data is invalid

 hw/char/cadence_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c index =
0215d65..
ce9063b 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -502,6 +502,13 @@ static int cadence_uart_post_load(void *opaque, int
version_id)  {
     CadenceUARTState *s =3D opaque;
=20
+    /* Ensure these two aren't invalid numbers */
+    if (s->r[R_BRGR] <=3D 1 || s->r[R_BRGR] & ~0xFFFF ||
+        s->r[R_BDIV] <=3D 3 || s->r[R_BDIV] & ~0xFF) {
+        /* Value is invalid, abort */
+        return 1;
+    }
+
     uart_parameters_setup(s);
     uart_update_status(s);
     return 0;
--
2.7.4
