Received: from eggs.gnu.org ([209.51.188.92]:48813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgxd-0006B0-DV
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgxU-0007pc-Gv
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:43:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gxgxM-0007id-K2
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 18:43:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id v26so4967552wmh.3
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 15:43:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20190223232954.7185-1-richard.henderson@linaro.org>
	<20190223232954.7185-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc2eb4c9-8ea3-1484-3bc8-e358b0ebefba@amsat.org>
Date: Sun, 24 Feb 2019 00:43:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190223232954.7185-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] decodetree: Do not unconditionaly
 return from Pattern.output_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de

On 2/24/19 12:29 AM, Richard Henderson wrote:
> As a consequence, the 'return false' gets pushed up one level.
> 
> This will allow us to perform some other action when the
> translator returns failure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/decodetree.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index fb9a0ab3ad..dd495096fc 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -348,8 +348,8 @@ class Pattern(General):
>              output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
>          for n, f in self.fields.items():
>              output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
> -        output(ind, 'return ', translate_prefix, '_', self.name,
> -               '(ctx, &u.f_', arg, ');\n')
> +        output(ind, 'if (', translate_prefix, '_', self.name,
> +               '(ctx, &u.f_', arg, ')) return true;\n')
>  # end Pattern
>  
>  
> @@ -777,8 +777,8 @@ class Tree:
>              output(ind, '    /* ',
>                     str_match_bits(innerbits, innermask), ' */\n')
>              s.output_code(i + 4, extracted, innerbits, innermask)
> +            output(ind, '    return false;\n')
>          output(ind, '}\n')
> -        output(ind, 'return false;\n')
>  # end Tree
>  
>  
> @@ -932,6 +932,7 @@ def main():
>      output(i4, '} u;\n\n')
>  
>      t.output_code(4, False, 0, 0)
> +    output(i4, 'return false;\n')
>  
>      output('}\n')
>  
> 
