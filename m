Received: from eggs.gnu.org ([2001:4830:134:3::10]:43327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLeyO-0003EU-Qp
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 20:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLeyO-0000K7-1E
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 20:18:48 -0400
Date: Thu, 15 Jun 2017 20:18:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170616001842.GA25056@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727927074.28532.17986481795216498698.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149727927074.28532.17986481795216498698.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 6/6] target: [tcg,
 arm] Port to generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Mon, Jun 12, 2017 at 17:54:30 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  target/arm/translate-a64.c |  346 ++++++++++-----------
>  target/arm/translate.c     |  720 ++++++++++++++++++++++----------------------
>  target/arm/translate.h     |   46 ++-
>  3 files changed, 560 insertions(+), 552 deletions(-)

This one makes my arm-softmmu hang while booting debian. The last line
I see is:

> Freeing unused kernel memory: 300K (80669000 - 806b4000)

Note that this happens even after disabling goto_ptr, so it shouldn't
be related to that feature.

The problem might be with the rebase. For instance, the
hunk below was modified by commit 542b3478a ("armv7m: Replace armv7m.hack
with unassigned_access handler"). Might be a good idea to go over
the latest changes to arm/translate.c. What commit was your last working
version based on?

(snip)
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 96272a9888..06f207a5f6 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> +#else
> +    if (dc->base.pc_next >= 0xfffffff0 && arm_dc_feature(dc, ARM_FEATURE_M)) {
> +        /* We always get here via a jump, so know we are not in a
> +           conditional execution block.  */
> +        gen_exception_internal(EXCP_EXCEPTION_EXIT);
> +        dc->base.jmp_type = DJ_EXC;
> +    }
> +#endif
> +}

Thanks,

		Emilio
