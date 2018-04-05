Received: from eggs.gnu.org ([2001:4830:134:3::10]:58263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f46cw-0000EI-M9
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f46cu-0004HC-Ba
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48044
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1f46cu-0004Ge-2L
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:16:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35FDvLq016382
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 11:16:33 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5nnhjktq-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 11:16:33 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 5 Apr 2018 16:16:31 +0100
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1522940844-12336-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<e9cc70da-86d2-c2a2-d807-4715d0be24bf@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 5 Apr 2018 17:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <e9cc70da-86d2-c2a2-d807-4715d0be24bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <0d4fa49b-433e-b2ab-5303-61bf2d4d12ef@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390: Do not pass inofficial IPL type
 to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 05.04.2018 17:11, David Hildenbrand wrote:
> On 05.04.2018 17:07, Viktor Mihajlovski wrote:
>> IPL over a virtio-scsi device requires special handling not
>> available in the real architecture. For this purpose the IPL
>> type 0xFF has been chosen as means of communication between
>> QEMU and the pc-bios. However, a guest OS could be confused
>> by seeing an unknown IPL type.
>>
>> This change sets the IPL parameter type to 0x02 (CCW) to prevent
>> this. Pre-existing Linux has looked up the IPL parameters only in
>> the case of FCP IPL. This means that the behavior should stay
>> the same even if Linux checks for the IPL type unconditionally.
>>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> ---
>>  pc-bios/s390-ccw/bootmap.c |  7 +++++++
>>  pc-bios/s390-ccw/iplb.h    | 15 +++++++++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index fc2a9fe..9287b7a 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -70,6 +70,13 @@ static void jump_to_IPL_code(uint64_t address)
>>  {
>>      /* store the subsystem information _after_ the bootmap was loaded */
>>      write_subsystem_identification();
>> +
>> +    /* prevent unknown IPL types in the guest */
>> +    if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
>> +        iplb.pbt = S390_IPL_TYPE_CCW;
>> +        set_iplb(&iplb);
>> +    }
> 
> Confused, doesn't this imply that a system reset immediately after this
> instruction will result in something different getting booted?
> 
Not if the other (QEMU) patches of this series are applied. Without
them, the behavior is the same as with an re-ipl (Today's Linux will
always request a CCW re-ipl).
[...]

-- 
Regards,
  Viktor Mihajlovski
