Received: from eggs.gnu.org ([2001:4830:134:3::10]:60270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em3bG-000689-Pd
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1em3bE-0008W1-4F
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 15:24:18 -0500
References: <1518629505-22480-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a9ac3ae-5974-f462-7321-9ae2ad5b78ae@redhat.com>
Date: Wed, 14 Feb 2018 14:23:58 -0600
MIME-Version: 1.0
In-Reply-To: <1518629505-22480-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Add missing space when using
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 02/14/2018 11:31 AM, Thomas Huth wrote:
> When running configure with --with-pkgversion=foo there is no
> space anymore between the version number and the parentheses:
> 
> $ m68k-softmmu/qemu-system-m68k -version
> QEMU emulator version 2.11.50(foo)
> 
> Fix it by moving the space from the configure script to the Makefile.
> 
> Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
> Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Makefile  | 2 +-
>   configure | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 4ec7a3c..41adbc9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -369,7 +369,7 @@ qemu-version.h: FORCE
>   		(cd $(SRC_PATH); \
>   		printf '#define QEMU_PKGVERSION '; \
>   		if test -n "$(PKGVERSION)"; then \
> -			printf '"$(PKGVERSION)"\n'; \
> +			printf '" ($(PKGVERSION))"\n'; \

I would argue that putting a space here is awkward; wouldn't it instead 
be easier to have all CLIENTS of QEMU_PKGVERSION in the source code 
assume that the macro does NOT have a leading space, and to supply a 
space themselves?

That is, change THESE locations:

bsd-user/main.c:    printf("qemu-" TARGET_NAME " version " QEMU_VERSION 
QEMU_PKGVERSION
linux-user/main.c:    printf("qemu-" TARGET_NAME " version " 
QEMU_VERSION QEMU_PKGVERSION
qemu-img.c:#define QEMU_IMG_VERSION "qemu-img version " QEMU_VERSION 
QEMU_PKGVERSION \
qemu-io.c:            printf("%s version " QEMU_VERSION QEMU_PKGVERSION "\n"
qemu-nbd.c:"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
qga/main.c:"QEMU Guest Agent " QEMU_VERSION QEMU_PKGVERSION "\n"
scsi/qemu-pr-helper.c:"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
ui/cocoa.m:    @"QEMU emulator version %s%s", QEMU_VERSION, 
QEMU_PKGVERSION];
vl.c:    printf("QEMU emulator version " QEMU_VERSION QEMU_PKGVERSION "\n"

to instead supply the missing space, and have configure/Makefile always 
generate without a leading space.

> +++ b/configure
> @@ -1162,7 +1162,7 @@ for opt do
>     ;;
>     --disable-blobs) blobs="no"
>     ;;
> -  --with-pkgversion=*) pkgversion=" ($optarg)"
> +  --with-pkgversion=*) pkgversion="$optarg"

Hmm - here you're changing who supplies the ().  But that argues that 
maybe the callsites should supply " (" and ")" themselves.

Here's how coreutils does it, by using gnulib's version-etc module:

src/local.mk:     $(AM_V_at)printf 'char const *Version = 
"$(PACKAGE_VERSION)";\n' >> $@t

src/system.h:    version_etc (stdout, Program_name, PACKAGE_NAME, 
Version, Authors,

version_etc_arn (FILE *stream,
                  const char *command_name, const char *package,
                  const char *version,
                  const char * const * authors, size_t n_authors)
{
   if (command_name)
     fprintf (stream, "%s (%s) %s\n", command_name, package, version);

which means that the Makefile magic outputs JUST the text that goes 
inside the (), and the callsite that outputs version information is what 
supplies the " (" and ")".

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
