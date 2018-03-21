Received: from eggs.gnu.org ([2001:4830:134:3::10]:60876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeaS-0002Vs-Bc
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeaP-00082c-7T
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:19:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyeaP-00081z-22
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:19:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F19C2A2017
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 14:19:24 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<3ec274aa-0dea-0932-e560-f388c1cbac41@redhat.com>
	<CAMxuvay1j+E1YRggpqm9+ETE_FxD-ThGtPBenUtvt8oeYweS8g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e876850-3057-e9d5-695b-69f4cde9aa9a@redhat.com>
Date: Wed, 21 Mar 2018 09:19:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvay1j+E1YRggpqm9+ETE_FxD-ThGtPBenUtvt8oeYweS8g@mail.gmail.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>

On 03/21/2018 09:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Mar 21, 2018 at 3:01 PM, Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>> On 21/03/2018 14:40, Marc-Andr=C3=A9 Lureau wrote:
>>> +/* A typecast, checking for the type of arguments */
>>> +/* QObject is at offset 0, for all QObject-derived types */
>>> +#define QOBJECT(x) QEMU_GENERIC(x,              \
>>> +    (QNull *, (QObject *) x),                   \
>>> +    (const QNull *, (const QObject *) x),       \
>>> +    (QNum *, (QObject *) x),                    \
>>> +    (const QNum *, (const QObject *) x),        \
>>> +    (QString *, (QObject *) x),                 \
>>> +    (const QString *, (const QObject *) x),     \
>>> +    (QDict *, (QObject *) x),                   \
>>> +    (const QDict *, (const QObject *) x),       \
>>> +    (QList *, (QObject *) x),                   \
>>> +    (const QList *, (const QObject *) x),       \
>>> +    (QBool *, (QObject *) x),                   \
>>> +    (const QBool *, (const QObject *) x),       \
>>> +    (QObject *, x),                             \
>>> +    (const QObject *, x),                       \
>>> +    qobject_unknown_type(x))
>>
>> Why not just
>>
>>          QEMU_GENERIC(x,
>>                  (QObject *, x),
>>                  (const QObject *, x),
>>                  ({ \
>>                          QEMU_BUILD_BUG_ON(offsetof(typeof(*x), base))=
;
>>                          &(x)->base;
>>                  }))
>>
>> That is just an extension of what was being done before, and it is
>> resilient against people putting a random "QObject base" in the middle
>> of a struct.
>>
>=20
> Yeah, I tried a few of those approaches. Here the problem is that
> QObject doesn't have base field. So you get a compile time error with
> a QObject * as argument.

So the compiler requires &(x)->base to resolve even when it is not on=20
the branch that gets selected?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
