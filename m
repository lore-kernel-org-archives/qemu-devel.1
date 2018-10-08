Received: from eggs.gnu.org ([2001:4830:134:3::10]:47010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6m-00025i-17
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6f-0008Bl-Kg
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:02:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W6f-0006uy-8w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W4v-0003eK-Pe
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:09 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:33 +0100
Message-Id: <20181008140004.12612-3-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/33] virt: Suppress external aborts on
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b57f87abcb..a4725660748 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1926,6 +1926,8 @@ static void virt_machine_2_10_options(MachineClass *mc)
 {
     virt_machine_2_11_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_10);
+    /* before 2.11 we never faulted accesses to bad addresses */
+    mc->ignore_memory_transaction_failures = true;
 }
 DEFINE_VIRT_MACHINE(2, 10)
 
-- 
2.19.0
