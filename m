Received: from eggs.gnu.org ([209.51.188.92]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKlu-0008LQ-Sf
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKYR-0002Hl-CF
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:50:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKYQ-0002F1-Uu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:50:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so6956016wrn.11
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:50:30 -0700 (PDT)
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<20190403161729.GW25150@redhat.com>
	<CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
	<43102ef9-2f96-2863-00aa-b6f2906c2f4f@redhat.com>
	<20190404085621.GD10471@redhat.com>
	<20190404183923.GA22347@ls3530.dellerweb.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02191499-2d1c-18a1-346d-4afda800d5ee@redhat.com>
Date: Fri, 5 Apr 2019 10:50:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190404183923.GA22347@ls3530.dellerweb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On 4/4/19 8:39 PM, Helge Deller wrote:
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
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
