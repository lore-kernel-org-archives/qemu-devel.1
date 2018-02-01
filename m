Received: from eggs.gnu.org ([2001:4830:134:3::10]:51244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehAsA-00089t-16
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ehAs4-0007qV-Ds
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:09:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Feb 2018 10:09:27 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180109170113.20768-1-michael@walle.cc>
References: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
	<20180109170113.20768-1-michael@walle.cc>
Message-ID: <1a4554ccbdae089bdb0a0a3ae0799b20@walle.cc>
Subject: Re: [Qemu-devel] [PATCH] lm32: take BQL before writing IP/IM
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Programmingkid <programmingkidx@gmail.com>, qemu-stable@nongnu.org


Hi Peter,

do you apply this patch? Or do I have to send a pull request?

-michael

Am 2018-01-09 18:01, schrieb Michael Walle:
> Writing to these registers may raise an interrupt request. Actually,
> this prevents the milkymist board from starting.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  target/lm32/op_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
> index 30f670eee8..a766a1ece4 100644
> --- a/target/lm32/op_helper.c
> +++ b/target/lm32/op_helper.c
> @@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t 
> dc)
> 
>  void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
>  {
> +    qemu_mutex_lock_iothread();
>      lm32_pic_set_im(env->pic_state, im);
> +    qemu_mutex_unlock_iothread();
>  }
> 
>  void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
>  {
> +    qemu_mutex_lock_iothread();
>      lm32_pic_set_ip(env->pic_state, im);
> +    qemu_mutex_unlock_iothread();
>  }
> 
>  void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)
