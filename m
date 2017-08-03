Received: from eggs.gnu.org ([2001:4830:134:3::10]:38122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddNkj-0005iR-Cc
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddNkg-00061G-Eu
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 17:33:57 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1dc53909-4cd9-2977-1188-d0316165652e@twiddle.net>
Date: Thu, 3 Aug 2017 14:33:50 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/15] target/arm: Tighten up Thumb decode
 where new v8M insns will be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/02/2017 09:43 AM, Peter Maydell wrote:
> Tighten up the T32 decoder in the places where new v8M instructions
> will be:
>  * TT/TTT/TTA/TTAT are in what was nominally LDREX/STREX r15, ...
>    which is UNPREDICTABLE:
>    make the UNPREDICTABLE behaviour be to UNDEF
>  * BXNS/BLXNS are distinguished from BX/BLX via the low 3 bits,
>    which in previous architectural versions are SBZ:
>    enforce the SBZ via UNDEF rather than ignoring it, and move
>    the "ARCH(5)" UNDEF case up so we don't leak a TCG temporary
>  * SG is in the encoding which would be LDRD/STRD with rn = r15;
>    this is UNPREDICTABLE and we currently UNDEF:
>    move this check further up the code so that we don't leak
>    TCG temporaries in the UNDEF case and have a better place
>    to put the SG decode.
> 
> This means that if a v8M binary is accidentally run on v7M
> or if a test case hits something that we haven't implemented
> yet the behaviour will be obvious (UNDEF) rather than obscure
> (plough on treating it as a different instruction).
> 
> In the process, add some comments about the instruction patterns
> at these points in the decode. Our Thumb and ARM decoders are
> very difficult to understand currently, but gradually adding
> comments like this should help to clarify what exactly has
> been decoded when.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
