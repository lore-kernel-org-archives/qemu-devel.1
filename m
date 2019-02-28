Received: from eggs.gnu.org ([209.51.188.92]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzIYF-0001g7-Ly
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzIY0-0007GO-1T
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:04:19 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzIXz-0007DS-7a
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:04:11 -0500
Received: by mail-oi1-x242.google.com with SMTP id x187so16012112oia.7
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 02:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20190228043503.68494-1-aik@ozlabs.ru>
In-Reply-To: <20190228043503.68494-1-aik@ozlabs.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 10:03:55 +0000
Message-ID: <CAFEAcA81zC5yEZWCbdN7qp+reJ8CqTvVX3_zyxzmgSv=hFjXVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH qemu] configure: Enable werror for git
 worktrees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 28 Feb 2019 at 04:36, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> The configure script checks multiple times whether it works in a git
> repository and it does this by "test -e "${source_path}/.git" in 4 cases
> but in one case where it tries to enable werror "-d" is used there which
> fails on git worktrees as .git is a file then and not a directory.
>
> This changes the test to "-e" as other occurrences.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Given that there is this non-obvious pitfall in trying to
hand-code the "are we running from git?" check and that
we do it in five places in configure, that suggests that
we should abstract this out:

sources_in_git() {
    # Note that -d will give the wrong answer for git worktrees
    test -e "$source_path/.git"
}

and then use wherever we're currently checking by hand:
    if sources_in_git && ...

(warning: code not tested at all)

Defining a sources_in_git variable which we set at
the start of the script would work too; no strong preference.

thanks
-- PMM
