Received: from eggs.gnu.org ([2001:4830:134:3::10]:47769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2zHQ-00042u-D4
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2zHP-0005J5-DA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 08:09:16 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-7-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f90169b-3d23-434a-40de-1e3eec37f64c@twiddle.net>
Date: Tue, 25 Apr 2017 14:09:02 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-7-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/13] tcg: add goto_ptr opcode
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
> +void tcg_gen_goto_ptr(TCGv_ptr ptr)
> +{
> +    if (TCG_TARGET_HAS_goto_ptr) {
> +        tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
> +    } else {
> +        tcg_gen_exit_tb(0);
> +    }
> +}
> +

I think this function should look more like

void tcg_gen_lookup_and_goto_ptr(TCGv target_addr)
{
     if (TCG_TARGET_HAS_goto_ptr) {
         TCGv_ptr ptr = tcg_temp_new_ptr();
         gen_helper_lookup_tb_ptr(ptr, tcg_ctx.tcg_env, addr);
         tcg_gen_op1i(INDEX_op_goto_ptr, GET_TCGV_PTR(ptr));
         tcg_temp_free_ptr(ptr);
     } else {
         tcg_gen_exit_tb(0);
     }
}

since there's not really any point in all targets being exposed to the 
implementation detail of lookup_tb_ptr.


r~
