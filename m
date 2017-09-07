Received: from eggs.gnu.org ([2001:4830:134:3::10]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0yo-0006Fy-Ao
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0yj-0007cy-Mb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:52:42 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0yj-0007cn-JH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:52:37 -0400
Received: by mail-qk0-x243.google.com with SMTP id r66so76239qke.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:52:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170907085316.8861-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1eba1296-af93-9905-e149-a2fa29d8b182@amsat.org>
Date: Thu, 7 Sep 2017 14:52:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170907085316.8861-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Otubo <otubo@redhat.com>

On 09/07/2017 05:53 AM, Fam Zheng wrote:
> Like many other libraries, libseccomp cflags and libs should only apply
> to the building of necessary objects. Do so in the usual way with the
> help of per object variables.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   Makefile.objs | 2 ++
>   configure     | 6 ++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index 24a4ea08b8..d9cf7ad791 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -70,6 +70,8 @@ common-obj-y += backends/
>   common-obj-y += chardev/
>   
>   common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
> +qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
> +qemu-seccomp.o-libs := $(SECCOMP_LIBS)
>   
>   common-obj-$(CONFIG_FDT) += device_tree.o
>   
> diff --git a/configure b/configure
> index fb7e34a901..fb81a0189b 100755
> --- a/configure
> +++ b/configure
> @@ -2052,8 +2052,8 @@ if test "$seccomp" != "no" ; then
>   
>       if test "$libseccomp_minver" != "" &&
>          $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
> -        libs_softmmu="$libs_softmmu $($pkg_config --libs libseccomp)"
> -        QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags libseccomp)"
> +        seccomp_cflags="$($pkg_config --cflags libseccomp)"
> +        seccomp_libs="$($pkg_config --libs libseccomp)"
>           seccomp="yes"
>       else
>           if test "$seccomp" = "yes" ; then
> @@ -5875,6 +5875,8 @@ fi
>   
>   if test "$seccomp" = "yes"; then
>     echo "CONFIG_SECCOMP=y" >> $config_host_mak
> +  echo "SECCOMP_CFLAGS=$seccomp_cflags" >> $config_host_mak
> +  echo "SECCOMP_LIBS=$seccomp_libs" >> $config_host_mak
>   fi
>   
>   # XXX: suppress that
> 
