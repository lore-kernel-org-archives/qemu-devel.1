Received: from eggs.gnu.org ([2001:4830:134:3::10]:43178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcLi-0004CS-7J
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcLh-0005hO-Ad
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:48:18 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZcLh-0005fv-2O
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:48:17 -0500
Received: by mail-wm0-x235.google.com with SMTP id c85so24822691wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:48:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485744457-10324-3-git-send-email-joserz@linux.vnet.ibm.com>
References: <1485744457-10324-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1485744457-10324-3-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:47:55 +0000
Message-ID: <CAFEAcA-GzRRz1jFj14cjEyXHTmE7RKr=1ocN5JckbNcmOtK9WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu 2/2] risu_ppc64: Compare FPSCR flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 January 2017 at 02:47, Jose Ricardo Ziviani
<joserz@linux.vnet.ibm.com> wrote:
> When running FP operations, FPSCR flag must be compared to make sure
> that any exception will behave consistently.
>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  risu_reginfo_ppc64le.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
> index 4dc509c..ee0e55e 100644
> --- a/risu_reginfo_ppc64le.c
> +++ b/risu_reginfo_ppc64le.c
> @@ -21,6 +21,7 @@
>
>  #define XER 37
>  #define CCR 38
> +#define FPREG 32
>
>  /* reginfo_init: initialize with a ucontext */
>  void reginfo_init(struct reginfo *ri, ucontext_t *uc)
> @@ -82,6 +83,10 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
>          }
>      }
>
> +    if (m->fpregs[FPREG] != a->fpregs[FPREG]) {
> +        return 0;
> +    }
> +
>      for (i = 0; i < 32; i++) {
>          if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
>                  m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
> --

Do we also need to add something to reginfo_dump_mismatch()
to print the mismatching FPSCR values ?

thanks
-- PMM
