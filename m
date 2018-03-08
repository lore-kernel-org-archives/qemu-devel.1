Received: from eggs.gnu.org ([2001:4830:134:3::10]:52189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eu0WU-0003hW-MC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eu0WP-0001qI-RB
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:44:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eu0WP-0001pq-Ke
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:44:09 -0500
References: <1518692807-25859-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c1674ff-1895-525a-a765-317a30f6f561@redhat.com>
Date: Thu, 8 Mar 2018 19:43:51 +0100
MIME-Version: 1.0
In-Reply-To: <1518692807-25859-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Polish the version strings containing the
 package version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 15/02/2018 12:06, Thomas Huth wrote:
> Since commit 67a1de0d195a there is no space anymore between the
> version number and the parentheses when running configure with
> --with-pkgversion=foo :
> 
>  $ qemu-system-s390x --version
>  QEMU emulator version 2.11.50(foo)
> 
> But the space is included when building without that option
> when building from a git checkout:
> 
>  $ qemu-system-s390x --version
>  QEMU emulator version 2.11.50 (v2.11.0-1494-gbec9c64-dirty)
> 
> The same confusion exists with the "query-version" QMP command.
> Let's fix this by introducing a proper QEMU_FULL_VERSION definition
> that includes the space and parentheses, while the QEMU_PKGVERSION
> should just cleanly contain the package version string itself.
> Note that this also changes the behavior of the "query-version" QMP
> command (the space and parentheses are not included there anymore),
> but that's supposed to be OK since the strings there are not meant
> to be parsed by other tools.
> 
> Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
> Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile              | 20 +++++++++++---------
>  bsd-user/main.c       |  2 +-
>  configure             |  2 +-
>  linux-user/main.c     |  2 +-
>  qemu-img.c            |  2 +-
>  qemu-io.c             |  2 +-
>  qemu-nbd.c            |  2 +-
>  qga/main.c            |  2 +-
>  scsi/qemu-pr-helper.c |  2 +-
>  ui/cocoa.m            |  2 +-
>  vl.c                  |  2 +-
>  11 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b5a6d60..e6afe5c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -367,21 +367,23 @@ all: $(DOCS) $(TOOLS) $(HELPERS-y) recurse-all modules
>  qemu-version.h: FORCE
>  	$(call quiet-command, \
>  		(cd $(SRC_PATH); \
> -		printf '#define QEMU_PKGVERSION '; \
>  		if test -n "$(PKGVERSION)"; then \
> -			printf '"$(PKGVERSION)"\n'; \
> +			pkgvers="$(PKGVERSION)"; \
>  		else \
>  			if test -d .git; then \
> -				printf '" ('; \
> -				git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
> +				pkgvers=$$(git describe --match 'v*' 2>/dev/null | tr -d '\n');\
>  				if ! git diff-index --quiet HEAD &>/dev/null; then \
> -					printf -- '-dirty'; \
> +					pkgvers="$${pkgvers}-dirty"; \
>  				fi; \
> -				printf ')"\n'; \
> -			else \
> -				printf '""\n'; \
>  			fi; \
> -		fi) > $@.tmp)
> +		fi; \
> +		printf "#define QEMU_PKGVERSION \"$${pkgvers}\"\n"; \
> +		if test -n "$${pkgvers}"; then \
> +			printf '#define QEMU_FULL_VERSION QEMU_VERSION " (" QEMU_PKGVERSION ")"\n'; \
> +		else \
> +			printf '#define QEMU_FULL_VERSION QEMU_VERSION\n'; \
> +		fi; \
> +		) > $@.tmp)
>  	$(call quiet-command, if ! cmp -s $@ $@.tmp; then \
>  	  mv $@.tmp $@; \
>  	 else \
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index efef5ff..05aa559 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -649,7 +649,7 @@ void cpu_loop(CPUSPARCState *env)
>  
>  static void usage(void)
>  {
> -    printf("qemu-" TARGET_NAME " version " QEMU_VERSION QEMU_PKGVERSION
> +    printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
>             "\n" QEMU_COPYRIGHT "\n"
>             "usage: qemu-" TARGET_NAME " [options] program [arguments...]\n"
>             "BSD CPU emulator (compiled for %s emulation)\n"
> diff --git a/configure b/configure
> index 913e148..5be086a 100755
> --- a/configure
> +++ b/configure
> @@ -1160,7 +1160,7 @@ for opt do
>    ;;
>    --disable-blobs) blobs="no"
>    ;;
> -  --with-pkgversion=*) pkgversion=" ($optarg)"
> +  --with-pkgversion=*) pkgversion="$optarg"
>    ;;
>    --with-coroutine=*) coroutine="$optarg"
>    ;;
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 7de0e02..dfd4c98 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4068,7 +4068,7 @@ static void handle_arg_strace(const char *arg)
>  
>  static void handle_arg_version(const char *arg)
>  {
> -    printf("qemu-" TARGET_NAME " version " QEMU_VERSION QEMU_PKGVERSION
> +    printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
>             "\n" QEMU_COPYRIGHT "\n");
>      exit(EXIT_SUCCESS);
>  }
> diff --git a/qemu-img.c b/qemu-img.c
> index 56edc15..e56a15d 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -46,7 +46,7 @@
>  #include "crypto/init.h"
>  #include "trace/control.h"
>  
> -#define QEMU_IMG_VERSION "qemu-img version " QEMU_VERSION QEMU_PKGVERSION \
> +#define QEMU_IMG_VERSION "qemu-img version " QEMU_FULL_VERSION \
>                            "\n" QEMU_COPYRIGHT "\n"
>  
>  typedef struct img_cmd_t {
> diff --git a/qemu-io.c b/qemu-io.c
> index f554ab6..b0efa96 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -534,7 +534,7 @@ int main(int argc, char **argv)
>              trace_file = trace_opt_parse(optarg);
>              break;
>          case 'V':
> -            printf("%s version " QEMU_VERSION QEMU_PKGVERSION "\n"
> +            printf("%s version " QEMU_FULL_VERSION "\n"
>                     QEMU_COPYRIGHT "\n", progname);
>              exit(0);
>          case 'h':
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index ed5d9b5..0af0560 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -130,7 +130,7 @@ QEMU_HELP_BOTTOM "\n"
>  static void version(const char *name)
>  {
>      printf(
> -"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
> +"%s " QEMU_FULL_VERSION "\n"
>  "Written by Anthony Liguori.\n"
>  "\n"
>  QEMU_COPYRIGHT "\n"
> diff --git a/qga/main.c b/qga/main.c
> index cb434d8..a877b30 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -218,7 +218,7 @@ static void usage(const char *cmd)
>  {
>      printf(
>  "Usage: %s [-m <method> -p <path>] [<options>]\n"
> -"QEMU Guest Agent " QEMU_VERSION QEMU_PKGVERSION "\n"
> +"QEMU Guest Agent " QEMU_FULL_VERSION "\n"
>  QEMU_COPYRIGHT "\n"
>  "\n"
>  "  -m, --method      transport method: one of unix-listen, virtio-serial,\n"
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 9fe615c..3facbba 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -102,7 +102,7 @@ QEMU_HELP_BOTTOM "\n"
>  static void version(const char *name)
>  {
>      printf(
> -"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
> +"%s " QEMU_FULL_VERSION "\n"
>  "Written by Paolo Bonzini.\n"
>  "\n"
>  QEMU_COPYRIGHT "\n"
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 51db47c..a9e173a 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1330,7 +1330,7 @@ QemuCocoaView *cocoaView;
>      /* Create the version string*/
>      NSString *version_string;
>      version_string = [[NSString alloc] initWithFormat:
> -    @"QEMU emulator version %s%s", QEMU_VERSION, QEMU_PKGVERSION];
> +    @"QEMU emulator version %s", QEMU_FULL_VERSION];
>      [version_label setStringValue: version_string];
>      [superView addSubview: version_label];
>  
> diff --git a/vl.c b/vl.c
> index 2187849..6740c27 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1942,7 +1942,7 @@ static void main_loop(void)
>  
>  static void version(void)
>  {
> -    printf("QEMU emulator version " QEMU_VERSION QEMU_PKGVERSION "\n"
> +    printf("QEMU emulator version " QEMU_FULL_VERSION "\n"
>             QEMU_COPYRIGHT "\n");
>  }
>  
> 

Queued, thanks.

Paolo
