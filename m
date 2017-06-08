Received: from eggs.gnu.org ([2001:4830:134:3::10]:35585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIvGD-0001mh-QY
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIvG8-0000ew-Pu
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:05:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIvG8-0000ek-GT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:05:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58B4FpP074940
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 07:05:46 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axw9sn28j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 07:05:45 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 8 Jun 2017 12:05:42 +0100
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
	<20170607095127.GB2099@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 8 Jun 2017 13:05:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170607095127.GB2099@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>



On 06/07/2017 11:51 AM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> In some cases a failing VMSTATE_*_EQUAL does not mean we detected a bug
>> (it's actually the best we can do). Especially in these cases a verbose
>> error message is required.
>>
>> Let's introduce infrastructure for specifying a error hint to be used if
>> equal check fails.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>> Macros come in part 2. Once we are happy with the macros
>> this two patches should be squashed into one. 
>> ---
>>  include/migration/vmstate.h |  1 +
>>  migration/vmstate-types.c   | 36 +++++++++++++++++++++++++++++++-----
>>  2 files changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 66895623da..d90d9b12ca 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -200,6 +200,7 @@ typedef enum {
>>  
>>  struct VMStateField {
>>      const char *name;
>> +    const char *err_hint;
>>      size_t offset;
>>      size_t size;
>>      size_t start;
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index 7287c6baa6..84d0545a38 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -19,6 +19,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/queue.h"
>>  #include "trace.h"
>> +#include "qapi/error.h"
>>  
>>  /* bool */
>>  
>> @@ -118,6 +119,7 @@ const VMStateInfo vmstate_info_int32 = {
>>  static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
>>                             VMStateField *field)
>>  {
>> +    Error *err = NULL;
>>      int32_t *v = pv;
>>      int32_t v2;
>>      qemu_get_sbe32s(f, &v2);
>> @@ -125,7 +127,11 @@ static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
>>      if (*v == v2) {
>>          return 0;
>>      }
>> -    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
>> +    error_setg(&err, "%" PRIx32 " != %" PRIx32, *v, v2);
>> +    if (field->err_hint) {
>> +        error_append_hint(&err, "%s\n", field->err_hint);
>> +    }
>> +    error_report_err(err);
> 
> I'm a bit worried as to whether the error_append_hint data gets
> printed out by error_report_err if we're being driven by a QMP
> monitor.
> error_report_err uses error_printf_unless_qmp
> 
> Since this code doesn't really handle Error *'s back up,
> and always prints it's errors into stderr, I'd prefer if you just
> used error_report again for the hint, something like:
> 
> if (field->err_hint) {
>   error_report("%" PRIx32 " != %" PRIx32 "(%s)",
>                *v, v2, field->err_hint);
> } else {
>   error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> }
> 
> Dave

One reason I choose error_report_err is to be consistent about hint
reporting (the other one is that was what Connie suggested). I do
not understand why do we omit hints if QMP, but I figured that's
our policy. So the hint I'm adding must not be printed in QMP
context -- because that's our policy. I was pretty sure what I
want to do is add a hint (and not make a very long 'core' error
message).

Can you (or somebody else)  explain why are hints dropped in QMP
context?

Don't misunderstand I'm open towards your proposal, it's just
that:
1) I would like to understand.
2) I would like to get the very same result as produced by
https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg01472.html 

Regards,
Halil
