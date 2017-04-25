Received: from eggs.gnu.org ([2001:4830:134:3::10]:60416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yO9-00075k-JP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yO8-00088W-Oe
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:12:09 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-9-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4415f093-84b7-6dfe-43c7-524507cfa41b@twiddle.net>
Date: Tue, 25 Apr 2017 13:11:59 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-9-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/13] target/arm: optimize cross-page
 block chaining in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/25/2017 09:53 AM, Emilio G. Cota wrote:
> Instead of unconditionally exiting to the exec loop, use the
> lookup_tb_ptr helper to jump to the target if it is valid.
> As long as the hit rate in tb_jmp_cache remains high, this
> will improve performance.
> 
> Perf impact: see the next commit's log.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   target/arm/translate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index e32e38c..574cf70 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -4085,8 +4085,12 @@ static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
>           gen_set_pc_im(s, dest);
>           tcg_gen_exit_tb((uintptr_t)s->tb + n);
>       } else {
> +        TCGv_ptr ptr = tcg_temp_new_ptr();
> +
>           gen_set_pc_im(s, dest);
> -        tcg_gen_exit_tb(0);
> +        gen_helper_lookup_tb_ptr(ptr, cpu_env, cpu_R[15]);
> +        tcg_gen_goto_ptr(ptr);
> +        tcg_temp_free_ptr(ptr);
>       }

This does not compile for aarch64.  You need to tcg_gen_extu_i32_tl first.


r~
