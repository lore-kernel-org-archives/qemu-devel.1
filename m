Received: from eggs.gnu.org ([2001:4830:134:3::10]:55920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehCIW-00073f-92
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehCIN-0007Nx-UD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:40:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <d21ddbab-921c-3cc9-05dd-5113cb16fd8f@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
	<d21ddbab-921c-3cc9-05dd-5113cb16fd8f@redhat.com>
Date: Thu, 01 Feb 2018 11:40:41 +0100
Message-ID: <w51tvv156xi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 18/39] qcow2: Refactor
 get_cluster_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed 31 Jan 2018 09:11:48 PM CET, Max Reitz wrote:
> On 2018-01-26 15:59, Alberto Garcia wrote:
>> After the previous patch we're now always using l2_load() in
>> get_cluster_table() regardless of whether a new L2 table has to be
>> allocated or not.
>> 
>> This patch refactors that part of the code to use one single l2_load()
>> call.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2-cluster.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>> 
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 2a53c1dc5f..0c0cab85e8 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -695,15 +695,7 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
>>          return -EIO;
>>      }
>>  
>> -    /* seek the l2 table of the given l2 offset */
>> -
>> -    if (s->l1_table[l1_index] & QCOW_OFLAG_COPIED) {
>> -        /* load the l2 table in memory */
>> -        ret = l2_load(bs, offset, l2_offset, &l2_table);
>> -        if (ret < 0) {
>> -            return ret;
>> -        }
>> -    } else {
>> +    if (!(s->l1_table[l1_index] & QCOW_OFLAG_COPIED)) {
>>          /* First allocate a new L2 table (and do COW if needed) */
>>          ret = l2_allocate(bs, l1_index);
>>          if (ret < 0) {
>> @@ -719,11 +711,12 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
>>          /* Get the offset of the newly-allocated l2 table */
>>          l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
>>          assert(offset_into_cluster(s, l2_offset) == 0);
>> -        /* Load the l2 table in memory */
>> -        ret = l2_load(bs, offset, l2_offset, &l2_table);
>> -        if (ret < 0) {
>> -            return ret;
>> -        }
>> +    }
>> +
>> +    /* load the l2 table in memory */
>> +    ret = l2_load(bs, offset, l2_offset, &l2_table);
>> +    if (ret < 0) {
>> +        return ret;
>>      }
>
> I'd pull the l2_offset assignment (and alignment check) down below the
> QCOW_OFLAG_COPIED check, saving us another two lines (!!1!) which we
> could then spend on an
>
> assert(s->l1_table[l1_index] & QCOW_OFLAG_COPIED);

I'm not sure if I'm following you. We need to set l2_offset before and
after allocating a new L2 table.

Before, because we need the offset of the old table (if there was one)
in order to decrease its refcount.

And after, because we need the offset of the new table in order to load
it.

Berto
