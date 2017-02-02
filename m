Received: from eggs.gnu.org ([2001:4830:134:3::10]:52056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5te-0004ZS-TP
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 20:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ5tb-0001YD-KN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 20:09:10 -0500
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<87wpdbw2ki.fsf@dusky.pond.sub.org>
	<157b55c5-2927-5f4e-0c43-820abd75a6d2@redhat.com>
	<874m0ejth1.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c841220-8219-69fc-413f-c6ad320fe2ed@redhat.com>
Date: Wed, 1 Feb 2017 17:09:00 -0800
MIME-Version: 1.0
In-Reply-To: <874m0ejth1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org



On 31/01/2017 22:49, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 31/01/2017 12:40, Markus Armbruster wrote:
>>>> =20
>>>>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>>>> =20
>>>> -#if QEMU_GNUC_PREREQ(3, 4)
>>>>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>>>> -#else
>>>> -#define QEMU_WARN_UNUSED_RESULT
>>>> -#endif
>>> Should we inline this macro?
>>>
>>>> =20
>>>> -#if QEMU_GNUC_PREREQ(4, 0)
>>>>  #define QEMU_SENTINEL __attribute__((sentinel))
>>>> -#else
>>>> -#define QEMU_SENTINEL
>>>> -#endif
>>> Likewise.
>>
>> Why, since we don't do that for QEMU_NORETURN, QEMU_PACKED, etc.?
>=20
> Because we do it for aligned, always_inline, constructor, format, mode,
> noinline, and in places even noreturn and packed:
>=20
>     $ git-grep __attribute__ | sed '/define/d;s/.*__attribute__ *((\([A=
-Za-z0-9_]*\).*/\1/' | sort -u
>=20

Uh oh. :)  You have to remove uses in firmware and in imported code
(which covers mode, format and noreturn), but there's certainly room for
some BiteSizedTasks.

For sure noinline should be wrapped by a macro so that you also include
noclone (usually you want to thwart some compiler optimization so both
are needed).

That leaves aligned, always_inline and constructor.  always_inline has
three users, constructors has many, aligned has many and there's
QEMU_ALIGNED too.  The smallest work would be to convert these three to
QEMU_* rather than convert QEMU_* to __attribute__.

Thanks,

Paolo
