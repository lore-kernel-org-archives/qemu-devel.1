Received: from eggs.gnu.org ([2001:4830:134:3::10]:58881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIrZe-0005Qz-Pt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIrZb-0000rY-8U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:09:42 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1ab8d614-be8d-b206-e52b-bd4539173bd7@redhat.com>
References: <cover.1496844254.git.berto@igalia.com>
	<c49daf8afe80eade79ac53d305b83eb24b264338.1496844254.git.berto@igalia.com>
	<1ab8d614-be8d-b206-e52b-bd4539173bd7@redhat.com>
Date: Thu, 08 Jun 2017 09:09:00 +0200
Message-ID: <w51poefhs6r.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/7] qcow2: Make perform_cow() call
 do_perform_cow() twice
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

On Wed 07 Jun 2017 11:43:34 PM CEST, Eric Blake wrote:
>>  block/qcow2-cluster.c | 38 +++++++++++++++++++++++---------------
>>  1 file changed, 23 insertions(+), 15 deletions(-)
>
>>      qemu_co_mutex_unlock(&s->lock);
>> -    ret = do_perform_cow(bs, m->offset, m->alloc_offset, r->offset, r->nb_bytes);
>> +    ret = do_perform_cow(bs, m->offset, m->alloc_offset,
>> +                         start->offset, start->nb_bytes);
>> +    if (ret < 0) {
>> +        goto fail;
>> +    }
>> +
>> +    ret = do_perform_cow(bs, m->offset, m->alloc_offset,
>> +                         end->offset, end->nb_bytes);
>> +
>> +fail:
>
> Since you reach this label even on success, it feels a bit awkward. I
> probably would have avoided the goto and used fewer lines by
> refactoring the logic as:
>
> ret = do_perform_cow(..., start->...);
> if (ret >= 0) {
>     ret = do_perform_cow(..., end->...);
> }

I actually wrote this code without any gotos the way you mention, and it
works fine in this patch, but as I was making more changes I ended up
with a quite large piece of code that needed to add "if (!ret)" to
almost every if statement, so I didn't quite like the final result.

I'm open to reconsider it, but take a look first at the code after the
last patch and you'll see that it would not be as neat as it appears
now.

Berto
