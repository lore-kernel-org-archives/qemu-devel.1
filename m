Received: from eggs.gnu.org ([2001:4830:134:3::10]:51543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAwuU-0004MG-9E
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAwuP-0003IG-BM
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:19:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fAwuP-0003HT-6w
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:18:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-2-marcandre.lureau@redhat.com>
	<d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
	<CAJ+F1C+X9vAi2xx5Z7yoi_65o_C9SxfE_HNrV9BDBd81Y1wxwg@mail.gmail.com>
Date: Tue, 24 Apr 2018 14:18:39 +0200
In-Reply-To: <CAJ+F1C+X9vAi2xx5Z7yoi_65o_C9SxfE_HNrV9BDBd81Y1wxwg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 19 Apr 2018
	17:23:02 +0200")
Message-ID: <87po2ohk68.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Thu, Apr 19, 2018 at 5:20 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> All QObject types have the base QObject as their first field. This
>>> allows the simplification of qobject_to().
>>>
>>> This explicitly guarantees that existing casts work correctly (even
>>> though we'd prefer to get rid of such casts in any location except the
>>> qobject.h macros)
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> My R-b stands that this is correct from a coding point of view.  But if
>> I read Markus' review correctly, we could omit this patch, fix the one
>> broken client in tests/check-qdict.c to use qobject_to() (why didn't you
>> fix that in v6)?, and then just apply patches 2-5 without this patch,

Is that safe?

>> with no change in behavior and where we are no longer dependent on using
>> offset 0 (even though all current instances do).  So, I'll leave that to
>> maintainer discretion.
>
> I don't think we have a good reason to allow offset different than 0.
> The fact that we have code that rely on that behaviour already is a
> sign that this could easily happen again,

Maybe.  We found one sloppy type cast, which should be cleaned up no
matter what we do with this patch (happy to post the obvious patch
myself).

>                                           because it's the common
> pattern in C for inheritance, and static casting is allowed, for
> better or worse.

"Common way to do single inheritance in C" is a stronger argument.  More
so since QOM does it that way.

We define hundreds of QOM types without ever bothering to check the
super type comes first.  We don't even bother to clearly document it has
to come first.

The fact that we nevertheless haven't seen misuse looks like fairly
strong evidence of a non-problem to me.
