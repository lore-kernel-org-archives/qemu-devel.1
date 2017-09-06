Received: from eggs.gnu.org ([2001:4830:134:3::10]:51922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZgQ-000050-KM
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZfd-00011M-Ik
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:43:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49384
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpZfd-000113-DG
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:43:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86Cd0gB122407
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 08:43:04 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ctc3jfvh3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 08:43:04 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 13:43:03 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-3-pasic@linux.vnet.ibm.com>
	<20170906143257.05f302c7.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 14:42:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170906143257.05f302c7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <77ebf9b2-ac17-878c-3d7a-a1ef352ea438@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] s390x/css: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/06/2017 02:32 PM, Cornelia Huck wrote:
> On Tue,  5 Sep 2017 13:16:42 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Replace direct access which implicitly assumes no IDA
>> or MIDA with the new ccw data stream interface which should
>> cope with these transparently in the future.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 87d913f81c..c1bc9944e6 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -890,6 +890,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>>      }
>>  
>>      /* Look at the command. */
>> +    ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
>>      switch (ccw.cmd_code) {
>>      case CCW_CMD_NOOP:
>>          /* Nothing to do. */
>> @@ -903,7 +904,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>>              }
>>          }
>>          len = MIN(ccw.count, sizeof(sch->sense_data));
>> -        cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
>> +        ccw_dstream_write_buf(&sch->cds, sch->sense_data, len);
>>          sch->curr_status.scsw.count = ccw.count - len;
> 
> ccw_dstream_residual_count()?

Yeah, I've introduced that function later. Will do.

> 
>>          memset(sch->sense_data, 0, sizeof(sch->sense_data));
>>          ret = 0;
>> @@ -930,7 +931,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>>          } else {
>>              sense_id.reserved = 0;
>>          }
>> -        cpu_physical_memory_write(ccw.cda, &sense_id, len);
>> +        ccw_dstream_write_buf(&sch->cds, &sense_id, len);
>>          sch->curr_status.scsw.count = ccw.count - len;
> 
> dito
> 
>>          ret = 0;
>>          break;
> 
