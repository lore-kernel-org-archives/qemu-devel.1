Received: from eggs.gnu.org ([2001:4830:134:3::10]:42377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d6mr3-00011B-LE
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d6mr2-00049c-Pl
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:41:45 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1d6mr2-00049M-L6
	for qemu-devel@nongnu.org; Fri, 05 May 2017 19:41:44 -0400
Received: by mail-oi0-x241.google.com with SMTP id w138so549612oiw.3
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 16:41:42 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170505193810.2934-2-eblake@redhat.com>
References: <20170505193810.2934-1-eblake@redhat.com>
	<20170505193810.2934-2-eblake@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 5 May 2017 16:41:11 -0700
Message-ID: <CAKmqyKP8teFMgsmeOtcvkW29+2insp1T2ybmveBmZTwYYxofVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6 1/5] shutdown: Simplify shutdown_signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, May 5, 2017 at 12:38 PM, Eric Blake <eblake@redhat.com> wrote:
> There is no signal 0 (kill(pid, 0) has special semantics to probe whether
> a process is alive), rather than actually sending a signal 0).  So we
> can use the simpler 0, instead of -1, for our sentinel of whether a
> shutdown request due to a signal has happened.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

>
> ---
> v4-v6: no change
> v3: new patch
> ---
>  vl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 42d4bce..f22a3ac 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1598,7 +1598,7 @@ void vm_state_notify(int running, RunState state)
>  }
>
>  static int reset_requested;
> -static int shutdown_requested, shutdown_signal = -1;
> +static int shutdown_requested, shutdown_signal;
>  static pid_t shutdown_pid;
>  static int powerdown_requested;
>  static int debug_requested;
> @@ -1629,7 +1629,7 @@ static int qemu_shutdown_requested(void)
>
>  static void qemu_kill_report(void)
>  {
> -    if (!qtest_driver() && shutdown_signal != -1) {
> +    if (!qtest_driver() && shutdown_signal) {
>          if (shutdown_pid == 0) {
>              /* This happens for eg ^C at the terminal, so it's worth
>               * avoiding printing an odd message in that case.
> @@ -1643,7 +1643,7 @@ static void qemu_kill_report(void)
>                           shutdown_cmd ? shutdown_cmd : "<unknown process>");
>              g_free(shutdown_cmd);
>          }
> -        shutdown_signal = -1;
> +        shutdown_signal = 0;
>      }
>  }
>
> --
> 2.9.3
>
>
