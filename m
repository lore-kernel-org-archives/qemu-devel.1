Received: from eggs.gnu.org ([2001:4830:134:3::10]:56816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcCqr-0002pz-R9
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcCqm-0005xv-93
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:43:25 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:38958 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dcCql-0005wx-SO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:43:20 -0400
References: <20170729164104.29537-1-vsementsov@virtuozzo.com>
	<ce1a6f7a-749c-7ede-9e4b-d072644b9da4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <808f737a-60c6-375d-d854-9f9ca9e454f7@virtuozzo.com>
Date: Mon, 31 Jul 2017 18:43:12 +0300
MIME-Version: 1.0
In-Reply-To: <ce1a6f7a-749c-7ede-9e4b-d072644b9da4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 0/3] qemu-img check: format allocation
 info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

31.07.2017 18:14, Eric Blake wrote:
> On 07/29/2017 11:41 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> See 01 patch for the doc.
>>
>> Question to discuss.
>> If I understand correctly get_block_status flags allocated, zero, and data
>> actually provide 5 possible combinations, which I combine into three.
> There are actually 8 possible bit combinations, but you are right that
> some of them are in practice impossible (since the allocated bit can
> only be set in cases where the underlying driver set the data or zero bit).
>
>> allocated data zero
>> 1         1    1    \__ data
> This one is interesting - it means we know the contents read as zero,
> but that it occupies space on the disk instead of being a hole;
> reporting it as zero may make it easier to punch a hole.
>
>> 1         1    0    /
> Yes, definitely data, and no clue if it can be turned into a hole.
>
>> 1         0    1    \__ zero
>> 0         0    1    /
> Yes, definitely zero.  (The former happens when a format layer directly
> reports that the current layer reads as zero; the latter is possible
> when a format layer doesn't have an allocation, but where we know
> unallocated clusters read as zero, perhaps because there is no backing
> file to further fall back to).
>
>> 0         0    0    ___ discarded
> Could also mean hasn't been touched yet (discarded sort of implies that
> it has been touched at some point in the past)

last time I don't like it too. What about renaming it to just 
'unallocated'?

>
> The other bit patterns:
>
>    0         1    0    - not possible: if a driver sets data, then the
> block layer sets allocated
>
>    0         1    1    - ditto
>    1         0    0    - not possible: nothing sets the allocated bit in
> isolation
>
>> This division looks not bad, but it is not the only one possible.
>> Separating data is really useful - it shows leaked clusters..
>> So the question is, don't we want to adjust the division?
>> I'm ok with the current one.
>>

-- 
Best regards,
Vladimir
