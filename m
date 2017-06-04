Received: from eggs.gnu.org ([2001:4830:134:3::10]:52675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZch-0002P7-6X
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZce-0002x6-2s
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:47:31 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:36109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZcd-0002wa-TD
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:47:28 -0400
Received: by mail-pf0-x231.google.com with SMTP id m17so72760526pfg.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:47:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>
	<1496446763-29756-1-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f768c0b-891f-a3d7-e7c7-b7f741b0a397@twiddle.net>
Date: Sun, 4 Jun 2017 10:47:23 -0700
MIME-Version: 1.0
In-Reply-To: <1496446763-29756-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org

On 06/02/2017 04:39 PM, Emilio G. Cota wrote:
> +    aligned = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, 64);

I would prefer that this and

> +} QEMU_ALIGNED(64);

this both use a define.  We may well have to adjust this for different hosts. 
In particular I'm thinking of PPC64 which would prefer 128.

> +    if (unlikely(!tcg_ctx.tb_ctx.tbs_size)) {
> +        tcg_ctx.tb_ctx.tbs_size = 1024;
> +    }

And I know that you resize this on demand, but surely we can avoid some startup 
slowdown by picking a more reasonable initial estimate here.  Like 32k or 64k.

Otherwise this looks good.  I'll have to have a more detailed look at the 
differences in the generated code later.


r~
