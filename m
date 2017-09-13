Received: from eggs.gnu.org ([2001:4830:134:3::10]:42418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1ds7mj-00055A-WB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1ds7mf-0002Tp-Lh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:32:57 -0400
Message-ID: <59B93376.1070108@oracle.com>
Date: Wed, 13 Sep 2017 14:32:38 +0100
From: Darren Kenny <darren.kenny@oracle.com>
MIME-Version: 1.0
References: <59B91B00.20208@oracle.com> <59B91DCA.5080405@oracle.com>
	<20170913122005.GB5319@localhost.localdomain>
In-Reply-To: <20170913122005.GB5319@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Q: Report of leaked clusters with
 qcow2 when disk is resized with a live VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi Kevin,

Thanks for getting back to me so quickly.

Kevin Wolf wrote:
> Am 13.09.2017 um 14:00 hat Darren Kenny geschrieben:
>> [Cross-posted from qemu-devel, meant to send here first]
>
> Just keep both lists in the CC for the same email.

Will do.
> There is an issue here, which is that you are accessing the image at 
> the same time from two separate processes. qemu is using writeback 
> caches in order to improve performance, so only after the guest has 
> issued a flush command to its disk or after you shut down or at least 
> pause qemu, the changes are fully written to the image file. In qemu 
> 2.10, you would probably see this instead: $ qemu-img check 
> ./test.qcow2 qemu-img: Could not open './test.qcow2': Failed to get 
> shared "write" lock Is another process using the image? This lock can 
> be overridden, but at least it shows clearly that you are doing 
> something that you probably shouldn't be doing.

Hmm, I've just updated to the HEAD of the Git repo, and I didn't see this
locking behaviour, it still did the same thing as before.

Does the disk need to be formatted/mounted before it's seen as locked?
Or even a configure option?

The version that have is:

     $ qemu-img --version
     qemu-img version 2.10.50 (v2.10.0-476-g04ef330)
     Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

     $ qemu-system-x86_64 --version
     QEMU emulator version 2.10.50 (v2.10.0-476-g04ef330)
     Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

The last commit I have is (as in the version string):

     04ef330 tcg/tci: do not use ldst label (never implemented)

>> What I observed, then was that if I powered down the VM, or even just
>> quit the VM, that the subsequent check of the disk would say that
>> everything was just fine, and there no longer were leaked clusters.
>
> Yes, quitting the VM writes out all of the cached data, so the on-disk
> state and the in-memory state become fully consistent again.

OK

>> In looking at the code in qcow2_truncate() it would appear that in the case
>> where prealloc has the value PREALLOC_MODE_OFF, that we don't flush the
>> metadata to disk - which seems to be the case here.
>>
>> If I ignore the if test, and always execute the block in block/qcow2.c,
>> lines 3250 to 3258:
>>
>>    if (prealloc != PREALLOC_MODE_OFF) {
>>        /* Flush metadata before actually changing the image size */
>>        ret = bdrv_flush(bs);
>>        if (ret<  0) {
>>            error_setg_errno(errp, -ret,
>>                             "Failed to flush the preallocated area to disk");
>>            return ret;
>>        }
>>    }
>>
>> causing the flush to always be done, then the check will succeed when
>> the VM is still running.
>>
>> While I know that this resolves the issue, I can only imagine that
>> there was some reason that this check for !PREALLOC_MODE_OFF was being
>> done in the first place.
>>
>> So, I'm hoping that someone here might be able to explain to me why
>> that check is needed, but also why it might be wrong to do the flush
>> regardless of the value of prealloc here.
>
> Doing a flush here wouldn't be wrong, but it's also unnecessary and
> would slow down the operation a bit.
Sure, but how often does a resize/truncate get done? Would seem like a
small impact to do it - but I agree w.r.t. the single-process access
as a better solution.
> For the preallocation case, the goal that is achieved with the flush is
> that the header update with the new image size is only written if the
> preallocation succeeded, so that in error cases you don't end up with an
> image that seems to be resized, but isn't actually preallocated as
> requested.
Understood, thanks.
>> If it is wrong to do that flush here, then would anyone have
>> suggestions as to an alternative solution to this issue?
>
> Don't call 'qemu-img check' (or basically any other operation on the
> image) while a VM is using the image.
Heh, sure - if the locking was working as you describe then I think
I would be fine with that :)

Thanks,

Darren.
