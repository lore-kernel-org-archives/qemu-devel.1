Received: from eggs.gnu.org ([2001:4830:134:3::10]:35388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cc3EW-00078f-8u
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cc3EV-00017b-BH
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:54:56 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cc3EV-00017U-6D
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 23:54:55 -0500
Received: by mail-oi0-x244.google.com with SMTP id u143so1802838oif.3
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 20:54:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170210014519.12413-1-bobby.prani@gmail.com>
References: <20170210014519.12413-1-bobby.prani@gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 9 Feb 2017 23:54:24 -0500
Message-ID: <CAJhHMCBNYHMcgz50s+sWgp0O6Y2=L6yzT8KmeEhzs9a9G_aODw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Thu, Feb 9, 2017 at 8:45 PM, Pranith Kumar <bobby.prani@gmail.com> wrote=
:
>
> The current method of executing atomic code in a guest uses
> cpu_exec_step_atomic() from the outermost loop. This causes an abort()
> when single stepping over atomic code since debug exception longjmp
> will point to the the setlongjmp in cpu_exec(). Another issue with
> this mechanism is that the flags which were set in atomic execution
> will be lost since we do not call cpu_exec_enter().
>
> The following patch moves atomic exception handling to the exception
> handler where all these issues are taken care of. The change in
> start_exclusive() is necessary since now the cpu in atomic execution
> will have its running flag set, but we do not want to count it as
> pending.
>
> Thanks to Alex for helping me debug the issue.
>
> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  cpu-exec.c    | 2 ++
>  cpus-common.c | 2 +-
>  cpus.c        | 4 ----
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/cpu-exec.c b/cpu-exec.c
> index b0ddada8c1..dceacfc5dd 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -427,6 +427,8 @@ static inline bool cpu_handle_exception(CPUState *cpu=
, int *ret)
>              *ret =3D cpu->exception_index;
>              if (*ret =3D=3D EXCP_DEBUG) {
>                  cpu_handle_debug_exception(cpu);
> +            } else if (*ret =3D=3D EXCP_ATOMIC) {
> +                cpu_exec_step_atomic(cpu);
>              }
>              cpu->exception_index =3D -1;
>              return true;


Looks like this is going to be a problem since we should not call
start_exclusive() from cpu_exec() (doh', I just read the comment for
this :-/).

It'll be great if we can make it callable from there. Thoughts?

Thanks,
--=20
Pranith
