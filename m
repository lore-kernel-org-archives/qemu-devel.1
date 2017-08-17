Received: from eggs.gnu.org ([2001:4830:134:3::10]:47758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1diS0e-0001X6-4z
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 17:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1diS0a-0005pI-4S
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 17:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1diS0Z-0005fW-Qz
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 17:07:16 -0400
References: <1501835795-92331-1-git-send-email-hare@suse.de>
	<1501835795-92331-4-git-send-email-hare@suse.de>
	<cecc5581-7013-f870-dbd7-da28ac80d2a4@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <347fe244-d544-0bfa-f7a6-0f87ea7a475b@redhat.com>
Date: Thu, 17 Aug 2017 22:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <cecc5581-7013-f870-dbd7-da28ac80d2a4@redhat.com>
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

On 08/04/17 12:49, Paolo Bonzini wrote:
> On 04/08/2017 10:36, Hannes Reinecke wrote:
>> The LUN0 emulation is just that, an emulation for a non-existing
>> LUN0. So we should be returning LUN_NOT_SUPPORTED for any request
>> coming from any other LUN.
>> And we should be aborting unhandled commands with INVALID OPCODE,
>> not LUN NOT SUPPORTED.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  hw/scsi/scsi-bus.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>> index 8419c75..79a222f 100644
>> --- a/hw/scsi/scsi-bus.c
>> +++ b/hw/scsi/scsi-bus.c
>> @@ -583,6 +583,11 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>>  {
>>      SCSITargetReq *r = DO_UPCAST(SCSITargetReq, req, req);
>>  
>> +    if (req->lun != 0) {
>> +        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
>> +        scsi_req_complete(req, CHECK_CONDITION);
>> +        return 0;
>> +    }
>>      switch (buf[0]) {
>>      case REPORT_LUNS:
>>          if (!scsi_target_emulate_report_luns(r)) {
>> @@ -613,7 +618,7 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
>>      case TEST_UNIT_READY:
>>          break;
>>      default:
>> -        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
>> +        scsi_req_build_sense(req, SENSE_CODE(INVALID_OPCODE));
>>          scsi_req_complete(req, CHECK_CONDITION);
>>          return 0;
>>      illegal_request:
>>
> 
> I am queuing this one since it's an independent bugfix.

This patch (ded6ddc5a7b9, "scsi: clarify sense codes for LUN0
emulation", 2017-08-04) seems to confuse the media detection in edk2's
"MdeModulePkg/Bus/Scsi/ScsiDiskDxe/ScsiDisk.c".

Namely, when it enumerates the {targets}x{LUNs} matrix on the
virtio-scsi HBA, it now reports the following message, for each
(target,LUN) pair to which no actual SCSI device (like disk or CD-ROM)
is assigned on the command line:

ScsiDisk: Sense Key = 0x5 ASC = 0x25!

Unfortunately, this is not all that happens -- the ScsiDiskDxe driver
even installs a BlockIo protocol instance on the handle (again, there is
no media, and no actual SCSI device), on which further protocols are
stacked, such as BlockIo2:

ScsiDisk: Sense Key = 0x5 ASC = 0x25!
InstallProtocolInterface: [EfiBlockIoProtocol] 13A59A3A8
InstallProtocolInterface: [EfiBlockIo2Protocol] 13A59A3D8
InstallProtocolInterface: [EfiDiskInfoProtocol] 13A59A4D0

In turn, in BDS, UEFI boot options are auto-generated for these devices,
which is not nice, given that this procedure in BDS is very
pflash-intensive, and pflash access is remarkably slow on aarch64 KVM.

For example, if I use one virtio-scsi HBA, and put a CD-ROM on target 0,
LUN 0, and a disk on target 1, LUN 0, then edk2 will create protocol
interfaces, and matching boot options, for

  2 targets * 7 LUNs/target = 14 LUNs

of which only 2 make sense.


If I revert the patch (on top of v2.10.0-rc3), then everything works as
before -- BlockIo protocol instances are produced only for actual
devices (with media).

I guess the path forward is to fix the ScsiDiskDxe driver in edk2; the
new ASC should be recognized.

My question is, how *exactly* did this patch change the reported sense
key and ASC? That is, what did they use to be *before*? INVALID_OPCODE?

Thanks!
Laszlo
