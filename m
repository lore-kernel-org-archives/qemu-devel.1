Received: from eggs.gnu.org ([2001:4830:134:3::10]:52470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhEa-00063U-9C
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhEX-0005EH-4C
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:09:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyhEX-0005Ds-0P
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:09:05 -0400
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvax_7QPP5rc3aAPKdUFWtfdEphfiN76mM6jnCKk4=QkauQ@mail.gmail.com>
	<407fd6f2-b88f-02fd-b4f8-9b4abb6a03a9@redhat.com>
	<CAMxuvawM+oOH7wHEMdcjJAZVaL9PbjfHA+UfMLu5+SbZgchrTw@mail.gmail.com>
	<2da23a16-51c7-fdcc-dfc5-7eed08f60d6f@redhat.com>
	<CAJ+F1C+NCwxnGSSE=5JAzf-grC3L4ebtZuXCXfxm9vv84FSPGQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9d6720a-19d9-b5d5-19dc-5c1f9a7a1665@redhat.com>
Date: Wed, 21 Mar 2018 12:08:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+NCwxnGSSE=5JAzf-grC3L4ebtZuXCXfxm9vv84FSPGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>

On 03/21/2018 11:59 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Hmm, perhaps by making it "struct {} base"?
>>
>> Or even:
>>
>> struct QObjectCommon {
>>      QType type;
>>      size_t refcnt;
>> }
>>
>> struct QObject {
>>      QObjectCommon base;
>> }
>>
>> struct QString {
>>      QObjectCommon base;
>>      ...
>> }
>=20
> I fail to see what that solves. You are moving the problem to
> QObjectCommon: we would have to replace all QObject * user to take
> QObjectCommon *, and then we wouldn't solve the problem for
> QObjectCommon.

Here, QObjectCommon is never used outside of qobject.h; all existing=20
code continues to uwe QObject *.  But the conversion from QString* or=20
QObject * to QObjectCommon * is trivial (&obj->base), and the conversion=20
from QObjectCommon * to the public QObject * is trivial (container_of=20
style cast).  So the QOBJECT() macro becomes comparable to a C++=20
reinterpret_cast<>() that converts any descendent of QObjectCommon into=20
QObject, even if the original type was not QObject; and we never offer a=20
public API to convert anything into or out of QObjectCommon (it only=20
exists as a dummy type to make our other casts easier).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
