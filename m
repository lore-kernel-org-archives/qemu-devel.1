Received: from eggs.gnu.org ([2001:4830:134:3::10]:44252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb8bw-0006Gv-PK
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb8bs-00005q-NE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:31:52 -0500
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:42784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb8bs-0008W5-GX
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:31:48 -0500
Received: by mail-pl0-x232.google.com with SMTP id bd8so4183775plb.9
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:31:48 -0800 (PST)
References: <1515562748-32287-1-git-send-email-rth@twiddle.net>
	<CAFEAcA8TxNTjvsqeHss=7BEm6SzwLHZ54UqDmOPMWA5z0oTsUA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2706dc83-cf36-31e9-71d7-ec7ca0cecff0@linaro.org>
Date: Mon, 15 Jan 2018 09:31:43 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8TxNTjvsqeHss=7BEm6SzwLHZ54UqDmOPMWA5z0oTsUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/arm: Fix double-word comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 01/15/2018 06:27 AM, Peter Maydell wrote:
> We could avoid the annoying "load LE/GE immediates to tempreg"
> extra code by having tcg_out_cmp2() return a flag to tell
> the caller which way round to put the conditions for its two
> conditional ARITH_MOV insns (for setcond2) or which condition
> to use for the branch (brcond2), right?

No.

We do return a condition to use for the user.  When we do the LE/GT load
immediates to temp path, we do apply tcg_cond_swap(cond), which converts the
condition as for swapped arguments, i.e. to GE/LT.

But we can't *not* swap the arguments to the generated comparison.  Otherwise
we're computing the wrong thing.


r~
