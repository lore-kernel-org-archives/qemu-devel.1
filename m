Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AC2C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C4922CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGaXJU4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C4922CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99mT-0006B7-D1
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99la-0005Ps-L3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99lY-0005PH-Kb
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598026783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L/pLLASZSXw3tu39qrArb+cFlMuYH1uCd0yyN+Asbi0=;
 b=jGaXJU4pJaRPk/jhdNDTudJnenZbC/M7u4i/f5pLU104YyfC3/EEJRaI/Jo4YfGUbZyVU5
 hchTS4/lW2Nhe3I7zbMQt+yjmlDsHyJFizSXOjM9q9PpGmK7kPDhwr27h/QWesdobnBWpn
 bbRLIpAJFA9BD8xu0kq6gyzTe6BPmew=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-4TaJQahkP8mjXZYCUOMCIA-1; Fri, 21 Aug 2020 12:19:41 -0400
X-MC-Unique: 4TaJQahkP8mjXZYCUOMCIA-1
Received: by mail-wr1-f72.google.com with SMTP id r14so702137wrq.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=L/pLLASZSXw3tu39qrArb+cFlMuYH1uCd0yyN+Asbi0=;
 b=OG6AErMb1Hfd+3Pag804f/VrQ7Kiuj/zPSWUx3uhvM16ulbGm1hPGTzOrfdSycPShK
 i1C4BnI4HMXQ3p6yXQy7f6jX3ScTDJxd0rUXAOHhREuZuUlw8p/8mXFm4Q8W7l0TVpp+
 xOe/rwWey93njiGbe24f/NF4q6hAgYrtV97bVIJExyT5tOsxObRGrAlHSENmRgMxfUvT
 HtWAEaNVWYaz4DeBwTiLc9S1GKJHkdsiLPaJEJlK7ifLeLrTv5aYZm158YvlYyWToJzD
 2mi8vLXmAkWeuUHnkSgC5m0lYo8NDbjCjiBMff+XL+WDD5hEUlWZ+HSKa+cyzJ0UGDW4
 uF4w==
X-Gm-Message-State: AOAM530RhVfZqm7HyhKmWShEEcA7WL81z/sU+56iGsMGb6QdrEGekhiK
 LTItQ8iX0zl/UOOYPIY2YBAOXQCCj28QJNTPNRktuWf7CcwA3naYunoxEFJ7YfC2itpqSgpZzA4
 9OoopByCSvAsLaAk=
X-Received: by 2002:adf:f847:: with SMTP id d7mr3224604wrq.328.1598026780305; 
 Fri, 21 Aug 2020 09:19:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnR5oMPwBbSSqObHP3UFwAwT4lpNSsNTG9PESUEF+4icpvGsKo1QmYT2ISJNqKEWsKP4bCKQ==
X-Received: by 2002:adf:f847:: with SMTP id d7mr3224578wrq.328.1598026780001; 
 Fri, 21 Aug 2020 09:19:40 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b184sm6363872wmb.19.2020.08.21.09.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 09:19:39 -0700 (PDT)
Subject: Re: [PATCH] meson: convert pc-bios/keymaps/Makefile
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200821161411.25214-1-pbonzini@redhat.com>
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
Message-ID: <02ea6eaa-7db0-3cc4-64d6-4534ec8f36d9@redhat.com>
Date: Fri, 21 Aug 2020 18:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821161411.25214-1-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 6:14 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Note that sl and sv keymaps were not created by qemu-keymap.

Ah this is the same content (without this note) that I sent split
as 2 patches, series "meson: Build qemu-keymap when configured using
--disable-tools".

Whichever you prefer:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile                    |  8 ------
>  meson.build                 | 11 ++++----
>  pc-bios/keymaps/.gitignore  |  1 +
>  pc-bios/keymaps/Makefile    | 56 -------------------------------------
>  pc-bios/keymaps/meson.build | 56 +++++++++++++++++++++++++++++++++++++
>  pc-bios/meson.build         |  1 +
>  ui/meson.build              |  2 +-
>  7 files changed, 65 insertions(+), 70 deletions(-)
>  create mode 100644 pc-bios/keymaps/.gitignore
>  delete mode 100644 pc-bios/keymaps/Makefile
>  create mode 100644 pc-bios/keymaps/meson.build
> 
> diff --git a/Makefile b/Makefile
> index 8373ddccc9..ef28ce0361 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -229,11 +229,6 @@ distclean: clean ninja-distclean
>  	rm -f linux-headers/asm
>  	rm -Rf .sdk
>  
> -KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
> -ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
> -de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
> -bepo    cz
> -
>  ifdef INSTALL_BLOBS
>  BLOBS=bios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
>  vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
> @@ -298,9 +293,6 @@ endif
>  	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
>  		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
> -	set -e; for x in $(KEYMAPS); do \
> -		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
> -	done
>  
>  ifdef CONFIG_WIN32
>  
> diff --git a/meson.build b/meson.build
> index 808f50b07e..dd8016c9da 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1062,6 +1062,12 @@ if 'CONFIG_GUEST_AGENT' in config_host
>    subdir('qga')
>  endif
>  
> +if 'CONFIG_XKBCOMMON' in config_host
> +  # used for the update-keymaps target, so include rules even if !have_tools
> +  qemu_keymap = executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c') + genh,
> +                           dependencies: [qemuutil, xkbcommon], install: have_tools)
> +endif
> +
>  if have_tools
>    qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
>               dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
> @@ -1078,11 +1084,6 @@ if have_tools
>    subdir('contrib/rdmacm-mux')
>    subdir('contrib/elf2dmp')
>  
> -  if 'CONFIG_XKBCOMMON' in config_host
> -    executable('qemu-keymap', files('qemu-keymap.c', 'ui/input-keymap.c'),
> -               dependencies: [qemuutil, xkbcommon], install: true)
> -  endif
> -
>    executable('qemu-edid', files('qemu-edid.c', 'hw/display/edid-generate.c'),
>               dependencies: qemuutil,
>               install: true)
> diff --git a/pc-bios/keymaps/.gitignore b/pc-bios/keymaps/.gitignore
> new file mode 100644
> index 0000000000..f90738f4dc
> --- /dev/null
> +++ b/pc-bios/keymaps/.gitignore
> @@ -0,0 +1 @@
> +/*.stamp
> diff --git a/pc-bios/keymaps/Makefile b/pc-bios/keymaps/Makefile
> deleted file mode 100644
> index 76217b0689..0000000000
> --- a/pc-bios/keymaps/Makefile
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -
> -KEYMAP	:= $(shell which qemu-keymap 2>/dev/null)
> -
> -MAPS	:= ar bepo cz da de de-ch en-us en-gb es et fi fo \
> -	   fr fr-be fr-ca fr-ch \
> -	   hr hu is it ja lt lv mk nl no pl pt pt-br ru th tr
> -
> -ar	: MAP_FLAGS :=	-l ar
> -bepo	: MAP_FLAGS :=	-l fr -v dvorak
> -cz	: MAP_FLAGS :=	-l cz
> -da	: MAP_FLAGS :=	-l dk
> -de	: MAP_FLAGS :=	-l de -v nodeadkeys
> -de-ch	: MAP_FLAGS :=	-l ch
> -en-us	: MAP_FLAGS :=	-l us
> -en-gb	: MAP_FLAGS :=	-l gb
> -es	: MAP_FLAGS :=	-l es
> -et	: MAP_FLAGS :=	-l et
> -fi	: MAP_FLAGS :=	-l fi
> -fo	: MAP_FLAGS :=	-l fo
> -fr	: MAP_FLAGS :=	-l fr -v nodeadkeys
> -fr-be	: MAP_FLAGS :=	-l be
> -fr-ca	: MAP_FLAGS :=	-l ca -v fr
> -fr-ch	: MAP_FLAGS :=	-l ch -v fr
> -hr	: MAP_FLAGS :=	-l hr
> -hu	: MAP_FLAGS :=	-l hu
> -is	: MAP_FLAGS :=	-l is
> -it	: MAP_FLAGS :=	-l it
> -ja	: MAP_FLAGS :=	-l jp -m jp106
> -lt	: MAP_FLAGS :=	-l lt
> -lv	: MAP_FLAGS :=	-l lv
> -mk	: MAP_FLAGS :=	-l mk
> -nl	: MAP_FLAGS :=	-l nl
> -no	: MAP_FLAGS :=	-l no
> -pl	: MAP_FLAGS :=	-l pl
> -pt	: MAP_FLAGS :=	-l pt
> -pt-br	: MAP_FLAGS :=	-l br
> -ru	: MAP_FLAGS :=	-l ru
> -th	: MAP_FLAGS :=	-l th
> -tr	: MAP_FLAGS :=	-l tr
> -
> -ifeq ($(KEYMAP),)
> -
> -all:
> -	@echo "nothing to do (qemu-keymap not found)"
> -
> -else
> -
> -all: $(MAPS)
> -
> -clean:
> -	rm -f $(MAPS)
> -
> -$(MAPS): $(KEYMAP) Makefile
> -	$(KEYMAP) -f $@ $(MAP_FLAGS)
> -
> -endif
> diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
> new file mode 100644
> index 0000000000..b737c82230
> --- /dev/null
> +++ b/pc-bios/keymaps/meson.build
> @@ -0,0 +1,56 @@
> +keymaps = {
> +  'ar': '-l ar',
> +  'bepo': '-l fr -v dvorak',
> +  'cz': '-l cz',
> +  'da': '-l dk',
> +  'de': '-l de -v nodeadkeys',
> +  'de-ch': '-l ch',
> +  'en-gb': '-l gb',
> +  'en-us': '-l us',
> +  'es': '-l es',
> +  'et': '-l et',
> +  'fi': '-l fi',
> +  'fo': '-l fo',
> +  'fr': '-l fr -v nodeadkeys',
> +  'fr-be': '-l be',
> +  'fr-ca': '-l ca -v fr',
> +  'fr-ch': '-l ch -v fr',
> +  'hr': '-l hr',
> +  'hu': '-l hu',
> +  'is': '-l is',
> +  'it': '-l it',
> +  'ja': '-l jp -m jp106',
> +  'lt': '-l lt',
> +  'lv': '-l lv',
> +  'mk': '-l mk',
> +  'nl': '-l nl',
> +  'no': '-l no',
> +  'pl': '-l pl',
> +  'pt': '-l pt',
> +  'pt-br': '-l br',
> +  'ru': '-l ru',
> +  'th': '-l th',
> +  'tr': '-l tr',
> +}
> +
> +if meson.is_cross_build() or 'CONFIG_XKBCOMMON' not in config_host
> +  native_qemu_keymap = find_program('qemu-keymap', required: false, disabler: true)
> +else
> +  native_qemu_keymap = qemu_keymap
> +endif
> +t = []
> +foreach km, args: keymaps
> +  t += custom_target(km,
> +                     build_by_default: true,
> +                     output: km,
> +                     command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
> +                     install_dir: config_host['qemu_datadir'] / 'keymaps')
> +endforeach
> +if t.length() > 0
> +  alias_target('update-keymaps', t)
> +else
> +  # install from the source tree
> +  install_data(keymaps.keys(), install_dir: config_host['qemu_datadir'] / 'keymaps')
> +endif
> +
> +install_data(['sl', 'sv'], install_dir: config_host['qemu_datadir'] / 'keymaps')
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index 6e3bfe3ca4..b6389f5148 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -25,3 +25,4 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
>  endif
>  
>  subdir('descriptors')
> +subdir('keymaps')
> diff --git a/ui/meson.build b/ui/meson.build
> index 6f74d30ea0..6bf398213f 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -95,7 +95,7 @@ keymaps = [
>    ['osx', 'qcode'],
>  ]
>  
> -if have_system
> +if have_system or have_tools
>    foreach e : keymaps
>      output = 'input-keymap-@0@-to-@1@.c.inc'.format(e[0], e[1])
>      genh += custom_target(output,
> 


