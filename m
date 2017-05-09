Received: from eggs.gnu.org ([2001:4830:134:3::10]:41520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7uOK-0002Q6-4U
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d7uOJ-0003Jk-C0
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:56:44 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:35069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d7uOJ-0003Ja-69
	for qemu-devel@nongnu.org; Mon, 08 May 2017 21:56:43 -0400
Received: by mail-qk0-x22b.google.com with SMTP id a72so51507531qkj.2
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 18:56:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <87pofj8kek.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e3e560d2-c380-0529-181a-b5bf3146650d@twiddle.net>
Date: Mon, 8 May 2017 18:56:33 -0700
MIME-Version: 1.0
In-Reply-To: <87pofj8kek.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 05/08/2017 07:58 AM, Alex Bennée wrote:
> Hi,
> 
> We've got a task coming up to implement half-precision floating point
> (FP16) for ARMv8.2. As you know pretty much all our floating point in
> QEMU is handled by our internal fork of John R. Hauser's BSD SoftFloat
> library. Our current implementation is based on version 2a which doesn't
> support FP16.
> 
> As it happens there has been a new release of SoftFloat recently.
> Version 3 is a complete re-write which made a number of changes, some
> notable ones being:
> 
>    - Complete rewrite, different use license than earlier releases.
>    - Renaming most types and functions, upgrading some algorithms
>      - restructuring the source files, and making SoftFloat into a true library.

But also now using thread-local globals instead of passing in a structure with 
all of the parameters.  So, really, we'd probably wind up touching every 
function if we were to import it.

> So what else can we do?
> 
> We could investigate having both libraries included in QEMU. It seems
> the API has changed quite a bit so that might be possible although there
> would be hackage involved in having two different softfloat.h's
> involved.
> 
> This would be useful if we wanted to take a piecemeal approach to
> updating the library. For example we could just use softfloat3 when we
> need the newer features (e.g. FP16).
> 
> Or we could convert one architecture at a time so each qemu binary links
> against either a version 2 or version 3 softfloat library. Of course
> that does run the risk of permanently holding two versions of softfloat
> in the code if the less maintained guest architectures don't convert
> quickly.

Another possibility is the code that's shared between the linux kernel 
(include/math-emu) and glibc (soft-fp).  The glibc version has support for f16 
while the kernel doesn't.  But the glibc version is LGPL 2.1, which I'd expect 
to be ok.

It is mildly nasty in that it's a collection of macros, but that's how we 
managed really good performance with the compiler tech of 15 years ago.  On the 
other hand, it would be fairly easy to adjust the support macros to achive 
source compatibility with our current code.

Just a thought...


r~
