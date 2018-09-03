Received: from eggs.gnu.org ([2001:4830:134:3::10]:53304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwnW0-0004dS-NX
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwnVx-00030u-Dh
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:59:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fwnVx-00030l-8A
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:59:29 -0400
Date: Mon, 3 Sep 2018 12:59:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903115926.GB14377@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-2-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830142708.14311-2-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [RFC 1/6] Add bpf support to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>

On Thu, Aug 30, 2018 at 05:27:03PM +0300, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> This commit adds the bpf header provided by Linux to Qemu.

s/Qemu/QEMU/

> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  MAINTAINERS                     |  5 +++++
>  configure                       | 44 +++++++++++++++++++++++++++++++++++++++++
>  scripts/update-linux-headers.sh |  8 ++++++--
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0fb5f38f9f..bf2619239c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2126,6 +2126,11 @@ F: hw/rdma/*
>  F: hw/rdma/vmw/*
>  F: docs/pvrdma.txt
>  
> +BPF
> +M: Sameeh Jubran <sameeh@daynix.com>
> +S: Maintained
> +F: linux-headers/linux/bpf.h
> +
>  Build and test automation
>  -------------------------
>  Build and test automation
> diff --git a/configure b/configure
> index a8c4094c87..21edaf59aa 100755
> --- a/configure
> +++ b/configure
> @@ -348,6 +348,7 @@ libattr=""
>  xfs=""
>  tcg="yes"
>  membarrier=""
> +bpf="no"

This should really default to "", with the check below
automatically doing the right thing to automatically
enable/disable it.

>  vhost_net="no"
>  vhost_crypto="no"
>  vhost_scsi="no"
> @@ -1173,6 +1174,10 @@ for opt do
>    ;;
>    --enable-membarrier) membarrier="yes"
>    ;;
> +  --disable-bpf) bpf="no"
> +  ;;
> +  --enable-bpf) bpf="yes"
> +  ;;
>    --disable-blobs) blobs="no"
>    ;;
>    --with-pkgversion=*) pkgversion="$optarg"
> @@ -1593,6 +1598,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    brlapi          BrlAPI (Braile)
>    curl            curl connectivity
>    membarrier      membarrier system call (for Linux 4.14+ or Windows)
> +  bpf             bpf system calls (for Linux 3.18+)
>    fdt             fdt device tree
>    bluez           bluez stack connectivity
>    kvm             KVM acceleration support
> @@ -5232,6 +5238,38 @@ else
>  fi
>  
>  ##########################################
> +# check for usable bpf system call
> +if test "$bpf" = "yes"; then

if test "x$bpf" != "xno"; then

> +    have_bpf=no
> +    if test "$linux" = "yes" ; then
> +        cat > $TMPC << EOF
> +    #include <sys/syscall.h>
> +    #include "linux/bpf.h"
> +    #include <unistd.h>
> +    #include <stdlib.h>
> +    #include <string.h>
> +    int main(void) {
> +        union bpf_attr * attr = NULL;
> +        syscall(__NR_bpf, BPF_PROG_LOAD, attr, sizeof(attr));
> +        exit(0);
> +    }
> +EOF
> +        bpf_include="-Iinclude/standard-headers/linux"
> +        bpf_cflags=""
> +        bpf_libs=""
> +        if compile_prog "$bpf_include" "$bpf_libs" ; then
> +            have_bpf=yes
> +        fi
> +    fi
> +    if test "$have_bpf" = "no"; then
> +      feature_not_found "bpf" "libelf libs are not available or else \
> +the bpf system call is not available"

if test "$have_bpf" = "no"; then
    if test "x$bpf" = "xyes" ;
    then
       feature_not_found ....
    else
       bpf=no
    fi
else
    bpf=yes
fi

> +    fi
> +else
> +    bpf=no
> +fi
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
