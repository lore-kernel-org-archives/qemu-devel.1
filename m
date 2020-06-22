Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DFEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC80D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSgiYFoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC80D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMJL-00008P-4L
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnMIY-0007kY-1S
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:15:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnMIW-00015L-6k
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592831739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=35VDSfGXKPygPJE9nflKCze4CtKv9sBvgcRXlKaHXVg=;
 b=OSgiYFoUltHjqtgOxNAOlH84feXcPaN0NNb3Um+aW9geOfhQaAc7UP6K8DdJIDc/5n1mi2
 qU6Zzlu0X0EIpm0GPd00qMASH3xTDCuJHDsjhEJ4KcvBMXSCtBW87beupXvAwFNdiAH6B0
 pSmNd0PJr+RoIiHywhxc1Gxb9j2xxKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Tdavcsp4PWWdFVnCe3R5tw-1; Mon, 22 Jun 2020 09:15:37 -0400
X-MC-Unique: Tdavcsp4PWWdFVnCe3R5tw-1
Received: by mail-wm1-f71.google.com with SMTP id b63so453wme.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 06:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=35VDSfGXKPygPJE9nflKCze4CtKv9sBvgcRXlKaHXVg=;
 b=CyIFvAbT5pZxz/5er9O0ucn+BsKldMERvWSqFbsQKEaz9XnoSMzE2piYeWzwa7fsft
 bYwnWb4Ac0ZZ/Og8CBgCdqcivyfhqgqpg6A/plIO8WUg7cq6NoKbM7SfVodYNc7YcdwZ
 H2dZd/0TNjDo0IZnEA1fpbyf8VJCkioz8jGh6Ynm7J5wogqYsyF3vl6YHh/vO3prphrr
 LwY754I3sABYU+tXImv2FJ++6KKiTdciecQmrCkzuLFSo62RwYWFORp90N1hDmwpUzSE
 7hAJR4C0n5vHXPdLd5rTuwd0O+K6sHG+R5o7RjgxitILbCR8v1KzTKg2UghVfzuViV9A
 55LQ==
X-Gm-Message-State: AOAM531/fwThyAORc30xshrahW/mZWUIK4GF1X1pB4Y4JYzN1sfVXlfz
 yCzi+fHrg4ki+VOU/cPrsoGSyj7zxGdOvE+lMAWAgqNCWDgZ+8sqNd9PRCQ4GFWGkllpfsFE/y+
 HFmueixITfDFz0bg=
X-Received: by 2002:adf:ef01:: with SMTP id e1mr8675182wro.116.1592831736574; 
 Mon, 22 Jun 2020 06:15:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8PakplgN34mFpj1YcfEj7vN+bSQU/iYocYo26zrx8VNJWwUMa7YnjDgsCJkG4LUmIloBWMQ==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr8675167wro.116.1592831736390; 
 Mon, 22 Jun 2020 06:15:36 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o6sm17983040wrp.3.2020.06.22.06.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:15:35 -0700 (PDT)
Subject: Re: [PATCH] configure: vgabios cleanups
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200622131240.9624-1-kraxel@redhat.com>
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
Message-ID: <8cae534f-3e87-a79a-ef61-89cbc3ca32cb@redhat.com>
Date: Mon, 22 Jun 2020 15:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622131240.9624-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 6/22/20 3:12 PM, Gerd Hoffmann wrote:
> Commit 91b8eba9ec3f ("vgabios: remove submodule and build rules.")
> removed the vgabios submodule, but left some traces in the configure
> script.  Remove them.
> 
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index ba88fd182447..1bc28ad014a1 100755
> --- a/configure
> +++ b/configure
> @@ -8384,14 +8384,14 @@ DIRS="tests tests/tcg tests/tcg/lm32 tests/qapi-schema tests/qtest/libqos"
>  DIRS="$DIRS tests/qtest tests/qemu-iotests tests/vm tests/fp tests/qgraph"
>  DIRS="$DIRS docs docs/interop fsdev scsi"
>  DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
> -DIRS="$DIRS roms/seabios roms/vgabios"
> +DIRS="$DIRS roms/seabios"
>  LINKS="Makefile"
>  LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
>  LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
>  LINKS="$LINKS tests/plugin/Makefile"
>  LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
>  LINKS="$LINKS pc-bios/s390-ccw/Makefile"
> -LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
> +LINKS="$LINKS roms/seabios/Makefile"
>  LINKS="$LINKS pc-bios/qemu-icon.bmp"
>  LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
>  LINKS="$LINKS tests/acceptance tests/data"
> @@ -8424,7 +8424,7 @@ export target_list source_path use_containers
>  $source_path/tests/tcg/configure.sh)
>  
>  # temporary config to build submodules
> -for rom in seabios vgabios ; do
> +for rom in seabios; do
>      config_mak=roms/$rom/config.mak
>      echo "# Automatically generated by configure - do not modify" > $config_mak
>      echo "SRC_PATH=$source_path/roms/$rom" >> $config_mak
> 


