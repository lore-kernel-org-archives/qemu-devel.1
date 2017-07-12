Received: from eggs.gnu.org ([2001:4830:134:3::10]:41962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVQkw-0006Rf-CV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 19:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVQkt-00019t-44
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 19:09:18 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVQks-00019c-Rt
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 19:09:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id m54so4049112qtb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:09:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170712221414.3867-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <507fef62-746c-703e-6b91-5becd7456d9d@twiddle.net>
Date: Wed, 12 Jul 2017 13:08:08 -1000
MIME-Version: 1.0
In-Reply-To: <20170712221414.3867-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: Use ADR for shorter jumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 07/12/2017 12:14 PM, Pranith Kumar wrote:
> Use ADR instruction for shorter jumps.
> 
> I was going through rth's email and realized that I should have done
> this the first time.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>   tcg/aarch64/tcg-target.inc.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 04bc369a92..5121ebc1a1 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -886,12 +886,16 @@ void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
>           i1 = I3206_B | ((offset >> 2) & 0x3ffffff);
>           i2 = NOP;
>       } else {
> -        offset = (addr >> 12) - (jmp_addr >> 12);
> +        if (offset == sextract64(offset, 0, 21)) {
> +            i1 = I3406_ADR;
> +            i2 = NOP;
> +        } else {

This is dead code because it is covered by the direct jump above.
B has a 26-bit range, whereas ADR has a 21-bit range.


r~
