Received: from eggs.gnu.org ([209.51.188.92]:59168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hC8YU-0005YK-0y
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hC8YT-0004Vi-4j
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hC8YS-0004VA-Nf
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:01:45 -0400
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<20190403161729.GW25150@redhat.com>
	<CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
	<43102ef9-2f96-2863-00aa-b6f2906c2f4f@redhat.com>
	<20190404085621.GD10471@redhat.com>
	<20190404183923.GA22347@ls3530.dellerweb.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e4202c5d-1fab-a032-99ca-9d41f0611677@redhat.com>
Date: Thu, 4 Apr 2019 22:01:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190404183923.GA22347@ls3530.dellerweb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Eduardo Otubo <otubo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 04/04/2019 20.39, Helge Deller wrote:
> All major distributions do support libseccomp version >= 2.3.0, so there
> is no need to special-case on various architectures any longer.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/configure b/configure
> index 1c563a7027..8fe4fc84d8 100755
> --- a/configure
> +++ b/configure
> @@ -2377,36 +2369,16 @@ fi
>  ##########################################
>  # libseccomp check
> 
> -libseccomp_minver="2.2.0"
>  if test "$seccomp" != "no" ; then
> -    case "$cpu" in
> -    i386|x86_64|mips)
> -        ;;
> -    arm|aarch64)
> -        libseccomp_minver="2.2.3"
> -        ;;
> -    ppc|ppc64|s390x)
> -        libseccomp_minver="2.3.0"
> -        ;;
> -    *)
> -        libseccomp_minver=""
> -        ;;
> -    esac
> -
> -    if test "$libseccomp_minver" != "" &&
> -       $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
> +    libseccomp_minver="2.3.0"
> +    if $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
>          seccomp_cflags="$($pkg_config --cflags libseccomp)"
>          seccomp_libs="$($pkg_config --libs libseccomp)"
>          seccomp="yes"
>      else
>          if test "$seccomp" = "yes" ; then
> -            if test "$libseccomp_minver" != "" ; then
> -                feature_not_found "libseccomp" \
> -                    "Install libseccomp devel >= $libseccomp_minver"
> -            else
> -                feature_not_found "libseccomp" \
> -                    "libseccomp is not supported for host cpu $cpu"
> -            fi
> +            feature_not_found "libseccomp" \
> +                 "Install libseccomp devel >= $libseccomp_minver"
>          fi
>          seccomp="no"
>      fi

Reviewed-by: Thomas Huth <thuth@redhat.com>
