Received: from eggs.gnu.org ([2001:4830:134:3::10]:56066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f87N5-00029n-0u
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f87N0-0007NZ-VG
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:52:51 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:51524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f87N0-0007NG-PM
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:52:46 -0400
Received: by mail-it0-f50.google.com with SMTP id b5-v6so12288476itj.1
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 09:52:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87efjfsgc3.fsf@dusky.pond.sub.org>
References: <20180413161842.5117-1-marcandre.lureau@redhat.com>
	<20180413161842.5117-3-marcandre.lureau@redhat.com>
	<87r2nfsh7w.fsf@dusky.pond.sub.org>
	<87efjfsgc3.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Apr 2018 18:52:45 +0200
Message-ID: <CAMxuvay5MCUZTaY5KpW_jTRP=LMV2YhMkFquGgXxUuYH5r89fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/4] qobject: use a QObjectBase_ struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>

On Mon, Apr 16, 2018 at 10:31 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Markus Armbruster <armbru@redhat.com> writes:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> By moving the base fields to a QObjectBase_, QObject can be a type
>>> which also has a 'base' field. This allows to write a generic
>>> QOBJECT() macro that will work with any QObject type, including
>>> QObject itself. The container_of() macro ensures that the object to
>>> cast has a QObjectBase_ base field, giving some type safety
>>> guarantees. However, for it to work properly, all QObject types must
>>> have 'base' at offset 0 (which is ensured by static checking from
>>> the previous patch)
>>
>> I'm afraid this condition is neither sufficient nor necessary.
>>
>> QOBJECT() maps a pointer to some subtype to the base type QObject.  For
>> this to work, the subtype must contain a QObject.
>>
>> Before the patch, this is trivially the case: the subtypes have a member
>> QObject base, and QOBJECT() returns its address.
>>
>> Afterwards, the subtypes have a member QObjectBase_ base, and QOBJECT()
>> returns the address of a notional QObject wrapped around this member.
>> Works because QObject has no other members.
>>
>> The condition 'base is at offset 0' does not ensure this, and is
>> therefore not sufficient.
>>
>> It's not necessary, either: putting base elsewhere would work just fine
>> as long as we put *all* of QObject there.
>>
>> Please document the real condition "QObject must have no members but
>> QObjectBase_ base, or else QOBJECT() breaks".  Feel free to check their
>> sizes are the same (I wouldn't bother).
>>
>> If requiring base to be at offset zero for all subtypes materially
>> simplifies code, then go ahead and do that in a separate patch.  My gut
>> feeling is it doesn't, but I could be wrong.
>
> Uh, there's another reason: existing type casts from QObject * to
> subtypes.  I just spotted one in tests/check-qdict.c:
>
>     dst =3D (QDict *)qdict_crumple(src, &error_abort);
>
> There may well be more.
>

So we better have checks from patch 1, don't we?
