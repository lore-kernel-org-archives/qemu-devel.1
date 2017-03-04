Received: from eggs.gnu.org ([2001:4830:134:3::10]:33092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjxS6-0003cT-Cd
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 19:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjxS3-0005Yd-7I
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 19:21:38 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cjxS3-0005Xv-2U
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 19:21:35 -0500
Received: by mail-qk0-x243.google.com with SMTP id g129so2886947qkd.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 16:21:35 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170228171921.21602-1-ale+qemu@clearmind.me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a6e8b5ff-0bac-116e-d621-8854884c7e8b@twiddle.net>
Date: Sat, 4 Mar 2017 11:21:28 +1100
MIME-Version: 1.0
In-Reply-To: <20170228171921.21602-1-ale+qemu@clearmind.me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Introducing libtcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alessandro Di Federico <ale+qemu@clearmind.me>, qemu-devel@nongnu.org

On 03/01/2017 04:19 AM, Alessandro Di Federico wrote:
> This series of patches is a follow-up to the "Preparing the build system
> for libtcg" patch set.
>
> The first six patches' aim is to decouple and factor out some components
> so that introducing libtcg can be painless and smooth. The last patch
> instead introduces libtcg, along with a set of simple tests.
>
> My main aim is to get the first six patches in mainline as soon as
> possible, since rebasing when large amounts of code is moved is quite a
> pain. If possible, letting the last patch in would be nice too.
>
> The current implementation of libtcg it's not thread-safe, doesn't allow
> to change the CPU, munmap memory pages and the library itself cannot be
> unloaded.
>
> Note that if libtcg is enabled in a build directory where it previously
> wasn't, a `make clean` is required, since everything has to be built
> with `-fPIC -fvisibility=hidden`. Maybe it's possible to have the build
> system recognize this automatically (suggestions welcome).
>
> Note also that the factoring process excluded the bsd-user targets,
> which would benefit from it (mainly for mmap.c and qemu.h), but are not
> in a working state, so I'm leaving them out to avoid making more
> damage. Once bsd-user is back in shape in mainline I'll be happy to
> include it in the factoring.
>
> For what concerns the test suite, the s390x linux-user target seems to
> be broken so I've temporarily excluded it from the test suite. Currently
> I'm testing translation only on a subset of architectures (MIPS, ARM and
> x86-64). It would be nice to test them all, but manually building all
> the toolchains can be a pain. Is there an "official" set of toolchains
> ready to use/compile?
>
> For what concerns the PREFIX changes in tcg-common.h, they're not very
> elegant. Another approach might be to prefix all the data types, data
> structures and enum entries in there with LibTCG/LIBTCG_ even
> internally. Opinions?
>
> Thanks.
>
> Alessandro Di Federico (7):
>   Factor out linux-user/qemu.h
>   Factor out *-user/mmap.c

These two patches I can understand, and seem like a good improvment.

>   Move *_cpu_dump_state to translate.c
>   *-user targets object files decoupling
>   Isolate coprocessor parts from target/arm/helper.c

I have no idea what you're going for here.  How does rearranging anything in 
target/* affect TCG, or creating a library form of TCG?

>   Factor out tcg/tcg.h

Most of this looks totally bogus.  Including:

(1) A common TCGReg?  This ought to be totally private between tcg.c and its 
backend.  The only reason this escapes at all right now is the history of 
TCG_AREG0.  Simply adjusting the interface given to target/* would clear that up.

(2) PREFIX(ArgConstraint), PREFIX(TempVal), etc.
Why is these being exported at all?

(3) PREFIX(Opcode), PREFIX3(NB_OPS), PREFIX(Cond), etc.
Why do you think these need to be specialized at all?

Indeed, the entire existence of this patch suggests a fundamental disconnect 
between how you and I interpret the goal and scope of a "libtcg".

>   Introduce libtcg infrastructure

And, this confirms it, in the first sentence:

> * Extend the build system to build libtcg-$arch.so dynamic libraries.

Why in the world would you want a JIT compiler for something other than the 
host cpu?  There is zero point in building libtcg-mips.so for an x86_64 host.

The only reason to want to pull TCG into a library form is so that another 
project might be able to also generate code on the fly also for the host.


r~
