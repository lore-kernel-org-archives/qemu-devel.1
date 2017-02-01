Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYsKX-000155-Tg
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYsKU-0005bV-Oz
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:40:01 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <574dd15d-ace7-cbaf-574a-944c2c436b95@redhat.com>
References: <20170130161441.30493-1-berto@igalia.com>
	<574dd15d-ace7-cbaf-574a-944c2c436b95@redhat.com>
Date: Wed, 01 Feb 2017 11:39:56 +0100
Message-ID: <w51inoury83.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 01 Feb 2017 02:46:20 AM CET, Max Reitz <mreitz@redhat.com> wrote:

>> The problem with the refcount table is that since it always occupies
>> complete clusters its size is usually very big.
>
> Actually the main problem is that BDRVQcow2State.refcount_table_size
> is updated very generously as opposed to BDRVQcow2State.l1_size. The
> latter is usually exactly as large as it needs to be (because the L1
> table size usually doesn't change), whereas the refcount_table_size is
> just bumped up every time the image gets bigger until it reaches or
> exceeds the value it needs to be.

That's actually a good point.

One reason why this happens is that the size of the L1 table is static
and the qcow2 header stores the actual number of entries, whereas for
the refcount table it stores the number of clusters.

Maybe we can have refcount_table_size store the actual size of the
table. The number of clusters can be calculated from that after all, and
we would get rid of max_refcount_table_index.

The change might be a bit more difficult, though, I'll take a look.

>> @@ -439,6 +450,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
>>          }
>>  
>>          s->refcount_table[refcount_table_index] = new_block;
>> +        s->max_refcount_table_index = refcount_table_index;
>
> Should be MAX(s->max_refcount_table_index, refcount_table_index) or
> this won't support refcount tables with holes in them.

Good catch.

Berto
