Received: from eggs.gnu.org ([2001:4830:134:3::10]:52640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZjr-0000L9-7K
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZjn-0004vt-93
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:23:51 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:48128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsZjn-0004vM-1D
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:23:47 -0400
Received: by mail-pf0-x22c.google.com with SMTP id n24so183651pfk.5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:23:46 -0700 (PDT)
References: <20170914134923.2479-1-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c45d5fc-c1a7-b65e-62c6-6e52a956b46f@linaro.org>
Date: Thu, 14 Sep 2017 12:23:43 -0700
MIME-Version: 1.0
In-Reply-To: <20170914134923.2479-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] osdep: Fix ROUND_UP(64-bit, 32-bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, lersek@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

On 09/14/2017 06:49 AM, Eric Blake wrote:
> When using bit-wise operations that exploit the power-of-two
> nature of the second argument of ROUND_UP(), we still need to
> ensure that the mask is as wide as the first argument (done
> by using a ternary to force proper arithmetic promotion).
> Unpatched, ROUND_UP(2ULL*1024*1024*1024*1024, 512U) produces 0,
> instead of the intended 2TiB, because negation of an unsigned
> 32-bit quantity followed by widening to 64-bits does not
> sign-extend the mask.
> 
> Broken since its introduction in commit 292c8e50 (v1.5.0).
> Callers that passed the same width type to both macro parameters,
> or that had other code to ensure the first parameter's maximum
> runtime value did not exceed the second parameter's width, are
> unaffected, but I did not audit to see which (if any) existing
> clients of the macro could trigger incorrect behavior (I found
> the bug while adding a new use of the macro).
> 
> While preparing the patch, checkpatch complained about poor
> spacing, so I also fixed that here and in the nearby DIV_ROUND_UP.
> 
> CC: qemu-trivial@nongnu.org
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: use ternary instead of addition of 0 [Laszlo], improve commit message
> ---
>  include/qemu/osdep.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
