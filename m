Received: from eggs.gnu.org ([2001:4830:134:3::10]:57521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bandvig@mail.ru>) id 1fEv3f-0005Vd-CF
	for qemu-devel@nongnu.org; Sat, 05 May 2018 07:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bandvig@mail.ru>) id 1fEv3c-0007jn-4j
	for qemu-devel@nongnu.org; Sat, 05 May 2018 07:08:55 -0400
Received: from smtp52.i.mail.ru ([94.100.177.112]:41436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bandvig@mail.ru>) id 1fEv3b-0007ga-Op
	for qemu-devel@nongnu.org; Sat, 05 May 2018 07:08:52 -0400
Message-ID: <B15ADA867F0F4C80905AE77EB13D0F0C@BAndViG>
From: "BAndViG" <bandvig@mail.ru>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
	<20180504054030.24527-2-richard.henderson@linaro.org>
	<20180505051922.GB4501@lianli.shorne-pla.net>
In-Reply-To: <20180505051922.GB4501@lianli.shorne-pla.net>
Date: Sat, 5 May 2018 14:08:37 +0300
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"; reply-type=original
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/13] target-openrisc: Write back result
 before FPE exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

I've read architecture manual again and found that my actual implementation 
differs from it.

How it should be (my updated view, thanks to your note).
The "Exception Processing" chapters stays than "EPCR (no delay slot)" should 
be "Address of next not executed instruction". And there is nothing about 
write-back discard.  It looks like it makes sense taking into account that 
IEEE-754 typically requires to return specially prepared value if an FPE 
occurs. As I remember correctly there are two approaches to compute the 
returned value. On of them is much simpler than another. For example, for 
overflow the value should be just +(-)Inf for simple approach but specially 
re-scaled for more complex one.

How it is implemented in CAPPUCCINO and MAROCCHINO pipes.
It look like till now I haven't been attentively enough. That's why my 
actual implementation follows "Synchronous/precise" approach that is 
write-back is discarded and "EPCR (no delay slot)" <= "Address of 
instruction that caused exception".

Currently I'm focused on implementation snoop-invalidation logic in 
MAROCCHINO and could not estimate when I could change FPE behavior. However, 
I'm voting to keep QEMU algorithms in consistent with actual HW- 
implementation. I remember that there is at list one QEMU to HW 
inconsistency that is implementation SPR_SR_DX. So Linux could run normally 
only in "SPR_SR_DX emulation" mode on HW SoCs. If we implement FPE 
processing in according to architecture manual now we increase number of 
QEMU-vs-HW inconsistencies.

PS. As I'm not a participant of QEMU developers mailing list, the letter 
could be rejected. Fill free to forward the answer there.

BR
Andrey Bacherov


-----Исходное сообщение----- 
From: Stafford Horne
Sent: Saturday, May 05, 2018 8:19 AM
To: Richard Henderson
Cc: qemu-devel@nongnu.org ; Richard Henderson ; bandvig@mail.ru
Subject: Re: [PATCH 01/13] target-openrisc: Write back result before FPE 
exception

On Thu, May 03, 2018 at 10:40:18PM -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
>
> The architecture manual is unclear about this, but the or1ksim
> does writeback before the exception.  This requires splitting
> the helpers in half, with the exception raised by the second.

I dont really see a problem with this, ccing bandvig who did a lot of the 
fpu
hardware implementation in mor1kx.

> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  target/openrisc/helper.h     |  25 +++--
>  target/openrisc/fpu_helper.c | 250 
> +++++++++----------------------------------
>  target/openrisc/translate.c  | 101 ++++++++++-------
>  3 files changed, 125 insertions(+), 251 deletions(-)
> 
