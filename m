Received: from eggs.gnu.org ([209.51.188.92]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MNE-0004sd-AQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MCe-00064L-9u
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:46:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1h3MCe-00063u-35
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:46:56 -0400
Received: by mail-pg1-x544.google.com with SMTP id l11so4197240pgq.10
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:46:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190310003428.11723-1-f4bug@amsat.org>
	<20190310003428.11723-3-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0c82bc13-532d-f450-7bd5-df9e36f24d33@twiddle.net>
Date: Mon, 11 Mar 2019 07:46:51 -0700
MIME-Version: 1.0
In-Reply-To: <20190310003428.11723-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] target/m68k: Optimize the partset
 instruction using deposit_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

On 3/9/19 4:34 PM, Philippe Mathieu-Daudé wrote:
>      case OS_BYTE:
> -        tcg_gen_andi_i32(reg, reg, 0xffffff00);
>          tmp = tcg_temp_new();
>          tcg_gen_ext8u_i32(tmp, val);

Might as well elide this as well.

> -        tcg_gen_or_i32(reg, reg, tmp);
> +        tcg_gen_deposit_i32(reg, tmp, reg, 8, 24);
>          tcg_temp_free(tmp);
>          break;
>      case OS_WORD:
> -        tcg_gen_andi_i32(reg, reg, 0xffff0000);
>          tmp = tcg_temp_new();
>          tcg_gen_ext16u_i32(tmp, val);

Likewise.

> -        tcg_gen_or_i32(reg, reg, tmp);
> +        tcg_gen_deposit_i32(reg, tmp, reg, 16, 16);
>          tcg_temp_free(tmp);
>          break;
