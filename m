Received: from eggs.gnu.org ([2001:4830:134:3::10]:37589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhtW-000335-0k
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhtV-00059Y-5z
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:25:10 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ehhtV-00059I-1M
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:25:09 -0500
Received: by mail-qt0-x242.google.com with SMTP id m11so4963794qtn.10
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 12:25:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <8be93dc009d8473294b1adc26657058b8e56a550.1517600250.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a5b70a60-86a3-a757-ecfe-dde7d6456682@amsat.org>
Date: Fri, 2 Feb 2018 17:24:08 -0300
MIME-Version: 1.0
In-Reply-To: <8be93dc009d8473294b1adc26657058b8e56a550.1517600250.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw: register: Run post_write hook
 on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair23@gmail.com

Hi Alistair,

On 02/02/2018 04:38 PM, Alistair Francis wrote:
> Ensure that the post write hook is called during reset. This allows us
> to rely on the post write functions instead of having to call them from
> the reset() function.

This makes sens. Can you add a comment about this new behavior in
include/hw/register.h?

> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

with comment:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  hw/core/register.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 900294b9c4..0741a1af32 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -159,13 +159,21 @@ uint64_t register_read(RegisterInfo *reg, uint64_t re, const char* prefix,
>  
>  void register_reset(RegisterInfo *reg)
>  {
> +    const RegisterAccessInfo *ac;
> +
>      g_assert(reg);
>  
>      if (!reg->data || !reg->access) {
>          return;
>      }
>  
> +    ac = reg->access;
> +
>      register_write_val(reg, reg->access->reset);
> +
> +    if (ac->post_write) {
> +        ac->post_write(reg, reg->access->reset);
> +    }
>  }
>  
>  void register_init(RegisterInfo *reg)
> 
