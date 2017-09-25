Received: from eggs.gnu.org ([2001:4830:134:3::10]:52809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwSqw-0006Id-WF
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwSqt-00089u-2v
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:51:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwSqs-00089U-QL
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:51:11 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-19-david@redhat.com>
	<1e5cbbe5-63ab-e628-a742-4f540a2d8c85@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <775a2477-6fce-4fbb-e873-56fc5acc3033@redhat.com>
Date: Mon, 25 Sep 2017 14:51:05 +0200
MIME-Version: 1.0
In-Reply-To: <1e5cbbe5-63ab-e628-a742-4f540a2d8c85@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 18/27] s390x/tcg: implement SIGP SENSE
 RUNNING STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 25.09.2017 14:47, Thomas Huth wrote:
> On 18.09.2017 18:00, David Hildenbrand wrote:
>> Preparation for TCG, for KVM is this is completely handled in the
>> kernel.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cpu.h  |  2 ++
>>  target/s390x/sigp.c | 25 +++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 5d03802c7d..5aa755d7b5 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -594,6 +594,7 @@ struct sysib_322 {
>>  #define SIGP_SET_PREFIX        0x0d
>>  #define SIGP_STORE_STATUS_ADDR 0x0e
>>  #define SIGP_SET_ARCH          0x12
>> +#define SIGP_SENSE_RUNNING     0x15
>>  #define SIGP_STORE_ADTL_STATUS 0x17
>>  
>>  /* SIGP condition codes */
>> @@ -604,6 +605,7 @@ struct sysib_322 {
>>  
>>  /* SIGP status bits */
>>  #define SIGP_STAT_EQUIPMENT_CHECK   0x80000000UL
>> +#define SIGP_STAT_NOT_RUNNING       0x00000400UL
>>  #define SIGP_STAT_INCORRECT_STATE   0x00000200UL
>>  #define SIGP_STAT_INVALID_PARAMETER 0x00000100UL
>>  #define SIGP_STAT_EXT_CALL_PENDING  0x00000080UL
>> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
>> index 9587c3d319..c57312b743 100644
>> --- a/target/s390x/sigp.c
>> +++ b/target/s390x/sigp.c
>> @@ -234,6 +234,28 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
>>      si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
>>  }
>>  
>> +static void sigp_sense_running(S390CPU *dst_cpu, SigpInfo *si)
>> +{
>> +    if (!tcg_enabled()) {
>> +        /* handled in KVM */
>> +        set_sigp_status(si, SIGP_STAT_INVALID_ORDER);
>> +        return;
>> +    }
> 
> If we're sure that this is always handled in the kernel, I think you
> could simply do a "g_assert(tcg_enabled())" here instead?
> 
>  Thomas
> 

This keeps existing behavior and does not crash the guest. Therefore I
decided to not use a g_assert().

Especially, kernels throw every SIGP order to user space that they don't
understand. So e.g. a SIGP SENSE RUNNING could end up here for older
kernels.

-- 

Thanks,

David
