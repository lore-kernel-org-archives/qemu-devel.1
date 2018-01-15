Received: from eggs.gnu.org ([2001:4830:134:3::10]:32885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eb9Up-0002wx-Kc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eb9Uo-0004ob-9K
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:28:35 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-7-vsementsov@virtuozzo.com>
	<a0096cf0-8bec-dedb-e637-f29c71e46fbb@redhat.com>
	<624f9181-d57c-4029-e3e8-7f6f4fea3963@virtuozzo.com>
	<fedadb51-af71-82b1-ee73-135a7ce689eb@redhat.com>
	<39f16940-1b62-5054-d872-80e9ce0fc560@virtuozzo.com>
	<c228c4f2-3f4b-1898-4ae6-92b2087e73ae@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <732f4de5-2e9b-538b-5fcc-9915a72fd3d9@virtuozzo.com>
Date: Mon, 15 Jan 2018 21:28:21 +0300
MIME-Version: 1.0
In-Reply-To: <c228c4f2-3f4b-1898-4ae6-92b2087e73ae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 6/6] iotest 201: new test for qmp
 nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

15.01.2018 18:05, Eric Blake wrote:
> On 01/15/2018 08:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>> And the list archives show several threads of people complaining that
>>> ./check failing with a diff that merely shows:
>>>
>>> -.....
>>> +..E..
>> didn't see that. usually, for failed iotests I see
>>
>> -.....
>> +..E..
>>
>> + some kind of assert-fail in one of testcases
> Although deciphering the assert-fail is not always trivial, and it is
> still sorely underdocumented on how to manually reproduce the situation
> that got to the stackdump.

hmm, restart test? is it documented for 194?

I don't see an option to run only one testcase, but unittest supports it,
so we just need to add this option to ./check


Is it really not trivial with my test?

example, inject bug:
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -76,7 +76,7 @@ class TestNbdServerRemove(iotests.QMPTestCase):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertEqual(filter_q=
emu_io(qemu_io_output).strip(),
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "can't open device=20
nbd+tcp://localhost:10900/exp: " +
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "Requested export not available\nserver=20
reported: " +
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "e=
xport 'exp' not present")
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "1=
export 'exp' not present")

 =C2=A0=C2=A0=C2=A0=C2=A0 def do_test_connect_after_remove(self, force=3DNo=
ne):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args =3D ('-r', '-f', 'ra=
w', '-c', 'read 0 512', nbd_uri)



output:

-.......
+FFF....
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+FAIL: test_connect_after_remove_default (__main__.TestNbdServerRemove)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+=C2=A0 File "201", line 89, in test_connect_after_remove_default
+=C2=A0=C2=A0=C2=A0 self.do_test_connect_after_remove()
+=C2=A0 File "201", line 86, in do_test_connect_after_remove
+=C2=A0=C2=A0=C2=A0 self.assertConnectFailed(qemu_io(*args))
+=C2=A0 File "201", line 79, in assertConnectFailed
+=C2=A0=C2=A0=C2=A0 "1export 'exp' not present")
+AssertionError: "can't open device nbd+tcp://localhost:10900/exp:=20
Requested export not available\nserver reported: export 'exp' not=20
present" !=3D "can't open device nbd+tcp://localhost:10900/exp: Requested=20
export not available\nserver reported: 1export 'exp' not present"
+
[...]


- all obvious. We see what happened and where. And the name of the=20
broken testcase.


----
I remember the following problems with iotests, but I do not think that=20
this is a reason to deprecate unittest and go
in some custom way. Better is to fix them. It's all are problems of our=20
unittest wrapping, not of python unittest.

- asserts and prints are not naturally mixed in final output (isn't it a=20
reason for never using print in these tests?)
- no progress, to see the output we should wait until test finished
- if qemu crashed, it is hard to understand, in which testcase

so, my point is: use unittest. It is a standard library and common way=20
of doing this. And it is already in Qemu iotests.
It gives good organization of test code.

Maybe, a "plain executable python test" is good for complicated tests,=20
which are actually cant be called "unit test", but
which are more like "system wide test", when we actually need only one=20
testcase, but it needs several pages of code.

>
>> so we know in which testcase and in which line it was failed.
>>
>>> makes it rather hard to see WHAT test 2 was doing that caused an error
>>> instead of a pass, let alone set up a reproduction scenario on JUST the
>>> failing test.=C2=A0 Yes, a lot of existing iotests use this unittest la=
yout,
>>> and on that grounds, I'm not opposed to adding another one; but test 19=
4
>>> really IS easier to debug when something goes wrong.
>>>
>>>> And there 3 test cases, sharing same setUp. Do not you say that unitte=
st
>>>> becomes
>>>> deprecated in qemu? I think, if we have only one testcase, we may use
>>>> 194-like approach,
>>>> but if we have more, it's better to use unittest.
>>> Yes, I think a nice goal for improved testing is to write more
>>> python-based iotests in the style that uses actual output, and not just
>>> the unittest framework, in the test log.=C2=A0 It's not a hard requirem=
ent as
>>> long as no one has converted existing tests, but is food for thought.
>>>
>> I think, it doesn't mean that we should not use unittest at all, we just
>> need more output with
>> it.
> Yes, that's also a potentially viable option.
>


--=20
Best regards,
Vladimir
