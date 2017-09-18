Received: from eggs.gnu.org ([2001:4830:134:3::10]:40426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtrT7-0007yD-Mn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtrT6-0001z7-Ll
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:31:53 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:50050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtrT6-0001o2-El
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:31:52 -0400
Received: by mail-wm0-x22e.google.com with SMTP id e71so395879wmg.4
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 01:31:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <77c55c6c-3397-5a32-6276-6b88f13fa531@siemens.com>
References: <77c55c6c-3397-5a32-6276-6b88f13fa531@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 09:31:30 +0100
Message-ID: <CAFEAcA_bpija3nfB2URJbsqyGZfkziszFf16Q2U9TkC9HbnAJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] seccomp: Fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 18 September 2017 at 08:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> vl.c includes seccomp.h, thus requires the related CFLAGS as well.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.objs b/Makefile.objs
> index d9cf7ad791..4f1488d65d 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -61,7 +61,7 @@ bt-host.o-cflags := $(BLUEZ_CFLAGS)
>
>  common-obj-y += dma-helpers.o
>  common-obj-y += vl.o
> -vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
> +vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS) $(SECCOMP_CFLAGS)
>  common-obj-y += tpm.o
>
>  common-obj-$(CONFIG_SLIRP) += slirp/

...I get the feeling we're going to get a whole bunch of these
compile errors and fixups as we switch over to trying to specify
package-dependent cflags only on certain source files. Is
there anything we can do to make this changeover more reliable?

In particular I think that just adding a new #include line
to a source file shouldn't suddenly require us to change
the makefile to add a FOO_CFLAGS if we can avoid it. If
it is necessary, then we need to make sure that's a compile
error on all platforms and configurations (including those
where pkg-config happens to set FOO_CFLAGS to the empty string.)

thanks
-- PMM
