Received: from eggs.gnu.org ([209.51.188.92]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkac8-0006zV-Sf
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 15:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkac7-0005k2-RS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 15:19:40 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gkac7-0005hf-Ie
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 15:19:39 -0500
Date: Fri, 18 Jan 2019 15:19:35 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190118201935.GA31012@flamenco>
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
	<20190117200805.GA14264@flamenco> <87va2lyibo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va2lyibo.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 18, 2019 at 17:41:15 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Thu, Jan 17, 2019 at 18:55:33 +0000, Peter Maydell wrote:
> >> On Thu, 17 Jan 2019 at 18:30, Emilio G. Cota <cota@braap.org> wrote:
> >> > What are the contents of "int-to-float.err"?
> >>
> >> linux1@lxub05:~$ cat qemu/build/all/tests/fp/int-to-float.err
(snip)
> >> >> Testing i32_to_f128
> >> 372 tests total.
> >> 21 tests performed; 20 errors found.
> >
> > I see, so i32_to_f128 is failing on this host. Is there
> > a s390x machine I could access? I don't see one in the
> > gcc compile farm.
> 
> I've managed to reproduce this in a s390x VM, for Debian install runes:
> 
>   https://wiki.qemu.org/Documentation/Platforms/S390X#Debian_Install_Example_.28TCG.29

It's an endianness issue -- I've reproduced it on both gcc110
(POWER7) from gcc's compile farm and on the s390 machine provided
by Peter (thanks!). Both machines are big endian.

I have a fix for the 128 conversions (below), but not for the
int-to-f80 conversions (the ones that work on little endian).
I have no more time to look into this, so if someone can take
a look, I'd appreciate it.

I'm a little puzzled because given these definitions:

// our floatx80
typedef struct {
    uint64_t low;
    uint16_t high;
} floatx80;

// softfloat's
#ifdef LITTLEENDIAN
struct extFloat80M { uint64_t signif; uint16_t signExp; };
#else
struct extFloat80M { uint16_t signExp; uint64_t signif; };
#endif

I fail to see why just copying low/high to/from signif/signExp
to convert between them fails to work.

Thanks,

		Emilio

---
diff --git a/tests/fp/wrap.inc.c b/tests/fp/wrap.inc.c
index d3bf600cd0..68f57bc167 100644
--- a/tests/fp/wrap.inc.c
+++ b/tests/fp/wrap.inc.c
@@ -87,8 +87,13 @@ static float128_t qemu_to_soft128(float128 a)
     float128_t ret;
     struct uint128 *to = (struct uint128 *)&ret;

+#ifdef LITTLEENDIAN
     to->v0 = a.low;
     to->v64 = a.high;
+#else
+    to->v0 = a.high;
+    to->v64 = a.low;
+#endif
     return ret;
 }

@@ -97,8 +102,13 @@ static float128 soft_to_qemu128(float128_t a)
     struct uint128 *from = (struct uint128 *)&a;
     float128 ret;

+#ifdef LITTLEENDIAN
     ret.low = from->v0;
     ret.high = from->v64;
+#else
+    ret.low = from->v64;
+    ret.high = from->v0;
+#endif
     return ret;
 }
