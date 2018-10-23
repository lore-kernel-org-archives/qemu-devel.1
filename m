Received: from eggs.gnu.org ([2001:4830:134:3::10]:39308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gF4MN-0003Og-7n
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gF4MH-0001hJ-Nl
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:37:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1gF4MF-0001QK-MX
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:37:00 -0400
References: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
	<596ea83a-279e-3a76-ead3-14aa8efe0a1d@redhat.com>
From: George Kennedy <george.kennedy@oracle.com>
Message-ID: <43e65c7a-f44d-797b-ab0c-389eaa0c0f82@oracle.com>
Date: Tue, 23 Oct 2018 17:36:43 -0400
MIME-Version: 1.0
In-Reply-To: <596ea83a-279e-3a76-ead3-14aa8efe0a1d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] lsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 10/23/2018 10:33 AM, Paolo Bonzini wrote:
> On 22/10/2018 23:28, George Kennedy wrote:
>> As you suggested I moved the loading of "s->resel_dsp" down to the "Wait Reselect"
>> case. The address of the Reselection Scripts, though, is contained in "s->dsp - 8"
>> and not in s->dnad.
> Are you sure?  s->dsp - 8 should be the address of the Wait Reselect
> instruction itself.  But you're right that s->dnad is the address at
> which to jump "if the LSI53C895A is selected before being reselected"
> (as the spec puts it) so the reselection DSP should be just s->dsp.

See within the 1st 25 lines of lsi_execute_script() where dsp is bumped 
up by 8, "s->dsp += 8", so it needs to be adjusted back to what it was.

>
>> The reason the timeout is needed is that under heavy IO some pending commands
>> stay on the pending queue longer than the 30 second command timeout set by the
>> linux upper layer scsi driver (sym53c8xx). When command timeouts occur, the
>> upper layer scsi driver sends SCSI Abort messages to remove the timed out
>> commands. The command timeouts are caused by the fact that under heavy IO,
>> lsi_reselect() in qemu "hw/scsi/lsi53c895a.c" is not being called before the
>> upper layer scsi driver 30 second command timeout goes off.
>>
>> If lsi_reselect() were called more frequently, the command timeout problem would
>> probably not occur. There are a number of places where lsi_reselect() is supposed
>> to get called (e.g. at the end of lsi_update_irq()), but the only place that I
>> have observed lsi_reselect() being called is from lsi_execute_script() when
>> lsi_wait_reselect() is called because of a SCRIPT "Wait Select" IO Instruction.
> Reselection should only happen when the target needs access to the bus,
> which is when I/O has finished.  There should be no need for such a
> deadline; reselection should already be happening at the right time when
> lsi_transfer_data calls lsi_queue_req, which in turn calls lsi_reselect.
Agree that it should happen as you describe, but under heavy IO (fio), 
it does not.

When it works as expected the check for "s->waiting == 1" (Wait Reselect 
instruction has been issued) in lsi_transfer_data() is true. Under heavy 
IO, s->waiting is not "1" for an extended period of time and 
lsi_queue_req() does not get called, which leaves any pending commands 
"stuck" on the queue because lsi_reselect() does not get called.

The Scripts are the only place where lsi_wait_reselect() is called and 
the only place where "s->waiting = 1" is set. So, the delay in getting a 
Scripts Wait Reselect command is the root cause of the problem.

The check in lsi_transfer_data() where it decides whether to call 
lsi_queue_req() is probably the preferred place to add a fix, but I have 
not been able to come up with a fix here that does not run into problems 
because of Script state.
>
> Maybe many of the places that call lsi_irq_on_rsl(s) also need to check
> s->want_resel?

I've added debug to all the places where lsi_reselect() should be 
called, but under heavy IO lsi_reselect() does not get called for a 
period of time exceeding the upper layer's 30 second command timeout, 
hence the need for the patch which injects a Scripts Wait Reselect IO 
command.

My test setup consists of 5 remote iscsi disks. Here are the fio write 
arguments, which show the problem:

[global]
bs=256k
iodepth=2
direct=1
ioengine=libaio
randrepeat=0
group_reporting
time_based
runtime=60
numjobs=40
name=test
rw=write

[job1]
filename=/dev/sda
filename=/dev/sdb
filename=/dev/sdc
filename=/dev/sdd
filename=/dev/sde


I am not strongly attached to my proposed fix. If an alternative fix can 
be suggested, I'd be more than willing to try that.

Thank you,
George

>
> Paolo
>
