Received: from eggs.gnu.org ([2001:4830:134:3::10]:33537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyhm9-0002hX-JO
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyhm5-0003qK-MK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:43:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyhm5-0003qD-IB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:43:45 -0400
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvax_7QPP5rc3aAPKdUFWtfdEphfiN76mM6jnCKk4=QkauQ@mail.gmail.com>
	<407fd6f2-b88f-02fd-b4f8-9b4abb6a03a9@redhat.com>
	<CAMxuvawM+oOH7wHEMdcjJAZVaL9PbjfHA+UfMLu5+SbZgchrTw@mail.gmail.com>
	<2da23a16-51c7-fdcc-dfc5-7eed08f60d6f@redhat.com>
	<CAJ+F1C+NCwxnGSSE=5JAzf-grC3L4ebtZuXCXfxm9vv84FSPGQ@mail.gmail.com>
	<e9d6720a-19d9-b5d5-19dc-5c1f9a7a1665@redhat.com>
	<CAJ+F1CJAy9jDoF-Q8MpOFkjqy0LGJ9EWC3qvwbkpc=eD7_srwA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9897af0-2079-018f-2c05-f95182d69a44@redhat.com>
Date: Wed, 21 Mar 2018 18:43:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJAy9jDoF-Q8MpOFkjqy0LGJ9EWC3qvwbkpc=eD7_srwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>

On 21/03/2018 18:23, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Here, QObjectCommon is never used outside of qobject.h; all existing c=
ode
>> continues to uwe QObject *.  But the conversion from QString* or QObje=
ct *
>> to QObjectCommon * is trivial (&obj->base), and the conversion from
>> QObjectCommon * to the public QObject * is trivial (container_of style
>> cast).  So the QOBJECT() macro becomes comparable to a C++
>> reinterpret_cast<>() that converts any descendent of QObjectCommon int=
o
>> QObject, even if the original type was not QObject; and we never offer=
 a
>> public API to convert anything into or out of QObjectCommon (it only e=
xists
>> as a dummy type to make our other casts easier).
> What is the QOJECT() macro you proposed with that?

#define QOBJECT(x) \
   container_of(&(x)->base, QObject, base)

where the double dereference-and-container_of provides some type safety
(container_of fails if &(x)->base is not a QObjectCommon*).

Paolo
