Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyxKF-0002aK-A2
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 05:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyxKB-0006WS-BM
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 05:15:31 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-5-famz@redhat.com>
	<20170406153754.GK4341@noname.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7014d1b-3724-64db-474d-4c23f9c62ebc@redhat.com>
Date: Fri, 14 Apr 2017 17:15:20 +0800
MIME-Version: 1.0
In-Reply-To: <20170406153754.GK4341@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 06/04/2017 23:37, Kevin Wolf wrote:
> We used to poll BHs in earlier times. Commit 99723548 ('block: add BDS
> field to count in-flight requests') changed this, without an explanation
> in the commit message.
> 
> Paolo, is this simply a bug in that commit, or do you rely on it
> somewhere? I remember that you wanted to get rid of some aio_poll()
> calls a while ago.

It was replaced by the bdrv_inc_in_flight/bdrv_dec_in_flight calls in
bdrv_aio_prw and bdrv_co_complete.

These let bdrv_drain complete the invocation of the callbacks.  But
block_job_defer_to_main_loop is different because it schedules the
bottom half in another QEMU AioContext (the main thread's).

Since he's here with me, I'll ask Fam exactly what's happening.  Stefan
also found something not too convincing in his review.

Paolo

>>  block/io.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 2709a70..b9cfd18 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -228,7 +228,12 @@ void bdrv_drained_begin(BlockDriverState *bs)
>>          bdrv_parent_drained_begin(bs);
>>      }
>>  
>> -    bdrv_drain_recurse(bs);
>> +    while (true) {
>> +        if (!bdrv_drain_recurse(bs) &&
>> +            !aio_poll(bdrv_get_aio_context(bs), false)) {
>> +                break;
>> +            }
> 
> The indentation is off here.
> 
>> +    }
>>  }
> 
> The old code had this in what is now the BDRV_POLL_WHILE() call in
> bdrv_drain_recurse(). I think it makes more sense there, saves you a
> loop here and fixes bdrv_drain_all_begin() at the same time.
> 
> Kevin
> 
> 
