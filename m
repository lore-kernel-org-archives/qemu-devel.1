Received: from eggs.gnu.org ([2001:4830:134:3::10]:43816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxm4K-0004j5-Pt
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 00:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxm4H-0003Rl-Em
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 00:39:00 -0400
References: <20180904194903.20712-1-hpoussin@reactos.org>
	<20180905001349.GI2679@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <352cb605-d2d3-e5de-bc5d-c1924b3fc793@ilande.co.uk>
Date: Thu, 6 Sep 2018 05:38:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180905001349.GI2679@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc: on 40p machine,
 change default firmware to OpenBIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 05/09/18 01:13, David Gibson wrote:

> On Tue, Sep 04, 2018 at 09:49:03PM +0200, Hervé Poussineau wrote:
>> OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
>> Use it, instead of relying on an unmaintained and very limited firmware.
>>
>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> 
> Uh.. against current ppc-for-3.1, plase.

I was a bit confused as to why this failed to apply since the original
had been part of a local branch for a while, but just noticed it was
because of this change to Hervé's original which I had missed:

[dwg: Drop prep from boot-serial test to avoid deprecation warnings]

Included below is the new diff against ppc-for-3.1: David, is this
enough for you to be able to fix up manually without a v3?

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 162b27a3b8..baca1d7c04 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -651,7 +651,7 @@ static void ibm_40p_init(MachineState *machine)
     /* PCI host */
     dev = qdev_create(NULL, "raven-pcihost");
     if (!bios_name) {
-        bios_name = BIOS_FILENAME;
+        bios_name = "openbios-ppc";
     }
     qdev_prop_set_string(dev, "bios-name", bios_name);
     qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index f123b15e3e..f865822e32 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -75,12 +75,12 @@ typedef struct testdef {
 static testdef_t tests[] = {
     { "alpha", "clipper", "", "PCI:" },
     { "ppc", "ppce500", "", "U-Boot" },
-    { "ppc", "40p", "-boot d", "Booting from device d" },
+    { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
     { "ppc", "g3beige", "", "PowerPC,750" },
     { "ppc", "mac99", "", "PowerPC,G4" },
     { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
     { "ppc64", "ppce500", "", "U-Boot" },
-    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
+    { "ppc64", "40p", "-m 192", "Memory: 192M" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries", "", "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },


ATB,

Mark.
