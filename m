Received: from eggs.gnu.org ([2001:4830:134:3::10]:44868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0lZW-0000WQ-Jm
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0lZV-0003Cw-5q
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 06:11:18 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
	<fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
	<4add3400-b4d4-4812-72f2-0f184b2f4fd6@virtuozzo.com>
	<b1fe16fd-05fe-73c6-f2f5-31b23459a131@virtuozzo.com>
Message-ID: <2520cd8d-990b-e7b9-c7b6-0b345e414ce8@virtuozzo.com>
Date: Tue, 27 Mar 2018 13:11:06 +0300
MIME-Version: 1.0
In-Reply-To: <b1fe16fd-05fe-73c6-f2f5-31b23459a131@virtuozzo.com>
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

27.03.2018 12:53, Vladimir Sementsov-Ogievskiy wrote:
> 27.03.2018 12:28, Vladimir Sementsov-Ogievskiy wrote:
>> 26.03.2018 21:06, Max Reitz wrote:
>>> On 2018-03-20 18:05, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all.
>>>>
>>>> This fixes bitmaps migration through shared storage. Look at 02 for
>>>> details.
>>>>
>>>> The bug introduced in 2.10 with the whole qcow2 bitmaps feature, so
>>>> qemu-stable in CC. However I doubt that someone really suffered=20
>>>> from this.
>>>>
>>>> Do we need dirty bitmaps at all in inactive case? - that was a=20
>>>> question in v2.
>>>> And, keeping in mind that we are going to use inactive mode not=20
>>>> only for
>>>> incoming migration, I'm not sure that answer is NO (but, it may be=20
>>>> "NO" for
>>>> 2.10, 2.11), so let's fix it in proposed here manner at least for=20
>>>> 2.12.
>>> For some reason, I can't get 169 to work now at all[1]. What's more,
>>> whenever I run it, two (on current master, maybe more after this=20
>>> series)
>>> "cat $TEST_DIR/mig_file" processes stay around.=C2=A0 That doesn't seem=
=20
>>> right.
>>>
>>> However, this series doesn't seem to make it worse[2]...=C2=A0 So I'm=20
>>> keeping
>>> it.=C2=A0 I suppose it's just some issue with the test.
>>>
>>> Max
>>>
>>>
>>> [1] Sometimes there are migration even timeouts, sometimes just VM
>>> launch timeouts (specifically when VM B is supposed to be re-launched
>>> just after it has been shut down), and sometimes I get a dirty bitmap
>>> hash mismatch.
>>>
>>>
>>> [2] The whole timeline was:
>>>
>>> - Apply this series, everything seems alright
>>>
>>> (a couple of hours later)
>>> - Test some other things, stumble over 169 once or so
>>>
>>> - Focus on 169, fails a bit more often
>>>
>>> (today)
>>> - Can't get it to work at all
>>>
>>> - Can't get it to work in any version, neither before nor after this=20
>>> patch
>>>
>>> - Lose my sanity
>>>
>>> - Write this email
>>>
>>> O:-)
>>>
>>
>> hmm.. checked on current master (7b93d78a04aa24), tried a lot of=20
>> times in a loop, works for me. How can I help?
>>
>
> O, loop finally finished, with:
>
> 169 6s ... [failed, exit status 1] - output mismatch (see 169.out.bad)
> --- /work/src/qemu/master/tests/qemu-iotests/169.out=C2=A0=C2=A0=C2=A0 20=
18-03-16=20
> 21:01:19.536765587 +0300
> +++ /work/src/qemu/master/tests/qemu-iotests/169.out.bad 2018-03-27=20
> 12:33:03.804800350 +0300
> @@ -1,5 +1,20 @@
> -........
> +......E.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ERROR: test__persistent__not_migbitmap__offline=20
> (__main__.TestDirtyBitmapMigration)
> +methodcaller(name, ...) --> methodcaller object
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +=C2=A0 File "169", line 129, in do_test_migration
> +=C2=A0=C2=A0=C2=A0 self.vm_b.event_wait("RESUME", timeout=3D10.0)
> +=C2=A0 File=20
> "/work/src/qemu/master/tests/qemu-iotests/../../scripts/qemu.py", line=20
> 349, in event_wait
> +=C2=A0=C2=A0=C2=A0 event =3D self._qmp.pull_event(wait=3Dtimeout)
> +=C2=A0 File=20
> "/work/src/qemu/master/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
> line 216, in pull_event
> +=C2=A0=C2=A0=C2=A0 self.__get_events(wait)
> +=C2=A0 File=20
> "/work/src/qemu/master/tests/qemu-iotests/../../scripts/qmp/qmp.py",=20
> line 124, in __get_events
> +=C2=A0=C2=A0=C2=A0 raise QMPTimeoutError("Timeout waiting for event")
> +QMPTimeoutError: Timeout waiting for event
> +
> =C2=A0-------------------------------------------------------------------=
---
> =C2=A0Ran 8 tests
>
> -OK
> +FAILED (errors=3D1)
> Failures: 169
> Failed 1 of 1 tests
>
>
> and I have a lot of opened pipes, like:
>
> root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18685=C2=A0 0.0=C2=A0 0.0 107924=
=C2=A0=C2=A0 352 pts/0=C2=A0=C2=A0=C2=A0 S=C2=A0=C2=A0=C2=A0 12:19=C2=A0=C2=
=A0 0:00 cat=20
> /work/src/qemu/master/tests/qemu-iotests/scratch/mig_file
>
> ...
>
> restart testing loop, it continues to pass 169 again and again...
>

.... and,

--- /work/src/qemu/master/tests/qemu-iotests/169.out=C2=A0=C2=A0=C2=A0 2018=
-03-16=20
21:01:19.536765587 +0300
+++ /work/src/qemu/master/tests/qemu-iotests/169.out.bad 2018-03-27=20
12:58:44.804894014 +0300
@@ -1,5 +1,20 @@
-........
+F.......
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test__not_persistent__migbitmap__offline=20
(__main__.TestDirtyBitmapMigration)
+methodcaller(name, ...) --> methodcaller object
+----------------------------------------------------------------------
+Traceback (most recent call last):
+=C2=A0 File "169", line 136, in do_test_migration
+=C2=A0=C2=A0=C2=A0 self.check_bitmap(self.vm_b, sha256 if persistent else =
False)
+=C2=A0 File "169", line 77, in check_bitmap
+=C2=A0=C2=A0=C2=A0 "Dirty bitmap 'bitmap0' not found");
+=C2=A0 File "/work/src/qemu/master/tests/qemu-iotests/iotests.py", line 42=
2,=20
in assert_qmp
+=C2=A0=C2=A0=C2=A0 result =3D self.dictpath(d, path)
+=C2=A0 File "/work/src/qemu/master/tests/qemu-iotests/iotests.py", line 38=
1,=20
in dictpath
+=C2=A0=C2=A0=C2=A0 self.fail('failed path traversal for "%s" in "%s"' % (p=
ath, str(d)))
+AssertionError: failed path traversal for "error/desc" in "{u'return':=20
{u'sha256':=20
u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}"
+
 =C2=A0--------------------------------------------------------------------=
--
 =C2=A0Ran 8 tests

-OK
+FAILED (failures=3D1)
Failures: 169
Failed 1 of 1 tests


isn't it because a lot of cat processes? will check, update loop to
i=3D0; while check -qcow2 169; do ((i++)); echo $i OK; killall -9 cat; done

--=20
Best regards,
Vladimir
