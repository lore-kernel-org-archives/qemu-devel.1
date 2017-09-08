Received: from eggs.gnu.org ([2001:4830:134:3::10]:51500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dqENa-0002O6-Ga
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dqENV-0004aB-Qu
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:11:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dqENV-0004ZN-K9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:11:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF80E883B8
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 08:11:03 +0000 (UTC)
Date: Fri, 8 Sep 2017 10:10:57 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170908081057.GB16888@vader>
References: <20170907085316.8861-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170907085316.8861-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] buildsys: Move seccomp cflags/libs to per
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Sep 07, 2017 at 04:53:16PM +0800, Fam Zheng wrote:
> Like many other libraries, libseccomp cflags and libs should only apply
> to the building of necessary objects. Do so in the usual way with the
> help of per object variables.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

I'll include in the next pull request. Thanks for the patch.

Acked-by: Eduardo Otubo <otubo@redhat.com>

> ---
>  Makefile.objs | 2 ++
>  configure     | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 24a4ea08b8..d9cf7ad791 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -70,6 +70,8 @@ common-obj-y += backends/
>  common-obj-y += chardev/
>  
>  common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
> +qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
> +qemu-seccomp.o-libs := $(SECCOMP_LIBS)
>  
>  common-obj-$(CONFIG_FDT) += device_tree.o
>  
> diff --git a/configure b/configure
> index fb7e34a901..fb81a0189b 100755
> --- a/configure
> +++ b/configure
> @@ -2052,8 +2052,8 @@ if test "$seccomp" != "no" ; then
>  
>      if test "$libseccomp_minver" != "" &&
>         $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
> -        libs_softmmu="$libs_softmmu $($pkg_config --libs libseccomp)"
> -        QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags libseccomp)"
> +        seccomp_cflags="$($pkg_config --cflags libseccomp)"
> +        seccomp_libs="$($pkg_config --libs libseccomp)"
>          seccomp="yes"
>      else
>          if test "$seccomp" = "yes" ; then
> @@ -5875,6 +5875,8 @@ fi
>  
>  if test "$seccomp" = "yes"; then
>    echo "CONFIG_SECCOMP=y" >> $config_host_mak
> +  echo "SECCOMP_CFLAGS=$seccomp_cflags" >> $config_host_mak
> +  echo "SECCOMP_LIBS=$seccomp_libs" >> $config_host_mak
>  fi
>  
>  # XXX: suppress that
> -- 
> 2.13.5
> 
> 

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
