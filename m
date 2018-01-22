Received: from eggs.gnu.org ([2001:4830:134:3::10]:39985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1edeTA-0004XF-ID
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1edeT7-0008A5-Ff
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:57:12 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <67060769-70fc-e6d4-673c-81f1382fe735@virtuozzo.com>
References: <cover.1513342045.git.berto@igalia.com>
	<8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
	<67060769-70fc-e6d4-673c-81f1382fe735@virtuozzo.com>
Date: Mon, 22 Jan 2018 16:56:30 +0100
Message-ID: <w51d121x4y9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 31/32] qcow2: Allow configuring the L2
 slice size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 16 Jan 2018 05:57:22 PM CET, Anton Nefedov wrote:
>> -    r->l2_slice_size = s->cluster_size / sizeof(uint64_t);
>> -    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size);
>> -    r->refcount_block_cache = qcow2_cache_create(bs, refcount_cache_size);
>> +    l2_cache_size *= s->cluster_size / l2_cache_entry_size;
>
> A bit confusing; l2_cache_size first means the size in bytes, then the
> size in clusters and now the size in entries.

You're right, I'll convert it to entries right after the
read_cache_sizes() call, there's no use for the size in clusters
anymore.

> Maybe in the comparison with MIN_L2_CACHE_SIZE, we should multiply
> MIN_L2_CACHE_SIZE to cluster_size instead.
> And perhaps MIN_L2_CACHE_CLUSTERS is a better name. Or should it even
> be MIN_L2_CACHE_ENTRIES instead, taking into account its motivation to
> make it possible to handle COW.

I think I'll keep the MIN_L2_CACHE_SIZE name but clarify in the
documentation that it means cache entries.

One consequence of this is that the L2 cache can be made smaller now,
and there's nothing wrong with that (it actually allows us to use less
memory in images with large clusters).

>> +    r->l2_slice_size = l2_cache_entry_size / sizeof(uint64_t);
>> +    r->l2_table_cache = qcow2_cache_create(bs, l2_cache_size,
>> +                                           l2_cache_entry_size);
>
> my gcc thinks l2_cache_entry_size may be used uninitialized here.
> can't quite see how that may happen though..

My gcc doesn't say anything but I've seen the warning:

   https://lists.gnu.org/archive/html/qemu-block/2017-12/msg00521.html

l2_cache_entry_size can remain uninitialized if read_cache_sizes()
fails, but then the calling function would return immediately. I guess
gcc doesn't know that.

I guess I'll initialize it to 0 to fix the warning.

Berto
