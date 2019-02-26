Received: from eggs.gnu.org ([209.51.188.92]:44007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gycsL-000498-Hr
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gycsD-0000Mm-IT
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 08:34:19 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1c4720aa-2831-ae7c-379d-8b7702a9dd23@virtuozzo.com>
References: <1550762799-830661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1550762799-830661-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1c4720aa-2831-ae7c-379d-8b7702a9dd23@virtuozzo.com>
Date: Tue, 26 Feb 2019 14:33:25 +0100
Message-ID: <w5136oaoesa.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] block-stream: include base into job
 node list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Mon 25 Feb 2019 05:39:14 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -259,6 +259,15 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>>                              &error_abort);
>>       }
>>   
>> +    if (base) {
>> +        /*
>> +         * The base node should not disappear during the job.
>> +         */
>> +        block_job_add_bdrv(&s->common, "base", base, 0,
>> +                           BLK_PERM_ALL & ~BLK_PERM_GRAPH_MOD,
>> +                           &error_abort);
>> +    }
>> +
>>       s->base = base;
>>       s->backing_file_str = g_strdup(backing_file_str);
>>       s->bs_read_only = bs_read_only;
>> 
>
>
> Hmm, intersting, is BLK_PERM_GRAPH_MOD a good way to lock relations in
> node graph?
>
> bdrv_replace_node don't check this permission. So, I don't understand,
> how this permission works.. Graph modification operation in difference
> with read or write are not done through BdrvChild at all.
>
> Are there any ideas or work started for some another mechanism of
> "freezing" a subgraph during an operation?

See this discussion:

   https://lists.gnu.org/archive/html/qemu-block/2018-11/msg00387.html

And these patches (currently under review):

   https://lists.gnu.org/archive/html/qemu-block/2019-01/msg00622.html

Berto
