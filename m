Received: from eggs.gnu.org ([2001:4830:134:3::10]:56173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG5dU-0003v8-1O
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG5dT-0005rS-Au
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:38:44 -0400
References: <20180302185448.6314-1-kwolf@redhat.com>
	<20180302185448.6314-9-kwolf@redhat.com>
	<CAFEAcA9eQ6be2Db89kR_OrrG2Hz-M_H7=NYDSTFQEXk62Lj9Tg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b961b4eb-3718-2815-d5b8-a80c3849d33f@redhat.com>
Date: Tue, 8 May 2018 11:38:28 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9eQ6be2Db89kR_OrrG2Hz-M_H7=NYDSTFQEXk62Lj9Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 08/37] iscsi: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 05/08/2018 10:37 AM, Peter Maydell wrote:
> On 2 March 2018 at 18:54, Kevin Wolf <kwolf@redhat.com> wrote:
>> From: Eric Blake <eblake@redhat.com>
>>
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Update the iscsi driver accordingly.  In this case,
>> it is handy to teach iscsi_co_block_status() to handle a NULL map
>> and file parameter, even though the block layer passes non-NULL
>> values, because we also call the function directly.  For now, there
>> are no optimizations done based on the want_zero flag.
>>
> 
>> -    *pnum = sector_lun2qemu(lbasd->num_blocks, iscsilun);
>> +    *pnum = lbasd->num_blocks * iscsilun->block_size;
> 
> Hi; following this change Coverity complains (CID1390646) about
> this multiplication, which is a 32-bit multiply whose result
> is then put into a 64-bit result. Is it intended to be a
> 64-bit multiply ?

Hmm, good question.  Before this patch, the block layer definitely 
capped things below 2G so that the multiply would not overflow; but in 
rewriting it to be byte-based, it also removed that cap.  I'll send a 
patch to do a 64-bit multiply, just to be safe (even though I don't know 
for sure whether iscsi_get_lba_status_task can return more blocks than 
INT_MAX/block_size).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
