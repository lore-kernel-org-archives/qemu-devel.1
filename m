Received: from eggs.gnu.org ([2001:4830:134:3::10]:55627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dqgGf-0007gD-F4
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 09:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dqgGa-0000pZ-Kb
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 09:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dqgGa-0000oX-El
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 09:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4931A81DE9
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 13:57:46 +0000 (UTC)
References: <20170804175011.21944-1-dgilbert@redhat.com>
	<20170906134017.GB8457@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0738dd90-2285-31e3-9d01-31681c7a03cc@redhat.com>
Date: Sat, 9 Sep 2017 15:57:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170906134017.GB8457@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH f0r 2.11] runstate/migrate: Two more
 transitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

On 06/09/2017 15:40, Dr. David Alan Gilbert wrote:
>> There's a race if someone does a 'stop' near the end of migrate;
>> the migration process goes through two runstates:
>>     'finish migrate'
>>     'postmigrate'
>>
>> If the user issues a 'stop' between the two we end up with invalid
>> state transitions.
>> Add the transitions as valid.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Queued
> 
>> ---
>>  vl.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/vl.c b/vl.c
>> index 99fcfa0442..bacb03f49d 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -621,6 +621,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>>  
>>      { RUN_STATE_PAUSED, RUN_STATE_RUNNING },
>>      { RUN_STATE_PAUSED, RUN_STATE_FINISH_MIGRATE },
>> +    { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },

There is:

    if (s->state == MIGRATION_STATUS_COMPLETED) {
        ...
        runstate_set(RUN_STATE_POSTMIGRATE);
    } else {
        ...
        if (old_vm_running && !entered_postcopy) {
            vm_start();
        } else {
            if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
                runstate_set(RUN_STATE_POSTMIGRATE);
            }
        }
    }

Maybe the runstate_check should be in the "then" branch too, instead
of adding this transition?

Paolo

>>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
>>  
>> @@ -633,6 +634,7 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
>>  
>>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
>> +    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
>>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_POSTMIGRATE },
>>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PRELAUNCH },
>>      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_COLO},
>> -- 
>> 2.13.3
>>
>>
