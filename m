Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED45C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AE5206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lgxcu1X7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AE5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Wml-0006Al-8H
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Wl0-0004Vs-7s
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:04:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Wkx-0006Rl-DV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597161846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nQ5394zOcjO/YO55isJUV3BuOLWxCXmlkbjR+9+PMfQ=;
 b=Lgxcu1X7DRfWhzer09J1dreo6yqaObm9AXNZZQWWDIA/CupzUw7+WnLFykfhJsFWVuFdoi
 AJWfBvWx3WgvHP4kdvbJPvZvkSctuI3xk9uMaibCMfQ5Yw2whyOgg/n9pEwTORA0E5tZf6
 PXyN0ijxZYddTjMtIxEW8BZ8ZK15L4M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-9fRTb6E9O_-GX-eydKSYtw-1; Tue, 11 Aug 2020 12:04:04 -0400
X-MC-Unique: 9fRTb6E9O_-GX-eydKSYtw-1
Received: by mail-wr1-f69.google.com with SMTP id f7so5752512wrs.8
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 09:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nQ5394zOcjO/YO55isJUV3BuOLWxCXmlkbjR+9+PMfQ=;
 b=c+vzvNgQGv9UuV643EZTHR1RRi4mMVc79sVs1bbbsHQsvCLhTGRKF163RbjLbLAUGC
 hUpz+8OPuEdahNOtmuIjEhHSk/acmJGxPJWVOhDxFjQw2Hu+rqlXfnYE2qIzlDVZQ5Wv
 IJwoaz2z+zyJaLfAq3pAi9D4OF1QeiNaKdzBTH9HRwSCb/HzEsFXAmfp+RJRCdnXvwH+
 iC/MAak2B+jB/jjP9BCEVDrS+lI5USEbxtqI8IFWARTkBkFw6mCffPvpoZKaXqc3JVxV
 jCCbtN0t+UN8VJVAN8CMgRKKeYgUbegpBIKL1DsqXueOdefMzJUkMeUMhmGrGYjb+SJF
 phlg==
X-Gm-Message-State: AOAM533e90yUOS9yTrenUUPHV/ENZ67MmC0vYPQa0PAyDNkTzTluPyzX
 5wiZCY7RtYnxVa1xu6uKQ7OzlRL2bYUgEtI4cUTKYw/pBc4o+859xfAIoEqpltr52wzSATL1rlE
 VS2nuABO8k+IYmtw=
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr6746719wrm.275.1597161843209; 
 Tue, 11 Aug 2020 09:04:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnq/ETlt4PKz0gRKkbNTg0pckdh3VJPSmsRpuXJnuLcHnTU/tR7gVf4nl/rQF0i+CCHtWJLg==
X-Received: by 2002:adf:dd4f:: with SMTP id u15mr6746699wrm.275.1597161842976; 
 Tue, 11 Aug 2020 09:04:02 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g25sm5508636wmh.35.2020.08.11.09.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 09:04:02 -0700 (PDT)
Subject: Re: [PATCH 007/147] tests/vm: do not pollute configure with
 --efi-aarch64
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-8-git-send-email-pbonzini@redhat.com>
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
Message-ID: <7d2f2683-2268-19bf-bcc6-9f97d9f36b31@redhat.com>
Date: Tue, 11 Aug 2020 18:04:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597079345-42801-8-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Robert in case.

On 8/10/20 7:06 PM, Paolo Bonzini wrote:
> Just make EFI_AARCH64 a variable in the makefile that defaults to the efi
> firmware included with QEMU.  It can be redefined on the "make" command
> line.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure                 | 19 -------------------
>  tests/vm/Makefile.include |  2 ++
>  2 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/configure b/configure
> index 2acc4d1..1c17a0f 100755
> --- a/configure
> +++ b/configure
> @@ -418,7 +418,6 @@ prefix="/usr/local"
>  mandir="\${prefix}/share/man"
>  datadir="\${prefix}/share"
>  firmwarepath="\${prefix}/share/qemu-firmware"
> -efi_aarch64=""
>  qemu_docdir="\${prefix}/share/doc/qemu"
>  bindir="\${prefix}/bin"
>  libdir="\${prefix}/lib"
> @@ -1109,8 +1108,6 @@ for opt do
>    ;;
>    --firmwarepath=*) firmwarepath="$optarg"
>    ;;
> -  --efi-aarch64=*) efi_aarch64="$optarg"
> -  ;;
>    --host=*|--build=*|\
>    --disable-dependency-tracking|\
>    --sbindir=*|--sharedstatedir=*|\
> @@ -3650,20 +3647,6 @@ EOF
>    fi
>  fi
>  
> -############################################
> -# efi-aarch64 probe
> -# Check for efi files needed by aarch64 VMs.
> -# By default we will use the efi included with QEMU.
> -# Allow user to override the path for efi also.
> -if ! test -f "$efi_aarch64"; then
> -  if test -f $source_path/pc-bios/edk2-aarch64-code.fd.bz2; then
> -    # valid after build
> -    efi_aarch64=$PWD/pc-bios/edk2-aarch64-code.fd
> -  else
> -    efi_aarch64=""
> -  fi
> -fi
> -
>  ##########################################
>  # libcap-ng library probe
>  if test "$cap_ng" != "no" ; then
> @@ -6861,7 +6844,6 @@ if test "$docs" != "no"; then
>      echo "sphinx-build      $sphinx_build"
>  fi
>  echo "genisoimage       $genisoimage"
> -echo "efi_aarch64       $efi_aarch64"
>  echo "python_yaml       $python_yaml"
>  echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
>  if test "$slirp" != "no" ; then
> @@ -7963,7 +7945,6 @@ echo "PYTHON=$python" >> $config_host_mak
>  echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
>  echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
>  echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
> -echo "EFI_AARCH64=$efi_aarch64" >> $config_host_mak
>  echo "PYTHON_YAML=$python_yaml" >> $config_host_mak
>  echo "CC=$cc" >> $config_host_mak
>  if $iasl -h > /dev/null 2>&1; then
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index f21948c..a599d19 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -2,6 +2,8 @@
>  
>  .PHONY: vm-build-all vm-clean-all
>  
> +EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
> +
>  IMAGES := freebsd netbsd openbsd centos fedora
>  ifneq ($(GENISOIMAGE),)
>  IMAGES += ubuntu.i386 centos
> 


