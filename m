Received: from eggs.gnu.org ([2001:4830:134:3::10]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eygX4-000272-JY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eygX1-0008MP-Ca
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:24:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eygX1-0008MB-6Q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:24:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E8CD4023BB3
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 16:24:03 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvax_7QPP5rc3aAPKdUFWtfdEphfiN76mM6jnCKk4=QkauQ@mail.gmail.com>
	<407fd6f2-b88f-02fd-b4f8-9b4abb6a03a9@redhat.com>
	<CAMxuvawM+oOH7wHEMdcjJAZVaL9PbjfHA+UfMLu5+SbZgchrTw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2da23a16-51c7-fdcc-dfc5-7eed08f60d6f@redhat.com>
Date: Wed, 21 Mar 2018 17:23:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvawM+oOH7wHEMdcjJAZVaL9PbjfHA+UfMLu5+SbZgchrTw@mail.gmail.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>, "Blake, Eric" <eblake@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

On 21/03/2018 17:11, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Mar 21, 2018 at 5:00 PM, Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>> On 21/03/2018 16:55, Marc-Andr=C3=A9 Lureau wrote:
>>> That would work with an anonymous union though:
>>>
>>> struct QObject {
>>>     union {
>>>         QType type;
>>>         QType base;
>>>     };
>>>     size_t refcnt;
>>> };
>>>
>>> If it's acceptable, I think I'll take this approach.
>>
>> You don't need QEMU_GENERIC at all then, don't you?
>=20
> Ah ah, that's what I thought too, but the type of QObject * &x->base
> isn't QObject * :)
>=20
> I don't think we can fool it there (without loosing some type safety)

Hmm, perhaps by making it "struct {} base"?

Or even:

struct QObjectCommon {
    QType type;
    size_t refcnt;
}

struct QObject {
    QObjectCommon base;
}

struct QString {
    QObjectCommon base;
    ...
}

Paolo
