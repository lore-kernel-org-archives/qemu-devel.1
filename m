Received: from eggs.gnu.org ([2001:4830:134:3::10]:44852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cReUW-0002Nw-Mw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cReUT-0006cf-HG
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:28:28 -0500
References: <1484216631-30723-1-git-send-email-thuth@redhat.com>
	<20170112121933.GB2513@work-vm>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a395cf35-a893-4237-e69c-676b9dfda70c@redhat.com>
Date: Thu, 12 Jan 2017 13:28:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170112121933.GB2513@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] monitor: Fix crashes when using HMP
 commands without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Daniel P Berrange <berrange@redhat.com>

On 12.01.2017 13:19, Dr. David Alan Gilbert wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
>> When running certain HMP commands ("info registers", "info cpustats",
>> "nmi", "memsave" or dumping virtual memory) with the "none" machine,
>> QEMU crashes with a segmentation fault. This happens because the "none"
>> machine does not have any CPUs by default, but these HMP commands did
>> not check for a valid CPU pointer yet. Add such checks now, so we get
>> an error message about the missing CPU instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2:
>>  - Added more checks to cover "nmi" and "memsave", too
>>
>>  hmp.c     |  8 +++++++-
>>  monitor.c | 37 +++++++++++++++++++++++++++++++------
>>  2 files changed, 38 insertions(+), 7 deletions(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index b869617..b1c503a 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -1013,8 +1013,14 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
>>      const char *filename = qdict_get_str(qdict, "filename");
>>      uint64_t addr = qdict_get_int(qdict, "val");
>>      Error *err = NULL;
>> +    int cpu_index = monitor_get_cpu_index();
>>  
>> -    qmp_memsave(addr, size, filename, true, monitor_get_cpu_index(), &err);
>> +    if (cpu_index < 0) {
>> +        monitor_printf(mon, "No CPU available\n");
>> +        return;
>> +    }
> 
> OK, that includes UNASSIGNED_CPU_INDEX.
> 
>> +
>> +    qmp_memsave(addr, size, filename, true, cpu_index, &err);
>>      hmp_handle_error(mon, &err);
>>  }
>>  
>> diff --git a/monitor.c b/monitor.c
>> index 0841d43..74843eb 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1025,6 +1025,9 @@ int monitor_set_cpu(int cpu_index)
>>  CPUState *mon_get_cpu(void)
>>  {
>>      if (!cur_mon->mon_cpu) {
>> +        if (!first_cpu) {
>> +            return NULL;
>> +        }
>>          monitor_set_cpu(first_cpu->cpu_index);
>>      }
>>      cpu_synchronize_state(cur_mon->mon_cpu);
>> @@ -1033,17 +1036,27 @@ CPUState *mon_get_cpu(void)
>>  
>>  CPUArchState *mon_get_cpu_env(void)
>>  {
>> -    return mon_get_cpu()->env_ptr;
>> +    CPUState *cs = mon_get_cpu();
>> +
>> +    return cs ? cs->env_ptr : NULL;
>>  }
>>  
>>  int monitor_get_cpu_index(void)
>>  {
>> -    return mon_get_cpu()->cpu_index;
>> +    CPUState *cs = mon_get_cpu();
>> +
>> +    return cs ? cs->cpu_index : -1;
>>  }
> 
> OK, do you think that should use UNASSIGNED_CPU_INDEX
> explicitly rather than -1 ?

I wasn't aware of the fact that we've even got a macro for this ... I'll
send a v3 with that change.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks for the review!

> I'm sure we'll find loads more similar cases where -M none breaks stuff.

I've added two more cases (migration and gdbstub) to the "Potentially
easy bugs" section on http://qemu-project.org/BiteSizedTasks now. I
think these are simple and easy tasks to get started with QEMU hacking...

 Thomas
