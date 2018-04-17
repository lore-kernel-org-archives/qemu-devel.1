Received: from eggs.gnu.org ([2001:4830:134:3::10]:50724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f8Y8D-0006u1-PW
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f8Y88-00020s-HI
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:27:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f8Y88-0001wo-AE
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:27:12 -0400
Date: Tue, 17 Apr 2018 17:27:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180417212710.GA10948@flamenco>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Tue, Apr 17, 2018 at 21:54:03 +0100, Peter Maydell wrote:
> On 17 April 2018 at 20:04, Emilio G. Cota <cota@braap.org> wrote:
> > Note that in fp-test I am not checking for flags that are raised
> > when none are expected, because doing so gives quite a few errors.
> > Just noticed that enabling this check yields 1049 of these errors for
> > v2.11, and before this patch that number was 1087. After this
> > patch, it is again brought down to 1049. IOW, the test cases in
> > fp-test raise exactly the same flags as v2.11, which is good to know.
> >
> > The 1049 errors are probably false positives -- at least a big
> > chunk of them should be, given that "-t host" gives even more errors.
> > I am tempted to keep the flag check and whitelist these errors
> > though, which would catch regressions such as the one we're fixing here.
> 
> I strongly suspect we do have a few cases where we get the answers
> wrong and/or don't report the flags right, so ideally we'd have
> a look at them in more detail...
> 
> > Here is the report file with the 1049 failing test cases:
> >   http://www.cs.columbia.edu/~cota/qemu/fp-test-after-inf-patch.txt
> 
> Syntax for interpreting the report:
> https://www.research.ibm.com/haifa/projects/verification/fpgen/syntax.txt
> 
> Here's the first one, am I reading it right?
> 
> + 0xffc00000 0xffb00000, expected: 0xffc00000, returned: 0xffc00000,
> expected exceptions: none, returned: i
> error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:1346:
> b32+ =0 Q S -> Q
> 
> That's a float32 addition where the first input is a QNaN
> and the second an SNaN (presumably the test is configured
> for what in QEMU is snan_bit_is_one == 0), and it expects
> the result to be the QNaN, with no exceptions set. But
> we raise Invalid.
> =0 is the rounding mode, not relevant here.

Yes, you're reading it right.

> IEEE754-2008 s6.2 seems pretty clear that if there's
> an SNaN as an operand then operations like addition should
> signal Invalid. So this looks like a bug in the test case
> input. (Which is weird, because IBM must have tested this,
> so it's odd to see an obvious error in it.)

Yes sometimes the input files don't make much sense -- that's why
I ended up whitelisting some of them.

BTW I just checked with -t host on an IBM Power8, and we get
the same 1049 flag errors we get with -t soft plus two additional ones:

+A 0xffb00000, expected: 0x7fa00000, returned: 0x7fa00000, \
  expected exceptions: i, returned: none
+error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:382:
+b32A =0 S -> S i
(...)
+cff 0xffb00000, expected: 0x7ff8000000000000, returned: 0x7ff4000000000000, \
  expected exceptions: i, returned: none
+error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:26170:
+b32b64cff =0 S -> Q i

On x86 with -t host we again get a strict superset of what we get
with -t soft.

So yeah, I don't know what these test cases are about.

> Most of the "expected none, returned i" lines look
> like the same thing. We should look at the others, though.

Given the above, whitelisting the 1049 cases and forcing the flag
checks for all tests (as below) seems reasonable to me.

--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -247,7 +247,7 @@ static enum error tester_check(const struct test_op *t, uint64_t res64,
             goto out;
         }
     }
-    if (t->exceptions && flags != (t->exceptions | default_exceptions)) {
+    if (flags != (t->exceptions | default_exceptions)) {
         err = ERROR_EXCEPTIONS;
         goto out;
     }

Thanks,

		E.
