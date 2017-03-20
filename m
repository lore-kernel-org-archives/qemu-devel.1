Received: from eggs.gnu.org ([2001:4830:134:3::10]:53438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpyk8-0006pC-KJ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpyk7-00022e-Sp
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:57:08 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpyk7-00022a-MM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:57:07 -0400
Received: by mail-wr0-x22a.google.com with SMTP id u48so94204089wrc.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:57:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
References: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 14:56:45 +0000
Message-ID: <CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hmp: gpa2hva and gpa2hpa hostaddr
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 20 March 2017 at 14:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> These commands are useful when testing machine-check passthrough.
> gpa2hva is useful to inject a MADV_HWPOISON madvise from gdb, while
> gpa2hpa is useful to inject an error with the mce-inject kernel
> module.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hmp-commands.hx |  32 ++++++++++++++++++
>  monitor.c       | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 8819281..0aca984 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -526,6 +526,38 @@ Dump 80 16 bit values at the start of the video memory.
>  ETEXI

I have some comments which feel kind of nit-picky, but since this
is a public-facing HMP API I think they need attention since we only
get one chance to get it right.

>      {
> +        .name       = "gpa2hva",
> +        .args_type  = "addr:l",
> +        .params     = "addr",
> +        .help       = "print the host virtual address corresponding to a guest physical address",
> +        .cmd        = hmp_gpa2hva,
> +    },

How does this work for guest CPUs which have more than one physical
address space (eg ARM TrustZone)? There's no ability here to specify
the secure/nonsecure transaction attribute that you need to distinguish
which kind of guest physical address you're talking about.

The command also doesn't let you specify which CPU you care about,
which is bad because they don't all have to have the same address map.

The documentation should also say what happens if the guest physaddr
doesn't correspond to RAM.

> +#ifdef CONFIG_LINUX
> +    {
> +        .name       = "gpa2hpa",
> +        .args_type  = "addr:l",
> +        .params     = "addr",
> +        .help       = "print the host physical address corresponding to a guest physical address",
> +        .cmd        = hmp_gpa2hpa,
> +    },
> +#endif
> +
> +STEXI
> +@item gpa2hpa @var{addr}
> +@findex gpa2hpa
> +Print the host physical address at which the guest's physical address @var{addr}
> +is mapped.

...what if you're on a system where host RAM exists at multiple host
physical addresses? What if the RAM happens to be paged out?
(Plus the remarks for gpa2hva apply.)

thanks
-- PMM
