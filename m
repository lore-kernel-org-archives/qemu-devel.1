Received: from eggs.gnu.org ([2001:4830:134:3::10]:51423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7dRm-0004Ta-GI
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7dK7-0000BK-1D
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:20:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7dK6-0000Av-PF
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 05:20:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so2635717wru.9
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 02:20:02 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d82eb933-48c7-25b9-9948-cf0354e27813@redhat.com>
Date: Wed, 3 Oct 2018 11:20:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/13] target/arm: Add v8M stack checks for
 Thumb push/pop
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

On 02/10/2018 18:35, Peter Maydell wrote:
> Add v8M stack checks for the 16-bit Thumb push/pop
> encodings: STMDB, STMFD, LDM, LDMIA, LDMFD.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/translate.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 65df8d6975c..ef64d2559de 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -12251,7 +12251,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>              store_reg(s, rd, tmp);
>              break;
>          case 4: case 5: case 0xc: case 0xd:
> -            /* push/pop */
> +            /*
> +             * 0b1011_x10x_xxxx_xxxx
> +             *  - push/pop
> +             */
>              addr = load_reg(s, 13);
>              if (insn & (1 << 8))
>                  offset = 4;
> @@ -12264,6 +12267,17 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>              if ((insn & (1 << 11)) == 0) {
>                  tcg_gen_addi_i32(addr, addr, -offset);
>              }
> +
> +            if (s->v8m_stackcheck) {
> +                /*
> +                 * Here 'addr' is the lower of "old SP" and "new SP";
> +                 * if this is a pop that starts below the limit and ends
> +                 * above it, it is UNKNOWN whether the limit check triggers;
> +                 * we choose to trigger.
> +                 */
> +                gen_helper_v8m_stackcheck(cpu_env, addr);
> +            }
> +
>              for (i = 0; i < 8; i++) {
>                  if (insn & (1 << i)) {
>                      if (insn & (1 << 11)) {
> 
