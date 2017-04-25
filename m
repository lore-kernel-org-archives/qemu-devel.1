Received: from eggs.gnu.org ([2001:4830:134:3::10]:35020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2wq3-0008H5-MP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2wq2-0007ta-OG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:32:51 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2wq2-0007tB-Iq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:32:50 -0400
Received: by mail-wm0-x232.google.com with SMTP id r190so90569666wme.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 02:32:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87mvb4q23i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
	<CAFEAcA-dD=DZmtvMDAz2Z8u6Qb2ozGWNroPQhwXr+zczvtjqVA@mail.gmail.com>
	<87pog0q2xz.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<CAFEAcA9S+q8FiZ2chaLoUWmQJ3uForGaDVGqwrBHnxmpH4sy_Q@mail.gmail.com>
	<87mvb4q23i.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 10:32:28 +0100
Message-ID: <CAFEAcA8ztT3mEy4BpUQGmONwSV6sPpq24C2=Vj_0s_gZ2oc6ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC] configure: fix clang failure for
 libatomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 25 April 2017 at 10:16, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 25 April 2017 at 09:58, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>>>     /tmp/atomic-1660e0.o: In function `main':
>>>     /tmp/atomic.c:(.text+0x28): undefined reference to `__atomic_load_8'
>>>     /tmp/atomic.c:(.text+0x40): undefined reference to `__atomic_store_8'
>>>     /tmp/atomic.c:(.text+0x69): undefined reference to `__atomic_compare_exchange_8'
>>>     /tmp/atomic.c:(.text+0x7d): undefined reference to `__atomic_exchange_8'
>>>     /tmp/atomic.c:(.text+0x91): undefined reference to `__atomic_fetch_add_8'
>>>     clang-3.9: error: linker command failed with exit code 1 (use -v to see invocation)
>>>
>>> With -latomic, the linker succeeds in getting the binary.
>>
>> What host is this on ?
>
> $ uname -a
> Linux abhimanyu 4.9.13-200.fc25.x86_64 #1 SMP Mon Feb 27 16:48:42 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

Hmm, I can repro that, but there's a problem even if we do link against
libatomic. If you disassemble the resulting binaries, gcc produces
what we want:
 f0 48 01 45 e8          lock add %rax,-0x18(%rbp)
and other inline atomic instructions.
clang on the other hand produces
 e8 33 fe ff ff          callq  400610 <__atomic_fetch_add_8@plt>
which is an expensive call to an out of line subroutine.

We need to figure out how to get clang to just emit the inline
operations.

thanks
-- PMM
