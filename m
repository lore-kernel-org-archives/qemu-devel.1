Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUxG6-0005wl-8s
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUxG2-0000W6-Be
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:39:30 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUxG2-0000Qa-4T
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:39:26 -0400
Received: by mail-wr0-f176.google.com with SMTP id c11so4160916wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:39:03 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-2-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-2-git-send-email-cota@braap.org>
Date: Tue, 11 Jul 2017 16:37:59 +0100
Message-ID: <87k23f9e7c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/22] vl: fix breakage of -tb-size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Commit e7b161d573 ("vl: add tcg_enabled() for tcg related code") adds
> a check to exit the program when !tcg_enabled() while parsing the -tb-size
> flag.
>
> It turns out that when the -tb-size flag is evaluated, tcg_enabled() can
> only return 0, since it is set (or not) much later by configure_accelerator().
>
> Fix it by unconditionally exiting if the flag is passed to a QEMU binary
> built with !CONFIG_TCG.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  vl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index d17c863..9ece570 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3933,10 +3933,10 @@ int main(int argc, char **argv, char **envp)
>                  configure_rtc(opts);
>                  break;
>              case QEMU_OPTION_tb_size:
> -                if (!tcg_enabled()) {
> -                    error_report("TCG is disabled");
> -                    exit(1);
> -                }
> +#ifndef CONFIG_TCG
> +                error_report("TCG is disabled");
> +                exit(1);
> +#endif
>                  if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
>                      error_report("Invalid argument to -tb-size");
>                      exit(1);


--
Alex Bennée
