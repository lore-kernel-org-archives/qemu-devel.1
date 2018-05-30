Received: from eggs.gnu.org ([2001:4830:134:3::10]:50491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO83b-0002PN-R5
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fO83Y-0004yf-N5
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:50:55 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fO83Y-0004y9-GH
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:50:52 -0400
Received: by mail-pg0-x241.google.com with SMTP id e21-v6so8671674pgv.0
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 13:50:52 -0700 (PDT)
References: <20180529234409.27023-1-evgreen@chromium.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a436fff7-76a3-976b-a5bc-492d1cf054fa@linaro.org>
Date: Wed, 30 May 2018 13:50:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180529234409.27023-1-evgreen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Fix hang with -L and symlink loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Evan Green <evgreen@chromium.org>, qemu-devel@nongnu.org

On 05/29/2018 04:44 PM, Evan Green wrote:
> When using -L with Linux app emulation, there is an issue in
> init_paths where Qemu will get lost exploring a directory tree
> with a symlink loop in it. This causes Qemu to hang, and
> eventually consume all memory in the system.
> 
> Qemu's code for pre-exploring the entire directory tree is both
> error-prone and slow. Instead, this changes uses faccessat, which
> both avoids the symlink loop (since the entire directory space isn't
> being explored up front), and likely speeds things up a bit.
> 
> Partial credit goes to Richard Henderson, as it was only after staring
> at his patch [1] that I wrote mine.
> 
> [1] https://patchwork.kernel.org/patch/9512083/
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

I like this as an improvement on the current situation.
Perhaps folks do like this a bit better than my more invasive patch.

> +int pathprefixfd = -1;
> +__thread char gluedpath[PATH_MAX];

static for both, otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
