Received: from eggs.gnu.org ([2001:4830:134:3::10]:46779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dv3mL-0004YX-Io
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dv3mI-0006D8-9S
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:52:41 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-3-pbutsykin@virtuozzo.com>
	<129077ca-af54-fe7c-40ee-850547f63cff@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <45a6e398-ebbf-fb7c-8d42-535376ae4234@virtuozzo.com>
Date: Thu, 21 Sep 2017 18:52:29 +0300
MIME-Version: 1.0
In-Reply-To: <129077ca-af54-fe7c-40ee-850547f63cff@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: truncate the tail of the image
 file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

On 21.09.2017 18:30, Max Reitz wrote:
> On 2017-09-20 15:58, Pavel Butsykin wrote:
>> Now after shrinking the image, at the end of the image file, there might be a
>> tail that probably will never be used. So we can find the last used cluster and
>> cut the tail.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   block/qcow2-refcount.c | 21 +++++++++++++++++++++
>>   block/qcow2.c          | 19 +++++++++++++++++++
>>   block/qcow2.h          |  1 +
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>> index 88d5a3f1ad..5e221a166c 100644
>> --- a/block/qcow2-refcount.c
>> +++ b/block/qcow2-refcount.c
>> @@ -3181,3 +3181,24 @@ out:
>>       g_free(reftable_tmp);
>>       return ret;
>>   }
>> +
>> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    int64_t i, last_cluster, nb_clusters = size_to_clusters(s, size);
>> +    uint64_t refcount;
>> +
>> +    for (i = 0, last_cluster = 0; i < nb_clusters; i++) {
>> +        int ret = qcow2_get_refcount(bs, i, &refcount);
>> +        if (ret < 0) {
>> +            fprintf(stderr, "Can't get refcount for cluster %" PRId64 ": %s\n",
>> +                    i, strerror(-ret));
>> +            continue;
> 
> Oh, and another thing: If you decide to ignore errors here, I'd at least
> consider the cluster allocated.
> 
> Of course it would also be possible not to ignore errors, and instead
> return them to the caller which would then just not truncate the file.

Yes, it seems so safer.

> Max
> 
>> +        }
>> +
>> +        if (refcount > 0) {
>> +            last_cluster = i;
>> +        }
>> +    }
>> +    return last_cluster;
>> +}
> 
