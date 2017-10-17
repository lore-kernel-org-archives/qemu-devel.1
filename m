Received: from eggs.gnu.org ([2001:4830:134:3::10]:36961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4UV7-0001GT-Rf
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4UV1-0008GX-Nl
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:13:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34222
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e4UV1-0008G8-Id
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:13:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9HG9VQV019614
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 12:13:42 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dnkyyc40j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 12:13:41 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 17 Oct 2017 17:13:40 +0100
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-3-pasic@linux.vnet.ibm.com>
	<20171017165817.5880e317.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 18:13:35 +0200
MIME-Version: 1.0
In-Reply-To: <20171017165817.5880e317.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9f1f1dd4-80eb-8b9d-7ee9-3e4ad747259f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 10/17/2017 04:58 PM, Cornelia Huck wrote:
> On Tue, 17 Oct 2017 16:04:48 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> CSS code needs to tell the IO instruction handlers located in how should
>> the emulated instruction be ended. Currently this is done by returning
>> generic (POSIX) error codes, and mapping them to outcomes like condition
>> codes. This makes bugs easy to create and hard to recognise.

also
s/recognise/recognize/

To on mix American and British.

>>
>> As a preparation for moving a way form (mis)using generic error codes for
> 
> s/form/from/
> 

Sorry this seems to be a recurring typo of me (not detected by spell check
because both valid).

>> flow control let us introduce a type which tells the instruction
>> handler function how to end the instruction, in a more straight-forward
>> and less ambiguous way.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  include/hw/s390x/css.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>> index 69b374730e..7e0dbd162f 100644
>> --- a/include/hw/s390x/css.h
>> +++ b/include/hw/s390x/css.h
>> @@ -99,6 +99,22 @@ typedef struct CcwDataStream {
>>      hwaddr cda;
>>  } CcwDataStream;
>>  
>> +/*
>> + * IO instructions conclude according this. Currently we have only
> 
> s/this/to this/
> 
>> + * cc codes. Valid values are 0,1,2,3 and the generic semantic for
> 
> blanks between numbers?

Overrated. Just joking. Definitely blanks between numbers.

> 
>> + * IO instructions is described briefly. For more details consult the PoP.
>> + */
>> +typedef enum IOInstEnding {
>> +    /* produced expected result */
>> +    IOINST_CC_EXPECTED = 0,
>> +    /* status conditions were present or produced alternate result */
>> +    IOINST_CC_STATUS_PRESENT = 1,
>> +    /* inst. ineffective because busy with previously initiated function */
>> +    IOINST_CC_BUSY = 2,
>> +    /* inst. ineffective because not operational */
>> +    IOINST_CC_NOT_OPERATIONAL = 3
>> +} IOInstEnding;
> 
> This looks a bit odd for some I/O instructions (STCRW, TPI, TSCH), but
> is fine for the others. But as the PoP also defines the meanings as
> above, it should be fine (and not confusing).

Yeah. The original idea was to keep stuff abstract, but I decided
to go with the names carrying meaning because Thomas seems to
be more reliable than me when it comes to matters of taste, and also
for consistency with SIGP_CC_*. I think, in the end it does not matter
that much.

> 
>> +
>>  typedef struct SubchDev SubchDev;
>>  struct SubchDev {
>>      /* channel-subsystem related things: */
> 
> 
