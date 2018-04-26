Received: from eggs.gnu.org ([2001:4830:134:3::10]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBiEd-0001X0-Qd
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBiEY-0003oF-0c
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:50:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBiEX-0003nU-Qg
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:50:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-2-marcandre.lureau@redhat.com>
	<d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
	<CAJ+F1C+X9vAi2xx5Z7yoi_65o_C9SxfE_HNrV9BDBd81Y1wxwg@mail.gmail.com>
	<87po2ohk68.fsf@dusky.pond.sub.org>
Date: Thu, 26 Apr 2018 16:50:52 +0200
In-Reply-To: <87po2ohk68.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 24 Apr 2018 14:18:39 +0200")
Message-ID: <87r2n2xbqr.fsf@dusky.pond.sub.org>
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

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
>> On Thu, Apr 19, 2018 at 5:20 PM, Eric Blake <eblake@redhat.com> wrote:
>>> On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>>>> All QObject types have the base QObject as their first field. This
>>>> allows the simplification of qobject_to().
>>>>
>>>> This explicitly guarantees that existing casts work correctly (even
>>>> though we'd prefer to get rid of such casts in any location except the
>>>> qobject.h macros)
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>> My R-b stands that this is correct from a coding point of view.  But if
>>> I read Markus' review correctly, we could omit this patch, fix the one
>>> broken client in tests/check-qdict.c to use qobject_to() (why didn't you
>>> fix that in v6)?, and then just apply patches 2-5 without this patch,
>
> Is that safe?

Yes, with a tweak to PATCH 2.

However, requiring base to come first is totally fine.  There's really
no reason to put it anywhere else, and fuzzing around with
container_of() is just complicating things.  Sunk cost (and thus not
worth changing) until this series, where keeping it would complicate the
next patch a bit, justifying this one.

I wouldn't have bothered with QEMU_BUILD_BUG(), let alone
QEMU_BUILD_BUG_MSG(); experience with QOM strongly indicates this
mistake is vanishingly unlikely in practice.  But I also can't be
bothered to rip it out.

[...]
