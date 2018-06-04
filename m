Received: from eggs.gnu.org ([2001:4830:134:3::10]:57321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fPoyO-0003Q6-F8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fPoyL-0004V1-7e
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:52:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fPoyL-0004Tm-27
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:52:29 -0400
Received: by mail-it0-f68.google.com with SMTP id 76-v6so9979583itx.4
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 05:52:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604123043.13985-1-berrange@redhat.com>
References: <20180604123043.13985-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 4 Jun 2018 14:52:27 +0200
Message-ID: <CAMxuvaweLW5kW9q0DXw7=zBD4ikUe2UyTPTGQCiA4oJAYrGf-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: don't splatter terminal settings
 on exit if not previously set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 4, 2018 at 2:30 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> The stdio chardev finalize method calls term_exit() to restore the
> original terminal settings that were saved in the "oldtty" global. If
> the qemu_chr_open_stdio() method exited with an error, we might not have
> any original terminal settings saved in "oldtty" yet.
>
> eg
>
>   $ qemu-system-x86_64 -monitor stdio -daemonize
>   qemu-system-x86_64: -monitor stdio: cannot use stdio with -daemonize
>
> will cause QEMU to splatter the terminal settings with an all-zeros
> "struct termios", with predictably unpleasant results. Fortunately the
> existing "stdio_in_use" flag is suitable witness for whether "oldtty"
> contains settings that need restoring.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-stdio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index d83e60e787..8039e85f64 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -46,8 +46,10 @@ static bool stdio_echo_state;
>
>  static void term_exit(void)
>  {
> -    tcsetattr(0, TCSANOW, &oldtty);
> -    fcntl(0, F_SETFL, old_fd0_flags);
> +    if (stdio_in_use) {
> +        tcsetattr(0, TCSANOW, &oldtty);
> +        fcntl(0, F_SETFL, old_fd0_flags);
> +    }
>  }
>
>  static void qemu_chr_set_echo_stdio(Chardev *chr, bool echo)
> --
> 2.17.0
>
