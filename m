Received: from eggs.gnu.org ([2001:4830:134:3::10]:38496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftCIr-0000rK-MS
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftC4v-0000zp-F1
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:24:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817171932.31976-1-marcandre.lureau@redhat.com>
	<20180817171932.31976-3-marcandre.lureau@redhat.com>
	<87d0u8b2u8.fsf@dusky.pond.sub.org>
	<CAJ+F1CLVBmcqa0Rz_=KJY9VphbwxhFWrqWtGnc4kTu61BJOjDg@mail.gmail.com>
Date: Fri, 24 Aug 2018 15:24:30 +0200
In-Reply-To: <CAJ+F1CLVBmcqa0Rz_=KJY9VphbwxhFWrqWtGnc4kTu61BJOjDg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 24 Aug 2018
	10:43:44 +0200")
Message-ID: <87sh337v8x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qobject: modify qobject_ref() to
 assert on NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
> On Fri, Aug 24, 2018 at 10:12 AM Markus Armbruster <armbru@redhat.com> wr=
ote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > While it may be convenient to accept NULL value in
>> > qobject_unref() (for similar reasons as free() accepts NULL), it is
>> > not such a good idea for qobject_ref(): now assert() on NULL.
>>
>> Why is it not such a good idea?
>>
>> Is it unsafe?  Unclean?  Ugly?
>>
>> If unsafe, can you point to actual problems, present or past?
>>
>> If you consider it unclean or ugly, can you point to established
>> convention?
>
> In general, a function/method shouldn't accept NULL as argument, as it
> is usually a programmer mistake.

There are certainly plenty of specific functions where the claim is
true.  But a blanket claim like yours need to be supported by evidence.

> free() / unref() are exceptions, for convenience.

Here's the argument for cleanup functions accepting null pointers.

Having cleanup functions reject null pointers complicates cleanup for no
gain.  Examples of this are everywhere.  Common pattern:

    T1 *v1 =3D NULL;
    ...
    Tn *vn =3D NULL;

    ... do stuff, create v1, ..., vn, goto out on error ...

out:
    T1_cleanup(v1);
    ...
    Tn_cleanup(vn);

Guarding the Ti_cleanup() with if (vi) clutters the code.  Moving the
guard into the Ti_cleanup() is an obvious improvement.

Conversely, examples where a cleanup function rejecting null would catch
actual mistakes do not come to mind.

qobject_unref() is an instance of this pattern.

qobject_ref() isn't, but there are similarities.  Again, examples exist
where rejecting null buys us nothing but additional code to guard the
call.  These are visible in your patch.  And again, examples where
rejecting null would catch mistakes do not come to (my) mind.  That's
why I'm asking for them.

> fwiw, g_object_ref/unref() do not accept NULL. However,
> g_clear_object() was introduced later to simply clearing an object
> reference (unref and set to NULL, checks NULL).

[...]
