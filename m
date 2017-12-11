Received: from eggs.gnu.org ([2001:4830:134:3::10]:60816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eORHn-0006gT-MN
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eORHm-0007uS-Js
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:50:35 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eORHm-0007te-6n
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:50:34 -0500
Received: by mail-ot0-x242.google.com with SMTP id y10so15259139otg.10
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 08:50:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171126211356.GA46174@humpty.home.comstyle.com>
References: <20171126211356.GA46174@humpty.home.comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2017 16:50:12 +0000
Message-ID: <CAFEAcA9K=eaQiVsQH6SfvzriKiwX6C6RT-GZZLFyK=RKS0dZXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Fix curses probe for older
 ncurses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 November 2017 at 21:13, Brad Smith <brad@comstyle.com> wrote:
> Fix the curses probe with older ncurses (.e.g. 5.7, as used by OpenBSD).
>
> ncurses 5.7 requires _XOPEN_SOURCE_EXTENDED to be defined for WACS_* constants.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
>
>
> diff --git a/configure b/configure
> index 0c6e7572db..9715b9c2cc 100755
> --- a/configure
> +++ b/configure
> @@ -3186,7 +3186,7 @@ EOF
>    IFS=:
>    for curses_inc in $curses_inc_list; do
>      # Make sure we get the wide character prototypes
> -    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
> +    curses_inc="-DNCURSES_WIDECHAR -D_XOPEN_SOURCE_EXTENDED $curses_inc"
>      IFS=:
>      for curses_lib in $curses_lib_list; do
>        unset IFS

Having thought about this a bit more, I think I'm definitely not
happy with defining _XOPEN_SOURCE_EXTENDED by default for every
host OS. I think we should either:
 (a) define it only for OpenBSD in the per-host case statement
in configure, with a note that we're doing it to work around the
supplied ncurses version being ancient
 (b) just say that if you want this optional QEMU feature you need
a version of ncurses that was released this decade

To be honest I'd favour (b): there are limits to how much
we need to support adventures in retrocomputing.

thanks
-- PMM
