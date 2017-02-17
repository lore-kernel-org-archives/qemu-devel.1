Received: from eggs.gnu.org ([2001:4830:134:3::10]:60137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cennG-00006T-37
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1cennD-0002qB-0J
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:02:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51445
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1cennC-0002pr-Pj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:02:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1HIwaKs024946
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 14:02:05 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28nwc8070w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 14:02:05 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 17 Feb 2017 17:02:03 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id ED9511DC006F
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 14:02:02 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1HJ1uTU35979514
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 17:02:01 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1HJ1fix021206
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 17:01:41 -0200
References: <20170217172607.25575-1-danielhb@linux.vnet.ibm.com>
	<3c2ce558-db56-79b5-14ed-4431f6529c82@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 17:01:28 -0200
MIME-Version: 1.0
In-Reply-To: <3c2ce558-db56-79b5-14ed-4431f6529c82@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <6fe6a499-faa2-1e3d-a419-d33b2e538e7c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com



On 02/17/2017 03:37 PM, Paolo Bonzini wrote:
>
> On 17/02/2017 18:26, Daniel Henrique Barboza wrote:
>> The previous error message was displaying the values in miliseconds,
>> being misleading with the command that accepts the value in seconds:
>>
>> { "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
>> {"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
>> expects an integer in the range of 0 to 2000000 milliseconds"}}
>>
>> This patch changes it to '2000 seconds' to keep consistency with
>> the expected parameter.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>   migration/migration.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index c6ae69d..2dc63b1 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -49,6 +49,9 @@
>>    * for sending the last part */
>>   #define DEFAULT_MIGRATE_SET_DOWNTIME 300
>>   
>> +/* Maximum migrate downtime set to 2000*1000 miliseconds */
>> +#define MAX_MIGRATE_SET_DOWNTIME (2000 * 1000)
>> +
>>   /* Default compression thread count */
>>   #define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
>>   /* Default decompression thread count, usually decompression is at
>> @@ -843,10 +846,11 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>           return;
>>       }
>>       if (params->has_downtime_limit &&
>> -        (params->downtime_limit < 0 || params->downtime_limit > 2000000)) {
>> +        (params->downtime_limit < 0 ||
>> +         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
>>           error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>>                      "downtime_limit",
>> -                   "an integer in the range of 0 to 2000000 milliseconds");
>> +                   "an integer in the range of 0 to 2000 seconds");
> Perhaps you could use %d and set  MAX_MIGRATE_SET_DOWNTIME to 2000?
> Though perhaps the migration maintainers are okay with the patch as is.

I did that at first but I got errors on "error_setg" about the extra 
parameter.
I even considered using sprintf to format the string but I was afraid it 
would be
a little overkill.


Daniel

>
> Paolo
>
>>           return;
>>       }
>>       if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
>>
