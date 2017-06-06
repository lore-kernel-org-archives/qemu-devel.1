Received: from eggs.gnu.org ([2001:4830:134:3::10]:51572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dI7BE-0002qM-FY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dI7BD-0007wt-GV
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:37:24 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dI7BD-0007vF-9e
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:37:23 -0400
Received: by mail-it0-x243.google.com with SMTP id d68so25825538ita.1
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 22:37:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496702979-26132-4-git-send-email-cota@braap.org>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-4-git-send-email-cota@braap.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 6 Jun 2017 01:36:50 -0400
Message-ID: <CAJhHMCBkf7dhNJpZ37U5j3TfPqQPUOfYaE9=ZXeM1wsR3OWMBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 5, 2017 at 6:49 PM, Emilio G. Cota <cota@braap.org> wrote:
> Allocating an arbitrarily-sized array of tbs results in either
> (a) a lot of memory wasted or (b) unnecessary flushes of the code
> cache when we run out of TB structs in the array.
>
> An obvious solution would be to just malloc a TB struct when needed,
> and keep the TB array as an array of pointers (recall that tb_find_pc()
> needs the TB array to run in O(log n)).
>
> Perhaps a better solution, which is implemented in this patch, is to
> allocate TB's right before the translated code they describe. This
> results in some memory waste due to padding to have code and TBs in
> separate cache lines--for instance, I measured 4.7% of padding in the
> used portion of code_gen_buffer when booting aarch64 Linux on a
> host with 64-byte cache lines. However, it can allow for optimizations
> in some host architectures, since TCG backends could safely assume that
> the TB and the corresponding translated code are very close to each
> other in memory. See this message by rth for a detailed explanation:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05172.html
>   Subject: Re: GSoC 2017 Proposal: TCG performance enhancements
>   Message-ID: <1e67644b-4b30-887e-d329-1848e94c9484@twiddle.net>

Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

Thanks for doing this Emilio. Do you plan to continue working on rth's
suggestions in that email? If so, can we co-ordinate our work?

-- 
Pranith
