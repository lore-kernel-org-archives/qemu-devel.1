Received: from eggs.gnu.org ([2001:4830:134:3::10]:53037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfmr-0003iQ-8Q
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfml-0002L6-JL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:36:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyfml-0002Kw-EH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:36:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0CE3640704B6
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 15:36:19 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-4-marcandre.lureau@redhat.com>
	<5321b7df-215e-e56d-ae6d-2ada8706cdcc@redhat.com>
	<CAMxuvazWmEuDeBPTPCatr_o0rKiUk8MddvTE6u70w_-ML8B7kA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <467e9318-2da4-56f6-1743-09c4a9e48349@redhat.com>
Date: Wed, 21 Mar 2018 10:36:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvazWmEuDeBPTPCatr_o0rKiUk8MddvTE6u70w_-ML8B7kA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>

On 03/21/2018 09:51 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, Mar 21, 2018 at 3:28 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 03/21/2018 08:40 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>
>>> Now that we can safely call QOBJECT() on QObject * and children types=
,
>>> we can have a single macro to ref/unref the object.
>>>
>>> Change the incref/decref prefix name for the more common ref/unref.
>>
>>
>> I know you did this by sed (for the most part); but it would be worth
>> including the command line you used in the commit message to make it e=
asier
>> to reproduce the same mechanical portion of the patch when rebasing.
>=20
> git sed QINCREF qobject_ref
> git sed QDECREF qobject_unref
> git sed qobject_incref qobject_ref
> git sed qobject_decref qobject_ref

Did any of these create longer lines that needed reflowing?  (Moot point=20
if we bikeshed the ending macro name to be no longer than QDECREF)

>>> +++ b/scripts/coccinelle/qobject.cocci
>>> @@ -3,11 +3,11 @@
>>>    expression Obj, Key, E;
>>>    @@
>>>    (
>>> -- qobject_incref(QOBJECT(E));
>>> -+ QINCREF(E);
>>> +- qobject_ref(QOBJECT(E));
>>> ++ qobject_ref(E);
>>>    |
>>> -- qobject_decref(QOBJECT(E));
>>> -+ QDECREF(E);
>>> +- qobject_unref(QOBJECT(E));
>>> ++ qobject_unref(E);
>>
>>
>> I wonder if these branches should just be removed; they made sense whe=
n we
>> had two spellings, but after your mass conversion, the .cocci script i=
s
>> unlikely to ever find regressions on this front.
>=20
> They would still remove extra cast, wouldn't they?

But the point I'm making is that the old code dealing with type-specific=20
names actually happened multiple times (it was easy to overlook the=20
macro definition that served as shorthand for decrementing a derived=20
type, and thus spelling it out in longhand as a decrement on the=20
conversion to the base type - and where because the two spellings were=20
type-dependent the compiler flagged you if you tried to use the wrong=20
spelling for the type at hand); in new code, where a single macro works=20
for both base and derived types, no one is likely to mistakenly cast=20
their derived type to the base type just to call the generic macro=20
(because your naive attempt at just decrementing will work, regardless=20
of the type at hand, so you don't have to throw in casts to shut up the=20
compiler).

At the same time, you're right that keeping the .cocci doesn't hurt=20
(even if it is unlikely to find future offenders).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
