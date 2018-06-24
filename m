Received: from eggs.gnu.org ([2001:4830:134:3::10]:43962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fX1UE-0001EO-OH
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 05:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fX1UB-0004Kl-Ky
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 05:39:10 -0400
Received: from chuckie.co.uk ([82.165.15.123]:46464
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fX1UB-0004H3-E4
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 05:39:07 -0400
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
	<20180623085028.29553-3-mark.cave-ayland@ilande.co.uk>
	<20180624065424-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1c525625-ac87-8f89-a933-7b512fd3674f@ilande.co.uk>
Date: Sun, 24 Jun 2018 10:38:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180624065424-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] pci: allow DeviceClass fw_name to
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

On 24/06/18 04:55, Michael S. Tsirkin wrote:

> On Sat, Jun 23, 2018 at 09:50:28AM +0100, Mark Cave-Ayland wrote:
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
> 
> 
> Do we know no existing pci device sets this?

Here was my basic check:

# Find all files containing PCIDevice
find . -type f -exec grep -l "PCIDevice" {} \; > /tmp/pcidevices.txt
# Of these return files containing 'dc->fw_name'
for FILE in `cat /tmp/pcidevices.txt`; do grep -H 'dc->fw_name' $FILE; done;

./hw/ppc/spapr.c:        snprintf(cpu_model, 32, "%s@%x", dc->fw_name, 
index);
./hw/ppc/spapr.c:        nodename = g_strdup_printf("%s@%x", 
dc->fw_name, index);
./hw/ppc/spapr.c:    nodename = g_strdup_printf("%s@%x", dc->fw_name, id);
./hw/pci-bridge/pci_expander_bridge.c:    dc->fw_name = "pci";
./hw/pci-host/designware.c:    dc->fw_name = "pci";
./hw/pci-host/piix.c:    dc->fw_name = "pci";
./hw/pci-host/gpex.c:    dc->fw_name = "pci";
./hw/pci-host/xilinx-pcie.c:    dc->fw_name = "pci";
./hw/pci-host/q35.c:    dc->fw_name = "pci";
./hw/pci-host/prep.c:    dc->fw_name = "pci";

 From what I can see the usage in spapr.c is for setting the DT CPU name 
whilst all of the others are derived from 
PCIE_HOST_BRIDGE/PCI_HOST_BRIDGE which are ultimately sysbus devices.


ATB,

Mark.
