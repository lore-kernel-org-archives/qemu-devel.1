Received: from eggs.gnu.org ([2001:4830:134:3::10]:34237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eED6P-0000MH-7p
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eED6M-0004Ny-3k
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:40:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57518
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eED6L-0004Gi-Ui
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:40:30 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vADBdBuW050365
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 06:40:07 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e79yh2ejv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 06:40:05 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 13 Nov 2017 06:40:03 -0500
References: <20171110203516.17027-1-danielhb@linux.vnet.ibm.com>
	<20171113032258.GB2921@xz-mi>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 09:39:57 -0200
MIME-Version: 1.0
In-Reply-To: <20171113032258.GB2921@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <7e0b1cbd-c9ef-6848-abb3-f6bb66bb2633@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] migration/ram.c: do not set
 'postcopy_running' in POSTCOPY_INCOMING_END
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Hi Peter,

On 11/13/2017 01:22 AM, Peter Xu wrote:
> On Fri, Nov 10, 2017 at 06:35:16PM -0200, Daniel Henrique Barboza wrote:
>> When migrating a VM with 'migrate_set_capability postcopy-ram on'
>> a postcopy_state is set during the process, ending up with the
>> state POSTCOPY_INCOMING_END when the migration is over. This
>> postcopy_state is taken into account inside ram_load to check
>> how it will load the memory pages. This same ram_load is called when
>> in a loadvm command.
>>
>> Inside ram_load, the logic to see if we're at postcopy_running state
>> is:
>>
>> postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING
>>
>> postcopy_state_get() returns this enum type:
>>
>> typedef enum {
>>      POSTCOPY_INCOMING_NONE = 0,
>>      POSTCOPY_INCOMING_ADVISE,
>>      POSTCOPY_INCOMING_DISCARD,
>>      POSTCOPY_INCOMING_LISTENING,
>>      POSTCOPY_INCOMING_RUNNING,
>>      POSTCOPY_INCOMING_END
>> } PostcopyState;
>>
>> In the case where ram_load is executed and postcopy_state is
>> POSTCOPY_INCOMING_END, postcopy_running will be set to 'true' and
>> ram_load will behave like a postcopy is in progress. This scenario isn't
>> achievable in a migration but it is reproducible when executing
>> savevm/loadvm after migrating with 'postcopy-ram on', causing loadvm
>> to fail with Error -22:
>>
>> Source:
>>
>> (qemu) migrate_set_capability postcopy-ram on
>> (qemu) migrate tcp:127.0.0.1:4444
>>
>> Dest:
>>
>> (qemu) migrate_set_capability postcopy-ram on
>> (qemu)
>> ubuntu1704-intel login:
>> Ubuntu 17.04 ubuntu1704-intel ttyS0
>>
>> ubuntu1704-intel login: (qemu)
>> (qemu) savevm test1
>> (qemu) loadvm test1
>> Unknown combination of migration flags: 0x4 (postcopy mode)
>> error while loading state for instance 0x0 of device 'ram'
>> Error -22 while loading VM state
>> (qemu)
>>
>> This patch fixes this problem by changing a bit the semantics
>> of postcopy_running inside ram_load, verifying first if
>> we're not in the POSTCOPY_INCOMING_END state. In this case,
>> postcopy_running is set to 'false'.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> ---
>>   migration/ram.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 8620aa400a..43ed719668 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2803,13 +2803,21 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>       int flags = 0, ret = 0, invalid_flags = 0;
>>       static uint64_t seq_iter;
>>       int len = 0;
>> -    /*
>> -     * If system is running in postcopy mode, page inserts to host memory must
>> -     * be atomic
>> -     */
>> -    bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
>> -    /* ADVISE is earlier, it shows the source has the postcopy capability on */
>> -    bool postcopy_advised = postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE;
>> +    bool postcopy_advised = false, postcopy_running = false;
>> +    uint8_t postcopy_state = postcopy_state_get();
>> +
>> +    if (postcopy_state != POSTCOPY_INCOMING_END) {
>> +        /*
>> +         * If system is running in postcopy mode, page inserts to host memory
>> +         * must be atomic
>> +         */
>> +        postcopy_running = postcopy_state >= POSTCOPY_INCOMING_LISTENING;
>> +
>> +        /* ADVISE is earlier, it shows the source has the postcopy
>> +         * capability on
>> +         */
>> +        postcopy_advised = postcopy_state >= POSTCOPY_INCOMING_ADVISE;
>> +    }
> For me, this is not that clear.  I would prefer something simpler like:
>
>    PostcopyState state = postcopy_state_get();
>    bool postcopy_running = state >= POSTCOPY_INCOMING_LISTENING && \
>                            state < POSTCOPY_INCOMING_END;
>
> Or we can introduce postcopy_is_running() helper.  Same thing to
> postcopy_advised.  Thanks,

I like the idea of creating helpers to make the logic simpler. I'll make
this change in the next spin.


Thanks,


Daniel

>
>>   
>>       seq_iter++;
>>   
>> -- 
>> 2.13.6
>>
>>
