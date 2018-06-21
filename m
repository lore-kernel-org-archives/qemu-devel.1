Received: from eggs.gnu.org ([2001:4830:134:3::10]:49168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fW7dW-0001Kk-6u
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fW7dU-0000wL-Sy
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:01:02 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:39118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fW7dU-0000va-Mh
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 18:01:00 -0400
Received: by mail-qk0-x241.google.com with SMTP id g14-v6so2665338qkm.6
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:01:00 -0700 (PDT)
References: <20180608200740.24915-1-danielhb413@gmail.com>
	<20180608200740.24915-4-danielhb413@gmail.com>
	<d2c8b235-3326-f78d-620e-d163ff8e880f@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <3f08cffd-a575-517f-302f-2fc587820376@gmail.com>
Date: Thu, 21 Jun 2018 19:00:56 -0300
MIME-Version: 1.0
In-Reply-To: <d2c8b235-3326-f78d-620e-d163ff8e880f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1 3/3] scsi-block: adding flag at realize
 to enable Block Limits emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com



On 06/21/2018 07:01 AM, Paolo Bonzini wrote:
> On 08/06/2018 22:07, Daniel Henrique Barboza wrote:
>> The previous patches implemented a way to deliver an emulated
>> Block Limits (BL) response for the guest in case the underlying
>> hardware does not support this page.
>>
>> However, the approach used is crude. We're executing the logic for
>> all SCSI devices, regardless of whether they need it or not. There's
>> also a possibility that we'll end up masking a legitimate SCSI error
>> of a device that does implement the BL page (thus not needing any
>> BL emulation).
>>
>> This patch refines the solution used in the previous patches by
>> adding a new SCSIDevice attribute called 'needs_vpl_bl_emulation'.
>> This flag is set at scsi_block_realize using a new function called
>> 'scsi_block_set_vpd_bl_emulation'. This new function queries the
>> Inquiry Supported Pages of the device and checks if it supports
>> the BL message. If it doesn't, the emulation flag is set to 'true'.
>>
>> This flag is then used at scsi_read_complete to isolate the emulation
>> logic from the devices that does not require it.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/scsi/scsi-disk.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/scsi/scsi-generic.c | 32 +++++++++++++++-----------------
>>   include/hw/scsi/scsi.h |  1 +
>>   3 files changed, 65 insertions(+), 17 deletions(-)
> Please squash this in the previous patch.  I wonder if it should be
> limited to scsi-block, or it should be done for all TYPE_DISK
> passthrough devices.

I'll end up doing like you suggested in the patch 1/3 review (a cleanup
patch first, the whole feature later on in a single patch).


>
> In that case, you could do the check in
> scsi_generic_read_device_identification (possibly renaming it to
> scsi_generic_read_device_inquiry).

Sounds good. I'll see how it goes in v2.



Thanks,


Daniel

>
> Thanks,
>
> Paolo
>
>> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
>> index 4461a592e5..cb53d0fdab 100644
>> --- a/hw/scsi/scsi-disk.c
>> +++ b/hw/scsi/scsi-disk.c
>> @@ -2599,6 +2599,54 @@ static int get_device_type(SCSIDiskState *s)
>>       return 0;
>>   }
>>   
>> +static void scsi_block_set_vpd_bl_emulation(SCSIDevice *s)
>> +{
>> +    uint8_t cmd[6];
>> +    uint8_t buf[250];
>> +    uint8_t sensebuf[8];
>> +    uint8_t page_len;
>> +    sg_io_hdr_t io_header;
>> +    int ret, i;
>> +
>> +    memset(cmd, 0, sizeof(cmd));
>> +    memset(buf, 0, sizeof(buf));
>> +    cmd[0] = INQUIRY;
>> +    cmd[1] = 1;
>> +    cmd[2] = 0x00;
>> +    cmd[4] = sizeof(buf);
>> +
>> +    memset(&io_header, 0, sizeof(io_header));
>> +    io_header.interface_id = 'S';
>> +    io_header.dxfer_direction = SG_DXFER_FROM_DEV;
>> +    io_header.dxfer_len = sizeof(buf);
>> +    io_header.dxferp = buf;
>> +    io_header.cmdp = cmd;
>> +    io_header.cmd_len = sizeof(cmd);
>> +    io_header.mx_sb_len = sizeof(sensebuf);
>> +    io_header.sbp = sensebuf;
>> +    io_header.timeout = 6000; /* XXX */
>> +
>> +    ret = blk_ioctl(s->conf.blk, SG_IO, &io_header);
>> +    if (ret < 0 || io_header.driver_status || io_header.host_status) {
>> +        /*
>> +         * Do not assume anything if we can't retrieve the
>> +         * INQUIRY response to assert the VPD Block Limits
>> +         * support.
>> +         */
>> +        s->needs_vpd_bl_emulation = false;
>> +        return;
>> +    }
>> +
>> +    page_len = buf[3];
>> +    for (i = 4; i < page_len + 4; i++) {
>> +        if (buf[i] == 0xb0) {
>> +            s->needs_vpd_bl_emulation = false;
>> +            return;
>> +        }
>> +    }
>> +    s->needs_vpd_bl_emulation = true;
>> +}
>> +
>>   static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>>   {
>>       SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
>> @@ -2648,6 +2696,7 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
>>   
>>       scsi_realize(&s->qdev, errp);
>>       scsi_generic_read_device_identification(&s->qdev);
>> +    scsi_block_set_vpd_bl_emulation(dev);
>>   }
>>   
>>   typedef struct SCSIBlockReq {
>> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
>> index 64d3b79518..e08ffaa38c 100644
>> --- a/hw/scsi/scsi-generic.c
>> +++ b/hw/scsi/scsi-generic.c
>> @@ -243,9 +243,8 @@ static void scsi_read_complete(void * opaque, int ret)
>>   {
>>       SCSIGenericReq *r = (SCSIGenericReq *)opaque;
>>       SCSIDevice *s = r->req.dev;
>> -    SCSISense sense;
>>       uint8_t page, page_len;
>> -    int len, i;
>> +    int len;
>>   
>>       assert(r->req.aiocb != NULL);
>>       r->req.aiocb = NULL;
>> @@ -328,11 +327,17 @@ static void scsi_read_complete(void * opaque, int ret)
>>                    * the buffer, clean up the io_header to avoid firing up
>>                    * the sense error.
>>                    */
>> -                if (sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
>> +                if (s->needs_vpd_bl_emulation) {
>> +
>>                       r->buflen = scsi_emulate_vpd_bl_page(s, r->buf);
>>                       r->io_header.sb_len_wr = 0;
>>   
>> -                    /* Clean sg_io_sense */
>> +                    /*
>> +                     * We have valid contents in the reply buffer but the
>> +                     * io_header will report a sense error coming from
>> +                     * the hardware in scsi_command_complete_noio. Clean it
>> +                     * up the io_header to avoid reporting it.
>> +                     */
>>                       r->io_header.driver_status = 0;
>>                       r->io_header.status = 0;
>>   
>> @@ -346,26 +351,19 @@ static void scsi_read_complete(void * opaque, int ret)
>>                       stl_be_p(&r->buf[12],
>>                                MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
>>                   }
>> -            } else if (page == 0x00) {
>> +            } else if (page == 0x00 && s->needs_vpd_bl_emulation) {
>>                   /*
>>                    * Now we're capable of supplying the VPD Block Limits
>> -                 * response if the hardware can't. Inspect if the INQUIRY
>> -                 * response contains support for the VPD Block Limits page.
>> -                 * Add it if it doesn't.
>> +                 * response if the hardware can't. Add it in the INQUIRY
>> +                 * Supported VPD pages response in case we are using the
>> +                 * emulation for this device.
>>                    *
>>                    * This way, the guest kernel will be aware of the support
>>                    * and will use it to proper setup the SCSI device.
>>                    */
>>                   page_len = r->buf[3];
>> -                for (i = 4; i < page_len + 4; i++) {
>> -                    if (r->buf[i] == 0xb0) {
>> -                        break;
>> -                    }
>> -                }
>> -                if (i == page_len + 4) {
>> -                    r->buf[i] = 0xb0;
>> -                    r->buf[3] = ++page_len;
>> -                }
>> +                r->buf[page_len + 4] = 0xb0;
>> +                r->buf[3] = ++page_len;
>>               }
>>           }
>>       }
>> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
>> index 4fdde102b8..5fba858b11 100644
>> --- a/include/hw/scsi/scsi.h
>> +++ b/include/hw/scsi/scsi.h
>> @@ -90,6 +90,7 @@ struct SCSIDevice
>>       uint64_t port_wwn;
>>       int scsi_version;
>>       int default_scsi_version;
>> +    bool needs_vpd_bl_emulation;
>>   };
>>   
>>   extern const VMStateDescription vmstate_scsi_device;
>>
