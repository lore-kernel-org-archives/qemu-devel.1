Received: from eggs.gnu.org ([209.51.188.92]:58626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtaiw-0004w1-OA
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gtaaA-0000Ir-Tx
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:06:53 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190212151558.GE5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<5c04485949b8cc3f63c6500b2bf6f70f4faaba4a.1547739122.git.berto@igalia.com>
	<20190212151558.GE5283@localhost.localdomain>
Date: Tue, 12 Feb 2019 17:06:17 +0100
Message-ID: <w51k1i58006.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 04/13] block: Freeze the backing chain for
 the duration of the stream job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 12 Feb 2019 04:15:58 PM CET, Kevin Wolf wrote:
> Am 17.01.2019 um 16:33 hat Alberto Garcia geschrieben:
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/stream.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>> 
>> diff --git a/block/stream.c b/block/stream.c
>> index 7a49ac0992..39a2e10892 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -54,6 +54,14 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
>>      return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
>>  }
>>  
>> +static void stream_abort(Job *job)
>> +{
>> +    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>> +    BlockJob *bjob = &s->common;
>> +
>> +    bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
>> +}
>
> Like in commit, you can get a double unfreeze here if .abort is called
> after .prepare returned an error.

You're right, I'll fix it

Berto
