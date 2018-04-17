Received: from eggs.gnu.org ([2001:4830:134:3::10]:56088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f8VuI-0003W9-13
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f8VuE-0000JO-Kh
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:04:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f8VuE-0000Hr-EU
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:04:42 -0400
Date: Tue, 17 Apr 2018 15:04:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180417190439.GA28717@flamenco>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180416135442.30606-1-alex.bennee@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Mon, Apr 16, 2018 at 14:54:42 +0100, Alex Bennée wrote:
> The re-factoring of div_floats changed the order of checking meaning
> an operation like -inf/0 erroneously raises the divbyzero flag.
> IEEE-754 (2008) specifies this should only occur for operations on
> finite operands.
> 
> We fix this by moving the check on the dividend being Inf/0 to before
> the divisor is zero check.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

I can confirm this fixes the issue -- just checked with a modified
version of fp-test, see below.

Note that in fp-test I am not checking for flags that are raised
when none are expected, because doing so gives quite a few errors.
Just noticed that enabling this check yields 1049 of these errors for
v2.11, and before this patch that number was 1087. After this
patch, it is again brought down to 1049. IOW, the test cases in
fp-test raise exactly the same flags as v2.11, which is good to know.

The 1049 errors are probably false positives -- at least a big
chunk of them should be, given that "-t host" gives even more errors.
I am tempted to keep the flag check and whitelist these errors
though, which would catch regressions such as the one we're fixing here.

Here is the report file with the 1049 failing test cases:
  http://www.cs.columbia.edu/~cota/qemu/fp-test-after-inf-patch.txt

Thanks,

		Emilio
