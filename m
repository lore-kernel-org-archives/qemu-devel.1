Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3DDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 16:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093E720738
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 16:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qv7DhPLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093E720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcXRu-0005kc-6j
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 12:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcXRH-0005Gc-IE
 for qemu-devel@nongnu.org; Sat, 23 May 2020 12:55:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37681
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcXRF-0003Ni-Lp
 for qemu-devel@nongnu.org; Sat, 23 May 2020 12:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590252955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZQ9/BeY80KFh4JzUoK8ulWF4DbN6CEeEM8hVyaEGdMc=;
 b=Qv7DhPLfBKbaZraZ8nCBhdZE5CTpMyzQ00z7P8Cn/yXs8a9kX/3XY7Dy24S3SF77bqsWds
 ZR8RZ5pAwpMnBaRH9LweBmfnEmWGR0r9+gkOyDQBvlwTKkVNWivYb6O/wDKCepkiQqwjHJ
 P453jD5gwx9Zz+fEZWFV+ql02IQ+keY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-vzpCFG-KOFGRmEIuTM1sXw-1; Sat, 23 May 2020 12:55:48 -0400
X-MC-Unique: vzpCFG-KOFGRmEIuTM1sXw-1
Received: by mail-wr1-f72.google.com with SMTP id z5so5759927wrt.17
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZQ9/BeY80KFh4JzUoK8ulWF4DbN6CEeEM8hVyaEGdMc=;
 b=rLCWl265MkP+DllAwhxW4Mu7vSK4SyCnk/nVtPII8g0x0Ns+SY7g2cWy7oGFfC1u4q
 qjEQgoESFOh1ZZ4eDufSCCCGb7ITfaPYd/gBosTzUWLNoc5uBpGpWUrXGohtLTtm0N+f
 UNKcXYjeNfgvqT3Ms95kXEsLYe/1PQfcLJdjLS8pQBoETstS4pBidjpfq79amjsNsXLK
 1E29jApiLw0FzyaOk9MppYm4r1QgtnX8gJKtwjm6U2PPL4KP6ofl55jV84Z1JfzTwYFe
 YL4Bw8TWxnR03j1df4cSsrWDygIUb9s/HUvcE8ZKS5Cj9VHmJmBk74nuNTukGQdKdpJL
 ewYg==
X-Gm-Message-State: AOAM533LCl2pl2fI6xElGh2uDpMwF9lNo+hrxEMqNUU2D34zEyknOR8l
 AhGaeIoN1OxBfbW0Npqbs0iZz3cUOouKfrOQKWUrtixWzNW+y0se66HBGsspMxbv+kBy+qYPoGo
 c1DOLGOWWO4xEo0w=
X-Received: by 2002:adf:decb:: with SMTP id i11mr8626166wrn.172.1590252947436; 
 Sat, 23 May 2020 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4dJe7ITcVMztdeevIJ7xHgsTy2smZvmoU//D/XDMofp2wIIi+RuzhdTVClthBG/9cr/WH9w==
X-Received: by 2002:adf:decb:: with SMTP id i11mr8626151wrn.172.1590252947220; 
 Sat, 23 May 2020 09:55:47 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id j2sm5779846wre.52.2020.05.23.09.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2020 09:55:46 -0700 (PDT)
Subject: Re: [PATCH 01/19] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-2-robert.foley@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <cc897d62-5346-ebee-3d1e-ef5df3fc9b3f@redhat.com>
Date: Sat, 23 May 2020 18:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200522160755.886-2-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 12:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 Lingfeng Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Robert,

On 5/22/20 6:07 PM, Robert Foley wrote:
> From: Lingfeng Yang <lfy@google.com>
> 
> We tried running QEMU under tsan in 2016, but tsan's lack of support for
> longjmp-based fibers was a blocker:
>   https://groups.google.com/forum/#!topic/thread-sanitizer/se0YuzfWazw
> 
> Fortunately, thread sanitizer gained fiber support in early 2019:
>   https://reviews.llvm.org/D54889
> 
> This patch brings tsan support upstream by importing the patch that annotated
> QEMU's coroutines as tsan fibers in Android's QEMU fork:
>   https://android-review.googlesource.com/c/platform/external/qemu/+/844675
> 
> Tested with '--enable-tsan --cc=clang-9 --cxx=clang++-9 --disable-werror'
> configure flags.
> 
> Signed-off-by: Lingfeng Yang <lfy@google.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> [cota: minor modifications + configure changes]
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> [RF: minor changes to clean up checkpatch warnings/errors]
> ---
>  configure                 | 39 ++++++++++++++++
>  util/coroutine-ucontext.c | 97 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 127 insertions(+), 9 deletions(-)
> 
> diff --git a/configure b/configure
> index 26084fc53a..c95c54fb48 100755
> --- a/configure
> +++ b/configure
> @@ -395,6 +395,7 @@ gprof="no"
>  debug_tcg="no"
>  debug="no"
>  sanitizers="no"
> +tsan="no"
>  fortify_source=""
>  strip_opt="yes"
>  tcg_interpreter="no"
> @@ -1150,6 +1151,10 @@ for opt do
>    ;;
>    --disable-sanitizers) sanitizers="no"
>    ;;
> +  --enable-tsan) tsan="yes"
> +  ;;
> +  --disable-tsan) tsan="no"
> +  ;;
>    --enable-sparse) sparse="yes"
>    ;;
>    --disable-sparse) sparse="no"
> @@ -1750,6 +1755,7 @@ Advanced options (experts only):
>    --with-pkgversion=VERS   use specified string as sub-version of the package
>    --enable-debug           enable common debug build options
>    --enable-sanitizers      enable default sanitizers
> +  --enable-tsan            enable thread sanitizer
>    --disable-strip          disable stripping binaries
>    --disable-werror         disable compilation abort on warning
>    --disable-stack-protector disable compiler-provided stack protection
> @@ -6176,6 +6182,27 @@ if test "$fuzzing" = "yes" ; then
>    fi
>  fi
>  
> +# Thread sanitizer is, for now, much noisier than the other sanitizers;
> +# keep it separate until that is not the case.
> +have_tsan=no
> +have_tsan_iface_fiber=no
> +if test "$tsan" = "yes" ; then
> +  write_c_skeleton
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
> +      have_tsan=yes
> +  fi
> +  cat > $TMPC << EOF
> +#include <sanitizer/tsan_interface.h>
> +int main(void) {
> +  __tsan_create_fiber(0);
> +  return 0;
> +}
> +EOF
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
> +      have_tsan_iface_fiber=yes
> +  fi
> +fi
> +
>  ##########################################
>  # check for libpmem
>  
> @@ -6277,6 +6304,14 @@ if test "$have_asan" = "yes"; then
>             "Without code annotation, the report may be inferior."
>    fi
>  fi
> +if test "$have_tsan" = "yes" ; then
> +  if test "$have_tsan_iface_fiber" = "yes" ; then
> +    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
> +    QEMU_LDFLAGS="-fsanitize=thread $QEMU_LDFLAGS"
> +  else
> +    echo "Cannot enable TSAN due to missing fiber annotation interface."

I tried your series and there were no changes anywhere, then I looked at
how TSan work, started to debug, to finally realize my build was not
using TSan (clang8). Please use to something such:

     if test "$tsan" = "yes" ; then
        error_exit "Cannot enable TSAN due to missing fiber" \
                   "annotation interface."
     fi

> +  fi
> +fi
>  if test "$have_ubsan" = "yes"; then
>    QEMU_CFLAGS="-fsanitize=undefined $QEMU_CFLAGS"
>    QEMU_LDFLAGS="-fsanitize=undefined $QEMU_LDFLAGS"
> @@ -7365,6 +7400,10 @@ if test "$have_asan_iface_fiber" = "yes" ; then
>      echo "CONFIG_ASAN_IFACE_FIBER=y" >> $config_host_mak
>  fi
>  
> +if test "$have_tsan" = "yes" && test "$have_tsan_iface_fiber" = "yes" ; then
> +    echo "CONFIG_TSAN=y" >> $config_host_mak
> +fi
> +
>  if test "$has_environ" = "yes" ; then
>    echo "CONFIG_HAS_ENVIRON=y" >> $config_host_mak
>  fi
[...]


