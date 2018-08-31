Received: from eggs.gnu.org ([2001:4830:134:3::10]:50652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvkQm-00019c-Od
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fvkEV-0005vx-Tp
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:17:11 -0400
References: <20180810053712.6587-1-hpoussin@reactos.org>
	<20180810064154.GE4079@umbus> <20180820031620.GA3348@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d9a25f9f-e578-5097-a7fc-0fe065275b16@ilande.co.uk>
Date: Fri, 31 Aug 2018 15:16:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180820031620.GA3348@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: on 40p machine,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 20/08/18 04:16, David Gibson wrote:

> On Fri, Aug 10, 2018 at 04:41:54PM +1000, David Gibson wrote:
>> On Fri, Aug 10, 2018 at 07:37:12AM +0200, Hervé Poussineau wrote:
>>> OpenBIOS gained 40p support in 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff
>>> Use it, instead of relying on an unmaintained and very limited firmware.
>>>
>>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
>>
>> Applied to ppc-for-3.1, thanks.
> 
> But I'm afraid I've had to pull it out.  This breaks boot-serial-test,
> because the new firmware prints different messages than the old one
> did and the testcase isn't looking for them.
> 
> I tried fixing it, but ran into complications I didn't have time to
> debug.  So I'm afraid this will miss my coming-soon pull request.
> 
> You should be able to reproduce the problem with "make check
> SPEED=slow", can you fix this up and resubmit.
> 
>>
>>> ---
>>>  hw/ppc/prep.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>>> index 3401570d98..1558855247 100644
>>> --- a/hw/ppc/prep.c
>>> +++ b/hw/ppc/prep.c
>>> @@ -736,7 +736,7 @@ static void ibm_40p_init(MachineState *machine)
>>>      /* PCI host */
>>>      dev = qdev_create(NULL, "raven-pcihost");
>>>      if (!bios_name) {
>>> -        bios_name = BIOS_FILENAME;
>>> +        bios_name = "openbios-ppc";
>>>      }
>>>      qdev_prop_set_string(dev, "bios-name", bios_name);
>>>      qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);

Thanks to Thomas on IRC, I was able come up with the diff below which
fixes boot-serial-test when this patch is applied:

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

Hervé, can you confirm that this fixes "make check" for you? If so it
should just be a simple case of squashing into the above patch and then
resubmitting a v2.


ATB,

Mark.
