Received: from eggs.gnu.org ([209.51.188.92]:59089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPep-00035b-Bg
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPeo-0008Fl-EO
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:26:55 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtPek-00085M-Ki
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:26:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so653718plb.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:26:42 -0800 (PST)
References: <20190211181907.2219-2-svens@stackframe.org>
	<20190211181907.2219-3-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ad863e8-e1b1-7a40-c8a8-ff1555cb9def@linaro.org>
Date: Mon, 11 Feb 2019 20:26:37 -0800
MIME-Version: 1.0
In-Reply-To: <20190211181907.2219-3-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] target/hppa: fix '</<=' conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <rth@twiddle.net>

On 2/11/19 10:19 AM, Sven Schnelle wrote:
>      case 3: /* <= / >        (N | Z / !N & !Z) */
> -        cond = cond_make_0(TCG_COND_LE, res);
> +        tmp = tcg_temp_new();
> +        tcg_gen_xor_reg(tmp, res, sv);
> +        cond = cond_make_0(TCG_COND_LE, tmp);
> +        tcg_temp_free(tmp);
>          break;

So the test here should be (N ^ V) | Z, which is not what you're testing.  I've
fixed this up locally.


r~
