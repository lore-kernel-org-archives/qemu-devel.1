Received: from eggs.gnu.org ([2001:4830:134:3::10]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ej0G2-0001kS-DD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ej0Fy-0003MZ-88
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:13:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ej0Fx-0003M4-UD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:13:42 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16ACHbm103033
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 05:13:41 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fy770r2sw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 05:13:40 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 10:13:38 -0000
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-6-git-send-email-walling@linux.vnet.ibm.com>
	<0c40e592-32e7-315e-fbad-1969c90b9b01@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 6 Feb 2018 11:13:33 +0100
MIME-Version: 1.0
In-Reply-To: <0c40e592-32e7-315e-fbad-1969c90b9b01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <60be1af6-ab00-5425-1cac-edb722dfcc1a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 05/12] s390-ccw: move
 auxiliary IPL data to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 06.02.2018 10:23, Thomas Huth wrote:
> On 05.02.2018 21:57, Collin L. Walling wrote:
>> The s390-ccw firmware needs some information in support of the
>> boot process which is not available on the native machine.
>> Examples are the netboot firmware load address and now the
>> boot menu parameters.
>>
>> While storing that data in unused fields of the IPL parameter block
>> works, that approach could create problems if the parameter block
>> definition should change in the future. Because then a guest could
>> overwrite these fields using the set IPLB diagnose.
>>
>> In fact the data in question is of more global nature and not really
>> tied to an IPL device, so separating it is rather logical.
>>
>> This commit introduces a new structure to hold firmware relevant
>> IPL parameters set by QEMU. The data is stored at location 204 (dec)
>> and can contain up to 7 32-bit words. This area is available to
>> programming in the z/Architecture Principles of Operation and
>> can thus safely be used by the firmware until the IPL has completed.
> 
> Sounds like a good idea.
> 
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/ipl.c          | 18 +++++++++++++++++-
>>  hw/s390x/ipl.h          | 11 +++++++++--
>>  pc-bios/s390-ccw/iplb.h | 12 ++++++++++--
>>  pc-bios/s390-ccw/main.c |  6 +++++-
>>  4 files changed, 41 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 0d06fc1..3e3c3b8 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -399,6 +399,20 @@ void s390_reipl_request(void)
>>      qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>>  }
>>  
>> +static void s390_ipl_prepare_qipl(S390CPU *cpu)
>> +{
>> +    S390IPLState *ipl = get_ipl_device();
>> +    uint8_t *addr;
>> +    uint64_t len = 4096;
>> +
>> +    addr = cpu_physical_memory_map(cpu->env.psa, &len, 1);
>> +    if (!addr || len < 204 + sizeof(QemuIplParameters)) {
>> +        error_report("Cannot set QEMU IPL parameters");
> 
> I think you should return or exit() here. Otherwise the memcpy below
> accesses an illegal memory range.Right, I have noticed and fixed that on my private branch, but forgot to
update the patch. Collin, could you squash in a
            return;
> 
>> +    }
>> +    memcpy(addr + 204, &ipl->iplb.qipl, sizeof(QemuIplParameters));
>> +    cpu_physical_memory_unmap(addr, len, 1, len);
>> +}
>> +
[...]
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 8a705e0..68dcaf8 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -16,8 +16,7 @@
>>  #include "cpu.h"
>>  
>>  struct IplBlockCcw {
>> -    uint64_t netboot_start_addr;
>> -    uint8_t  reserved0[77];
>> +    uint8_t  reserved0[85];
>>      uint8_t  ssid;
>>      uint16_t devno;
>>      uint8_t  vm_flags;
>> @@ -59,6 +58,13 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>  
>>  #define DIAG308_FLAGS_LP_VALID 0x80
>>  
>> +struct QemuIplParameters {
>> +    uint8_t  reserved1[4];
>> +    uint64_t netboot_start_addr;
>> +    uint8_t  reserved2[16];
>> +} QEMU_PACKED;
>> +typedef struct QemuIplParameters QemuIplParameters;
>> +
>>  union IplParameterBlock {
>>      struct {
>>          uint32_t len;
>> @@ -74,6 +80,7 @@ union IplParameterBlock {
>>              IplBlockFcp fcp;
>>              IplBlockQemuScsi scsi;
>>          };
>> +        QemuIplParameters qipl;
>>      } QEMU_PACKED;
> 
> Sorry if I get that wrong, but if you store that within
> IplParameterBlock, the information is still passed via DIAG 0x308, isn't
> it? (see handle_diag_308(), case 6). Is that really what was intended here?
> 
Got me :).
The intention is to remove non-standard data from the IPL parameter
block. But I needed a place to store it in the s390-ipl context. The
IPLB conveniently has plenty of space following the standard data.
The alternative would be to have the QEMU IPL parameters explicitly
called out in the object. But they're only duplication information
available elsewhere (boot menu) or are computed anyway (netboot).
This may change in the future...
> [...]
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index e857ce4..825a1a3 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -16,6 +16,7 @@ char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>>  static SubChannelId blk_schid = { .one = 1 };
>>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>>  static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
>> +QemuIplParameters qipl;
>>  
>>  /*
>>   * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
>> @@ -81,6 +82,7 @@ static void virtio_setup(void)
>>      uint16_t dev_no;
>>      char ldp[] = "LOADPARM=[________]\n";
>>      VDev *vdev = virtio_get_device();
>> +    QemuIplParameters *early_qipl = (QemuIplParameters *)204;
> 
> Could you please introduce a proper #define for that magic 204 value
> (and use it in s390_ipl_prepare_qipl, too)? ... so that it is later
> easier to grep for this.
> 
Hm ... I was following the pattern established in
write_subsystem_identification(). Christian, what is your opinion?
>>      /*
>>       * We unconditionally enable mss support. In every sane configuration,
>> @@ -93,6 +95,8 @@ static void virtio_setup(void)
>>      memcpy(ldp + 10, loadparm, 8);
>>      sclp_print(ldp);
>>  
>> +    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
>> +
>>      if (store_iplb(&iplb)) {
>>          switch (iplb.pbt) {
>>          case S390_IPL_TYPE_CCW:
>> @@ -127,7 +131,7 @@ static void virtio_setup(void)
>>  
>>      if (virtio_get_device_type() == VIRTIO_ID_NET) {
>>          sclp_print("Network boot device detected\n");
>> -        vdev->netboot_start_addr = iplb.ccw.netboot_start_addr;
>> +        vdev->netboot_start_addr = qipl.netboot_start_addr;
>>      } else {
>>          virtio_blk_setup_device(blk_schid);
>>  
>>
> 
>  Thomas
> 


-- 
Regards,
 Viktor Mihajlovski
