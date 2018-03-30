Received: from eggs.gnu.org ([2001:4830:134:3::10]:46151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1w1K-0007TL-RT
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1w1J-00044Y-E1
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 11:32:50 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
	<fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
	<4add3400-b4d4-4812-72f2-0f184b2f4fd6@virtuozzo.com>
	<b1fe16fd-05fe-73c6-f2f5-31b23459a131@virtuozzo.com>
	<2520cd8d-990b-e7b9-c7b6-0b345e414ce8@virtuozzo.com>
	<48dbaef0-0a9f-de65-9c7d-584021fc4759@redhat.com>
	<a9b1455f-185d-4461-2d72-ed9d3aa329e9@virtuozzo.com>
	<1870fc0d-0c36-f983-8496-3cb5119851ba@redhat.com>
	<50eaf53c-871e-6081-7c4d-4d8de9b0d87f@virtuozzo.com>
	<9f49e65a-fc44-ea11-ff0a-cb38270451aa@virtuozzo.com>
Message-ID: <7be588fb-dd63-d6fd-0e39-81fbee1bdd25@virtuozzo.com>
Date: Fri, 30 Mar 2018 18:32:37 +0300
MIME-Version: 1.0
In-Reply-To: <9f49e65a-fc44-ea11-ff0a-cb38270451aa@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 for 2.12 0/3] fix bitmaps migration
 through shared storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

30.03.2018 16:31, Vladimir Sementsov-Ogievskiy wrote:
> 29.03.2018 18:09, Vladimir Sementsov-Ogievskiy wrote:
>> 29.03.2018 17:03, Max Reitz wrote:
>>> On 2018-03-29 10:08, Vladimir Sementsov-Ogievskiy wrote:
>>>> 28.03.2018 17:53, Max Reitz wrote:
>>>>> On 2018-03-27 12:11, Vladimir Sementsov-Ogievskiy wrote:
>>> [...]
>>>
>>>>>> isn't it because a lot of cat processes? will check, update loop to
>>>>>> i=3D0; while check -qcow2 169; do ((i++)); echo $i OK; killall -9 ca=
t;
>>>>>> done
>>>>> Hmm...=C2=A0 I know I tried to kill all of the cats, but for some=20
>>>>> reason that
>>>>> didn't really help yesterday.=C2=A0 Seems to help now, for 2.12.0-rc0=
 at
>>>>> least (that is, before this series).
>>>> reproduced with killing... (without these series, just on master)
>>>>
>>>>> After the whole series, I still get a lot of failures in 169
>>>>> (mismatching bitmap hash, mostly).
>>>>>
>>>>> And interestingly, if I add an abort():
>>>>>
>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>>> index 486f3e83b7..9204c1c0ac 100644
>>>>> --- a/block/qcow2.c
>>>>> +++ b/block/qcow2.c
>>>>> @@ -1481,6 +1481,7 @@ static int coroutine_fn
>>>>> qcow2_do_open(BlockDriverState *bs, QDict *options,=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_next(bs, N=
ULL)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* It's =
some kind of reopen with already existing dirty
>>>>> bitmaps. There
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
are no known cases where we need loading bitmaps in=20
>>>>> such
>>>>> situation,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
so it's safer don't load them.
>>>>>
>>>>> Then this fires for a couple of test cases of 169 even without the=20
>>>>> third
>>>>> patch of this series.
>>>>>
>>>>> I guess bdrv_dirty_bitmap_next() reacts to some bitmaps that=20
>>>>> migration
>>>>> adds or something?=C2=A0 Then this would be the wrong condition, beca=
use I
>>>>> guess we still want to load the bitmaps that are in the qcow2 file.
>>>>>
>>>>> I'm not sure whether bdrv_has_readonly_bitmaps() is the correct
>>>>> condition then, either, though.=C2=A0 Maybe let's take a step back: W=
e=20
>>>>> want
>>>>> to load all the bitmaps from the file exactly once, and that is=20
>>>>> when it
>>>>> is opened the first time.=C2=A0 Or that's what I would have thought..=
.=C2=A0 Is
>>>>> that even correct?
>>>>>
>>>>> Why do we load the bitmaps when the device is inactive anyway?
>>>>> Shouldn't we load them only once the device is activated?
>>>> Hmm, not sure. May be, we don't need. But we anyway need to load them,
>>>> when opening read-only, and we should correspondingly reopen in=20
>>>> this case.
>>> Yeah, well, yeah, but the current state seems just wrong. Apparently
>>> there are cases where a qcow2 node may have bitmaps before we try to
>>> load them from the file, so the current condition doesn't work.
>>>
>>> Furthermore, it seems like the current "state machine" is too=20
>>> complex so
>>> we don't know which cases are possible anymore and what to do when.
>>>
>>> So the first thing we could do is add a field to the BDRVQCow2State=20
>>> that
>>> tells us whether the bitmaps have been loaded already or not. If not,
>>> we invoke qcow2_load_dirty_bitmaps() and set the value to true. If the
>>> value was true already and the BDS is active and R/W now, we call
>>> qcow2_reopen_bitmaps_rw_hint().=C2=A0 That should solve one problem.
>>
>> good idea, will do.
>>
>>>
>>> The other problem of course is the question whether we should call
>>> qcow2_load_dirty_bitmaps() at all while the drive is still inactive.
>>> You know the migration model better than me, so I'm asking this=20
>>> question
>>> to you.=C2=A0 We can phrase it differently: Do we need to load the bitm=
aps
>>> before the drive is activated?
>>
>> Now I think that we don't need. At least, we don't have such cases in=20
>> Virtuozzo (I hope :).
>>
>> Why did I doubt:
>>
>> 1. We have cases, when we want to start vm as inactive, to be able to=20
>> export it's drive as NBD export, push some data to it and then start=20
>> the VM (which involves activating)
>> 2. We have cases, when we want to start vm stopped and operate on=20
>> dirty bitmaps.
>>
>> If just open all images in inactive mode until vm start, it looks=20
>> like we need bitmaps in inactive mode (for 2.). But it looks like=20
>> wrong approach anyway.
>> Firstly, I tried to solve (1.) by simply inactivate_all() in case of=20
>> start vm in paused mode, but it breaks at least (2.), so finally, I=20
>> solved (1.) by an approach similar with "-incoming defer". So, we=20
>> have inactive mode in two cases:
>> =C2=A0- incoming migration
>> =C2=A0- push data to vm before start
>>
>> and, in these cases, we don't need to load dirty-bitmaps.
>>
>> Also, inconsistency: now, we remove persistent bitmaps on inactivate.=20
>> So, it is inconsistent to load the in inactive mode.
>>
>> Ok, I'll try to respin.
>
> finally, what cases we actually have for qcow2_do_open?
>
> 1. INACTIVE -> ACTIVE (through invalidate_cache, we obviously should=20
> load bitmaps, if we decided that we have no persistent bitmaps in=20
> INACTIVE mode)
> 2. creating new bdrv state (first open of the image) in INACTIVE mode=20
> (will not load bitmaps)
> 3. creating new bdrv state (first open of the image) in ACTIVE mode=20
> (will load bitmaps, maybe read-only if disk is RO)
>
> If only these three cases, it would be enough to just load bitmaps if=20
> !INACTIVE and do nothing otherwise.
>
> Or, we have some of the following cases too?
>
> 1?. ACTIVE -> ACTIVE (through invalidate_cache, some kind of no-op, we=20
> should not reload bitmaps)
> 2?. RO -> RW (we should reopen_bitmaps_rw) (or it is possible only=20
> through bdrv_reopen, which will not touch qcow2_do_open?
> 3?. RW -> RO (reopen_bitmaps_ro ?)
> ? something other??
>
>>
>>>
>>> Max
>>>
>>
>> about 169, how often is it reproducible for you?
>>
>
> it becomes very interseting.
>
> persistent-migbitmap-online case failed on line 136. with mismathced=20
> bitmap sha. This check is not relate to migration, on this line,=20
> bitmap is already successfully migrated. But for some reason it is=20
> corrupted after stop/start the VM. How is it possible - I can't=20
> imagine. But it looks not really related to migration.. May it relate=20
> to case, when postcopy was not finished or something like this?..=20
> maybe fixing wait(RESUME) to something more appropriate will help. But=20
> it is strange anyway.
>
> persistent-notmigbitmap-offline case failed on ine 128, which is=20
> "self.vm_b.event_wait("RESUME", timeout=3D10.0)" with timeout.. can we=20
> skip RESUME for some reason? maybe just move to MIGRATION event will=20
> help, will check
>

looks like moving from "RESUME" to "MIGRATION" events fixes the whole=20
issue (I've already 740 successful iterations, which is good enough, but=20
I will not stop the loop until at least 2000). I'll submit a patch. But=20
I don't understand, why it fix sha256 mismatch, and why sha256-check=20
fails with "RESUME" (check success after migration and fail after=20
stop/start, o_O)...

--=20
Best regards,
Vladimir
