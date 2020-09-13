Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECB9C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 21:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9BD21D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 21:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tswxg6KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9BD21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHZGy-0003CG-48
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 17:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHZG3-0001nc-4C
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 17:09:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHZFz-0002M0-Hf
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 17:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600031393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NZmefyiMd3OQu2suCBGHury0I2opDZZ7VCklKKg5C1c=;
 b=Tswxg6KQT51zv36ZsEilIWJtRx2sIcRMAAyW8upBZOHoOauca1mt/itCVIsdz2sAKmzEth
 /4qisWUaJFPI9AoP5qC/174RSX13Rfi92mREr3X3RXgJvYp9tbAIXglHSCFQwE9L5oT7HD
 06KZ3GBJI9bbt1tplMys03vDQ/3EidM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-7AEP1BfANtenfhdJpaiiLQ-1; Sun, 13 Sep 2020 17:09:50 -0400
X-MC-Unique: 7AEP1BfANtenfhdJpaiiLQ-1
Received: by mail-wr1-f72.google.com with SMTP id i10so5951317wrq.5
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 14:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NZmefyiMd3OQu2suCBGHury0I2opDZZ7VCklKKg5C1c=;
 b=mbJXVkYC+fJ0FfkgPPq88zEMTiMY3AWI9L6qiwWTv46q44Wy3PeoZuAmY2TlwDs8KS
 eftvmZHajsK0LZ09yxPIlltbM3L5PY4GGEVe5emznSNUiDk8w6GA5PXSMbuzh9xQfoor
 klNxo3GzJtR/bjWpMNqIzTP3Qiu+ldIr2MWK/BDz6LGn9Xt9BmqzzsOLomchAS29K7TS
 gANLgDCx0Hzc72HOolE36FXHs8EUDdQsrm5b4eQPHvtIo4GHMCMkNpKPPIL13H778TQx
 WZICTX8FP15WuM/CIt+s6dXZdtsYo4L/ZoG1S+zYlGZTqQmjHUWvjmdAsFMUObrtAG8W
 5Gfw==
X-Gm-Message-State: AOAM530zOPLyhPVgMNMMLBO1Jz+JPH1dSGS5FmUHRF02qBAZyVoiX86e
 QOhJ5jLJwBNAgwhO+8a41i1k9P+cD2WKj2ZUr1QOuDrC+lY2IMB1ZXyM4AsV3rojC09g45RnedQ
 0diV3UG0cllJv7w0=
X-Received: by 2002:a7b:c308:: with SMTP id k8mr11921739wmj.90.1600031389111; 
 Sun, 13 Sep 2020 14:09:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy32kTvBbAbyKbMgqtR1vxSEm5xCbBgcuDWnCV1be3i9zBiPaGXphrUzQ7gf5SbDovntepAQ==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr11921716wmj.90.1600031388722; 
 Sun, 13 Sep 2020 14:09:48 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 91sm18929251wrq.9.2020.09.13.14.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 14:09:47 -0700 (PDT)
Subject: Re: [PATCH resend] configure: actually disable 'git_update' mode with
 --disable-git-update
To: Dan Streetman <ddstreet@canonical.com>, qemu-devel@nongnu.org
References: <20200913185708.1681279-1-ddstreet@canonical.com>
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
Message-ID: <f0b87265-d997-c29a-af55-de862ebe34b7@redhat.com>
Date: Sun, 13 Sep 2020 23:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200913185708.1681279-1-ddstreet@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 14:49:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Daniel as this is related to 'GIT submodules' which
he maintains:

$ scripts/get_maintainer.pl -f scripts/git-submodule.sh
"Daniel P. Berrangé" <berrange@redhat.com> (odd fixer:GIT submodules)

On 9/13/20 8:57 PM, Dan Streetman wrote:
> The --disable-git-update configure param sets git_update=no, but
> some later checks only look for the .git dir. This changes the
> --enable-git-update to set git_update=yes but also fail if it
> does not find a .git dir. Then all the later checks for the .git
> dir can just be changed to a check for $git_update = "yes".
> 
> Also update the Makefile to skip the 'git_update' checks if it has
> been disabled.
> 
> This is needed because downstream packagers, e.g. Debian, Ubuntu, etc,
> also keep the source code in git, but do not want to enable the
> 'git_update' mode; with the current code, that's not possible even
> if the downstream package specifies --disable-git-update.
> 
> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
> Resend; this was sent twice before:
> https://lists.nongnu.org/archive/html/qemu-trivial/2020-07/msg00180.html

Which was v2,

> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg08243.html

probably v3,

so this is v4.

Please don't post new patches as reply to previous versions,
because they'll likely get unnoticed (for developers who use
threaded view of their mail folder).

> 
> Makefile  | 15 +++++++++------
>  configure | 23 ++++++++++++++---------
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2ed19310cf7..712aaf8b53b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -38,6 +38,8 @@ git-submodule-update:
>  
>  .PHONY: git-submodule-update
>  
> +# If --disable-git-update specified, skip these git checks
> +ifneq (no,$(GIT_UPDATE))
>  git_module_status := $(shell \
>    cd '$(SRC_PATH)' && \
>    GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
> @@ -45,7 +47,12 @@ git_module_status := $(shell \
>  )
>  
>  ifeq (1,$(git_module_status))
> -ifeq (no,$(GIT_UPDATE))
> +ifeq (yes,$(GIT_UPDATE))
> +git-submodule-update:
> +	$(call quiet-command, \
> +          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
> +          "GIT","$(GIT_SUBMODULES)")
> +else
>  git-submodule-update:
>  	$(call quiet-command, \
>              echo && \
> @@ -54,11 +61,7 @@ git-submodule-update:
>              echo "from the source directory checkout $(SRC_PATH)" && \
>              echo && \
>              exit 1)
> -else
> -git-submodule-update:
> -	$(call quiet-command, \
> -          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
> -          "GIT","$(GIT_SUBMODULES)")
> +endif
>  endif
>  endif
>  
> diff --git a/configure b/configure
> index 4231d56bcc0..2e0e2adc587 100755
> --- a/configure
> +++ b/configure
> @@ -346,7 +346,7 @@ then
>      git_submodules="$git_submodules tests/fp/berkeley-testfloat-3"
>      git_submodules="$git_submodules tests/fp/berkeley-softfloat-3"
>  else
> -    git_update=no
> +    git_update=""
>      git_submodules=""
>  
>      if ! test -f "$source_path/ui/keycodemapdb/README"
> @@ -1577,7 +1577,12 @@ for opt do
>    ;;
>    --with-git=*) git="$optarg"
>    ;;
> -  --enable-git-update) git_update=yes
> +  --enable-git-update)
> +      git_update=yes
> +      if test ! -e "$source_path/.git"; then
> +          echo "ERROR: cannot --enable-git-update without .git"
> +          exit 1
> +      fi
>    ;;
>    --disable-git-update) git_update=no
>    ;;
> @@ -1974,7 +1979,7 @@ python="$python -B"
>  if test -z "$meson"; then
>      if test "$explicit_python" = no && has meson && version_ge "$(meson --version)" 0.55.1; then
>          meson=meson
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +    elif test $git_update = 'yes' ; then
>          meson=git
>      elif test -e "${source_path}/meson/meson.py" ; then
>          meson=internal
> @@ -2052,7 +2057,7 @@ fi
>  # Consult white-list to determine whether to enable werror
>  # by default.  Only enable by default for git builds
>  if test -z "$werror" ; then
> -    if test -e "$source_path/.git" && \
> +    if test "$git_update" = "yes" && \
>          { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
>          werror="yes"
>      else
> @@ -4175,10 +4180,10 @@ EOF
>      fdt=system
>    else
>        # have GIT checkout, so activate dtc submodule
> -      if test -e "${source_path}/.git" ; then
> +      if test "$git_update" = "yes" ; then
>            git_submodules="${git_submodules} dtc"
>        fi
> -      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
> +      if test -d "${source_path}/dtc/libfdt" || test "$git_update" = "yes" ; then
>            fdt=git
>            mkdir -p dtc
>            fdt_cflags="-I${source_path}/dtc/libfdt"
> @@ -5126,7 +5131,7 @@ case "$capstone" in
>    "" | yes)
>      if $pkg_config capstone; then
>        capstone=system
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +    elif test "$git_update" = "yes" ; then
>        capstone=git
>      elif test -e "${source_path}/capstone/Makefile" ; then
>        capstone=internal
> @@ -6126,7 +6131,7 @@ case "$slirp" in
>    "" | yes)
>      if $pkg_config slirp; then
>        slirp=system
> -    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
> +    elif test "$git_update" = "yes" ; then
>        slirp=git
>      elif test -e "${source_path}/slirp/Makefile" ; then
>        slirp=internal
> @@ -6460,7 +6465,7 @@ if test "$cpu" = "s390x" ; then
>      roms="$roms s390-ccw"
>      # SLOF is required for building the s390-ccw firmware on s390x,
>      # since it is using the libnet code from SLOF for network booting.
> -    if test -e "${source_path}/.git" ; then
> +    if test "$git_update" = "yes" ; then
>        git_submodules="${git_submodules} roms/SLOF"
>      fi
>    fi
> 


