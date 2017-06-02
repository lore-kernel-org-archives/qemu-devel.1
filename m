Received: from eggs.gnu.org ([2001:4830:134:3::10]:53221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGhb9-00078w-KR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGhb5-00077L-MG
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:06:19 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<ceab079c-1d8e-368f-c51a-82e92a0b2852@redhat.com>
	<20170601162833.GH4987@noname.redhat.com>
	<4c7ba620-b0cf-554d-7494-530bc0652076@redhat.com>
	<20170601170801.GI4987@noname.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <930d34de-56d2-d237-ee43-8739e49db3bb@redhat.com>
Date: Fri, 2 Jun 2017 10:06:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170601170801.GI4987@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/29] qed: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 01/06/2017 19:08, Kevin Wolf wrote:
> Am 01.06.2017 um 18:40 hat Paolo Bonzini geschrieben:
>> On 01/06/2017 18:28, Kevin Wolf wrote:
>>>> - qed_acquire/qed_release can be removed as you inline stuff, but this
>>>> should not cause bugs so you can either do it as a final patch or let
>>>> me remove it later.
>>> To be honest, I don't completely understand what they are protecting in
>>> the first place. The places where they are look quite strange to me. So
>>> I tried to simply leave them alone.
>>>
>>> What is the reason that we can remove them when we inline stuff?
>>> Shouldn't the inlining be semantically equivalent?
>>
>> You're right, they can be removed when going from callback to direct
>> call.  Callbacks are invoked without the AioContext acquire (aio_co_wake
>> does it for the callbacks).
> 
> So if we take qed_read_table_cb() for example:
> 
>     qed_acquire(s);
>     for (i = 0; i < noffsets; i++) {
>         table->offsets[i] = le64_to_cpu(table->offsets[i]);
>     }
>     qed_release(s);
> 
> First of all, I don't see what it protects. If we wanted to avoid that
> someone else sees table->offsets with wrong endianness, we would be
> taking the lock much too late. And if nobody else knows about the table
> yet, what is there to be locked?

That is the product of a mechanical conversion where all callbacks grew
a qed_acquire/qed_release pair (commit b9e413dd37, "block: explicitly
acquire aiocontext in aio callbacks that need it", 2017-02-21).

In this case:

        qed_acquire(s);
        bdrv_aio_flush(write_table_cb->s->bs, qed_write_table_cb,
                       write_table_cb);
        qed_release(s);

the AioContext protects write_table_cb->s->bs.

> But anyway, given your explanation that acquiring the AioContext lock is
> getting replaced by coroutine magic, the qed_acquire/release() pair
> actually can't be removed in patch 2 when the callback is converted to a
> direct call, but only when the whole call path between .bdrv_aio_readv/
> writev and this specific callback is converted, so that we never drop
> out of coroutine context before reaching this code. Correct?

Yes.

> This happens only very late in the series, so it probably also means
> that patch 5 is indeed wrong because it removes the lock too early?

bdrv_qed_co_get_block_status is entirely in coroutine context, so I
think that one is fine.

Paolo
