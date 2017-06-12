Received: from eggs.gnu.org ([2001:4830:134:3::10]:55993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKOxe-0002xP-NQ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKOxb-0000LS-FT
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:00:50 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <36215351-07f7-43ab-bad5-96ed1f6ecd61@redhat.com>
References: <cover.1496844254.git.berto@igalia.com>
	<643c9f0a83c8f5c913a55a556dcddd13754d1275.1496844254.git.berto@igalia.com>
	<36215351-07f7-43ab-bad5-96ed1f6ecd61@redhat.com>
Date: Mon, 12 Jun 2017 15:00:41 +0200
Message-ID: <w51tw3lpdhi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/7] qcow2: Split do_perform_cow() into
 _read(), _encrypt() and _write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri 09 Jun 2017 04:53:05 PM CEST, Eric Blake wrote:
> Let's suppose we have a guest issuing 512-byte aligned requests and a
> host that requires 4k alignment; and the guest does an operation that
> needs a COW with one sector at both the front and end of the cluster.
>
>> @@ -760,22 +776,59 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
>>      BDRVQcow2State *s = bs->opaque;
>>      Qcow2COWRegion *start = &m->cow_start;
>>      Qcow2COWRegion *end = &m->cow_end;
>> +    unsigned buffer_size = start->nb_bytes + end->nb_bytes;
>
> This sets buffer_size to 1024 initially.
>
>> +    uint8_t *start_buffer, *end_buffer;
>>      int ret;
>>  
>> +    assert(start->nb_bytes <= UINT_MAX - end->nb_bytes);
>> +
>>      if (start->nb_bytes == 0 && end->nb_bytes == 0) {
>>          return 0;
>>      }
>>  
>> +    /* Reserve a buffer large enough to store the data from both the
>> +     * start and end COW regions */
>> +    start_buffer = qemu_try_blockalign(bs, buffer_size);
>
> This is going to allocate a bigger buffer, namely one that is at least
> 4k in size (at least, that's my understanding - the block device is
> able to track its preferred IO size/alignment).
>
>> +    if (start_buffer == NULL) {
>> +        return -ENOMEM;
>> +    }
>> +    /* The part of the buffer where the end region is located */
>> +    end_buffer = start_buffer + start->nb_bytes;
>
> But now end_buffer does not have optimal alignment.  In the old code,
> we called qemu_try_blockalign() twice, so that both read()s were
> called on a 4k boundary; but now, the end read() is called unaligned
> to a 4k boundary.  Of course, since we're only reading 512 bytes,
> instead of 4k, it MIGHT not matter, but I don't know if we are going
> to cause a bounce buffer to come into play that we could otherwise
> avoid if we were smarter with our alignments.  Is that something we
> need to analyze further, or even possibly intentionally over-allocate
> our buffer to ensure optimal read alignments?

I think you're right, I actually thought about this but forgot it when
preparing the series for publishing.

If I'm not wrong it should be simply a matter of replacing

   buffer_size = start->nb_bytes + end->nb_bytes;

with

   buffer_size = QEMU_ALIGN_UP(start->nb_bytes, bdrv_opt_mem_align(bs))
                 + end->nb_bytes;

and then

    end_buffer = start_buffer + buffer_size - end->nb_bytes;

    (this one we do anyway in patch 5)

Berto
