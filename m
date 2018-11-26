Received: from eggs.gnu.org ([2001:4830:134:3::10]:40973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRMaX-0002uZ-76
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRMaU-0006K5-1M
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:30:33 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:36408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRMaT-0006Jq-Iq
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:30:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id g9so1873994plo.3
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:30:29 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-24-cota@braap.org> <87lg5f51sz.fsf@linaro.org>
	<e1160c9a-454d-5c55-1295-fb1ab977b2a5@linaro.org>
	<20181126190733.GC6688@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ff01881-3130-ef72-217d-511b4de0cd3c@linaro.org>
Date: Mon, 26 Nov 2018 11:30:25 -0800
MIME-Version: 1.0
In-Reply-To: <20181126190733.GC6688@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 23/48] translator: add plugin_insn argument
 to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

On 11/26/18 11:07 AM, Emilio G. Cota wrote:
> The main reason why I added the qemu_plugin_insn_append calls
> was to avoid reading the instructions twice from guest memory,
> because I was worried that doing so might somehow alter the
> guest's execution, e.g. what if we read a cross-page instruction,
> and both pages mapped to the same TLB entry? We'd end up having
> more TLB misses because instrumentation was enabled.

A better solution for this, I think is to change direct calls from

  cpu_ldl_code(env, pc);
to
  translator_ldl_code(dc_base, env, pc);

instead of passing around a new argument separate from DisasContextBase?


r~
