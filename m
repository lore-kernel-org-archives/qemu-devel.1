Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f3OPr-0007s4-Hg
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f3OPl-00085h-6o
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:04:11 -0400
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
	<7be588fb-dd63-d6fd-0e39-81fbee1bdd25@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d0d202f1-6384-178c-9dd7-989d5f06c48a@redhat.com>
Date: Tue, 3 Apr 2018 18:03:43 +0200
MIME-Version: 1.0
In-Reply-To: <7be588fb-dd63-d6fd-0e39-81fbee1bdd25@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

On 2018-03-30 17:32, Vladimir Sementsov-Ogievskiy wrote:
> 30.03.2018 16:31, Vladimir Sementsov-Ogievskiy wrote:
>> 29.03.2018 18:09, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.03.2018 17:03, Max Reitz wrote:
>>>> On 2018-03-29 10:08, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 28.03.2018 17:53, Max Reitz wrote:
>>>>>> On 2018-03-27 12:11, Vladimir Sementsov-Ogievskiy wrote:
>>>> [...]
>>>>
>>>>>>> isn't it because a lot of cat processes? will check, update loop =
to
>>>>>>> i=3D0; while check -qcow2 169; do ((i++)); echo $i OK; killall -9=
 cat;
>>>>>>> done
>>>>>> Hmm...=C2=A0 I know I tried to kill all of the cats, but for some
>>>>>> reason that
>>>>>> didn't really help yesterday.=C2=A0 Seems to help now, for 2.12.0-=
rc0 at
>>>>>> least (that is, before this series).
>>>>> reproduced with killing... (without these series, just on master)
>>>>>
>>>>>> After the whole series, I still get a lot of failures in 169
>>>>>> (mismatching bitmap hash, mostly).
>>>>>>
>>>>>> And interestingly, if I add an abort():
>>>>>>
>>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>>>> index 486f3e83b7..9204c1c0ac 100644
>>>>>> --- a/block/qcow2.c
>>>>>> +++ b/block/qcow2.c
>>>>>> @@ -1481,6 +1481,7 @@ static int coroutine_fn
>>>>>> qcow2_do_open(BlockDriverState *bs, QDict *options,=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_next(bs=
, NULL)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* It=
's some kind of reopen with already existing dirty
>>>>>> bitmaps. There
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * are no known cases where we need loading bitmaps in
>>>>>> such
>>>>>> situation,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * so it's safer don't load them.
>>>>>>
>>>>>> Then this fires for a couple of test cases of 169 even without the
>>>>>> third
>>>>>> patch of this series.
>>>>>>
>>>>>> I guess bdrv_dirty_bitmap_next() reacts to some bitmaps that
>>>>>> migration
>>>>>> adds or something?=C2=A0 Then this would be the wrong condition, b=
ecause I
>>>>>> guess we still want to load the bitmaps that are in the qcow2 file=
.
>>>>>>
>>>>>> I'm not sure whether bdrv_has_readonly_bitmaps() is the correct
>>>>>> condition then, either, though.=C2=A0 Maybe let's take a step back=
: We
>>>>>> want
>>>>>> to load all the bitmaps from the file exactly once, and that is
>>>>>> when it
>>>>>> is opened the first time.=C2=A0 Or that's what I would have though=
t...=C2=A0 Is
>>>>>> that even correct?
>>>>>>
>>>>>> Why do we load the bitmaps when the device is inactive anyway?
>>>>>> Shouldn't we load them only once the device is activated?
>>>>> Hmm, not sure. May be, we don't need. But we anyway need to load th=
em,
>>>>> when opening read-only, and we should correspondingly reopen in
>>>>> this case.
>>>> Yeah, well, yeah, but the current state seems just wrong. Apparently
>>>> there are cases where a qcow2 node may have bitmaps before we try to
>>>> load them from the file, so the current condition doesn't work.
>>>>
>>>> Furthermore, it seems like the current "state machine" is too
>>>> complex so
>>>> we don't know which cases are possible anymore and what to do when.
>>>>
>>>> So the first thing we could do is add a field to the BDRVQCow2State
>>>> that
>>>> tells us whether the bitmaps have been loaded already or not. If not=
,
>>>> we invoke qcow2_load_dirty_bitmaps() and set the value to true. If t=
he
>>>> value was true already and the BDS is active and R/W now, we call
>>>> qcow2_reopen_bitmaps_rw_hint().=C2=A0 That should solve one problem.
>>>
>>> good idea, will do.
>>>
>>>>
>>>> The other problem of course is the question whether we should call
>>>> qcow2_load_dirty_bitmaps() at all while the drive is still inactive.
>>>> You know the migration model better than me, so I'm asking this
>>>> question
>>>> to you.=C2=A0 We can phrase it differently: Do we need to load the b=
itmaps
>>>> before the drive is activated?
>>>
>>> Now I think that we don't need. At least, we don't have such cases in
>>> Virtuozzo (I hope :).
>>>
>>> Why did I doubt:
>>>
>>> 1. We have cases, when we want to start vm as inactive, to be able to
>>> export it's drive as NBD export, push some data to it and then start
>>> the VM (which involves activating)
>>> 2. We have cases, when we want to start vm stopped and operate on
>>> dirty bitmaps.
>>>
>>> If just open all images in inactive mode until vm start, it looks
>>> like we need bitmaps in inactive mode (for 2.). But it looks like
>>> wrong approach anyway.
>>> Firstly, I tried to solve (1.) by simply inactivate_all() in case of
>>> start vm in paused mode, but it breaks at least (2.), so finally, I
>>> solved (1.) by an approach similar with "-incoming defer". So, we
>>> have inactive mode in two cases:
>>> =C2=A0- incoming migration
>>> =C2=A0- push data to vm before start
>>>
>>> and, in these cases, we don't need to load dirty-bitmaps.
>>>
>>> Also, inconsistency: now, we remove persistent bitmaps on inactivate.
>>> So, it is inconsistent to load the in inactive mode.
>>>
>>> Ok, I'll try to respin.
>>
>> finally, what cases we actually have for qcow2_do_open?
>>
>> 1. INACTIVE -> ACTIVE (through invalidate_cache, we obviously should
>> load bitmaps, if we decided that we have no persistent bitmaps in
>> INACTIVE mode)
>> 2. creating new bdrv state (first open of the image) in INACTIVE mode
>> (will not load bitmaps)
>> 3. creating new bdrv state (first open of the image) in ACTIVE mode
>> (will load bitmaps, maybe read-only if disk is RO)
>>
>> If only these three cases, it would be enough to just load bitmaps if
>> !INACTIVE and do nothing otherwise.

Maybe, but I'd prefer just adding a flag for now.  We can think about
whether we need bitmaps in inactive mode later, and even then managing
the state through a flag doesn't hurt.

>> Or, we have some of the following cases too?
>>
>> 1?. ACTIVE -> ACTIVE (through invalidate_cache, some kind of no-op, we
>> should not reload bitmaps)
>> 2?. RO -> RW (we should reopen_bitmaps_rw) (or it is possible only
>> through bdrv_reopen, which will not touch qcow2_do_open?
>> 3?. RW -> RO (reopen_bitmaps_ro ?)
>> ? something other??

I don't really know, but I just hope having a flag saves us from having
to think about all of this too much. :-)

>>> about 169, how often is it reproducible for you?

More errors than passes, I guess.

But it always leaves cats behind, and that's another sign that something
isn't right.

>> it becomes very interseting.
>>
>> persistent-migbitmap-online case failed on line 136. with mismathced
>> bitmap sha. This check is not relate to migration, on this line,
>> bitmap is already successfully migrated. But for some reason it is
>> corrupted after stop/start the VM. How is it possible - I can't
>> imagine. But it looks not really related to migration.. May it relate
>> to case, when postcopy was not finished or something like this?..
>> maybe fixing wait(RESUME) to something more appropriate will help. But
>> it is strange anyway.
>>
>> persistent-notmigbitmap-offline case failed on ine 128, which is
>> "self.vm_b.event_wait("RESUME", timeout=3D10.0)" with timeout.. can we
>> skip RESUME for some reason? maybe just move to MIGRATION event will
>> help, will check

It would still be interesting to know where the RESUME ended up...

> looks like moving from "RESUME" to "MIGRATION" events fixes the whole
> issue (I've already 740 successful iterations, which is good enough, bu=
t
> I will not stop the loop until at least 2000). I'll submit a patch. But
> I don't understand, why it fix sha256 mismatch, and why sha256-check
> fails with "RESUME" (check success after migration and fail after
> stop/start, o_O)...

Well, if you have the time, it might be worth investigating.

Max
