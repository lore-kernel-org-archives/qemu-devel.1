Received: from eggs.gnu.org ([2001:4830:134:3::10]:44597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkKU-0004OX-78
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkKT-0000w4-5n
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:24:06 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:37551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkKS-0000vN-Vh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:24:05 -0500
Received: by mail-wr0-x231.google.com with SMTP id f8so3542179wre.4
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:24:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zi6tirpa.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-18-marcandre.lureau@redhat.com>
	<87d13qo6c6.fsf@dusky.pond.sub.org>
	<CAJ+F1CJt5U9y1O2coL0Lb7-cF9Oe69Wwn_94Jv4g8emJ5ArQdg@mail.gmail.com>
	<87zi6tirpa.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:24:03 +0100
Message-ID: <CAJ+F1C+y5ZLgGpa28bWGGopycpxnejNSsacfo5XFK_gDV4LwGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Fri, Dec 8, 2017 at 8:50 AM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> On Thu, Dec 7, 2017 at 5:23 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>
>>>> The C standard has the initial value at 0 and the subsequent values
>>>> incremented by 1. No need to set this explicitely.
>>>>
>>>> This will prevent from artificial "gaps" when compiling out some enum
>>>> values and having unnecessarily large MAX values & enums arrays.
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>  scripts/qapi.py | 7 ++-----
>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/scripts/qapi.py b/scripts/qapi.py
>>>> index 94b735d8d6..074ee221a1 100644
>>>> --- a/scripts/qapi.py
>>>> +++ b/scripts/qapi.py
>>>> @@ -1985,14 +1985,11 @@ typedef enum %(c_name)s {
>>>>  ''',
>>>>                  c_name=3Dc_name(name))
>>>>
>>>> -    i =3D 0
>>>>      for value in enum_values:
>>>>          ret +=3D mcgen('''
>>>> -    %(c_enum)s =3D %(i)d,
>>>> +    %(c_enum)s,
>>>>  ''',
>>>> -                     c_enum=3Dc_enum_const(name, value, prefix),
>>>> -                     i=3Di)
>>>> -        i +=3D 1
>>>> +                     c_enum=3Dc_enum_const(name, value, prefix))
>>>>
>>>>      ret +=3D mcgen('''
>>>>  } %(c_name)s;
>>>
>>> Recapitulate review of v2: this risks entertaining mishaps like
>>> compiling this one
>>>
>>>     typedef enum Color {
>>>         COLOR_WHITE,
>>> #if defined(NEED_CPU_H)
>>> #if defined(TARGET_S390X)
>>>         COLOR_BLUE,
>>> #endif /* defined(TARGET_S390X) */
>>> #endif /* defined(NEED_CPU_H) */
>>>         COLOR_BLACK,
>>>     } Color;
>>>
>>> in s390x-code (COLOR_BLACK =3D 2) and in target-independent code
>>> (COLOR_BLACK =3D 1), then linking the two together.
>>>
>>> Same issue for struct members and such (previous patch).
>>>
>>> What's our story on preventing disaster here?
>>>
>>> In the long run, we want to split the generated code so that
>>> target-specific and target-independent code are separate, and each part
>>> is always compiled with consistent preprocessor symbols.  But I'm afrai=
d
>>> that's not in the card right now.
>>
>> Eh, I need to refresh my memories about that series, but I think
>> that's what I did in v3
>>
>> It doesn't use the NEED_CPU_H trick. It has a seperate per-target target=
.json
>
> Looking... aha!  target.json appears in PATCH 44 (which I haven't even
> glanced at, yet).  The problem appears in PATCH 16, though.  Perhaps a
> bit of patch reshuffling would do.

What problem appears in patch 16? Some code could be introduced using
NEED_CPU_H and link arch & independent code together? It is still true
after patch 44. If necessary, I can work on a split-qapi series before
the conditionals are added. But the real benefit is only apparent
after the conditional are introduced, so I am not motivated to
reorder.

>
>>> I therefore proposed the stupidest temporary stopgap that could possibl=
y
>>> work: apply conditionals *only* to qmp-introspect.c, leave everything
>>> unconditional elsewhere.
>>
>> I don't like that idea much and I don't think we need that
>> restriction, but I need to get back to that series on some point
>> (probably after you finish the review).
>
> It's a beefy series, and it's probably best to let me review the largest
> prefix I can before we dive into discussion.

thanks

--=20
Marc-Andr=C3=A9 Lureau
