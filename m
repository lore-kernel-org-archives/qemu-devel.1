Received: from eggs.gnu.org ([2001:4830:134:3::10]:34925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ety3Y-0008K9-Dj
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ety3S-0001qG-Gf
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:06:12 -0500
References: <20180307225732.155835-1-eblake@redhat.com>
	<1651749911.5944222.1520491852256.JavaMail.zimbra@redhat.com>
	<8b5bee3a-c30b-38da-b861-bceebad9b57e@redhat.com>
	<c316b5e0-932f-6de0-ac19-41d12730201c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0e62cf0-c7b8-d883-4959-b5bc22be5608@redhat.com>
Date: Thu, 8 Mar 2018 10:05:55 -0600
MIME-Version: 1.0
In-Reply-To: <c316b5e0-932f-6de0-ac19-41d12730201c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Honor FUA request on
 NBD_CMD_TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, kwolf@redhat.com

On 03/08/2018 09:22 AM, Paolo Bonzini wrote:
>>> TRIM requests should not need FUA since they're just advisory.
>>
>> Still, while you argue that TRIM is advisory (which I agree), if it does
>> nothing, then you've (implicitly) honored FUA (that transaction didn't
>> affect persistent storage, so you didn't have to wait any longer for
>> anything to land); but if it DOES change the disk contents, then waiting
>> for that change to land IS worth supporting, hence why the NBD protocol
>> requires the FUA flag to be honored on trim.
> 
> But if power fails, after restart you cannot see the difference between
> a TRIM command that chose to did nothing, and one that chose to change
> the disk contents but failed to persist the changes.  This is why I
> thought there is no need for FUA in my opinion.
> 
> I suppose in principle you could detect the change by reading the
> TRIMmed sectors and writing to another disk.  So TRIM would have to be a
> Schroedinger command that is persistent once you read the sectors, and
> that makes little sense.  The problem is, SCSI doesn't have a FUA flag
> either...

The documentation of NBD_CMD_TRIM says that in general you must not 
expect reliable read results from the area you trimmed (since the 
command is advisory, you don't know if you would read the old data 
unchanged, all zeroes, or even random unrelated data).  But if you know 
that a particular server treats TRIM as mandatory rather than advisory, 
and also guarantees a reads-as-zero after a successful TRIM, then for 
that particular server, the FUA flag on TRIM makes sense.  The 
documentation for NBD_CMD_BLOCK_STATUS also points out that block status 
may, but not must, be altered by NBD_CMD_TRIM, which might be another 
way to observer how much of a TRIM request was advisory.

At any rate, your argument makes sense that because bdrv_pdiscard() is 
advisory, we can't tell whether it made a difference, and therefore 
waiting for it to make a difference isn't worthwhile, and therefore 
plumbing BDRV_REQ_FUA through the block layer for bdrv_pdiscard() is 
pointless.  At this point, I will just go ahead and add the flush for 
qemu as NBD server if it ever sees NBD_CMD_TRIM + FUA (which is unlikely 
to happen in practice, as most clients are smart enough to realize that 
TRIM is advisory and reading after TRIM is unreliable anyways, so 
waiting for the TRIM to land is pointless); and qemu as a client will 
probably never send NBD_CMD_TRIM + FUA.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
