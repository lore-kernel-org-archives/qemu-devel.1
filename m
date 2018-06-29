Received: from eggs.gnu.org ([2001:4830:134:3::10]:40874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYwzb-0002o4-87
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYwzX-0000vY-8q
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:15:31 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58938
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fYwzW-0000s0-T5
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:15:27 -0400
References: <20180629135616.16570-1-mark.cave-ayland@ilande.co.uk>
	<20180629135616.16570-3-mark.cave-ayland@ilande.co.uk>
	<20180629200121-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d6d2b16b-e263-c29e-cdd2-4d68e851ef28@ilande.co.uk>
Date: Fri, 29 Jun 2018 18:15:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180629200121-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] pci: allow DeviceClass fw_name to
 override pci_dev_fw_name() if set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

On 29/06/18 18:04, Michael S. Tsirkin wrote:

> On Fri, Jun 29, 2018 at 02:56:16PM +0100, Mark Cave-Ayland wrote:
>> The current implementation of pci_dev_fw_name() scans through a fixed
>> set of PCI class descriptions to determine the firmware device name
>> but in some cases this isn't always appropriate, for example with
>> the macio device which uses a class code of 0xff (unassigned).
>>
>> Rather than add a new entry for the macio device and risk a potential
>> clash with another unassigned device later, add a check to
>> pcibus_get_fw_dev_path() that will use DeviceClass fw_name if set in
>> preference to pci_dev_fw_name().
>>
>> This enables PCI devices such as macio to set dc->fw_name as required
>> to match the name specified in the firmware.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci/pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 80bc45930d..126dd683dc 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2411,12 +2411,14 @@ static char *pci_dev_fw_name(DeviceState *dev, char *buf, int len)
>>   
>>   static char *pcibus_get_fw_dev_path(DeviceState *dev)
>>   {
>> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>       PCIDevice *d = (PCIDevice *)dev;
>>       char path[50], name[33];
>>       int off;
>>   
>>       off = snprintf(path, sizeof(path), "%s@%x",
>> -                   pci_dev_fw_name(dev, name, sizeof name),
>> +                   dc->fw_name ? dc->fw_name :
>> +                       pci_dev_fw_name(dev, name, sizeof name),
>>                      PCI_SLOT(d->devfn));
> 
> So why not put the logic into pci_dev_fw_name then?

To me it felt like pci_dev_fw_name() had already made the assumption 
that it's going to start interrogating PCI config space to determine the 
fw_name (the initialisers at the top of the function have already 
started pulling information from out of there) so it seemed a little odd 
to bury the logic in there.

However if you feel it should still belong in pci_dev_fw_name() then I'm 
happy to resubmit.


ATB,

Mark.
