Received: from eggs.gnu.org ([209.51.188.92]:45889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp4pV-00068k-6k
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 00:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp4pT-0007GK-A0
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 00:24:01 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-4-git-send-email-thuth@redhat.com>
	<630e6520-5860-bbd2-f480-07ba367d65a8@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6ccc706-5268-e393-33c3-386770af89f3@redhat.com>
Date: Thu, 31 Jan 2019 06:23:47 +0100
MIME-Version: 1.0
In-Reply-To: <630e6520-5860-bbd2-f480-07ba367d65a8@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] ppc: Express dependencies of the
 Mac machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org

On 2019-01-30 18:13, Mark Cave-Ayland wrote:
> On 30/01/2019 09:43, Thomas Huth wrote:
>=20
>> This will make it for example easier if the users want to disable
>> one of the two machines for their builds.
>>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
[...]
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index 3ebe30f..f392502 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -59,6 +59,14 @@ config MOS6522
>> =20
>>  config MACIO
>>      bool
>> +    select CUDA
>> +    select ESCC
>> +    select IDE_MACIO
>> +    select MACIO_GPIO
>> +    select MAC_DBDMA
>> +    select MAC_NVRAM
>> +    select MAC_PMU
>> +    select MOS6522
>=20
> Technically MACIO_GPIO and MAC_PMU are MAC_NEWWORLD only, so we might w=
ant to split
> this down further?

I can also change the lines into:

    select MACIO_GPIO if MAC_NEWWORLD
    select MAC_PMU if MAC_NEWWORLD

>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index 809830e..f6b4206 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -44,9 +44,16 @@ config RS6000_MC
>> =20
>>  config MAC_OLDWORLD
>>      bool
>> +    select ADB
>> +    select GRACKLE_PCI
>> +    select HEATHROW_PIC
>> +    select MACIO
>> =20
>>  config MAC_NEWWORLD
>>      bool
>> +    select ADB
>> +    select MACIO
>> +    select UNIN_PCI
>=20
> Also MAC_NEWWORLD has an in-built USB PCI bridge (OHCI) which populates=
 with a USB
> keyboard/mouse rather than ADB when using -M mac99,via=3Dpmu, but I pre=
sume USB is
> handled elsewhere?

Yes, in hw/usb/Kconfig we have:

config USB_OHCI
    bool
    default y if PCI_DEVICES
    depends on PCI
    select USB

 Thomas
