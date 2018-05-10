Received: from eggs.gnu.org ([2001:4830:134:3::10]:40907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGlBM-0003g7-KR
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGlBI-0004qY-Ii
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:00:28 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGlBI-0004pr-C3
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:00:24 -0400
Received: by mail-wr0-x241.google.com with SMTP id p18-v6so1942750wrm.1
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 06:00:23 -0700 (PDT)
References: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
	<20180109170113.20768-1-michael@walle.cc>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180109170113.20768-1-michael@walle.cc>
Date: Thu, 10 May 2018 14:00:21 +0100
Message-ID: <87o9hnvf6i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Michael Walle <michael@walle.cc>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org, Programmingkid <programmingkidx@gmail.com>


Michael Walle <michael@walle.cc> writes:

> Writing to these registers may raise an interrupt request. Actually,
> this prevents the milkymist board from starting.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/lm32/op_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
> index 30f670eee8..a766a1ece4 100644
> --- a/target/lm32/op_helper.c
> +++ b/target/lm32/op_helper.c
> @@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t dc)
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


--
Alex Benn=C3=A9e
