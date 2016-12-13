Received: from eggs.gnu.org ([2001:4830:134:3::10]:52506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cGo5o-0000pD-1t
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cGo5k-0005Qq-4Y
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:30:08 -0500
References: <1481633076-24521-1-git-send-email-thuth@redhat.com>
	<1481637176.27088.132.camel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <282345c0-fad3-eb66-63c5-3d1d24ab6d6d@redhat.com>
Date: Tue, 13 Dec 2016 15:29:58 +0100
MIME-Version: 1.0
In-Reply-To: <1481637176.27088.132.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix boot path of usb-host
 storage devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 13.12.2016 14:52, Gerd Hoffmann wrote:
> On Di, 2016-12-13 at 13:44 +0100, Thomas Huth wrote:
>> When passing through a USB storage device to a pseries guest, it
>> is currently not possible to automatically boot from the device
>> if the "bootindex" property has been specified, too (e.g. when using
>> "-device nec-usb-xhci -device usb-host,hostbus=1,hostaddr=2,bootindex=0"
>> at the command line). The problem is that QEMU builds a device tree path
>> like "/pci@800000020000000/usb@0/usb-host@1" and passes it to SLOF
>> in the /chosen/qemu,boot-list property. SLOF, however, probes the
>> USB device, recognizes that it is a storage device and thus changes
>> its name to "storage", and additionally adds a child node for the
>> SCSI LUN, so the correct boot path in SLOF is something like
>> "/pci@800000020000000/usb@0/storage@1/disk@101000000000000" instead.
>> So when we detect an USB mass storage device with SCSI interface,
>> we've got to adjust the firmware boot-device path properly, so that
>> SLOF can automatically boot from the device.
> 
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 208ef7b..fe315b5 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2185,6 +2185,15 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
>>          }
>>      }
>>  
>> +    if (strcmp("usb-host", qdev_fw_name(dev)) == 0) {
>> +        USBDevice *usbdev = CAST(USBDevice, dev, TYPE_USB_DEVICE);
>> +
>> +        /* SLOF scans USB storage and adds a "disk" node for the SCSI LUN */
>> +        if (usb_host_dev_is_scsi_storage(usbdev)) {
>> +            return g_strdup_printf("storage@%s/disk", usbdev->port->path);
>> +        }
>> +    }
>> +
> 
> Any reason why this is hidden in ppc/spapr?
> 
> usb-host could implement the ->fw_name callback instead to create a name
> depending on the device type ...

The naming is specific to SLOF ... not sure what happens with other
firmware implementations, so spapr.c sounds like the better place to me
right now.

 Thomas
