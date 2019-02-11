Received: from eggs.gnu.org ([209.51.188.92]:49879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gt6xT-0005jG-EB
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gt6xS-000207-E1
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:28:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52754
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gt6xQ-0001qQ-F9
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:28:53 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1B8Krno075993
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:28:43 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qk33jp2um-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:28:43 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Feb 2019 08:28:41 -0000
References: <20190208221111.25237-1-walling@linux.ibm.com>
	<20190211092339.054706bb.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Feb 2019 09:28:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190211092339.054706bb.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <4441a5a6-6c26-0e2c-8b95-40af98b2962c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/cpumodel: default enable mepoch
 for z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, david@redhat.com, pasic@linux.ibm.com, rth@twiddle.net



On 11.02.2019 09:23, Cornelia Huck wrote:
> On Fri,  8 Feb 2019 17:11:10 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> Latest systems and host kernels support mepoch, which is a
>> feature that was meant to be supported for z14 GA1 from the
>> get-go. Let's copy it to the z14 GA1 default CPU model.
> 
> Do older kernels simply not support it, or was there something actively
> missing? IOW, is it fine to turn this on with older kernels?

Older kernels will not provide the necessary implementation, so mepoch will not
work with such older kernel. (So worst case would be that a new qemu+old kernel
requires to add mepoch=off to -cpu z14)
The idea of this patch is to update QEMU in accordance with newer kernels to use
more features by default if people use -cpu z14.

Now that I look a 2nd time: shall we also add 
S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF ?


> 
> [It's probably all good, although I like to wait for David's ack for
> any cpu model patches :)]
> 
>>
>> Machines s390-ccw-virtio-3.1 and older will retain the old CPU
>> models and will not provide this bit in the default model.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c  | 1 +
>>  target/s390x/gen-features.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index fd9d0b0542..32c5027345 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -757,6 +757,7 @@ DEFINE_CCW_MACHINE(4_0, "4.0", true);
>>  static void ccw_machine_3_1_instance_options(MachineState *machine)
>>  {
>>      ccw_machine_4_0_instance_options(machine);
>> +    s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
>>  }
>>  
>>  static void ccw_machine_3_1_class_options(MachineClass *mc)
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 70015eaaf5..d258d67dca 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -550,6 +550,7 @@ static uint16_t default_GEN14_GA1[] = {
>>      S390_FEAT_GROUP_MSA_EXT_6,
>>      S390_FEAT_GROUP_MSA_EXT_7,
>>      S390_FEAT_GROUP_MSA_EXT_8,
>> +    S390_FEAT_MULTIPLE_EPOCH,
>>  };
>>  
>>  /* QEMU (CPU model) features */
> 
