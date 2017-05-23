Received: from eggs.gnu.org ([2001:4830:134:3::10]:41600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dD5ue-0007r4-Eb
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dD5ub-00030M-7x
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:15:32 -0400
Received: from mail-ve1eur01on0139.outbound.protection.outlook.com
	([104.47.1.139]:39054
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dD5ua-0002yt-RL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:15:29 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-4-git-send-email-anton.nefedov@virtuozzo.com>
	<fb751647-3473-76e2-bc49-bf2c9734a027@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <1db1a394-8681-226a-8b98-7fc654860061@openvz.org>
Date: Tue, 23 May 2017 12:15:20 +0300
MIME-Version: 1.0
In-Reply-To: <fb751647-3473-76e2-bc49-bf2c9734a027@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1 03/13] qcow2: do not COW the empty areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com

On 05/22/2017 10:24 PM, Eric Blake wrote:
> On 05/19/2017 04:34 AM, Anton Nefedov wrote:
>> If COW area of the newly allocated cluster is zeroes, there is no reason
>> to write zero sectors in perform_cow() again now as whole clusters are
>> zeroed out in single chunks by handle_alloc_space().
> But that's only true if you can guarantee that handle_alloc_space()
> succeeded at ensuring the cluster reads as zeroes.  If you silently
> ignore errors (which is what patch 1/13 does), you risk assuming that
> the cluster reads as zeroes when in reality it does not, and then you
> have corrupted data.
>
> The idea of avoiding a COW of areas that read as zero at the source when
> the destination also already reads as zeroes makes sense, but I'm not
> convinced that this patch is safe as written.
we will recheck error path. OK.

>> Introduce QCowL2Meta field "reduced", since the existing fields
>> (offset and nb_bytes) still has to keep other write requests from
>> simultaneous writing in the area
>>
>> iotest 060:
>> write to the discarded cluster does not trigger COW anymore.
>> so, break on write_aio event instead, will work for the test
>> (but write won't fail anymore, so update reference output)
>>
>> iotest 066:
>> cluster-alignment areas that were not really COWed are now detected
>> as zeroes, hence the initial write has to be exactly the same size for
>> the maps to match
>>
>> performance tests: ===
>>
>> qemu-io,
>>   results in seconds to complete (less is better)
>>   random write 4k to empty image, no backing
>>     HDD
>>       64k cluster
>>         128M over 128M image:   160 -> 160 ( x1  )
>>         128M over   2G image:    86 ->  84 ( x1  )
>>         128M over   8G image:    40 ->  29 ( x1.4 )
>>       1M cluster
>>          32M over   8G image:    58 ->  23 ( x2.5 )
>>
>>     SSD
>>       64k cluster
>>           2G over   2G image:    71 ->  38 (  x1.9 )
>>         512M over   8G image:    85 ->   8 ( x10.6 )
>>       1M cluster
>>         128M over  32G image:   314 ->   2 ( x157  )
> At any rate, the benchmark numbers show that there is merit to pursuing
> the idea of reducing I/O when partial cluster writes can avoid writing
> COW'd zeroes on either side of the data.
>
yes! This is exactly the point and also with this approach we would
allow sequential non-aligned to cluster writes, which is also very good.

Den
