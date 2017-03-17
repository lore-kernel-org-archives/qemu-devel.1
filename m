Received: from eggs.gnu.org ([2001:4830:134:3::10]:38571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cosZY-0000xY-UC
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cosZV-0003ZH-PW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:09:40 -0400
References: <20170316090048.23185-1-jordan.l.justen@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a5007f28-f936-0a92-be74-c131cd527ee0@redhat.com>
Date: Fri, 17 Mar 2017 15:09:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170316090048.23185-1-jordan.l.justen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu: Fix -version with configure
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jordan Justen <jordan.l.justen@intel.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, 1673373@bugs.launchpad.net, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

On 16.03.2017 10:00, Jordan Justen wrote:
> This appears to have regressed in 67a1de0d19.
> 
> When the configure --with-pkgversion=foo option is used, the output
> from -version will look like:
> 
> QEMU emulator version 2.8.90(foo)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> 
> After this patch, it will be:
> 
> QEMU emulator version 2.8.90 (foo)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Fixes: https://bugs.launchpad.net/bugs/1673373
> Cc: 1673373@bugs.launchpad.net
> Signed-off-by: Jordan Justen <jordan.l.justen@intel.com>
> ---
>  Makefile  | 2 +-
>  configure | 2 +-
>  vl.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1c4c04f6f2..c9df119798 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -289,7 +289,7 @@ qemu-version.h: FORCE
>  			printf '"$(PKGVERSION)"\n'; \
>  		else \
>  			if test -d .git; then \
> -				printf '" ('; \
> +				printf '"('; \
>  				git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
>  				if ! git diff-index --quiet HEAD &>/dev/null; then \
>  					printf -- '-dirty'; \
> diff --git a/configure b/configure
> index 99d8bece70..e94b06b5fc 100755
> --- a/configure
> +++ b/configure
> @@ -1004,7 +1004,7 @@ for opt do
>    ;;
>    --disable-blobs) blobs="no"
>    ;;
> -  --with-pkgversion=*) pkgversion=" ($optarg)"
> +  --with-pkgversion=*) pkgversion="($optarg)"
>    ;;
>    --with-coroutine=*) coroutine="$optarg"
>    ;;
> diff --git a/vl.c b/vl.c
> index 0b4ed5241c..3e60e61905 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1904,7 +1904,7 @@ static void main_loop(void)
>  
>  static void version(void)
>  {
> -    printf("QEMU emulator version " QEMU_VERSION QEMU_PKGVERSION "\n"
> +    printf("QEMU emulator version " QEMU_VERSION " " QEMU_PKGVERSION "\n"
>             QEMU_COPYRIGHT "\n");
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
