Received: from eggs.gnu.org ([2001:4830:134:3::10]:48274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNHki-0004NZ-2v
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNHkd-0001Dk-7Z
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:59:56 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNHkd-0001Da-0M
	for qemu-devel@nongnu.org; Mon, 28 May 2018 08:59:51 -0400
Received: from player773.ha.ovh.net (unknown [10.109.108.63])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E3FDB139D34
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 14:59:48 +0200 (CEST)
Date: Mon, 28 May 2018 14:59:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180528145945.05e22d0f@bahia.lan>
In-Reply-To: <f7e1cd54774642aec19dd2c547a5e560050ab9cd.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<f7e1cd54774642aec19dd2c547a5e560050ab9cd.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/13] 9p: darwin: configure: Allow VirtFS
 on Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keno@juliacomputing.com
Cc: qemu-devel@nongnu.org, Keno Fischer <keno@alumni.harvard.edu>

On Sat, 26 May 2018 01:23:15 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  Makefile.objs |  1 +
>  configure     | 23 +++++++++++++++--------
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index c6c3554..a2245c9 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -104,6 +104,7 @@ common-obj-$(CONFIG_WIN32) += os-win32.o
>  common-obj-$(CONFIG_POSIX) += os-posix.o
>  
>  common-obj-$(CONFIG_LINUX) += fsdev/
> +common-obj-$(CONFIG_DARWIN) += fsdev/
>  
>  common-obj-y += migration/
>  
> diff --git a/configure b/configure
> index a8498ab..eb7328c 100755
> --- a/configure
> +++ b/configure
> @@ -5535,16 +5535,27 @@ if test "$want_tools" = "yes" ; then
>    fi
>  fi
>  if test "$softmmu" = yes ; then
> -  if test "$linux" = yes; then
> -    if test "$virtfs" != no && test "$cap" = yes && test "$attr" = yes ; then
> +  if test "$virtfs" != no; then
> +    if test "$linux" = yes; then
> +      if test "$cap" = yes && test "$attr" = yes ; then
> +        virtfs=yes
> +        tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
> +      else
> +        if test "$virtfs" = yes; then
> +          error_exit "VirtFS requires libcap devel and libattr devel under Linux"
> +        fi
> +        virtfs=no
> +      fi
> +    elif test "$darwin" = yes; then
>        virtfs=yes
> -      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"

So, no proxy helper on Darwin ? Why ? The limitation should be mentioned in
the changelog at least.

>      else
>        if test "$virtfs" = yes; then
> -        error_exit "VirtFS requires libcap devel and libattr devel"
> +        error_exit "VirtFS is supported only on Linux and Darwin"
>        fi
>        virtfs=no
>      fi
> +  fi
> +  if test "$linux" = yes; then
>      if test "$mpath" != no && test "$mpathpersist" = yes ; then
>        mpath=yes
>      else
> @@ -5555,10 +5566,6 @@ if test "$softmmu" = yes ; then
>      fi
>      tools="$tools scsi/qemu-pr-helper\$(EXESUF)"
>    else
> -    if test "$virtfs" = yes; then
> -      error_exit "VirtFS is supported only on Linux"
> -    fi
> -    virtfs=no
>      if test "$mpath" = yes; then
>        error_exit "Multipath is supported only on Linux"
>      fi
