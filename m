Received: from eggs.gnu.org ([2001:4830:134:3::10]:56662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elGho-0006e5-H9
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elGhn-00040z-Id
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:11:48 -0500
References: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1518441241-32557-3-git-send-email-anton.nefedov@virtuozzo.com>
	<w51sha68d2i.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <d50d4276-2907-e40d-3fed-b67087cd9068@virtuozzo.com>
Date: Mon, 12 Feb 2018 19:11:35 +0300
MIME-Version: 1.0
In-Reply-To: <w51sha68d2i.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block: fix write with zero flag set
 and iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com



On 12/2/2018 6:03 PM, Alberto Garcia wrote:
> On Mon 12 Feb 2018 02:14:01 PM CET, Anton Nefedov wrote:
>> The normal bdrv_co_pwritev() use is either
>>    - BDRV_REQ_ZERO_WRITE clear and iovector provided
>>    - BDRV_REQ_ZERO_WRITE set and iovector == NULL
>>
>> while
>>    - the flag clear and iovector == NULL is an assertion failure
>>      in bdrv_co_do_zero_pwritev()
>>    - the flag set and iovector provided is in fact allowed
>>      (the flag prevails and zeroes are written)
>>
>> However the alignment logic does not support the latter case so the
>> padding areas get overwritten with zeroes.
> 
> Oh, so this doesn't simply write zeroes in [offset, offset+bytes), but
> also in the head and tail areas, instead of keeping the previous
> contents.
> 
> This is a pretty serious bug, but I assume it can't be triggered
> (bdrv_pwrite_zeroes() is used in complete clusters). Did you check if
> there was any other scenario where this could happen?
> 

I was a bit lazy to look deep but as far as I can say currently it's
only bdrv_pwrite_zeroes(). It's mostly called for large extents like
clusters, but not everywhere, another case is I guess
qcow2_crypto_hdr_init_func(); also it's probably not guaranteed (though
being quite exotic) that the cluster size is not smaller than the
protocol driver alignment requirements.

At least external (block.h) write interfaces don't accept or set any
flags
