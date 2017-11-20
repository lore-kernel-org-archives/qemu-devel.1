Received: from eggs.gnu.org ([2001:4830:134:3::10]:41288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eGik9-0001oN-Mx
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eGik5-0003Qt-OW
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:51:57 -0500
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
	<20171117123059.GB4795@localhost.localdomain>
	<b95aaa97-39d0-fdc1-21a1-2e0ea7acac17@redhat.com>
	<79f2607f-d4f9-8f92-76df-c99ae48b9936@redhat.com>
	<20171117182526.GK4795@localhost.localdomain>
	<fa7cd556-c784-2105-6777-bae1c5814c76@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <923a2b4c-b85f-3840-384a-9c99126483ef@virtuozzo.com>
Date: Mon, 20 Nov 2017 12:51:47 +0300
MIME-Version: 1.0
In-Reply-To: <fa7cd556-c784-2105-6777-bae1c5814c76@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

17.11.2017 23:40, John Snow wrote:
>
> On 11/17/2017 01:25 PM, Kevin Wolf wrote:
>> Am 17.11.2017 um 19:15 hat John Snow geschrieben:
>>>
>>> On 11/17/2017 10:01 AM, Max Reitz wrote:
>>>> On 2017-11-17 13:30, Kevin Wolf wrote:
>>>>> Am 23.10.2017 um 11:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>>> Snapshot-switch actually changes active state of disk so it should
>>>>>> reflect on dirty bitmaps. Otherwise next incremental backup using
>>>>>> these bitmaps will be invalid.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>>> We discussed this quite a while ago, and I'm still not convinced that
>>>>> this approach makes sense.
>>>> I think it at least makes more sense than not handling this case at al=
l.
>>>>
>>>>> Can you give just one example of a use case where dirtying the whole
>>>>> bitmap while loading a snapshot is the desired behaviour?
>>>>>
>>>>> I think the most useful behaviour would be something where the bitmap=
s
>>>>> themselves are snapshotted, too.
>>>> Agreed.
>>>>
>>>>>                                   But for the time being, the easiest=
 and
>>>>> safest solution might just be to error out in any snapshot operations
>>>>> if any bitmaps are in use.
>>>> Sounds OK, too.  I personally don't have an opinion either way.
>>>>
>>>> But in any case, what we did before this patch was definitely wrong so=
 I
>>>> consider it an improvement.
>>>>
>>> This is how I feel about it too. Erroring out entirely is an option, bu=
t
>>> code-wise just dirtying everything is at least verifiably not-wrong and
>>> pretty simple to implement.
>> But that's exactly the problem: If something is just plain wrong, you
>> can always replace it with something that makes sense. If it errors out,
>> you can still remove that error later. But if you have something that
>> doesn't make a whole lot of sense, but kinda sorta works (like after
>> this patch), it's ABI and you can't implement something more useful
>> later any more.
>>
>>> It's an improvement... Don't do it, but at least you won't get
>>> something wrong after, just something heinously unoptimal.
>> It's a short-term improvement that may become a long-term burden.
>>
>> Kevin
>>
> I see your point.
>
> If we enable it now, we always have to.
> If we disable it now, we *can* later if we wish.
>
> ...however, I think it's been the case that we haven't prohibited it
> before, but also it's a pretty good case that nobody has been using this
> feature in production because they're not yet persistent and migratable.
>
> An error message asking the user to delete bitmaps (which will very
> obviously invalidate them) would be fine, too. I was erring on the side
> of "just let things work," but you have a point that making sure the
> user knows that what they're trying to accomplish is not a good idea is
> probably better than silently doing the very stupid thing.

Hi all. erroring=C2=A0 is ok for me too. And looks like it's a way which=20
looks ok for all interested in. Should I make a patch?

--=20
Best regards,
Vladimir
