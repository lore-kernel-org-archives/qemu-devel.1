Received: from eggs.gnu.org ([2001:4830:134:3::10]:53098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d2wJf-0008QK-7b
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d2wJc-0007Oq-5w
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:59:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60148
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d2wJb-0007OQ-VZ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:59:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3P8rpSU033757
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 04:59:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1v50dxxv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 04:59:18 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 18:58:57 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA-dD=DZmtvMDAz2Z8u6Qb2ozGWNroPQhwXr+zczvtjqVA@mail.gmail.com>
References: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
	<CAFEAcA-dD=DZmtvMDAz2Z8u6Qb2ozGWNroPQhwXr+zczvtjqVA@mail.gmail.com>
Date: Tue, 25 Apr 2017 14:28:00 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87pog0q2xz.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 25 April 2017 at 09:35, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
>> Travis builds failure was reported for powernv boot-serial test with
>> qemu built with clang.
>>
>> Debugging revealed that CONFIG_ATOMIC64 wasnt getting set for the clang
>> build because of that atomic operations weren't being used and was
>> resulting in MTTCG failure in the powernv boot-serial test.
>>
>> libatomic is required to successfully test atomic64 and atomic128 for
>> clang. Introduced newer checks for the same. And on failure default to
>> single threaded tcg support in PPC64.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>
> Do we really need libatomic?

I was trying out the program in the configure script with clang and I do
get errors without libatomic:

    $ clang /tmp/atomic.c 
    /tmp/atomic.c:6:7: warning: implicit declaration of function '__atomic_load_8' is invalid in C99 [-Wimplicit-function-declaration]
      y = __atomic_load_8(&x, 0);
          ^
    /tmp/atomic.c:7:3: warning: implicit declaration of function '__atomic_store_8' is invalid in C99 [-Wimplicit-function-declaration]
      __atomic_store_8(&x, y, 0);
      ^
    /tmp/atomic.c:8:3: warning: implicit declaration of function '__atomic_compare_exchange_8' is invalid in C99 [-Wimplicit-function-declaration]
      __atomic_compare_exchange_8(&x, &y, x, 0, 0, 0);
      ^
    /tmp/atomic.c:9:3: warning: implicit declaration of function '__atomic_exchange_8' is invalid in C99 [-Wimplicit-function-declaration]
      __atomic_exchange_8(&x, y, 0);
      ^
    /tmp/atomic.c:10:3: warning: implicit declaration of function '__atomic_fetch_add_8' is invalid in C99 [-Wimplicit-function-declaration]
      __atomic_fetch_add_8(&x, y, 0);
      ^
    5 warnings generated.
    /tmp/atomic-1660e0.o: In function `main':
    /tmp/atomic.c:(.text+0x28): undefined reference to `__atomic_load_8'
    /tmp/atomic.c:(.text+0x40): undefined reference to `__atomic_store_8'
    /tmp/atomic.c:(.text+0x69): undefined reference to `__atomic_compare_exchange_8'
    /tmp/atomic.c:(.text+0x7d): undefined reference to `__atomic_exchange_8'
    /tmp/atomic.c:(.text+0x91): undefined reference to `__atomic_fetch_add_8'
    clang-3.9: error: linker command failed with exit code 1 (use -v to see invocation)

With -latomic, the linker succeeds in getting the binary.

> I thought the intention here was that atomic operations were only done
> on types of width of the pointer or less, which should all be doable
> by the compiler inline, and thus don't need the external library.

You are right, even without -latomic in libs_softmmu, tests are passing.
But then __atomic_load_8() isn't used in qemu, if it was using them,
build would fail.

> In the past "doesn't work without libatomic" usually meant
>"accidentally tried to do an atomic operation on a type that is too
>wide".

Regards
Nikunj
