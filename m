Received: from eggs.gnu.org ([2001:4830:134:3::10]:48723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcoKn-0008Om-QD
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcoKk-0000aW-Lk
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:49:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fcoKk-0000aD-FR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:49:18 -0400
Date: Tue, 10 Jul 2018 10:49:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180710104914.1ca245db@redhat.com>
In-Reply-To: <1531202789-31006-5-git-send-email-junyan.he@gmx.com>
References: <1531202789-31006-1-git-send-email-junyan.he@gmx.com>
	<1531202789-31006-5-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7 V8] configure: add libpmem support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Tue, 10 Jul 2018 14:06:26 +0800
junyan.he@gmx.com wrote:

> From: Junyan He <junyan.he@intel.com>
> 
> Add a pair of configure options --{enable,disable}-libpmem to control
> whether QEMU is compiled with PMDK libpmem [1].
> 
> QEMU may write to the host persistent memory (e.g. in vNVDIMM label
> emulation and live migration), so it must take the proper operations
> to ensure the persistence of its own writes. Depending on the CPU
> models and available instructions, the optimal operation can vary [2].
> PMDK libpmem have already implemented those operations on multiple CPU
> models (x86 and ARM) and the logic to select the optimal ones, so QEMU
> can just use libpmem rather than re-implement them.
> 
> [1] PMDK (formerly known as NMVL), https://github.com/pmem/pmdk/
pls use document names in addition to links that could be found using search engine

> [2] https://github.com/pmem/pmdk/blob/38bfa652721a37fd94c0130ce0e3f5d8baa3ed40/src/libpmem/pmem.c#L33
it probably would be better to point out a specific specs/chapters
that describe difference. since the link can disappear and line change
so reader of commit message won't have any clue what [2] meant.

> 
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

patch probably should be reordered and placed before 
[PATCH 3/7 V8] hostmem-file: add the 'pmem' option

> ---
>  configure | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/configure b/configure
> index 2a7796e..1c9288b 100755
> --- a/configure
> +++ b/configure
> @@ -475,6 +475,7 @@ vxhs=""
>  libxml2=""
>  docker="no"
>  debug_mutex="no"
> +libpmem=""
>  
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>  cross_cc_aarch64="aarch64-linux-gnu-gcc"
> @@ -1435,6 +1436,10 @@ for opt do
>    ;;
>    --disable-debug-mutex) debug_mutex=no
>    ;;
> +  --enable-libpmem) libpmem=yes
> +  ;;
> +  --disable-libpmem) libpmem=no
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1710,6 +1715,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    vhost-user      vhost-user support
>    capstone        capstone disassembler support
>    debug-mutex     mutex debugging support
> +  libpmem         libpmem support
>  
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -5546,6 +5552,24 @@ if has "docker"; then
>  fi
>  
>  ##########################################
> +# check for libpmem
> +
> +if test "$libpmem" != "no"; then
> +	if $pkg_config --exists "libpmem"; then
> +		libpmem="yes"
> +		libpmem_libs=$($pkg_config --libs libpmem)
> +		libpmem_cflags=$($pkg_config --cflags libpmem)
> +		libs_softmmu="$libs_softmmu $libpmem_libs"
> +		QEMU_CFLAGS="$QEMU_CFLAGS $libpmem_cflags"
> +	else
> +		if test "$libpmem" = "yes" ; then
> +			feature_not_found "libpmem" "Install nvml or pmdk"
> +		fi
> +		libpmem="no"
> +	fi
> +fi
> +
> +##########################################
>  # End of CC checks
>  # After here, no more $cc or $ld runs
>  
> @@ -6010,6 +6034,7 @@ echo "replication support $replication"
>  echo "VxHS block device $vxhs"
>  echo "capstone          $capstone"
>  echo "docker            $docker"
> +echo "libpmem support   $libpmem"
>  
>  if test "$sdl_too_old" = "yes"; then
>  echo "-> Your SDL version is too old - please upgrade to have SDL support"
> @@ -6763,6 +6788,10 @@ if test "$vxhs" = "yes" ; then
>    echo "VXHS_LIBS=$vxhs_libs" >> $config_host_mak
>  fi
>  
> +if test "$libpmem" = "yes" ; then
> +  echo "CONFIG_LIBPMEM=y" >> $config_host_mak
> +fi
> +
>  if test "$tcg_interpreter" = "yes"; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
>  elif test "$ARCH" = "sparc64" ; then
