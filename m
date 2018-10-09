Received: from eggs.gnu.org ([2001:4830:134:3::10]:40575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9slC-0002kC-PY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9sl7-0000lc-2p
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:13:16 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9sl5-0000kP-7F
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:13:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id p125-v6so1336737oic.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:13:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Oct 2018 15:12:49 +0100
Message-ID: <CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Kamil Rytarowski <n54@gmx.com>
Cc: Brad Smith <brad@comstyle.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 October 2018 at 14:52, Kamil Rytarowski <n54@gmx.com> wrote:
> On 07.10.2018 17:37, Brad Smith wrote:
>> Use MAP_STACK in qemu_alloc_stack() on OpenBSD.
>>
>> Added to -current and will be in our soon to be 6.4 release.
>>
>> MAP_STACK      Indicate that the mapping is used as a stack.  This
>>                flag must be used in combination with MAP_ANON and
>>                MAP_PRIVATE.
>>
>> Implement MAP_STACK option for mmap().  Synchronous faults (pagefault an=
d
>> syscall) confirm the stack register points at MAP_STACK memory, otherwis=
e
>> SIGSEGV is delivered. sigaltstack() and pthread_attr_setstack() are modi=
fied
>> to create a MAP_STACK sub-region which satisfies alignment requirements.
>> Observe that MAP_STACK can only be set/cleared by mmap(), which zeroes t=
he
>> contents of the region -- there is no mprotect() equivalent operation, s=
o
>> there is no MAP_STACK-adding gadget.
>>
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>
>>
>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>> index fbd0dc8c57..51e9a012c2 100644
>> --- a/util/oslib-posix.c
>> +++ b/util/oslib-posix.c
>> @@ -611,7 +611,11 @@ void *qemu_alloc_stack(size_t *sz)
>>      *sz +=3D pagesz;
>>
>>      ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE,
>> -               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +               MAP_PRIVATE | MAP_ANONYMOUS
>> +#ifdef MAP_STACK
>> +               | MAP_STACK
>> +#endif
>> +               , -1, 0);
>>      if (ptr =3D=3D MAP_FAILED) {
>>          perror("failed to allocate memory for stack");
>>          abort();
>>
>
> Can we handle it differently, storing MAP_* flags in a variable:
>
> int flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
> #ifdef MAP_STACK
> flags |=3D MAP_STACK;
> #endif
>
> ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE, flags, -1, 0);
>
> This way it will look nicer as we won't ifdef the middle of a function ca=
ll.

The other nice way to handle that is to have osdep.h do
#ifndef MAP_STACK
#define MAP_STACK 0
#endif
and then you can just unconditionally use MAP_STACK in your
expression for the mmap flags.


I note that Linux also defines a MAP_STACK, about which the
manpage says:
       MAP_STACK (since Linux 2.6.27)
              Allocate the mapping at an address suitable for a
process or thread  stack.
              This  flag  is currently a no-op, but is used in the
glibc threading imple=E2=80=90
              mentation so that if some architectures require special
treatment for stack
              allocations, support can later be transparently
implemented for glibc.

So this patch would be opting Linux QEMU builds into whatever that
potential future behaviour change is. That sounds I guess like
it's more likely to be the right thing than the wrong thing,
but it would be useful if some Linux expert could confirm...

thanks
-- PMM
