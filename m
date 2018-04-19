Received: from eggs.gnu.org ([2001:4830:134:3::10]:51337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f8yod-0003IM-9C
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 21:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f8yoa-0005hS-4n
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 21:56:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55124 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f8yoZ-0005gv-Uy
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 21:56:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC8D84023112
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 01:56:38 +0000 (UTC)
Date: Thu, 19 Apr 2018 09:56:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180419015631.GE29462@lemon.usersys.redhat.com>
References: <20180418090622.20073-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418090622.20073-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] QemuMutex: support --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 04/18 17:06, Peter Xu wrote:
> We have had some tracing tools for mutex but it's not easy to use them
> for e.g. dead locks.  Let's provide "--enable-debug-mutex" parameter
> when configure to allow QemuMutex to store the last owner that took
> specific lock.  It might be extremely easy to use this tool to debug
> deadlocks since we can directly know who took the lock then as long as
> we can have a gdb attached to the process.
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - fix "--disable-debug-mutex" not working..
> ---
>  configure                   | 10 ++++++++++
>  include/qemu/thread-posix.h |  4 ++++
>  util/qemu-thread-posix.c    |  4 ++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/configure b/configure
> index 0a19b033bc..a80af735b2 100755
> --- a/configure
> +++ b/configure
> @@ -451,6 +451,7 @@ jemalloc="no"
>  replication="yes"
>  vxhs=""
>  libxml2=""
> +debug_mutex="no"
>  
>  supported_cpu="no"
>  supported_os="no"
> @@ -1374,6 +1375,10 @@ for opt do
>    ;;
>    --disable-git-update) git_update=no
>    ;;
> +  --enable-debug-mutex) debug_mutex=yes
> +  ;;
> +  --disable-debug-mutex) debug_mutex=no
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1631,6 +1636,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    crypto-afalg    Linux AF_ALG crypto backend driver
>    vhost-user      vhost-user support
>    capstone        capstone disassembler support
> +  debug-mutex     mutex debugging support
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -5874,6 +5880,7 @@ echo "avx2 optimization $avx2_opt"
>  echo "replication support $replication"
>  echo "VxHS block device $vxhs"
>  echo "capstone          $capstone"
> +echo "mutex debugging   $debug_mutex"
>  
>  if test "$sdl_too_old" = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
> @@ -6602,6 +6609,9 @@ fi
>  if test "$capstone" != "no" ; then
>    echo "CONFIG_CAPSTONE=y" >> $config_host_mak
>  fi
> +if test "$debug_mutex" = "yes" ; then
> +  echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
> +fi
>  
>  # Hold two types of flag:
>  #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
> diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
> index f3f47e426f..fd27b34128 100644
> --- a/include/qemu/thread-posix.h
> +++ b/include/qemu/thread-posix.h
> @@ -12,6 +12,10 @@ typedef QemuMutex QemuRecMutex;
>  
>  struct QemuMutex {
>      pthread_mutex_t lock;
> +#ifdef CONFIG_DEBUG_MUTEX
> +    const char *file;
> +    int line;
> +#endif

These look quite cheap, why we need a configure option to enable it?

>      bool initialized;
>  };
>  
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index b789cf32e9..905a816af6 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -68,6 +68,10 @@ void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
>      if (err)
>          error_exit(err, __func__);
>  
> +#ifdef CONFIG_DEBUG_MUTEX
> +    mutex->file = file;
> +    mutex->line = line;
> +#endif
>      trace_qemu_mutex_locked(mutex, file, line);
>  }
>  
> -- 
> 2.14.3
> 

Fam
