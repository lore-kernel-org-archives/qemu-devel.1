Received: from eggs.gnu.org ([2001:4830:134:3::10]:50601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ehG0N-0006l5-1e
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ehG0I-000084-DL
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:38:23 -0500
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
	<w51bmh86awn.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <a553ea1c-3194-c219-6307-3b4f1238de16@virtuozzo.com>
Date: Thu, 1 Feb 2018 17:38:02 +0300
MIME-Version: 1.0
In-Reply-To: <w51bmh86awn.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: fix write with zero
 flag set and iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com



On 1/2/2018 5:29 PM, Alberto Garcia wrote:
> On Thu 01 Feb 2018 03:16:31 PM CET, Anton Nefedov wrote:
>> The normal bdrv_co_pwritev() use is either
>>    - BDRV_REQ_ZERO_WRITE reset and iovector provided
>>    - BDRV_REQ_ZERO_WRITE set and iovector == NULL
>>
>> while
>>    - the flag reset and iovector == NULL is an assertion failure
>>      in bdrv_co_do_zero_pwritev()
> 
> Where is that assertion?
> 
> Berto
> 

beginning of bdrv_co_do_zero_pwritev():

     assert(flags & BDRV_REQ_ZERO_WRITE);

and bdrv_co_do_zero_pwritev() was only called with qiov==NULL.

Now this case will instead segfault at some point.
Don't know if it needs a separate assertion.

/Anton
