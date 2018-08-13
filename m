Received: from eggs.gnu.org ([2001:4830:134:3::10]:55068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp68i-00038V-Q2
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fp68i-0007MY-03
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 02:15:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
	<20180809114417.28718-3-marcandre.lureau@redhat.com>
	<87r2j6u44f.fsf@dusky.pond.sub.org>
	<165ace92-3b41-3d56-19f4-d2aa6edf8d8e@redhat.com>
Date: Mon, 13 Aug 2018 08:15:29 +0200
In-Reply-To: <165ace92-3b41-3d56-19f4-d2aa6edf8d8e@redhat.com> (Max Reitz's
	message of "Sat, 11 Aug 2018 16:03:24 +0200")
Message-ID: <877ekudc72.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] tests: fix bdrv-drain leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Max Reitz <mreitz@redhat.com> writes:

> On 2018-08-10 08:28, Markus Armbruster wrote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>>> Spotted by ASAN:
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =3D=3D5378=3D=3DERROR: LeakSanitizer: detected memory leaks
>>>
>>> Direct leak of 65536 byte(s) in 1 object(s) allocated from:
>>>     #0 0x7f788f83bc48 in malloc (/lib64/libasan.so.5+0xeec48)
>>>     #1 0x7f788c9923c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
>>>     #2 0x5622a1fe37bc in coroutine_trampoline /home/elmarco/src/qq/util=
/coroutine-ucontext.c:116
>>>     #3 0x7f788a15d75f in __correctly_grouped_prefixwc (/lib64/libc.so.6=
+0x4c75f)
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  tests/test-bdrv-drain.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
>>> index 17bb8508ae..abc8bbe6f0 100644
>>> --- a/tests/test-bdrv-drain.c
>>> +++ b/tests/test-bdrv-drain.c
>>> @@ -948,6 +948,7 @@ static void coroutine_fn test_co_delete_by_drain(vo=
id *opaque)
>>>      }
>>>=20=20
>>>      dbdd->done =3D true;
>>> +    g_free(buffer);
>>>  }
>>>=20=20
>>>  /**
>>=20
>> Screwed up in commit 4c8158e359d.
>>=20
>> Max, could the coroutine's stack accomodate the buffer?
>
> I don't know.  How big is a coroutine's stack?  The buffer size
> apparently is 64k.  (Which is my opinion is generally too much to put on
> any stack.)

Even in tests?

> But why would you want to put it on the stack anyway?  It's not like it
> would make the patch any simpler.

If you like the patch as is, go merge it as is :)
