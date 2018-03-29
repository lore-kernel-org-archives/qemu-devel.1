Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1Sbu-00082z-63
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1Sbs-0007Bf-EP
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 04:08:38 -0400
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
	<fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
	<4add3400-b4d4-4812-72f2-0f184b2f4fd6@virtuozzo.com>
	<b1fe16fd-05fe-73c6-f2f5-31b23459a131@virtuozzo.com>
	<2520cd8d-990b-e7b9-c7b6-0b345e414ce8@virtuozzo.com>
	<48dbaef0-0a9f-de65-9c7d-584021fc4759@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a9b1455f-185d-4461-2d72-ed9d3aa329e9@virtuozzo.com>
Date: Thu, 29 Mar 2018 11:08:23 +0300
MIME-Version: 1.0
In-Reply-To: <48dbaef0-0a9f-de65-9c7d-584021fc4759@redhat.com>
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

28.03.2018 17:53, Max Reitz wrote:
> On 2018-03-27 12:11, Vladimir Sementsov-Ogievskiy wrote:
>> 27.03.2018 12:53, Vladimir Sementsov-Ogievskiy wrote:
>>> 27.03.2018 12:28, Vladimir Sementsov-Ogievskiy wrote:
>>>> 26.03.2018 21:06, Max Reitz wrote:
>>>>> On 2018-03-20 18:05, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Hi all.
>>>>>>
>>>>>> This fixes bitmaps migration through shared storage. Look at 02 for
>>>>>> details.
>>>>>>
>>>>>> The bug introduced in 2.10 with the whole qcow2 bitmaps feature, so
>>>>>> qemu-stable in CC. However I doubt that someone really suffered
>>>>>> from this.
>>>>>>
>>>>>> Do we need dirty bitmaps at all in inactive case? - that was a
>>>>>> question in v2.
>>>>>> And, keeping in mind that we are going to use inactive mode not
>>>>>> only for
>>>>>> incoming migration, I'm not sure that answer is NO (but, it may be
>>>>>> "NO" for
>>>>>> 2.10, 2.11), so let's fix it in proposed here manner at least for
>>>>>> 2.12.
>>>>> For some reason, I can't get 169 to work now at all[1]. What's more,
>>>>> whenever I run it, two (on current master, maybe more after this
>>>>> series)
>>>>> "cat $TEST_DIR/mig_file" processes stay around.=C2=A0 That doesn't se=
em
>>>>> right.
>>>>>
>>>>> However, this series doesn't seem to make it worse[2]...=C2=A0 So I'm
>>>>> keeping
>>>>> it.=C2=A0 I suppose it's just some issue with the test.
>>>>>
>>>>> Max
>>>>>
>>>>>
>>>>> [1] Sometimes there are migration even timeouts, sometimes just VM
>>>>> launch timeouts (specifically when VM B is supposed to be re-launched
>>>>> just after it has been shut down), and sometimes I get a dirty bitmap
>>>>> hash mismatch.
>>>>>
>>>>>
>>>>> [2] The whole timeline was:
>>>>>
>>>>> - Apply this series, everything seems alright
>>>>>
>>>>> (a couple of hours later)
>>>>> - Test some other things, stumble over 169 once or so
>>>>>
>>>>> - Focus on 169, fails a bit more often
>>>>>
>>>>> (today)
>>>>> - Can't get it to work at all
>>>>>
>>>>> - Can't get it to work in any version, neither before nor after this
>>>>> patch
>>>>>
>>>>> - Lose my sanity
>>>>>
>>>>> - Write this email
>>>>>
>>>>> O:-)
>>>>>
>>>> hmm.. checked on current master (7b93d78a04aa24), tried a lot of
>>>> times in a loop, works for me. How can I help?
>>>>
>>> O, loop finally finished, with:
>>>
>>> 169 6s ... [failed, exit status 1] - output mismatch (see 169.out.bad)
>>> --- /work/src/qemu/master/tests/qemu-iotests/169.out=C2=A0=C2=A0=C2=A0 =
2018-03-16
>>> 21:01:19.536765587 +0300
>>> +++ /work/src/qemu/master/tests/qemu-iotests/169.out.bad 2018-03-27
>>> 12:33:03.804800350 +0300
>>> @@ -1,5 +1,20 @@
>>> -........
>>> +......E.
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +ERROR: test__persistent__not_migbitmap__offline
>>> (__main__.TestDirtyBitmapMigration)
>>> +methodcaller(name, ...) --> methodcaller object
>>> +----------------------------------------------------------------------
>>> +Traceback (most recent call last):
>>> +=C2=A0 File "169", line 129, in do_test_migration
>>> +=C2=A0=C2=A0=C2=A0 self.vm_b.event_wait("RESUME", timeout=3D10.0)
>>> +=C2=A0 File
>>> "/work/src/qemu/master/tests/qemu-iotests/../../scripts/qemu.py", line
>>> 349, in event_wait
>>> +=C2=A0=C2=A0=C2=A0 event =3D self._qmp.pull_event(wait=3Dtimeout)
>>> +=C2=A0 File
>>> "/work/src/qemu/master/tests/qemu-iotests/../../scripts/qmp/qmp.py",
>>> line 216, in pull_event
>>> +=C2=A0=C2=A0=C2=A0 self.__get_events(wait)
>>> +=C2=A0 File
>>> "/work/src/qemu/master/tests/qemu-iotests/../../scripts/qmp/qmp.py",
>>> line 124, in __get_events
>>> +=C2=A0=C2=A0=C2=A0 raise QMPTimeoutError("Timeout waiting for event")
>>> +QMPTimeoutError: Timeout waiting for event
>>> +
>>>  =C2=A0----------------------------------------------------------------=
------
>>>  =C2=A0Ran 8 tests
>>>
>>> -OK
>>> +FAILED (errors=3D1)
>>> Failures: 169
>>> Failed 1 of 1 tests
>>>
>>>
>>> and I have a lot of opened pipes, like:
>>>
>>> root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18685=C2=A0 0.0=C2=A0 0.0 1079=
24=C2=A0=C2=A0 352 pts/0=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 12:19=C2=A0=
=C2=A0 0:00 cat
>>> /work/src/qemu/master/tests/qemu-iotests/scratch/mig_file
>>>
>>> ...
>>>
>>> restart testing loop, it continues to pass 169 again and again...
>>>
>> .... and,
>>
>> --- /work/src/qemu/master/tests/qemu-iotests/169.out=C2=A0=C2=A0=C2=A0 2=
018-03-16
>> 21:01:19.536765587 +0300
>> +++ /work/src/qemu/master/tests/qemu-iotests/169.out.bad 2018-03-27
>> 12:58:44.804894014 +0300
>> @@ -1,5 +1,20 @@
>> -........
>> +F.......
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +FAIL: test__not_persistent__migbitmap__offline
>> (__main__.TestDirtyBitmapMigration)
>> +methodcaller(name, ...) --> methodcaller object
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +=C2=A0 File "169", line 136, in do_test_migration
>> +=C2=A0=C2=A0=C2=A0 self.check_bitmap(self.vm_b, sha256 if persistent el=
se False)
>> +=C2=A0 File "169", line 77, in check_bitmap
>> +=C2=A0=C2=A0=C2=A0 "Dirty bitmap 'bitmap0' not found");
>> +=C2=A0 File "/work/src/qemu/master/tests/qemu-iotests/iotests.py", line=
 422,
>> in assert_qmp
>> +=C2=A0=C2=A0=C2=A0 result =3D self.dictpath(d, path)
>> +=C2=A0 File "/work/src/qemu/master/tests/qemu-iotests/iotests.py", line=
 381,
>> in dictpath
>> +=C2=A0=C2=A0=C2=A0 self.fail('failed path traversal for "%s" in "%s"' %=
 (path, str(d)))
>> +AssertionError: failed path traversal for "error/desc" in "{u'return':
>> {u'sha256':
>> u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}"
>> +
>>  =C2=A0-----------------------------------------------------------------=
-----
>>  =C2=A0Ran 8 tests
>>
>> -OK
>> +FAILED (failures=3D1)
>> Failures: 169
>> Failed 1 of 1 tests
>>
>>
>> isn't it because a lot of cat processes? will check, update loop to
>> i=3D0; while check -qcow2 169; do ((i++)); echo $i OK; killall -9 cat; d=
one
> Hmm...  I know I tried to kill all of the cats, but for some reason that
> didn't really help yesterday.  Seems to help now, for 2.12.0-rc0 at
> least (that is, before this series).

reproduced with killing... (without these series, just on master)

>
> After the whole series, I still get a lot of failures in 169
> (mismatching bitmap hash, mostly).
>
> And interestingly, if I add an abort():
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 486f3e83b7..9204c1c0ac 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1481,6 +1481,7 @@ static int coroutine_fn
> qcow2_do_open(BlockDriverState *bs, QDict *options,     }
>
>       if (bdrv_dirty_bitmap_next(bs, NULL)) {
> +        abort();
>           /* It's some kind of reopen with already existing dirty
> bitmaps. There
>            * are no known cases where we need loading bitmaps in such
> situation,
>            * so it's safer don't load them.
>
> Then this fires for a couple of test cases of 169 even without the third
> patch of this series.
>
> I guess bdrv_dirty_bitmap_next() reacts to some bitmaps that migration
> adds or something?  Then this would be the wrong condition, because I
> guess we still want to load the bitmaps that are in the qcow2 file.
>
> I'm not sure whether bdrv_has_readonly_bitmaps() is the correct
> condition then, either, though.  Maybe let's take a step back: We want
> to load all the bitmaps from the file exactly once, and that is when it
> is opened the first time.  Or that's what I would have thought...  Is
> that even correct?
>
> Why do we load the bitmaps when the device is inactive anyway?
> Shouldn't we load them only once the device is activated?

Hmm, not sure. May be, we don't need. But we anyway need to load them,=20
when opening read-only, and we should correspondingly reopen in this case.

>
> Max
>


--=20
Best regards,
Vladimir
