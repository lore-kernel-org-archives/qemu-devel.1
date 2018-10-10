Received: from eggs.gnu.org ([2001:4830:134:3::10]:53008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAOKJ-00079a-ET
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 19:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gAOKF-0005Mb-GM
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 19:55:39 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:23923
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1gAOKF-0004xU-70
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 19:55:35 -0400
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
	<933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
Date: Wed, 10 Oct 2018 19:55:15 -0400
MIME-Version: 1.0
In-Reply-To: <933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/9/2018 11:04 AM, Kamil Rytarowski wrote:

> On 09.10.2018 16:12, Peter Maydell wrote:
>> On 9 October 2018 at 14:52, Kamil Rytarowski <n54@gmx.com> wrote:
>>> On 07.10.2018 17:37, Brad Smith wrote:
>>>> Use MAP_STACK in qemu_alloc_stack() on OpenBSD.
>>>>
>>>> Added to -current and will be in our soon to be 6.4 release.
>>>>
>>>> MAP_STACK      Indicate that the mapping is used as a stack.  This
>>>>                 flag must be used in combination with MAP_ANON and
>>>>                 MAP_PRIVATE.
>>>>
>>>> Implement MAP_STACK option for mmap().  Synchronous faults (pagefaul=
t and
>>>> syscall) confirm the stack register points at MAP_STACK memory, othe=
rwise
>>>> SIGSEGV is delivered. sigaltstack() and pthread_attr_setstack() are =
modified
>>>> to create a MAP_STACK sub-region which satisfies alignment requireme=
nts.
>>>> Observe that MAP_STACK can only be set/cleared by mmap(), which zero=
es the
>>>> contents of the region -- there is no mprotect() equivalent operatio=
n, so
>>>> there is no MAP_STACK-adding gadget.
>>>>
>>>>
>>>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>>>
>>>>
>>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>>> index fbd0dc8c57..51e9a012c2 100644
>>>> --- a/util/oslib-posix.c
>>>> +++ b/util/oslib-posix.c
>>>> @@ -611,7 +611,11 @@ void *qemu_alloc_stack(size_t *sz)
>>>>       *sz +=3D pagesz;
>>>>
>>>>       ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE,
>>>> -               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>> +               MAP_PRIVATE | MAP_ANONYMOUS
>>>> +#ifdef MAP_STACK
>>>> +               | MAP_STACK
>>>> +#endif
>>>> +               , -1, 0);
>>>>       if (ptr =3D=3D MAP_FAILED) {
>>>>           perror("failed to allocate memory for stack");
>>>>           abort();
>>>>
>>> Can we handle it differently, storing MAP_* flags in a variable:
>>>
>>> int flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
>>> #ifdef MAP_STACK
>>> flags |=3D MAP_STACK;
>>> #endif
>>>
>>> ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
>>>
>>> This way it will look nicer as we won't ifdef the middle of a functio=
n call.
>> The other nice way to handle that is to have osdep.h do
>> #ifndef MAP_STACK
>> #define MAP_STACK 0
>> #endif
>> and then you can just unconditionally use MAP_STACK in your
>> expression for the mmap flags.
>>
> I assume that this is a cleaner solution.
>
>> I note that Linux also defines a MAP_STACK, about which the
>> manpage says:
>>         MAP_STACK (since Linux 2.6.27)
>>                Allocate the mapping at an address suitable for a
>> process or thread  stack.
>>                This  flag  is currently a no-op, but is used in the
>> glibc threading imple=E2=80=90
>>                mentation so that if some architectures require special
>> treatment for stack
>>                allocations, support can later be transparently
>> implemented for glibc.
>>
>> So this patch would be opting Linux QEMU builds into whatever that
>> potential future behaviour change is. That sounds I guess like
>> it's more likely to be the right thing than the wrong thing,
>> but it would be useful if some Linux expert could confirm...
>>
>> thanks
>> -- PMM
>>
> There is a similar description on NetBSD:
>
> MAP_STACK
>
> Allocate a memory segment that can be used
> either for a process or thread stack.  This
> currently has no effect, but its use is
> reserved for architectures that might require
> special treatment of that address space.
> Unimplemented.
>
> Apparently OpenBSD started to overload it for some hardening.

And from FreeBSD...

      MAP_STACK		MAP_STACK implies MAP_ANON, and	/offset/  of 0.  The/fd/
			argument must be -1 and	/prot/  must include at least
			PROT_READ and PROT_WRITE.

			This option creates a memory region that grows to at
			most/len/  bytes in size,	starting from the stack	top
			and growing down.  The stack top is the	starting
			address	returned by the	call, plus/len/  bytes.  The
			bottom of the stack at maximum growth is the starting
			address	returned by the	call.

			Stacks created with MAP_STACK automatically grow.
			Guards prevent inadvertent use of the regions into
			which those stacks can grow without requiring mapping
			the whole stack	in advance.
