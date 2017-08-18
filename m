Received: from eggs.gnu.org ([2001:4830:134:3::10]:33029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1diVbl-0006BQ-H9
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 20:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1diVbi-0001TJ-Eq
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 20:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1diVbi-0001Sz-4Z
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 20:57:50 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <1501835795-92331-1-git-send-email-hare@suse.de>
	<1501835795-92331-4-git-send-email-hare@suse.de>
	<cecc5581-7013-f870-dbd7-da28ac80d2a4@redhat.com>
	<347fe244-d544-0bfa-f7a6-0f87ea7a475b@redhat.com>
	<c2451b20-c457-dbca-340f-fed0a35e673a@redhat.com>
Message-ID: <5d04f0b0-0736-dca4-1f59-eb0169148f77@redhat.com>
Date: Fri, 18 Aug 2017 02:57:45 +0200
MIME-Version: 1.0
In-Reply-To: <c2451b20-c457-dbca-340f-fed0a35e673a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 3/4] scsi: clarify sense codes for LUN0
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@suse.com>, qemu-devel@nongnu.org

On 08/18/17 02:16, Laszlo Ersek wrote:
> On 08/17/17 22:57, Laszlo Ersek wrote:
>> On 08/04/17 12:49, Paolo Bonzini wrote:
>>> On 04/08/2017 10:36, Hannes Reinecke wrote:
>>>> The LUN0 emulation is just that, an emulation for a non-existing
>>>> LUN0. So we should be returning LUN_NOT_SUPPORTED for any request
>>>> coming from any other LUN.
>>>> And we should be aborting unhandled commands with INVALID OPCODE,
>>>> not LUN NOT SUPPORTED.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>>>> ---
>>>>  hw/scsi/scsi-bus.c | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>>>> index 8419c75..79a222f 100644
>>>> --- a/hw/scsi/scsi-bus.c
>>>> +++ b/hw/scsi/scsi-bus.c
>>>> @@ -583,6 +583,11 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>>>>  {
>>>>      SCSITargetReq *r = DO_UPCAST(SCSITargetReq, req, req);
>>>>
>>>> +    if (req->lun != 0) {
>>>> +        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
>>>> +        scsi_req_complete(req, CHECK_CONDITION);
>>>> +        return 0;
>>>> +    }
>>>>      switch (buf[0]) {
>>>>      case REPORT_LUNS:
>>>>          if (!scsi_target_emulate_report_luns(r)) {
>>>> @@ -613,7 +618,7 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>>>>      case TEST_UNIT_READY:
>>>>          break;
>>>>      default:
>>>> -        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
>>>> +        scsi_req_build_sense(req, SENSE_CODE(INVALID_OPCODE));
>>>>          scsi_req_complete(req, CHECK_CONDITION);
>>>>          return 0;
>>>>      illegal_request:
>>>>
>>>
>>> I am queuing this one since it's an independent bugfix.
>>
>> This patch (ded6ddc5a7b9, "scsi: clarify sense codes for LUN0
>> emulation", 2017-08-04) seems to confuse the media detection in
>> edk2's "MdeModulePkg/Bus/Scsi/ScsiDiskDxe/ScsiDisk.c".
>>
>> Namely, when it enumerates the {targets}x{LUNs} matrix on the
>> virtio-scsi HBA, it now reports the following message, for each
>> (target,LUN) pair to which no actual SCSI device (like disk or
>> CD-ROM) is assigned on the command line:
>>
>> ScsiDisk: Sense Key = 0x5 ASC = 0x25!
>>
>> Unfortunately, this is not all that happens -- the ScsiDiskDxe driver
>> even installs a BlockIo protocol instance on the handle (again, there
>> is no media, and no actual SCSI device), on which further protocols
>> are stacked, such as BlockIo2:
>>
>> ScsiDisk: Sense Key = 0x5 ASC = 0x25!
>> InstallProtocolInterface: [EfiBlockIoProtocol] 13A59A3A8
>> InstallProtocolInterface: [EfiBlockIo2Protocol] 13A59A3D8
>> InstallProtocolInterface: [EfiDiskInfoProtocol] 13A59A4D0
>>
>> In turn, in BDS, UEFI boot options are auto-generated for these
>> devices, which is not nice, given that this procedure in BDS is very
>> pflash-intensive, and pflash access is remarkably slow on aarch64
>> KVM.
>>
>> For example, if I use one virtio-scsi HBA, and put a CD-ROM on target
>> 0, LUN 0, and a disk on target 1, LUN 0, then edk2 will create
>> protocol interfaces, and matching boot options, for
>>
>>   2 targets * 7 LUNs/target = 14 LUNs
>>
>> of which only 2 make sense.
>>
>>
>> If I revert the patch (on top of v2.10.0-rc3), then everything works
>> as before -- BlockIo protocol instances are produced only for actual
>> devices (with media).
>>
>> I guess the path forward is to fix the ScsiDiskDxe driver in edk2;
>> the new ASC should be recognized.
>>
>> My question is, how *exactly* did this patch change the reported
>> sense key and ASC? That is, what did they use to be *before*?
>> INVALID_OPCODE?
>
> I found the bug in edk2. It's a missing error check. I'll send a patch
> and CC you guys.

Actually, I think both QEMU and edk2 have bugs in this area.

The problem surfaces when the DiscoverScsiDevice() function in edk2's
"MdeModulePkg/Bus/Scsi/ScsiBusDxe/ScsiBus.c" file sends an INQUIRY
command to a nonexistent LUN (for probing purposes).

(1) About QEMU:

(1.1) Without the above patch, QEMU sends the following response:

> DiscoverScsiDevice:1361: Lun=2 HostAdapterStatus=0 TargetStatus=0
>                          SenseDataLength=0 InquiryDataLength=36
> Sense {
> Sense }
> Inquiry {
> Inquiry 000000 7F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry 000010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry 000020 00 00 00 00
> Inquiry }

This response *conforms* to the SPC-4, as follows:

> 6.4.1 INQUIRY command introduction
>
> [...]
>
> In response to an INQUIRY command received by an incorrect logical
> unit, the SCSI target device shall return the INQUIRY data with the
> peripheral qualifier set to the value defined in 6.4.2. The INQUIRY
> command shall return CHECK CONDITION status only when the device
> server is unable to return the requested INQUIRY data.
>
> [...]
>
> 6.4.2 Standard INQUIRY data
>
> [...]
>
> The PERIPHERAL QUALIFIER field and PERIPHERAL DEVICE TYPE field
> identify the peripheral device connected to the logical unit. If the
> SCSI target device is not capable of supporting a peripheral device
> connected to this logical unit, the device server shall set these
> fields to 7Fh (i.e., PERIPHERAL QUALIFIER field set to 011b and
> PERIPHERAL DEVICE TYPE field set to 1Fh).

(1.2) With the patch, QEMU sends the following response (ignore
InquiryData here, it's just an artifact of my debug patch):

> DiscoverScsiDevice:1361: Lun=2 HostAdapterStatus=0 TargetStatus=2
>                          SenseDataLength=18 InquiryDataLength=96
> Sense {
> Sense 000000 70 00 05 00 00 00 00 0A 00 00 00 00 25 00 00 00
> Sense 000010 00 00
> Sense }
> Inquiry {
> Inquiry 000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry 000010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry 000020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry 000030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry 000040 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry 000050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Inquiry }

Here "TargetStatus=2" means CHECK CONDITION, and the sense data
corresponds to "sense_code_LUN_NOT_SUPPORTED", returned by the first
hunk of the patch.

According to the SPC-4, this is less preferable, if not outright
invalid. The spec says (repeating it from above),

> The INQUIRY command shall return CHECK CONDITION status only when the
> device server is unable to return the requested INQUIRY data

with the "requested INQUIRY data" being, in this case,

> PERIPHERAL QUALIFIER field set to 011b and PERIPHERAL DEVICE TYPE
> field set to 1Fh

So in this regard, the patch implements an INQUIRY response that we
should minimally call "less preferred".

(2) About edk2:

The INQUIRY request site in question totally ignores TargetStatus and
SenseData. (This is arguably a bug; the SPC-4 *does* spell out a case
when the device server is allowed to respond with CHECK CONDITION.)

ScsiBusDxe happily produces ScsiIo protocol interfaces for nonexistent
LUNs in both cases, blindly saving the PERIPHERAL DEVICE TYPE value in
the ScsiIo protocol instance. The behavior differs only at a higher
level:

(2.1) Without the QEMU patch, the device type saved in the ScsiIo
protocol is 0x1f. This device type means "Unknown or no device type",
and so none of the SCSI device drivers in edk2 support it! In other
words, the ScsiIo protocol instances all exist (with an invalid device
type), but are ignored by other drivers.

(2.2) With the QEMU patch, the device type saved in the ScsiIo protocol
is zero, simply because the CHECK CONDITION response does not overwrite
the pre-zeroed InquiryData array in edk2. Type 0 happens to mean "Direct
access block device" (that is, disk), and that *is* bound by
ScsiDiskDxe. Hence the bogus BlockIo protocol instances, which show up
even in BDS.

I think I'll try to send an edk2 patch, but I suggest that the QEMU
patch too be reconsidered or revised.

Thanks
Laszlo
