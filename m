Received: from eggs.gnu.org ([2001:4830:134:3::10]:57765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epyAS-0001C3-02
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 10:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epyAN-0006YN-Tz
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 10:24:47 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:44171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1epyAN-0006XA-JK
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 10:24:43 -0500
References: <20180219024555.26467-1-shea@shealevy.com>
	<20180223045735.1288-1-shea@shealevy.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1c105562-7933-d6bf-1071-6836ad8b6e40@vivier.eu>
Date: Sun, 25 Feb 2018 16:24:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180223045735.1288-1-shea@shealevy.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: Support f_flags in statfs
 when available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shea Levy <shea@shealevy.com>, qemu-devel@nongnu.org

Le 23/02/2018 à 05:57, Shea Levy a écrit :
> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>  configure                 | 21 +++++++++++++++++++
>  linux-user/syscall.c      |  3 +++
>  linux-user/syscall_defs.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/configure b/configure
> index 913e14839d..91082aa1dc 100755
> --- a/configure
> +++ b/configure
> @@ -5303,6 +5303,23 @@ if compile_prog "" "" ; then
>      have_utmpx=yes
>  fi
>  
> +##########################################
> +# Check for newer fields of struct statfs on Linux
> +
> +if test "$linux_user" = "yes"; then
> +  cat > $TMPC <<EOF
> +#include <sys/vfs.h>
> +
> +int main(void) {
> +  struct statfs fs;
> +  fs.f_flags = 0;
> +  return fs.f_flags;
> +}
> +EOF
> +  if compile_object ; then
> +      have_statfs_flags=yes
> +  fi
> +fi

I don't think you need this.

statfs is provided by glibc and  glibc as a flag to tell code we have
this member:

    _STATFS_F_FLAGS

(see glibc commit:

  3cdaa6adb1 f_flags in Linux statfs implementation.
             (Wed Aug 11 14:07:28 2010 -0700)

since glibc 2.13)

>  ##########################################
>  # checks for sanitizers
>  
> @@ -6518,6 +6535,10 @@ if test "$have_utmpx" = "yes" ; then
>    echo "HAVE_UTMPX=y" >> $config_host_mak
>  fi
>  
> +if test "$have_statfs_flags" = "yes" ; then
> +  echo "HAVE_STATFS_FLAGS=y" >> $config_host_mak
> +fi
> +
>  if test "$ivshmem" = "yes" ; then
>    echo "CONFIG_IVSHMEM=y" >> $config_host_mak
>  fi
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 82b35a6bdf..77481eca2c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9534,6 +9534,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
>              __put_user(stfs.f_namelen, &target_stfs->f_namelen);
>              __put_user(stfs.f_frsize, &target_stfs->f_frsize);
> +#ifdef HAVE_STATFS_FLAGS

#ifdef _STATFS_F_FLAGS

> +            __put_user(stfs.f_flags, &target_stfs->f_flags);

I think you should define f_flags in target_statfs unconditionally (see
below), so you should clear target_stfs->f_flags if host kernel doesn't
support it:
glibc will check for "ST_VALID" flag to see if this field is implemented
by the kernel, and we must be sure in this case it is not set.

> +#endif
>              memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
>              unlock_user_struct(target_stfs, arg2, 1);
>          }
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index a35c52a60a..64aa49d3c5 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -362,7 +362,14 @@ struct kernel_statfs {
>  	int f_ffree;
>          kernel_fsid_t f_fsid;
>  	int f_namelen;
> +#ifdef HAVE_STATFS_FLAGS
> +	int f_frsize;
> +	int f_flags;
> +	int f_spare[4];
> +#else
>  	int f_spare[6];
> +#endif
> +
>  };

I think the kernel_statfs structure can be removed totally, as it is not
used anymore since:

    56c8f68f1d statfs fix (Mon Nov 28 22:28:41 2005)

>  
>  struct target_dirent {
> @@ -2223,7 +2230,12 @@ struct target_statfs {

I think you can update unconditionally all target_statfs to be in sync
with current kernel structures, that have been updated by:

  commit 365b18189789bfa1acd9939e6312b8a4b4577b28
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Wed Jul 7 18:53:25 2010 +0200

    add f_flags to struct statfs(64)

    Add a flags field to help glibc implementing statvfs(3) efficiently.

    We copy the flag values from glibc, and add a new ST_VALID flag to
    denote that f_flags is implemented.

Thanks,
Laurent
