Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <julia.lawall@lip6.fr>) id 1d9LfZ-0008VK-N6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <julia.lawall@lip6.fr>) id 1d9LfW-0004tp-H1
	for qemu-devel@nongnu.org; Fri, 12 May 2017 21:16:29 -0400
Date: Sat, 13 May 2017 09:16:10 +0800 (SGT)
From: Julia Lawall <julia.lawall@lip6.fr>
In-Reply-To: <20170512233843.27713-1-f4bug@amsat.org>
Message-ID: <alpine.DEB.2.20.1705130915020.3152@hadrien>
References: <20170512233843.27713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [Qemu-devel] [RFC PATCH v4 0/6] optimize various tcg_gen()
 functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Elfring <elfring@users.sourceforge.net>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>



On Fri, 12 May 2017, Philippe Mathieu-Daudé wrote:

> * Changes from v3
>
> Tried to fix wrong previous attempt...
> After getting some nice/fast pieces of advice from Coccinelle folks, I tried to
> improved the script (not much inline documentation yet although).
> - correctly check if this optimizable?
> - document as Mersenne number instead of prime (Eric Blake)
> - try to write Python code instead of BASIC (Markus Elfring advices)
> - try to reduce regex usage
> - try to match shri(); unrelated(); andi(); pattern to optimize, I was surprised
>   to see the alpha diff Coccinelle found.
>
> This is surely not the last version of this patchset, but I think now the
> generated patches are correct and I prefer reviewers to look at them fixed
> instead of wrong one in the ML.
> Still lot of work to do in the cocci script, now it seems to hang trying to
> parse "target/arm/translate.c".

Try using the arguments --debug and --show-trying.  This will help you see
what rule it is stuck on, and what function.  If the function is just very
complicated and the file is not important for transforming, you may just
want to give up, by adding eg --timeout 120.

julia


>
> * [v3] (v2 was a resend of the cocci script):
>
> In my first attempt I misunderstood tcg_gen_extract() intrinsics, and Richard
> Henderson pointed that out.
> In this patchset the cocci script is corrected and clarified, it also print how
> arguments are checked while running.
> Also:
> - incorrect patches have been removed. (Richard Henderson, Nikunj A Dadhania)
> - Coccinelle script licensed GPLv2+ (Eric Blake)
> - comment in each commit about how to apply the patch (Eric Blake)
> - added Acked-by for m68k (Laurent Vivier)
> - Cc: Coccinelle developers.
>
> [v1]
>
> While reviewing a commit from Aurelien Jarno where he optimized a TCG generator
> for SH-4 [1] I found the same optimization done on PPC by Nikunj A Dadhania few
> months ago [2].
> After asking on the ML about a cocci script [3] I thought it would be easier to
> learn about Coccinelle.
>
> citing Aurelien Jarno:
>     This doesn't change the generated code on x86, but optimizes it on most
>     RISC architectures and makes the code simpler to read.
>
> I actually applied the script using the following command:
>
> $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
>     --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
>     --macro-file scripts/cocci-macro-file.h \
>     --dir target \
>     --in-place
>
> Please review again! thanks.
>
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01466.html
> [2] http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05211.html
> [3] http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg01499.html
>
> Philippe Mathieu-Daudé (6):
>   coccinelle: add a script to optimize tcg op using tcg_gen_extract()
>   target/alpha: optimize cvtlq() using extract op
>   target/arm: optimize rev16() using extract op
>   target/m68k: optimize bcd_flags() using extract op
>   target/ppc: optimize various functions using extract op
>   target/sparc: optimize various functions using extract op
>
>  scripts/coccinelle/tcg_gen_extract.cocci | 103 +++++++++++++++++++++++++++++++
>  target/alpha/translate.c                 |   3 +-
>  target/arm/translate-a64.c               |   6 +-
>  target/m68k/translate.c                  |   3 +-
>  target/ppc/translate.c                   |  21 +++----
>  target/ppc/translate/vsx-impl.inc.c      |  24 +++----
>  target/sparc/translate.c                 |  15 ++---
>  7 files changed, 127 insertions(+), 48 deletions(-)
>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci
>
> --
> 2.11.0
>
>
