Received: from eggs.gnu.org ([2001:4830:134:3::10]:43475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGuam-0008Ik-2j
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGual-0007Ly-3Y
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGuak-0007Lj-Th
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:58:47 -0400
References: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <31f800cb-846d-e627-9d1f-f898a0948652@redhat.com>
Date: Fri, 2 Jun 2017 23:58:42 +0200
MIME-Version: 1.0
In-Reply-To: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Define NCURSES_WIDECHAR if
 we're using curses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Chad Joan <chadjoan@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@codingfarm.de>

On 06/02/17 16:35, Peter Maydell wrote:
> We want the wide character functions from the ncurses header.
> Unfortunately it doesn't provide them by default, but only
> if either:
>  * NCURSES_WIDECHAR is defined (for ncurses 20111030 and up)
>  * _XOPEN_SOURCE/_XOPEN_SOURCE_EXTENDED are suitably defined
> 
> So far we have been implicitly relying on the latter, because
> for GNU libc when we define _GNU_SOURCE this causes libc
> to define the _XOPEN_SOURCE macros for us. Unfortunately
> this doesn't work on all libcs, because some (like OSX and
> musl libc) do not define _XOPEN_SOURCE when _GNU_SOURCE
> is defined.
> 
> We can't fix this by defining _XOPEN_SOURCE ourselves, because
> that also means "and don't provide any functions that aren't in
> that standard", and not all libcs provide any way to override
> that to also get the non-standard functions. In particular
> FreeBSD has no such mechanism, and OSX's _DARWIN_C_SOURCE
> doesn't reenable everything (for instance getpagesize()
> is still not prototyped if _DARWIN_C_SOURCE and _XOPEN_SOURCE
> are both defined).
> 
> So we have to define NCURSES_WIDECHAR. (This will only work
> if your ncurses is at least 20111030, as older versions
> don't honour this macro.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Testing from the people with musl libc and OSX-with-ncurses
> appreciated, as I don't have any systems which have the bug
> which this patch is attempting to fix...
> 
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configure b/configure
> index 0586ec9..6aca5d1 100755
> --- a/configure
> +++ b/configure
> @@ -3053,6 +3053,8 @@ int main(void) {
>  EOF
>    IFS=:
>    for curses_inc in $curses_inc_list; do
> +    # Make sure we get the wide character prototypes
> +    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
>      IFS=:
>      for curses_lib in $curses_lib_list; do
>        unset IFS
> 

Given that we're already consciously using non-portable functions, this
solution looks the least messy to me.

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
