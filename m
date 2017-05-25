Received: from eggs.gnu.org ([2001:4830:134:3::10]:51087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzi9-0006st-8r
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dDzi8-00043X-Bg
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:50:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dDzi8-00043L-5u
	for qemu-devel@nongnu.org; Thu, 25 May 2017 16:50:20 -0400
Date: Thu, 25 May 2017 22:50:17 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170525205017.sxbs2jrtvwcwnhbj@aurel32.net>
References: <20170524192246.15905-1-rth@twiddle.net>
	<20170524192246.15905-31-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524192246.15905-31-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 30/33] target/s390x: Fix some helper_ex
 problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-05-24 12:22, Richard Henderson wrote:
> (1) The OR of the low bits or R1 into INSN were not being done
> consistently; it was forgotten along all but the SVC path.

It was done for the logical ops assuming the instruction has the
corresponding byte set to 0, as in that case it matches the length
and is passed directly as an argument to the helper.

> (2) The setting of ILEN was wrong on SVC path for EXRL.
> (3) The data load for ICM read too much.
> 
> Fix these by consolidating data load at the beginning, using
> get_ilen to control the number of bytes loaded, and ORing in
> the byte from R1.  Use extract64 from the full aligned insn
> to extract arguments.
> 
> Pass in ILEN rather than RET as the more natural way to give
> the required data along the SVC path.
> 
> Modify ENV->CC_OP directly rather than include it in the
> functional interface.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h     |   2 +-
>  target/s390x/mem_helper.c | 135 +++++++++++++++++++++++++---------------------
>  target/s390x/translate.c  |   8 +--
>  3 files changed, 78 insertions(+), 67 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
