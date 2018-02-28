Received: from eggs.gnu.org ([2001:4830:134:3::10]:35701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1er7S5-0003Ra-BZ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1er7S1-0006Mc-8d
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49016
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1er7S1-0006L1-3C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1SJT7HR091949
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:31:38 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gdwyynty6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:31:38 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 28 Feb 2018 19:31:36 -0000
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
	<20180226175751.2d8e5f05.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 28 Feb 2018 20:31:32 +0100
MIME-Version: 1.0
In-Reply-To: <20180226175751.2d8e5f05.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bd560bfd-1bf6-3806-ffaf-3627776f1912@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] s390x/sclp: extend SCLP event masks
 to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

h

On 02/26/2018 05:57 PM, Cornelia Huck wrote:
> On Fri, 23 Feb 2018 18:42:58 +0100
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> 
>> Extend the SCLP event masks to 64 bits.
>>
>> Notice that using any of the new bits results in a state that cannot be
>> migrated to an older version.
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/event-facility.c         | 56 ++++++++++++++++++++++++++++++---------
>>  include/hw/s390x/event-facility.h |  2 +-
>>  2 files changed, 45 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>> index e04ed9f..c3e39ee 100644
>> --- a/hw/s390x/event-facility.c
>> +++ b/hw/s390x/event-facility.c
>> @@ -30,7 +30,7 @@ struct SCLPEventFacility {
>>      SysBusDevice parent_obj;
>>      SCLPEventsBus sbus;
>>      /* guest's receive mask */
>> -    sccb_mask_t receive_mask;
>> +    uint32_t receive_mask_pieces[2];
>>      /*
>>       * when false, we keep the same broken, backwards compatible behaviour as
>>       * before, allowing only masks of size exactly 4; when true, we implement
>> @@ -42,6 +42,18 @@ struct SCLPEventFacility {
>>      uint16_t mask_length;
>>  };
>>  
>> +static inline sccb_mask_t make_receive_mask(SCLPEventFacility *ef)
>> +{
>> +    return ((sccb_mask_t)ef->receive_mask_pieces[0]) << 32 |
>> +                         ef->receive_mask_pieces[1];
>> +}
>> +
>> +static inline void store_receive_mask(SCLPEventFacility *ef, sccb_mask_t val)
>> +{
>> +    ef->receive_mask_pieces[1] = val;
>> +    ef->receive_mask_pieces[0] = val >> 32;
>> +}
>> +
> 
> Hm... how are all those values actually defined in the architecture?
> You pass around some values internally (which are supposedly in host
> endian) and then and/or them with the receive mask here. Are they
> compared byte-for-byte? 32-bit-for-32-bit?

Its a bitfield in ibm byte order. the length is a multitude of bytes.


> 
> I'm also not a fan of the _pieces suffix - reminds me of Dwarf pieces :)
> 
