Received: from eggs.gnu.org ([2001:4830:134:3::10]:43788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnV4-0007L2-Lg
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnUH-0004SI-C5
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:45:14 -0500
References: <20171201014242.16877-1-eblake@redhat.com>
	<20171201014242.16877-2-eblake@redhat.com>
	<20171201144047.GE4147@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2bde291-63d7-d94c-aac7-d894fa2a5218@redhat.com>
Date: Fri, 1 Dec 2017 09:03:14 -0600
MIME-Version: 1.0
In-Reply-To: <20171201144047.GE4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 01/20] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/01/2017 08:40 AM, Kevin Wolf wrote:
>> Note that most drivers give sector-aligned answers, except at
>> end-of-file, even when request_alignment is smaller than a sector.
>> However, bdrv_getlength() is sector-aligned (even though it gives a
>> byte answer), often by exceeding the actual file size.  If we were to
>> give back strict results, at least file-posix.c would report a
>> transition from DATA to HOLE at the end of a file even in the middle
>> of a sector, which can throw off callers; so we intentionally lie and
>> state that any partial sector at the end of a file has the same
>> status for the entire sector.  Maybe at some future day we can
>> report actual file size instead of rounding up, but not for this
>> series.
> 
> In what way does this throw off callers in practice?
> 

Several iotests failed if I didn't do that (it's been a few months, so 
the details are a bit fuzzy).  I think the biggest problem is that 
because we round the size up in bdrv_getlength(), but CANNOT access 
those rounded bytes, then reporting the status of those bytes as a hole 
(which is the only sane thing that file-posix can do) can cause grief 
when the rest of the sector (which we CAN access) is data.

> The rounding will lead to strange effects, and I'm not sure that dealing
> with them is any easier than fixing the callers. Imagine an image file
> like this (very small example, file size 384 bytes):
> 
>      0    128      384  512
>      |    |        |    |
>      +----+--------+----+
>      |Hole|  Data  |    |
>      +----+--------+----+
>                    |
>                    EOF

Unlikely.  Holes are at least a sector in size on all known filesystems 
that have holes; that's also true for qcow2 format.  The only 
non-sector-aligned hole that you can encounter in practice is at EOF.

> 
> bdrv_co_block_status(offset=0, bytes=512) returns 512 bytes of HOLE.
> bdrv_co_block_status(offset=128, bytes=512) returns 384 bytes of DATA.
> bdrv_co_block_status(offset=384, bytes=512) returns 128 bytes of HOLE.
> 
> This is not only contradictory, but the first one is almost begging for
> data corruption because it returns HOLE for a region that actually
> contains data.

I agree that it would be confusing, if it were possible.  But in 
practice it is not possible.

> 
> The only excuse I can imagine is that we say that this can never happen
> because drivers use 512 byte granularity anyway. But why are we
> introducing the new interface then? I don't think this semantics is
> compatible with a bytes-based driver interface.

Really, the ONLY boundary that is unlikely to ever be 512-byte aligned 
is at EOF - and we wouldn't even need to do any rounding if 
bdrv_getlength() didn't round.

One thing I _can_ do: it is ALWAYS valid to report a partial sector as 
data. It may pessimize the code slightly, but while rounding the size of 
a hole up can be wrong if the rounding covers data but the caller 
getting the rounded data treats that data as 0, rounding the size of 
data up will never misbehave because the caller will just read the 
literal zeroes.  So I will tweak the code to make sure that if any 
rounding takes place, that either the driver already set BDRV_BLOCK_EOF 
(all further bytes also read as zero), or else report the rounded region 
as data.  (I thought I could get away with only io.c setting 
BDRV_BLOCK_EOF; but it sounds like setting it in the drivers will be 
helpful).

> 
>> We also add an assertion that any driver using the new callback will
>> make progress (the only time pnum will be 0 is if the block layer
>> already handled an out-of-bounds request, or if there is an error).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> +    ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
>> +                                        aligned_bytes, pnum, &local_map,
>> +                                        &local_file);
>> +    if (ret < 0) {
>> +        *pnum = 0;
>> +        goto out;
>> +    }
>> +    assert(*pnum); /* The block driver must make progress */

I debated about combining this assert...

>> +
>> +    /*
>> +     * total_size is always sector-aligned, by sometimes exceeding actual
>> +     * file size. Expand pnum if it lands mid-sector due to end-of-file.
>> +     */
>> +    if (QEMU_ALIGN_UP(*pnum + aligned_offset,
> 
> aligned_offset + *pnum wouldn be the more conventional order.

Sure.

> 
>> +                      BDRV_SECTOR_SIZE) == total_size) {
>> +        *pnum = total_size - aligned_offset;
>> +    }
>> +refine:
>>       /*
>>        * The driver's result must be a multiple of request_alignment.
>>        * Clamp pnum and adjust map to original request.

...with these, but it would trigger on at least vmdk (see patch 17/20)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
