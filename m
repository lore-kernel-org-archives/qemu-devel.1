Received: from eggs.gnu.org ([209.51.188.92]:42493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46g-0003Gu-Dc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46f-0004i6-3a
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45558
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46e-0004ZN-Ph
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4KHY054847
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:24 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkr97pakc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:21 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:28 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:23 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-50-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 49/97] virt: Suppress external aborts on
 virt-2.10 and earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In commit c79c0a314c43b78 we enabled emulation of external aborts
when the guest attempts to access a physical address with no
mapped device. In commit 4672cbd7bed88dc6 we suppress this for
most legacy boards to prevent breakage of previously working
guests, but we didn't suppress it in the 'virt' board, with
the rationale "we know that guests won't try to prod devices
that we don't describe in the device tree or ACPI tables". This
is mostly true, but we've had a report of a Linux guest image
that this did break. The problem seems to be that the guest
is (incorrectly) configured with a DEBUG_UART_PHYS value that
tells it there is a uart at 0x10009000 (which is true for
vexpress but not for virt), so in early bootup the kernel
probes this bogus address.

This is a misconfigured guest, so we don't need to worry
about it too much, but we can arrange that guests that ran
on QEMU v2.10 (before c79c0a314c43b78) will still run on
the "virt-2.10" board model, by suppressing external aborts
only for that version and earlier. This seems a reasonable
compromise: "virt-2.10" is supposed to behave the same way
that "virt" did in the 2.10 release, and making it do that
provides a usable workaround for guests with bugs like this.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180925144127.31965-1-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
(cherry picked from commit 846690dee8ca6a4143d20b39e894fd1f24627561)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 281ddcdf6e..7f234ff6e8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1881,6 +1881,8 @@ static void virt_machine_2_10_options(MachineClass =
*mc)
 {
     virt_machine_2_11_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_10);
+    /* before 2.11 we never faulted accesses to bad addresses */
+    mc->ignore_memory_transaction_failures =3D true;
 }
 DEFINE_VIRT_MACHINE(2, 10)
=20
--=20
2.17.1
