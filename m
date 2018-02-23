Received: from eggs.gnu.org ([2001:4830:134:3::10]:41419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epGRX-0008Ax-Fq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epGRW-0003ma-If
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:43:31 -0500
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
	<20180214120525.GB4766@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <afb56cfd-4f42-07e5-9a65-d929b2ea9916@redhat.com>
Date: Fri, 23 Feb 2018 10:43:25 -0600
MIME-Version: 1.0
In-Reply-To: <20180214120525.GB4766@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 09/21] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/14/2018 06:05 AM, Kevin Wolf wrote:

>> +static int coroutine_fn null_co_block_status(BlockDriverState *bs,

>>       if (s->read_zeroes) {
>> -        return BDRV_BLOCK_OFFSET_VALID | start | BDRV_BLOCK_ZERO;
>> -    } else {
>> -        return BDRV_BLOCK_OFFSET_VALID | start;
>> +        ret |= BDRV_BLOCK_ZERO;
>>       }
>> +    return ret;
>>   }
> 
> Preexisting, but I think this return value is wrong. OFFSET_VALID
> without DATA is to documented to have the following semantics:
> 
>   * DATA ZERO OFFSET_VALID
>   *  f    t        t       sectors preallocated, read as zero, returned file not
>   *                        necessarily zero at offset
>   *  f    f        t       sectors preallocated but read from backing_hd,
>   *                        returned file contains garbage at offset
> 
> I'm not sure what OFFSET_VALID is even supposed to mean for null.

I'm finally getting around to playing with this.

> 
> Or in fact, what it is supposed to mean for any protocol driver, because
> normally it just means I can use this offset for accessing bs->file. But > protocol drivers don't have a bs->file, so it's interesting to see that
> they still all set this flag.

More precisely, it means "I can use this offset for accessing the 
returned *file".  Format and filter drivers set *file = bs->file (ie. 
their protocol layer), but protocol drivers set *file = bs (ie. 
themselves).  As long as you read it as "the offset is valid in the 
returned *file", and are careful as to _which_ BDS gets returned in 
*file*, it can still make sense.

So next I tried playing with a patch, to see how much returning 
OFFSET_VALID with DATA matters; and it turns out is is easily observable 
anywhere that the underlying protocol bleeds through to the format layer 
(particularly the raw format driver):

$ echo abc > tmp
$ truncate --size=10M tmp

pre-patch:
$ ./qemu-img map --output=json tmp
[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, 
"offset": 0},
{ "start": 4096, "length": 10481664, "depth": 0, "zero": true, "data": 
false, "offset": 4096}]

turn off OFFSET_VALID at the protocol layer:
diff --git i/block/file-posix.c w/block/file-posix.c
index f1591c38490..c05992c1121 100644
--- i/block/file-posix.c
+++ w/block/file-posix.c
@@ -2158,9 +2158,7 @@ static int coroutine_fn 
raw_co_block_status(BlockDriverState *bs,

      if (!want_zero) {
          *pnum = bytes;
-        *map = offset;
-        *file = bs;
-        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+        return BDRV_BLOCK_DATA;
      }

      ret = find_allocation(bs, offset, &data, &hole);
@@ -2183,9 +2181,7 @@ static int coroutine_fn 
raw_co_block_status(BlockDriverState *bs,
          *pnum = MIN(bytes, data - offset);
          ret = BDRV_BLOCK_ZERO;
      }
-    *map = offset;
-    *file = bs;
-    return ret | BDRV_BLOCK_OFFSET_VALID;
+    return ret;
  }

  static coroutine_fn BlockAIOCB *raw_aio_pdiscard(BlockDriverState *bs,


post-patch:
$ ./qemu-img map --output=json tmp
[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true},
{ "start": 4096, "length": 10481664, "depth": 0, "zero": true, "data": 
false}]


> 
> OFFSET_VALID | DATA might be excusable because I can see that it's
> convenient that a protocol driver refers to itself as *file instead of
> returning NULL there and then the offset is valid (though it would be
> pointless to actually follow the file pointer), but OFFSET_VALID without
> DATA probably isn't.

So OFFSET_VALID | DATA for a protocol BDS is not just convenient, but 
necessary to avoid breaking qemu-img map output.  But you are also right 
that OFFSET_VALID without data makes little sense at a protocol layer. 
So with that in mind, I'm auditing all of the protocol layers to make 
sure OFFSET_VALID ends up as something sane.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
