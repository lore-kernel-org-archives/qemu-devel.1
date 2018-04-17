Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f8ZFL-0008Pn-3O
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f8ZFG-0005s3-T7
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:38:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f8ZFG-0005rM-N4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 18:38:38 -0400
Date: Tue, 17 Apr 2018 18:38:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180417223837.GA25085@flamenco>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<20180417190439.GA28717@flamenco>
	<CAFEAcA87BUwn96GY5esyNBtoGQY+myVAX9XoPW02gpaJbqyBzg@mail.gmail.com>
	<20180417212710.GA10948@flamenco>
	<CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9PS2FNSq0VFgO652RaemTViGKzOQStiycqFB8DDhy_ig@mail.gmail.com>
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

On Tue, Apr 17, 2018 at 22:45:51 +0100, Peter Maydell wrote:
> On 17 April 2018 at 22:27, Emilio G. Cota <cota@braap.org> wrote:
> > BTW I just checked with -t host on an IBM Power8, and we get
> > the same 1049 flag errors we get with -t soft plus two additional ones:
> >
> > +A 0xffb00000, expected: 0x7fa00000, returned: 0x7fa00000, \
> >   expected exceptions: i, returned: none
> > +error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:382:
> > +b32A =0 S -> S i
> 
> That's Abs of an SNaN; the test expects Invalid, which is wrong,
> because IEEE754 says absolute-value is a "quiet-computational
> operation" that never signals an exception.
> 
> What's odd is that we don't report that error for the softfloat
> implementation! I also don't understand why the expected value
> isn't just the input value with the sign bit flipped.

With -t soft we don't handle "abs" and we don't get the error -- we get
a "not handled" instead.
Is there a function that we could use for abs? The only ones I've seen
are floatX_abs() which mask out the sign bit and do nothing else.

> > (...)
> > +cff 0xffb00000, expected: 0x7ff8000000000000, returned: 0x7ff4000000000000, \
> >   expected exceptions: i, returned: none
> > +error: flags mismatch for input @ ibm/Basic-Types-Inputs.fptest:26170:
> > +b32b64cff =0 S -> Q i
> 
> SNaN conversion from 32 bit to 64 bit. Here I agree
> with the test -- we should quieten the NaN and raise
> Invalid -- which implies that the hardware is wrong ?!?

This passes on an Intel host, and fails on both Power7 and 8 hosts I have
access to. I don't have the Power ISA spec in front of me, but I hope
there's something about this specified in it.

		E.
