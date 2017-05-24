Received: from eggs.gnu.org ([2001:4830:134:3::10]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDZbR-0000Dl-Vz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dDZbN-0005nl-Tp
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:57:42 -0400
Received: from mail-db5eur01on0122.outbound.protection.outlook.com
	([104.47.2.122]:54784
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dDZbN-0005jb-31
	for qemu-devel@nongnu.org; Wed, 24 May 2017 12:57:37 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-5-git-send-email-anton.nefedov@virtuozzo.com>
	<b2e896f2-363b-9ce0-9ae3-d814c2d503fd@redhat.com>
Message-ID: <49f09068-17d8-43e0-2f12-05668b6b0095@virtuozzo.com>
Date: Wed, 24 May 2017 19:57:30 +0300
MIME-Version: 1.0
In-Reply-To: <b2e896f2-363b-9ce0-9ae3-d814c2d503fd@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/13] qcow2: preallocation at image
 expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>, mreitz@redhat.com



On 05/22/2017 10:29 PM, Eric Blake wrote:
> On 05/19/2017 04:34 AM, Anton Nefedov wrote:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> This patch adds image preallocation at expand to provide better locality
>> of QCOW2 image file and optimize this procedure for some distributed
>> storages where this procedure is slow.
>>
>> Image expand requests have to be suspended until the allocation is
>> performed which is done via special QCowL2Meta.
>> This meta is invisible to handle_dependencies() code.
>> This is the main reason for also calling preallocation before metadata
>> write: it might intersect with preallocation triggered by another IO,
>> and has to yield
>
> How does this interact with Max's work on preallocated truncate?
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg00267.html
>

Seems like Max's patchset makes it possible to manually (with qemu-img)
allocate a continuous guest address space in advance?

Preallocation in this series is a little bit different:
- it's in-flight, and it fallocates (using drv->write_zeroes) space
ahead in the underlying image as qcow2 writes beyond EOF.
- it doesn't link L2. So it leaves the image 'sparse' on qcow2 level.

If you ask me, these 2 patchsets are not contradictory, and probably
won't even merge-conflict :)

/Anton
