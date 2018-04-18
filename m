Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f8qQD-0001lD-54
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f8qQ8-0003Ko-6N
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:59:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f8qQ8-0003KQ-19
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:59:00 -0400
Received: by mail-io0-f195.google.com with SMTP id f3-v6so3237002iob.13
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 09:58:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87po2wsbu6.fsf@dusky.pond.sub.org>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-2-marcandre.lureau@redhat.com>
	<ea5c5be8-2e0f-ed00-8ce1-aee6d6e117d4@redhat.com>
	<87po2wsbu6.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Apr 2018 18:58:57 +0200
Message-ID: <CAMxuvayPRQuAndb=3_KdarTsykU803rD9tDoD1jZ458Mzjj7Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>

Hi

On Wed, Apr 18, 2018 at 6:45 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Eric Blake <eblake@redhat.com> writes:
>
>> On 04/17/2018 08:35 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> All QObject types have the base QObject as first field. This allows to
>>
>> s/as/as their/
>>
>>> simplify qobject_to() and will allow further simplification in
>>
>> s/allows to simplify/allows the simplification of/
>> s/in/in the/
>>
>>> following patch.
>>
>> Might also be worth mentioning that this explicitly guarantees that
>> existing casts work correctly (even though we'd prefer to get rid of
>> such casts in any location except the qobject.h macros); Markus pointed =
out:
>>
>>>> Uh, there's another reason: existing type casts from QObject * to
>>>> subtypes.  I just spotted one in tests/check-qdict.c:
>>>>
>>>>     dst =3D (QDict *)qdict_crumple(src, &error_abort);
>
> As far as I'm concerned, that's the real reason.  The simplification
> plus the check to make it safe seems like a wash.
>
> The cast I spotted appears to be the only one, though:
>
>     $ git-grep '(Q[A-Z][a-z]* \*)'
>     hmp.c:    qmp_device_add((QDict *)qdict, NULL, &err);
>     include/qapi/qmp/qobject.h:        return (QObject *)obj;
>     qobject/qobject.c:static void (*qdestroy[QTYPE__MAX])(QObject *) =3D =
{
>     tests/check-qdict.c:    dst =3D (QDict *)qdict_crumple(src, &error_ab=
ort);
>
> The first two cast away const, the third isn't a type cast.  The fourth
> one should use qobject_to() instead, regardless of this patch.
>
> Do we want to force base to come first anyway?

to simplify qobject_to and allow static casting?

> Where does PATCH 2 exploit "base first"?

patch 2 no longer needs that afaict
