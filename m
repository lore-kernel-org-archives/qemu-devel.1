Received: from eggs.gnu.org ([2001:4830:134:3::10]:34916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etDaI-0000KF-3j
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etDaH-0003nY-8Z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:28:54 -0500
References: <20180301163619.21072-1-pbonzini@redhat.com>
	<20180306135924.GE7139@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c0f3566-f693-6ae3-26b7-3d542dd68a58@redhat.com>
Date: Tue, 6 Mar 2018 15:28:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180306135924.GE7139@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/8] Call check and invalidate_cache
 from coroutine context
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

On 06/03/2018 14:59, Kevin Wolf wrote:
> Am 01.03.2018 um 17:36 hat Paolo Bonzini geschrieben:
>> Check and invalidate_cache share some parts of the implementation
>> with the regular I/O path.  This is sometimes complicated because the
>> I/O path wants to use a CoMutex but that is not possible outside coroutine
>> context.  By moving things to coroutine context, we can remove special
>> cases.  In fact, invalidate_cache is already called from coroutine context
>> because incoming migration is placed in a coroutine.
>>
>> I'm including two patches from Stefan to rename the bdrv_create callback
>> to bdrv_co_create, because it is already called from coroutine context.
>> The name is now bdrv_co_create_opts, with bdrv_co_create reserved for
>> the QAPI-based version that Kevin is working on.
>>
>> qcow2 still has cache flushing in non-coroutine context, coming from
>> qcow2_reopen_prepare->qcow2_update_options_prepare,
>> qcow2_close->qcow2_inactivate and several dirty bitmap functions.
> 
> Hmm... Which commit is this based on? I can't seem to find one where it
> applies cleanly.

It's on top of bec9c64ef7be8063f1192608b83877bc5c9ea217, I'll respin.

Paolo
