Received: from eggs.gnu.org ([2001:4830:134:3::10]:35426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1ds9fL-0001D4-Hv
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1ds9fK-0006Be-GY
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:33:27 -0400
Message-ID: <59B94FB6.2080209@oracle.com>
Date: Wed, 13 Sep 2017 16:33:10 +0100
From: Darren Kenny <darren.kenny@oracle.com>
MIME-Version: 1.0
References: <59B91B00.20208@oracle.com> <59B91DCA.5080405@oracle.com>
	<20170913122005.GB5319@localhost.localdomain>
	<59B93376.1070108@oracle.com>
	<20170913140717.GC5319@localhost.localdomain>
In-Reply-To: <20170913140717.GC5319@localhost.localdomain>
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

Kevin Wolf wrote:
> Am 13.09.2017 um 15:32 hat Darren Kenny geschrieben:
>> Hi Kevin,
>>
>> Thanks for getting back to me so quickly.
>>
>> Kevin Wolf wrote:
>>> Am 13.09.2017 um 14:00 hat Darren Kenny geschrieben:
>>>> [Cross-posted from qemu-devel, meant to send here first]
>>> Just keep both lists in the CC for the same email.
>> Will do.
>>> There is an issue here, which is that you are accessing the image at the
>>> same time from two separate processes. qemu is using writeback caches in
>>> order to improve performance, so only after the guest has issued a flush
>>> command to its disk or after you shut down or at least pause qemu, the
>>> changes are fully written to the image file. In qemu 2.10, you would
>>> probably see this instead: $ qemu-img check ./test.qcow2 qemu-img: Could
>>> not open './test.qcow2': Failed to get shared "write" lock Is another
>>> process using the image? This lock can be overridden, but at least it
>>> shows clearly that you are doing something that you probably shouldn't
>>> be doing.
>> Hmm, I've just updated to the HEAD of the Git repo, and I didn't see this
>> locking behaviour, it still did the same thing as before.
>>
>> Does the disk need to be formatted/mounted before it's seen as locked?
>> Or even a configure option?
>>
>> The version that have is:
>>
>>      $ qemu-img --version
>>      qemu-img version 2.10.50 (v2.10.0-476-g04ef330)
>>      Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>>
>>      $ qemu-system-x86_64 --version
>>      QEMU emulator version 2.10.50 (v2.10.0-476-g04ef330)
>>      Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>>
>> The last commit I have is (as in the version string):
>>
>>      04ef330 tcg/tci: do not use ldst label (never implemented)
>
> This should have the locking code. It only works with relatively new
> Linux kernels, though (it needs F_OFD_SETLK support). If you don't have
> that, no locking is used even in qemu 2.10.
>
> You could try enforcing some locking by adding file.locking=on to your
> -drive option. If you're running an old kernel, this should print a
> warning message (and use some less safe locking variant).
Ah, OK - I will need to look into that.

>>> Doing a flush here wouldn't be wrong, but it's also unnecessary and
>>> would slow down the operation a bit.
>> Sure, but how often does a resize/truncate get done? Would seem like a
>> small impact to do it - but I agree w.r.t. the single-process access
>> as a better solution.
>
> The thing is, truncate isn't the only operation that will lead to
> qemu-img check reporting failure. Any cluster allocation in the image
> can cause the same symptom, and there it is actually very important for
> performance that we use the cache and do a batched write only later.
>
> So changing truncate so that this specific operation looks as if
> accessing the image from a second process were okay wouldn't actually
> make a big difference for the overall state. Maybe it's in fact better
> to have such attempts fail consistently.
>
Thanks for the explanation, and I agree that consistency is usually best.

Thanks,

Darren.
