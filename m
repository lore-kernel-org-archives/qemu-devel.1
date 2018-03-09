Received: from eggs.gnu.org ([2001:4830:134:3::10]:51092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euGFf-0003rc-MV
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euGFa-0005W3-Od
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:31:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1euGFa-0005Vs-Jw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:31:50 -0500
References: <20180309110152.16109-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <00dbd8a1-01a4-15b2-28a8-4b43922e8cfc@redhat.com>
Date: Fri, 9 Mar 2018 12:31:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180309110152.16109-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: try improve handling of clang
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 09.03.2018 12:01, Gerd Hoffmann wrote:
> This patch disables the pragma diagnostic -Wunused-but-set-variable for
> clang in util/coroutine-ucontext.c.
> 
> This in turn allows us to remove it from the configure check, so the
> CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE will succeed for clang.
> 
> With that in place clang builds (linux) will use -Werror by default,
> which breaks the build due to warning about unaligned struct members.
> 
> Given that our structs are often dictated by the hardware qemu emulates
> and the file formats we use this can't be fixed easily, so I think it is
> reasonaable to turn off this warning.  Do so by adding
> -Wno-address-of-packed-member to our list of warning flags.
> 
> Now clang builds qemu without warnings.  Well, almost.  There are some
> left in the rdma code.  Leaving that to the rdma people.  All others can
> use --disable-rdma to workarounds this.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure                 | 2 +-
>  util/coroutine-ucontext.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 6f3921c02a..5e4310b910 100755
> --- a/configure
> +++ b/configure
> @@ -1692,6 +1692,7 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>  gcc_flags="-Wno-string-plus-int $gcc_flags"
> +gcc_flags="-Wno-address-of-packed-member $gcc_flags"

Since the warning is sometimes also a good idea ... maybe it would
rather be better to use -Wno-error=address-of-packed-member instead?

Anyway, with or without that change:

Reviewed-by: Thomas Huth <thuth@redhat.com>
