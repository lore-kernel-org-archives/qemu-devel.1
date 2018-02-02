Received: from eggs.gnu.org ([2001:4830:134:3::10]:38141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehcYq-0000CV-JA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehcYl-0001vI-OF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehcYl-0001uh-Fx
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:23 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-18-marcandre.lureau@redhat.com>
	<87d13qo6c6.fsf@dusky.pond.sub.org>
	<CAJ+F1CJt5U9y1O2coL0Lb7-cF9Oe69Wwn_94Jv4g8emJ5ArQdg@mail.gmail.com>
	<87zi6tirpa.fsf@dusky.pond.sub.org>
	<CAJ+F1C+y5ZLgGpa28bWGGopycpxnejNSsacfo5XFK_gDV4LwGA@mail.gmail.com>
Date: Fri, 02 Feb 2018 15:43:20 +0100
In-Reply-To: <CAJ+F1C+y5ZLgGpa28bWGGopycpxnejNSsacfo5XFK_gDV4LwGA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 11 Jan 2018
	22:24:03 +0100")
Message-ID: <87a7wrlaev.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 17/50] qapi: do not define enumeration
 value explicitely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Fri, Dec 8, 2017 at 8:50 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>>> On Thu, Dec 7, 2017 at 5:23 PM, Markus Armbruster <armbru@redhat.com> w=
rote:
>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>>
>>>>> The C standard has the initial value at 0 and the subsequent values
>>>>> incremented by 1. No need to set this explicitely.
>>>>>
>>>>> This will prevent from artificial "gaps" when compiling out some enum
>>>>> values and having unnecessarily large MAX values & enums arrays.
>>>>>
>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>>> ---
>>>>>  scripts/qapi.py | 7 ++-----
>>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>>>>> index 94b735d8d6..074ee221a1 100644
>>>>> --- a/scripts/qapi.py
>>>>> +++ b/scripts/qapi.py
>>>>> @@ -1985,14 +1985,11 @@ typedef enum %(c_name)s {
>>>>>  ''',
>>>>>                  c_name=3Dc_name(name))
>>>>>
>>>>> -    i =3D 0
>>>>>      for value in enum_values:
>>>>>          ret +=3D mcgen('''
>>>>> -    %(c_enum)s =3D %(i)d,
>>>>> +    %(c_enum)s,
>>>>>  ''',
>>>>> -                     c_enum=3Dc_enum_const(name, value, prefix),
>>>>> -                     i=3Di)
>>>>> -        i +=3D 1
>>>>> +                     c_enum=3Dc_enum_const(name, value, prefix))
>>>>>
>>>>>      ret +=3D mcgen('''
>>>>>  } %(c_name)s;
>>>>
>>>> Recapitulate review of v2: this risks entertaining mishaps like
>>>> compiling this one
>>>>
>>>>     typedef enum Color {
>>>>         COLOR_WHITE,
>>>> #if defined(NEED_CPU_H)
>>>> #if defined(TARGET_S390X)
>>>>         COLOR_BLUE,
>>>> #endif /* defined(TARGET_S390X) */
>>>> #endif /* defined(NEED_CPU_H) */
>>>>         COLOR_BLACK,
>>>>     } Color;
>>>>
>>>> in s390x-code (COLOR_BLACK =3D 2) and in target-independent code
>>>> (COLOR_BLACK =3D 1), then linking the two together.
>>>>
>>>> Same issue for struct members and such (previous patch).
>>>>
>>>> What's our story on preventing disaster here?
>>>>
>>>> In the long run, we want to split the generated code so that
>>>> target-specific and target-independent code are separate, and each part
>>>> is always compiled with consistent preprocessor symbols.  But I'm afra=
id
>>>> that's not in the card right now.
>>>
>>> Eh, I need to refresh my memories about that series, but I think
>>> that's what I did in v3
>>>
>>> It doesn't use the NEED_CPU_H trick. It has a seperate per-target targe=
t.json
>>
>> Looking... aha!  target.json appears in PATCH 44 (which I haven't even
>> glanced at, yet).  The problem appears in PATCH 16, though.  Perhaps a
>> bit of patch reshuffling would do.
>
> What problem appears in patch 16? Some code could be introduced using
> NEED_CPU_H and link arch & independent code together?

It's been a while...

Generated headers using conditionals must include the headers providing
the symbols used in conditionals.  Not doing so is an open death trap.

PATCH 16 sets up the first instance of the death trap.  Or maybe it's
PATCH 13.

However, including these headers only becomes possible *after* you split
off the target-specific stuff in PATCH 44.

Do I make any sense?

>                                                       It is still true
> after patch 44. If necessary, I can work on a split-qapi series before
> the conditionals are added. But the real benefit is only apparent
> after the conditional are introduced, so I am not motivated to
> reorder.

Understand.

As a maintainer, I can ask for improvements, but the only lever I have
is saying no.  Which should be reserved for cases that are actually
wrong, or create inacceptable technical debt.  Temporary death traps
don't count as either.  For cases I merely hate, when asking doesn't
help, all I can do is do the work myself.  So I did:

    [PATCH RFC 00/21] Modularize generated QAPI code
    Message-Id: <20180202130336.24719-1-armbru@redhat.com>

[...]
