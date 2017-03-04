Received: from eggs.gnu.org ([2001:4830:134:3::10]:54620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1ck6Mq-0000Rj-2K
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 04:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1ck6Mm-0004B5-6j
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 04:52:48 -0500
Received: from clearmind.me ([178.32.49.9]:37635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1ck6Ml-00049y-VH
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 04:52:44 -0500
Date: Sat, 4 Mar 2017 10:53:47 +0100
From: Alessandro Di Federico <ale+qemu@clearmind.me>
In-Reply-To: <a6e8b5ff-0bac-116e-d621-8854884c7e8b@twiddle.net>
References: <20170228171921.21602-1-ale+qemu@clearmind.me>
	<a6e8b5ff-0bac-116e-d621-8854884c7e8b@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1ck6Ra-00025x-HP@clearmind.me>
Sender: ale@clearmind.me
Subject: Re: [Qemu-devel] [PATCH 0/7] Introducing libtcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Sat, 4 Mar 2017 11:21:28 +1100
Richard Henderson <rth@twiddle.net> wrote:

> > Alessandro Di Federico (7):
> >   Move *_cpu_dump_state to translate.c
> >   *-user targets object files decoupling
> >   Isolate coprocessor parts from target/arm/helper.c  
> 
> I have no idea what you're going for here.  How does rearranging
> anything in target/* affect TCG, or creating a library form of TCG?

Splitting target/arm/helper.c in two allows to link in libtcg only one
of the two files (namely, coprocessors.c) avoiding to pull in all the
helpers which are not needed for libtcg's goal and that would pull more
dependencies with no real use (e.g., I've made thing so that
soft_float.c is never required by libtcg).

> >   Factor out tcg/tcg.h  
> 
> Most of this looks totally bogus.  Including:
> 
> (1) A common TCGReg?  This ought to be totally private between tcg.c
> and its backend.  The only reason this escapes at all right now is
> the history of TCG_AREG0.  Simply adjusting the interface given to
> target/* would clear that up.

The patch makes TCGReg common to all architectures in terms of its
size, not in terms of enum entries. In fact, it's no longer an enum.
This is required since a compiler might decide to give a different size
to an enum depending on its entries.

> (2) PREFIX(ArgConstraint), PREFIX(TempVal), etc.
> Why is these being exported at all?

Because they are used in tiny code instructions' related data
structures, which is what we're exposing to users.

> (3) PREFIX(Opcode), PREFIX3(NB_OPS), PREFIX(Cond), etc.
> Why do you think these need to be specialized at all?

We need to expose those to users, and therefore we need to prefix them.
The PREFIX macros do not specialize their argument based on the
architecture, they simply add a different prefix depending on where
they are included (namely, tcg/tcg.h and include/libtcg.h).

> Indeed, the entire existence of this patch suggests a fundamental
> disconnect between how you and I interpret the goal and scope of a
> "libtcg".

Yes, there's definetely a misunderstanding.

> >   Introduce libtcg infrastructure  
> 
> And, this confirms it, in the first sentence:
> 
> > * Extend the build system to build libtcg-$arch.so dynamic
> > libraries.  
> 
> Why in the world would you want a JIT compiler for something other
> than the host cpu?  There is zero point in building libtcg-mips.so
> for an x86_64 host.
> 
> The only reason to want to pull TCG into a library form is so that
> another project might be able to also generate code on the fly also
> for the host.

The aim of libtcg (as I mentioned in the original proposal [1]) is not
to use it as a JIT compiler. The idea is to expose libtcg's *frontends*
to users, that is, allow our users to get tiny code instructions
corresponding to executable code for any of the architectures supported
by QEMU. This is why we need several libtcg-$arch.so libraries, one to
"lift" to tiny code instructions MIPS code, one for ARM and so on. Take
a look at the test in the last patch to get a better idea.

Hope this clarifies things a bit :)

--
Alessandro Di Federico
PhD student at Politecnico di Milano

[1]
http://lists.nongnu.org/archive/html/qemu-devel/2016-11/msg04847.html
