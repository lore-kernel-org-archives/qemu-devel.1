Received: from eggs.gnu.org ([2001:4830:134:3::10]:36316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDyL-0005Ro-TY
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwDyL-0007g8-25
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 16:57:54 -0400
References: <20170914134923.2479-1-eblake@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <03356889-9fb0-b22a-62b3-496df0ad71dc@msgid.tls.msk.ru>
Date: Sun, 24 Sep 2017 23:57:47 +0300
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

14.09.2017 16:49, Eric Blake wrote:
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

Applied to -trivial, thanks!

/mjt
