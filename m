Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1VhT-0000rC-8d
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 06:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1VhN-0008Ai-HX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 06:54:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1VhN-0008A2-8H
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 06:54:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99As0FT025004
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 06:54:08 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dg7fk93um-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 06:54:08 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 11:54:06 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 12:54:03 +0200
MIME-Version: 1.0
In-Reply-To: <d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/09/2017 10:20 AM, Thomas Huth wrote:
> On 04.10.2017 17:41, Halil Pasic wrote:
>> CSS code needs to tell the IO instruction handlers located in how should
> 
> located in how?
> 

First, thanks for your review!

Wanted to say: in target/s390x/ioinst.c just forgot to copy paste.

>> the emulated instruction be ended. Currently this is done by returning
>> generic (POSIX) error codes, and mapping them to outcomes like condition
>> codes. This makes bugs easy to create and hard to recognise.
>>
>> As a preparation for moving a way form (mis)using generic error codes for
>> flow control let us introduce a struct which tells the instruction
>> handler function how to end the instruction, in a more straight-forward
>> and less ambiguous way.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  include/hw/s390x/css.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>> index 0653d3c9be..66916b6546 100644
>> --- a/include/hw/s390x/css.h
>> +++ b/include/hw/s390x/css.h
>> @@ -75,6 +75,18 @@ typedef struct CMBE {
>>      uint32_t reserved[7];
>>  } QEMU_PACKED CMBE;
>>  
>> +/* IO instructions conclude according this */
>> +typedef struct IOInstEnding {
>> +        /*
>> +         * General semantic of cc codes of IO instructions is (brief):
>> +         * 0 -- produced expected result
>> +         * 1 --  status conditions were present or produced alternate result
>> +         * 2 -- ineffective, because busy with previously initiated function
>> +         * 3 -- ineffective, not operational
>> +         */
>> +        int cc;
>> +} IOInstEnding;
> 
> Why do you need a struct for this? Do you plan to extend it later? If
> so, I think you should mention that in the patch description. If not,
> please use a named enum or a "typedef unsigned int IOInstEnding" instead.
> 
>  Thomas

We may, we may not. In the previous version we also had to support
do end a certain instruction with an addressing exception, but this
is going away in patch #3. Honestly I don't expect this being extended.

I have other reasons for the struct. Type safety and clear semantics,
and frankly at least for s390 and linux I don't see any downsides given
what is written in the "zSeries ELF Application Binary Interface Supplement".
Can you please explain to me what is the problem with using this struct, and
what is the benefit switching to a unsigned int?

Regards,
Halil
> 
