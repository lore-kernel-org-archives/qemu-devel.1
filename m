Received: from eggs.gnu.org ([2001:4830:134:3::10]:56697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyhSo-0007XU-NR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eyhSo-0004RM-0y
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:23:50 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eyhSn-0004Qv-Qy
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:23:49 -0400
Received: by mail-wr0-x243.google.com with SMTP id f14so5997720wre.8
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 10:23:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e9d6720a-19d9-b5d5-19dc-5c1f9a7a1665@redhat.com>
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvax_7QPP5rc3aAPKdUFWtfdEphfiN76mM6jnCKk4=QkauQ@mail.gmail.com>
	<407fd6f2-b88f-02fd-b4f8-9b4abb6a03a9@redhat.com>
	<CAMxuvawM+oOH7wHEMdcjJAZVaL9PbjfHA+UfMLu5+SbZgchrTw@mail.gmail.com>
	<2da23a16-51c7-fdcc-dfc5-7eed08f60d6f@redhat.com>
	<CAJ+F1C+NCwxnGSSE=5JAzf-grC3L4ebtZuXCXfxm9vv84FSPGQ@mail.gmail.com>
	<e9d6720a-19d9-b5d5-19dc-5c1f9a7a1665@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 21 Mar 2018 18:23:47 +0100
Message-ID: <CAJ+F1CJAy9jDoF-Q8MpOFkjqy0LGJ9EWC3qvwbkpc=eD7_srwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qobject: assume base of a qobject is
 at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>

On Wed, Mar 21, 2018 at 6:08 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/21/2018 11:59 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>
>>> Hmm, perhaps by making it "struct {} base"?
>>>
>>> Or even:
>>>
>>> struct QObjectCommon {
>>>      QType type;
>>>      size_t refcnt;
>>> }
>>>
>>> struct QObject {
>>>      QObjectCommon base;
>>> }
>>>
>>> struct QString {
>>>      QObjectCommon base;
>>>      ...
>>> }
>>
>>
>> I fail to see what that solves. You are moving the problem to
>> QObjectCommon: we would have to replace all QObject * user to take
>> QObjectCommon *, and then we wouldn't solve the problem for
>> QObjectCommon.
>
>
> Here, QObjectCommon is never used outside of qobject.h; all existing code
> continues to uwe QObject *.  But the conversion from QString* or QObject =
*
> to QObjectCommon * is trivial (&obj->base), and the conversion from
> QObjectCommon * to the public QObject * is trivial (container_of style
> cast).  So the QOBJECT() macro becomes comparable to a C++
> reinterpret_cast<>() that converts any descendent of QObjectCommon into
> QObject, even if the original type was not QObject; and we never offer a
> public API to convert anything into or out of QObjectCommon (it only exis=
ts
> as a dummy type to make our other casts easier).

What is the QOJECT() macro you proposed with that?

thanks


--=20
Marc-Andr=C3=A9 Lureau
