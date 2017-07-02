Received: from eggs.gnu.org ([2001:4830:134:3::10]:60489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTty-0000jp-G8
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTtx-0003Pv-NS
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:42:18 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865801156.17063.15618379976159104550.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <244b5aab-8863-3139-f252-09cc02333eda@twiddle.net>
Date: Sat, 1 Jul 2017 18:42:09 -0700
MIME-Version: 1.0
In-Reply-To: <149865801156.17063.15618379976159104550.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 24/29] target/arm: [tcg,
 a64] Port to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 06:53 AM, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>   target/arm/translate-a64.c |   74 +++++++++++++++++++++++++++-----------------
>   1 file changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 9c870f6d07..586a01a2de 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11244,6 +11244,9 @@ static void aarch64_trblock_init_disas_context(DisasContextBase *dcbase,
>       dc->is_ldex = false;
>       dc->ss_same_el = (arm_debug_target_el(env) == dc->current_el);
>   
> +    dc->next_page_start =
> +        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;

I think a better solution for a fixed-length ISA is to adjust max_insns. 
Perhaps the init_disas_context hook should be able to modify it?

And, while I'm thinking of it -- why is the init_globals hook separate? 
There's nothing in between the two hook calls, and the more modern target front 
ends won't need it.


r~
