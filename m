Received: from eggs.gnu.org ([2001:4830:134:3::10]:60048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhgs-0005kI-5C
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhgn-0001xm-Gd
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:38:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyhgn-0001xd-C3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:38:17 -0400
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
From: Eric Blake <eblake@redhat.com>
Message-ID: <858d67db-409f-c23a-3f3c-2812ab1cc1b5@redhat.com>
Date: Wed, 21 Mar 2018 12:38:16 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJAy9jDoF-Q8MpOFkjqy0LGJ9EWC3qvwbkpc=eD7_srwA@mail.gmail.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>

On 03/21/2018 12:23 PM, Marc-Andr=C3=A9 Lureau wrote:

>>>> struct QObjectCommon {
>>>>       QType type;
>>>>       size_t refcnt;
>>>> }
>>>>
>>>> struct QObject {
>>>>       QObjectCommon base;
>>>> }
>>>>
>>>> struct QString {
>>>>       QObjectCommon base;
>>>>       ...
>>>> }

> What is the QOJECT() macro you proposed with that?

Here's what you can do while still leaving all "subtypes" of QObject=20
free to put base at a non-zero offset:

#define QOBJECT(o) ((QObject *)(&(o)->base))

QEMU_BUILD_BUG_MSG(offsetof(QObject, base),
     "base of QObject must be at offset 0");

#define qobject_to(type, obj) ({ \
     QObjectCommon *_tmp =3D qobject_check_type(obj, glue(QTYPE_CAST_TO_,=
=20
type)); \
     _tmp ? container_of(_tmp, type, base) : (type *)NULL; })


static inline QObjectCommon *qobject_check_type(const QObject *obj,=20
QType type)
{
     if (obj && qobject_type(obj) =3D=3D type) {
         return QOBJECT(obj);
     } else {
         return NULL;
     }
}


Or, you keep your idea of requiring ALL subtypes to put base at offset=20
0, so that qobject_to() also becomes simpler.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
