Received: from eggs.gnu.org ([209.51.188.92]:45163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1nR-0007kv-Lb
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1iN-00085t-8K
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:28:04 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1iL-0006mK-7M
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:28:03 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so18426006oif.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-7-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 14:12:48 +0000
Message-ID: <CAFEAcA_cvfL2Sja4WawDAR++Ak85yKo7J=Xy4hzO_ChiFt7mZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/11] target/arm: Reset btype for direct
 branches and syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 10 Jan 2019 at 12:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is all of the non-exception cases of DISAS_NORETURN.

What about the gen_helper_exit_atomic() exit cases ?

> For the rest of the synchronous exceptions, the state of
> SPSR_ELx.BTYPE is CONSTRAINED UNPREDICTABLE.  However, it
> makes more sense to me to have syscalls reset BTYPE.

The advantage of picking the other choice (SPSR_ELx.BTYPE ==
PSTATE.BTYPE) is that it means that the behaviour is identical
for all exceptions (async or sync of any type) and we don't
do the work of clearing the BTYPE field (which will happen
potentially in "normal" guest code if we're not in a guarded page,
I think).

thanks
-- PMM
