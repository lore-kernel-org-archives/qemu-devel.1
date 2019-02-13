Received: from eggs.gnu.org ([209.51.188.92]:51481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtxtt-0004rC-PN
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtxtm-00056b-JP
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:00:45 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtxtm-00053m-7K
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:00:38 -0500
Received: by mail-wr1-f53.google.com with SMTP id q1so3337433wrp.7
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 09:00:34 -0800 (PST)
References: <cae4cdd7-2693-275b-5a54-e419e914d0a2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49268e92-0abf-a2d3-a523-2c14e009e9cd@redhat.com>
Date: Wed, 13 Feb 2019 18:00:31 +0100
MIME-Version: 1.0
In-Reply-To: <cae4cdd7-2693-275b-5a54-e419e914d0a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [edk2] nonzero LUN on USB Bulk Only Transfer fails
 with QEMU+edk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Ray Ni <ray.ni@intel.com>
Cc: edk2-devel-01 <edk2-devel@lists.01.org>, qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi Laszlo,

On 2/13/19 9:37 AM, Laszlo Ersek wrote:
> Hi,
> 
> using QEMU, when I specify a nonzero LUN for the hard disk that sits on
> the "SCSI bus" that embodies the USB Bulk Only Transfer device, then
> UsbMassStorageDxe fails to recognize the hard disk.
> 
> (1) Consider the following QEMU command line snippet:
> 
>   -drive id=disk1,if=none,format=raw,readonly,file=$APPDISK \
>   -device qemu-xhci,id=xhci1,p3=15,addr=02.0 \
>   -device usb-bot,bus=xhci1.0,port=3,id=bot1 \

Do you have a specific need to use the 'usb-bot' device?

>   -device scsi-hd,drive=disk1,bus=bot1.0,lun=0,bootindex=1 \
> 
> For this (i.e., lun=0), I see the following INQUIRY exchange between
> UsbMassStorageDxe and QEMU:
> 
>> Lun=0 InquiryCmd {
>> Lun=0 InquiryCmd 000000 12 00 00 00 24 00 00 00 00 00 00 00
>> Lun=0 InquiryCmd }
>> Lun=0 InquiryData {
>> Lun=0 InquiryData 000000 00 00 05 12 1F 00 00 10 51 45 4D 55 20 20 20 20
>> Lun=0 InquiryData 000010 51 45 4D 55 20 48 41 52 44 44 49 53 4B 20 20 20
>> Lun=0 InquiryData 000020 32 2E 35 2B
>> Lun=0 InquiryData }
> 
> The vendor and product ID fields translate to "QEMU____" and
> "QEMU_HARDDISK___", respectively. (For easier reading, I replaced the
> space characters with underscores, for the sake of better
> readability/wrapping.)
> 
> In this case, edk2 recognizes the disk and things work fine.
> 
> (In fact, for lun=0, the QemuBootOrderLib pattern matching / translation
> works fine as well -- verifying which was my original goal, before I ran
> into the issues below, for nonzero LUNs. But, I digress.)
> 
> 
> (2) If I change the cmdline to "lun=5", then the exchange is:

>From qemu/docs/usb-storage.txt:

  The LUN numbers must be continuous, i.e. for three devices you must
  use 0+1+2. The 0+1+5 numbering from the "usb-uas" example isn't going
  to work with "usb-bot".

A failure is expected :/

> 
>> Lun=0 InquiryCmd {
>> Lun=0 InquiryCmd 000000 12 00 00 00 24 00 00 00 00 00 00 00
>> Lun=0 InquiryCmd }
>> Lun=0 InquiryData {
>> Lun=0 InquiryData 000000 3F 00 05 12 1F 00 00 10 51 45 4D 55 20 20 20 20
>> Lun=0 InquiryData 000010 51 45 4D 55 20 54 41 52 47 45 54 20 20 20 20 20
>> Lun=0 InquiryData 000020 32 2E 35 00
>> Lun=0 InquiryData }
> 
> Here the product ID is unchanged, but the vendor ID becomes
> "QEMU_TARGET_____".
> 
> And, edk2 fails to recognize the device:
> 
>> UsbBootGetParams: Found an unsupported peripheral type[31]
>> UsbMassInitMedia: UsbBootGetParams (Unsupported)
>> UsbMassInitNonLun: UsbMassInitMedia (Unsupported)
>> USBMassDriverBindingStart: UsbMassInitNonLun (Unsupported)
> 
> This happens because the first byte in the response is 0x3F. QEMU sets
> this byte in
> 
>>         r->buf[0] = TYPE_NOT_PRESENT | TYPE_INACTIVE;
> 
> in function scsi_target_emulate_inquiry(), file "hw/scsi/scsi-bus.c".
> 
> And edk2 parses the byte in UsbBootInquiry() and UsbBootGetParams()
> (file "MdeModulePkg/Bus/Usb/UsbMassStorageDxe/UsbMassBoot.c"):
> 
>> typedef struct {
>>   UINT8             Pdt;            ///< Peripheral Device Type (low 5 bits)
>>   UINT8             Removable;      ///< Removable Media (highest bit)
>>   UINT8             Reserved0[2];
>>   UINT8             AddLen;         ///< Additional length
>>   UINT8             Reserved1[3];
>>   UINT8             VendorID[8];
>>   UINT8             ProductID[16];
>>   UINT8             ProductRevision[4];
>> } USB_BOOT_INQUIRY_DATA;
> 
>> #define USB_BOOT_PDT(Pdt)           ((Pdt) & 0x1f)
> 
>>   UsbMass->Pdt          = (UINT8) (USB_BOOT_PDT (UsbMass->InquiryData.Pdt));
> 
>>   //
>>   // According to USB Mass Storage Specification for Bootability, only following
>>   // 4 Peripheral Device Types are in spec.
>>   //
>>   if ((UsbMass->Pdt != USB_PDT_DIRECT_ACCESS) &&
>>        (UsbMass->Pdt != USB_PDT_CDROM) &&
>>        (UsbMass->Pdt != USB_PDT_OPTICAL) &&
>>        (UsbMass->Pdt != USB_PDT_SIMPLE_DIRECT)) {
>>     DEBUG ((EFI_D_ERROR, "UsbBootGetParams: Found an unsupported peripheral type[%d]\n", UsbMass->Pdt));
>>     return EFI_UNSUPPORTED;
>>   }
> 
> It looks likely that at least one of edk2 and QEMU has a bug. Which one
> is it?

Both implementation looks correct at first glance, QEMU replies a
standard SCSI INQUIRY format, while EDK2 expects a "USB Mass Storage
Specification
 for Bootability, Revision 1.0" INQUIRY format.

> Or is the command line incorrect perhaps? (I.e., is it invalid to
> specify *only* lun=5? Does the LUN space have to be contiguous?)
> 
> 
> (3) Starting again from the original command line, if I change "lun=0"
> to "lun=1" (rather than to "lun=5"), then OVMF even hangs, with the
> following log:
> 
>> UsbMassInitMultiLun: Start to initialize No.0 logic unit
>> Lun=0 InquiryCmd {
>> Lun=0 InquiryCmd 000000 12 00 00 00 24 00 00 00 00 00 00 00
>> Lun=0 InquiryCmd }
>> Lun=0 InquiryData {
>> Lun=0 InquiryData 000000 3F 00 05 12 1F 00 00 10 51 45 4D 55 20 20 20 20
>> Lun=0 InquiryData 000010 51 45 4D 55 20 54 41 52 47 45 54 20 20 20 20 20
>> Lun=0 InquiryData 000020 32 2E 35 00
>> Lun=0 InquiryData }
>> UsbBootGetParams: Found an unsupported peripheral type[31]
>> UsbMassInitMedia: UsbBootGetParams (Unsupported)
>> UsbMassInitMultiLun: UsbMassInitMedia (Unsupported)
>> UsbMassInitMultiLun: Start to initialize No.1 logic unit
>> Lun=32 InquiryCmd {
>> Lun=32 InquiryCmd 000000 12 20 00 00 24 00 00 00 00 00 00 00
>> Lun=32 InquiryCmd }
>> Lun=32 InquiryData {
>> Lun=32 InquiryData 000000 00 00 05 12 1F 00 00 10 51 45 4D 55 20 20 20 20
>> Lun=32 InquiryData 000010 51 45 4D 55 20 48 41 52 44 44 49 53 4B 20 20 20
>> Lun=32 InquiryData 000020 32 2E 35 2B
>> Lun=32 InquiryData }
>> UsbBootExecCmd: Success to Exec 0x0 Cmd (Result = 1)
>> UsbBootRequestSense: (Invalid Parameter) with error code (70) sense key 5/25/0
>> UsbMassInitMedia: UsbBootGetParams (Media changed)
>> InstallProtocolInterface: 09576E91-6D3F-11D2-8E39-00A0C969723B 3DC7DD98
>> InstallProtocolInterface: 964E5B21-6459-11D2-8E39-00A0C969723B 3DBFA6B8
>> InstallProtocolInterface: D432A67F-14DC-484B-B3BB-3F0291849327 3DBFA730
>> UsbMassInitMultiLun: Success to initialize No.1 logic unit
>> InstallProtocolInterface: CE345171-BA0B-11D2-8E4F-00A0C969723B 3DBFA2A0
>>  BlockSize : 512
>>  LastBlock : 136B
>> UsbBootExecCmd: Success to Exec 0x28 Cmd (Result = 1)
>> UsbBootRequestSense: (Invalid Parameter) with error code (70) sense key 5/25/0
>> UsbBootExecCmd: Success to Exec 0x28 Cmd (Result = 1)
>> UsbBootRequestSense: (Invalid Parameter) with error code (70) sense key 5/25/0
>> UsbBootExecCmd: Success to Exec 0x28 Cmd (Result = 1)
>> UsbBootRequestSense: (Invalid Parameter) with error code (70) sense key 5/25/0
>> UsbBootExecCmd: Success to Exec 0x28 Cmd (Result = 1)
>> UsbBootRequestSense: (Invalid Parameter) with error code (70) sense key 5/25/0
>> UsbBootExecCmd: Success to Exec 0x28 Cmd (Result = 1)
>> UsbBootRequestSense: (Invalid Parameter) with error code (70) sense key 5/25/0
>> UsbBootExecCmd: Success to Exec 0x28 Cmd (Result = 1)
>> UsbBootRequestSense: (Invalid Parameter) with error code (70) sense key 5/25/0
>> UsbMassReadBlocks: UsbBootReadBlocks (Invalid Parameter) -> Reset
>> XhcUsbPortReset!
>> XhcSetRootHubPortFeature: status Success
>> XhcClearRootHubPortFeature: status Success
>> XhcClearRootHubPortFeature: status Success
>> Disable device slot 1!
>> Enable Slot Successfully, The Slot ID = 0x1
>>     Address 1 assigned successfully
>> UsbIoPortReset: device is now ADDRESSED at 1
>> ASSERT MdeModulePkg/Bus/Pci/XhciDxe/XhciSched.c(1915): TrsRing != ((void *) 0)
> 
> In this case, edk2 seems to recognize that a nonzero LUN is available on
> the target, but the initialization never completes, and then an
> assertion fails, apparently in the lower-level XHCI transport code.

Can you try using the 'usb-uas' device instead of the 'usb-bot'?

> 
> The information that I'm primarily looking for here is which bug tracker
> I should file these under, the edk2 bugzilla, or the QEMU launchpad.
> 
> Thanks,
> Laszlo
