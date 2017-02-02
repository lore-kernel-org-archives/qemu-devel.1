Received: from eggs.gnu.org ([2001:4830:134:3::10]:46392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJ73-0001ly-Ph
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJ70-0007lC-JK
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:15:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZJ70-0007ko-BZ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:15:50 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 745C8804E5
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 15:15:50 +0000 (UTC)
Date: Thu, 2 Feb 2017 15:15:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170202151543.GD4603@work-vm>
References: <20170202150530.1025-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170202150530.1025-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] configure: remove
 --enable-replication/--disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> The replication feature is a small amount of code, does not
> require any external library and unless used does not add
> anything to the guest's attack surface.  Since any extra
> configure option affects maintainability on the other hand
> and is subject to bit rot, I think there is no need to
> make it configurable.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         Sending as RFC to start discussion because I know
>         Dave Gilbert disagrees. :)

Yep!
I started thinking about this for two other cases:
   a) I noticed you'd removed the config for COLO

   b) I was thinking of adding a config to disable old-school
      block migration which we've had downstream for ages.

  I think people like being able to disable features they're not
using in their builds; certainly we do downstream and if we do I don't
see why others won't - perhaps for different reasons.

  While it's true block replication probably doesn't add to the
guest-visible attack surface, if someone was trying to audit
what they were running it would still be something they'd have
to check, and which it's easier if compiled out.

Dave

>  Makefile.objs          |  2 +-
>  block/Makefile.objs    |  2 +-
>  configure              | 11 -----------
>  tests/Makefile.include |  2 +-
>  4 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 01cef86..d834906 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -15,7 +15,7 @@ block-obj-$(CONFIG_POSIX) += aio-posix.o
>  block-obj-$(CONFIG_WIN32) += aio-win32.o
>  block-obj-y += block/
>  block-obj-y += qemu-io-cmds.o
> -block-obj-$(CONFIG_REPLICATION) += replication.o
> +block-obj-y += replication.o
>  
>  block-obj-m = block/
>  
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index c6bd14e..fd099a6 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -24,7 +24,7 @@ block-obj-$(CONFIG_LIBSSH2) += ssh.o
>  block-obj-y += accounting.o dirty-bitmap.o
>  block-obj-y += write-threshold.o
>  block-obj-y += backup.o
> -block-obj-$(CONFIG_REPLICATION) += replication.o
> +block-obj-y += replication.o
>  
>  block-obj-y += crypto.o
>  
> diff --git a/configure b/configure
> index 86fd833..0cb124e 100755
> --- a/configure
> +++ b/configure
> @@ -320,7 +320,6 @@ libssh2=""
>  numa=""
>  tcmalloc="no"
>  jemalloc="no"
> -replication="yes"
>  
>  # parse CC options first
>  for opt do
> @@ -1166,10 +1165,6 @@ for opt do
>    ;;
>    --enable-jemalloc) jemalloc="yes"
>    ;;
> -  --disable-replication) replication="no"
> -  ;;
> -  --enable-replication) replication="yes"
> -  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1402,7 +1397,6 @@ disabled with --disable-FEATURE, default is enabled if available:
>    numa            libnuma support
>    tcmalloc        tcmalloc support
>    jemalloc        jemalloc support
> -  replication     replication support
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -5113,7 +5107,6 @@ echo "NUMA host support $numa"
>  echo "tcmalloc support  $tcmalloc"
>  echo "jemalloc support  $jemalloc"
>  echo "avx2 optimization $avx2_opt"
> -echo "replication support $replication"
>  
>  if test "$sdl_too_old" = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
> @@ -5711,10 +5704,6 @@ if test "$have_rtnetlink" = "yes" ; then
>    echo "CONFIG_RTNETLINK=y" >> $config_host_mak
>  fi
>  
> -if test "$replication" = "yes" ; then
> -  echo "CONFIG_REPLICATION=y" >> $config_host_mak
> -fi
> -
>  if test "$have_af_vsock" = "yes" ; then
>    echo "CONFIG_AF_VSOCK=y" >> $config_host_mak
>  fi
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 33b4f88..77dc08f 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -115,7 +115,7 @@ check-unit-y += tests/test-crypto-xts$(EXESUF)
>  check-unit-y += tests/test-crypto-block$(EXESUF)
>  gcov-files-test-logging-y = tests/test-logging.c
>  check-unit-y += tests/test-logging$(EXESUF)
> -check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
> +check-unit-y += tests/test-replication$(EXESUF)
>  check-unit-y += tests/test-bufferiszero$(EXESUF)
>  gcov-files-check-bufferiszero-y = util/bufferiszero.c
>  check-unit-y += tests/test-uuid$(EXESUF)
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
