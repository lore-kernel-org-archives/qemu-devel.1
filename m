Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8Nf0-0002k5-EU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8Nez-0004LW-Ko
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:48:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8Nez-0004LB-8Q
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:48:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id q50so8109373otd.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 03:48:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538734535-7483-1-git-send-email-thuth@redhat.com>
References: <1538734535-7483-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 11:48:19 +0100
Message-ID: <CAFEAcA8pAJbEon93xHs3x6j-kXHaTps0eu=obDr2b6-n1qSuWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Compile only once,
 not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 5 October 2018 at 11:15, Thomas Huth <thuth@redhat.com> wrote:
> The generic-loader is currently compiled target specific due to one
> single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We've already
> got a function called target_words_bigendian() for this instead, so
> we can put the generic-loader into common-obj to save some compilation
> time.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  exec.c                   | 1 -
>  hw/core/Makefile.objs    | 2 +-
>  hw/core/generic-loader.c | 6 +-----
>  hw/virtio/virtio.c       | 1 -
>  include/qom/cpu.h        | 2 ++
>  qom/cpu.c                | 1 -
>  6 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index d0821e6..3ae0e54 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3910,7 +3910,6 @@ int qemu_target_page_bits_min(void)
>   * A helper function for the _utterly broken_ virtio device model to find out if
>   * it's running on a big endian machine. Don't do this at home kids!
>   */
> -bool target_words_bigendian(void);
>  bool target_words_bigendian(void)
>  {
>  #if defined(TARGET_WORDS_BIGENDIAN)

> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -1085,6 +1085,8 @@ void cpu_exec_initfn(CPUState *cpu);
>  void cpu_exec_realizefn(CPUState *cpu, Error **errp);
>  void cpu_exec_unrealizefn(CPUState *cpu);
>
> +bool target_words_bigendian(void);
> +

Can we have a doc comment for a new global function in a header
file, please? In particular this one needs a big health warning
that using it is almost always the wrong thing (compare the
comment in the .c file).

thanks
-- PMM
