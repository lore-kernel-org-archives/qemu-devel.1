Received: from eggs.gnu.org ([2001:4830:134:3::10]:36940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYWE-0003QA-0j
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYW9-0000Uj-3P
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:06:53 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:39138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYW8-0000Tk-Rh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:06:49 -0400
Received: by mail-pg0-x230.google.com with SMTP id w12-v6so3399854pgc.6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:06:48 -0700 (PDT)
References: <20180614015437.GA14538@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99c2d221-7867-4182-c750-6f3806b3ae53@linaro.org>
Date: Thu, 14 Jun 2018 10:06:43 -1000
MIME-Version: 1.0
In-Reply-To: <20180614015437.GA14538@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TCG region page guards and transparent huge pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 06/13/2018 03:54 PM, Emilio G. Cota wrote:
> So, what to do based on all this?
> 
> I think the current implementation makes sense. That said, two
> things we could consider doing are:

Thanks for checking.


> - Remove the guard pages. I'd rather keep them in though, since
>   their cost is negligible in most scenarios. If we really wanted
>   to recover this performance, we could just enable the guards
>   (by calling mprotect) only under TCG_DEBUG.
> 
> - Change tcg_n_regions() to assign larger regions. I am not convinced
>   of this, since at most we'd gain 3% in performance, but we might
>   end up wasting more space (recall that not all vCPUs translate
>   code at the same rate), or flushing more often (probably with
>   a perf impact larger than 3%).

If we change anything at all, my preference would be to simply remove the guard
pages.  We have other asserts that pre-date the guard pages that should prevent
us from tromping on the next region -- the program should have crashed with
SIGABRT before hitting the guard page -- so I'm not especially worried about
dropping them.

And while it doesn't apply to x86-64, other hosts have even huger huge pages,
so IMO it does make sense to prefer a contiguous region when talking about such
a large allocation.

Does anyone else have an opinion here?


r~
