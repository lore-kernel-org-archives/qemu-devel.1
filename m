Received: from eggs.gnu.org ([2001:4830:134:3::10]:45324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgFdc-0004JJ-SC
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1fgFdZ-0001ht-O3
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:35:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1fgFdZ-0001hM-D9
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 16:34:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6JKTVlc067074
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 16:34:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kb17xhbhx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 16:34:55 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 19 Jul 2018 14:34:54 -0600
References: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
	<20180719191818.GD2462@work-vm>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 19 Jul 2018 16:34:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180719191818.GD2462@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <97bef638-4441-3367-6c64-9339cba3c33f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/19/2018 03:18 PM, Dr. David Alan Gilbert wrote:
> * Collin Walling (walling@linux.ibm.com) wrote:
>> When typing 'help' followed by an unknown command, QEMU will
>> not print anything to the command line to let the user know
>> they typed a bad command. Let's fix this by printing a message
>> to the monitor when this happens. For example:
>>
>>     (qemu) help xyz
>>     unknown command: 'xyz'
>>
>> Reported-by: Stefan Zimmermann <stzi@linux.ibm.com>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  monitor.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 7af1f18..7942f9f 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -1034,9 +1034,12 @@ static void help_cmd_dump(Monitor *mon, const mon_cmd_t *cmds,
>>              } else {
>>                  help_cmd_dump_one(mon, cmd, args, arg_index);
>>              }
>> -            break;
>> +            return;
>>          }
>>      }
>> +
>> +    /* Entry not found */
>> +    monitor_printf(mon, "unknown command: '%s'\n", args[arg_index]);
> 
> Thanks, that does suffer from a similar bug to the one you fixed a
> few months back in  317c52cc6aa0d ('monitor: report entirety of hmp
> command on error'):
> 
> (qemu) help foo
> unknown command: 'foo'
> (qemu) help info foo
> unknown command: 'foo'

Yeah... my thinking was that "info" is a correct command, so let's instead only
report to the user just the piece that was incorrect.

If it makes better sense to include the whole "info foo" piece, it's certainly
doable... whichever makes the most sense. Thoughts?

> 
> Dave
> (And yes, please cc me, otherwise I can miss them)
> 

Will do :)

>>  }
>>  
>>  static void help_cmd(Monitor *mon, const char *name)
>> -- 
>> 2.7.4
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


-- 
Respectfully,
- Collin Walling
