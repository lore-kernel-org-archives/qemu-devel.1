Received: from eggs.gnu.org ([2001:4830:134:3::10]:46575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etP0V-0007yp-Kn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1etP0R-0007fv-JK
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 21:40:43 -0500
References: <20180306232851.8DD617456A5@zero.eik.bme.hu>
	<20180307022327.GA3083@umbus.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <d1c5f8a6-a7c1-b08c-4994-940e890e7894@redhat.com>
Date: Tue, 6 Mar 2018 21:40:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180307022327.GA3083@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sii3112: Remove unneeded exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>



On 03/06/2018 09:23 PM, David Gibson wrote:
> On Wed, Mar 07, 2018 at 12:15:15AM +0100, BALATON Zoltan wrote:
>> An exit function was mistakenly left here but it's not needed because
>> the PCI bars are organised differently in this device. Calling this
>> exit function during device_del was causing an abort with
>> memory_region_del_subregion: `Assertion subregion->container == mr' failed.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Applied to ppc-for-2.12, thanks.
> 

Beat me to it, thanks! I'm a little distracted right now.

>> ---
>>  hw/ide/sii3112.c | 12 ------------
>>  1 file changed, 12 deletions(-)
>>
>> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
>> index e3896c6..743a50e 100644
>> --- a/hw/ide/sii3112.c
>> +++ b/hw/ide/sii3112.c
>> @@ -327,17 +327,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
>>      qemu_register_reset(sii3112_reset, s);
>>  }
>>  
>> -static void sii3112_pci_exitfn(PCIDevice *dev)
>> -{
>> -    PCIIDEState *d = PCI_IDE(dev);
>> -    int i;
>> -
>> -    for (i = 0; i < 2; ++i) {
>> -        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].extra_io);
>> -        memory_region_del_subregion(&d->bmdma_bar, &d->bmdma[i].addr_ioport);
>> -    }
>> -}
>> -
>>  static void sii3112_pci_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -348,7 +337,6 @@ static void sii3112_pci_class_init(ObjectClass *klass, void *data)
>>      pd->class_id = PCI_CLASS_STORAGE_RAID;
>>      pd->revision = 1;
>>      pd->realize = sii3112_pci_realize;
>> -    pd->exit = sii3112_pci_exitfn;
>>      dc->desc = "SiI3112A SATA controller";
>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>  }
> 
