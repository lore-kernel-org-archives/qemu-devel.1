Received: from eggs.gnu.org ([2001:4830:134:3::10]:57485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yEJ-0002KJ-VT
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yEJ-00025E-7U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:02:00 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4867e64c-c26d-f71b-2708-c2a3163c20d1@twiddle.net>
Date: Tue, 25 Apr 2017 13:01:48 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/13] tcg: enforce 64-byte alignment of
 TCGContext
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
> This will allow us to prevent cache line false sharing in TCGContext.
> 
> Before:
> $ objdump -t  build/x86_64-linux-user/qemu-x86_64 | grep tcg_ctx
> 00000000003ea820 g     O .bss   00000000000152d8              tcg_ctx
> 
> After:
> $ objdump -t  build/x86_64-linux-user/qemu-x86_64 | grep tcg_ctx
> 00000000003ea880 g     O .bss   0000000000015300              tcg_ctx
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   tcg/tcg.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 6c216bb..5fdbfe3 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -727,7 +727,7 @@ struct TCGContext {
>   
>       uint16_t gen_insn_end_off[TCG_MAX_INSNS];
>       target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
> -};
> +} QEMU_ALIGNED(64);

Let's drop the alignment and structure re-arrangement for now and focus on the 
task of goto_ptr.


r~
