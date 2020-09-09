Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E70C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DE420758
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyTnhgWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DE420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2eK-0001up-KJ
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG2dA-0000uo-PF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG2d8-0004o7-HF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599667648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Uen1zQ03UCNBS0tMR0NsJEQYDnVTJlnMGc3Wshw14MM=;
 b=LyTnhgWVI+LyCygHoTbde/yNe8u1b1CQMmcJtMhVrJ9YX4YVC079COQenXBC32tnvcu0jz
 eJHOzb+Kf2LxB9bu+gXblbG/HSo96G/E2F0c3JCAUoJAo7RlnIg1R7Siq0cTuN/+rDnPOf
 jmnFkd9ikKI+M+kgqsZ5kxiT+ZumAjA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-w1yBnBsKORy3BtYKXlRykw-1; Wed, 09 Sep 2020 12:07:27 -0400
X-MC-Unique: w1yBnBsKORy3BtYKXlRykw-1
Received: by mail-wm1-f70.google.com with SMTP id g79so915473wmg.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 09:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Uen1zQ03UCNBS0tMR0NsJEQYDnVTJlnMGc3Wshw14MM=;
 b=jqX9y4oxFCUbwFRCBD8RaN4e955Vr3VdDcFg/6pPXbFx1M5cjlE815hvKsOd7w9jl9
 GUp/3/LN2NOSTGZcF/WsnfbOwVs7OpKmQjnRfcgcu7qn3oVO5SCWJooVH7YBa5eMdWoP
 UlDCRwuzQWAQ1olfaamPQDAPni14vs/OBcxtd/v+krhxgRxpYSwmMfOzZczMMbfwUOGh
 /9n2KeKuJjA3npZxLz+5Mpw/rCnV31GWo9/u1xVwyNzvx5gTtI0o4BTwneQms5Cj1yVZ
 Ydah3tPgMe8FxlINuuV7i5IF68QG5lMo+EVZ47jgkOEZ5R1PS6DRjb5DOikJZlOTQej/
 K/dA==
X-Gm-Message-State: AOAM530AZvZskXm7pwAl6EsNEShP5BfS5s3krgjrwSm+ZnkffAnx5zKF
 mipBbNgwve9y1kfmUDdTqFVNGK0V8/THxOIc8j8zP4gBmyJlcjU128P/m+M0MXu0srPqVkSF+i5
 w4vbc+Sm4B57G+JQ=
X-Received: by 2002:adf:e989:: with SMTP id h9mr5152362wrm.38.1599667645994;
 Wed, 09 Sep 2020 09:07:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpv/+XHwWKr4EUMMfP0obi4T7UUMz99B/UguEmXxXoOHuyc4LOlcgL42h4en7XlWq29SbxSg==
X-Received: by 2002:adf:e989:: with SMTP id h9mr5152325wrm.38.1599667645555;
 Wed, 09 Sep 2020 09:07:25 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z15sm4694479wrv.94.2020.09.09.09.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 09:07:24 -0700 (PDT)
Subject: Re: [PATCH v2] Simplify the .gitignore file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200909080305.258961-1-thuth@redhat.com>
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
Message-ID: <2fdc9691-2fd6-d453-be45-8140b0afa429@redhat.com>
Date: Wed, 9 Sep 2020 18:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909080305.258961-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 10:03 AM, Thomas Huth wrote:
> Now that we always do out-of-tree builds (and the in-tree builds are
> faked via a "build" directory), we can simplify out .gitignore file
> quite a bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Do not delete the .sdk, stgit and coccinelle lines 
> 
>  .gitignore | 152 -----------------------------------------------------
>  1 file changed, 152 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index b6fdd34ddf..5515f595e6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,163 +1,11 @@
>  /GNUmakefile
>  /build/
> -/.doctrees
> -/config-devices.*
> -/config-host.*
> -/config-target.*
> -/config.status
> -/config-temp
> -/tools/virtiofsd/50-qemu-virtiofsd.json
> -/elf2dmp
> -/trace-events-all
> -/trace/generated-events.h
> -/trace/generated-events.c
> -/trace/generated-helpers-wrappers.h
> -/trace/generated-helpers.h
> -/trace/generated-helpers.c
> -/trace/generated-tcg-tracers.h
> -/ui/shader/texture-blit-frag.h
> -/ui/shader/texture-blit-vert.h
> -/ui/shader/texture-blit-flip-vert.h
> -/ui/input-keymap-*.c.inc
> -*-timestamp
> -/*-softmmu
> -/*-darwin-user
> -/*-linux-user
> -/*-bsd-user
> -/ivshmem-client
> -/ivshmem-server
> -/libdis*
> -/libuser
> -/linux-headers/asm
> -/qga/qapi-generated
> -/qapi-gen-timestamp
> -/qapi/qapi-builtin-types.[ch]
> -/qapi/qapi-builtin-visit.[ch]
> -/qapi/qapi-commands-*.[ch]
> -**/qapi/qapi-commands.[ch]
> -**/qapi/qapi-emit-events.[ch]
> -/qapi/qapi-events-*.[ch]
> -**/qapi/qapi-events.[ch]
> -**/qapi/qapi-init-commands.[ch]
> -**/qapi/qapi-introspect.[ch]
> -/qapi/qapi-types-*.[ch]
> -**/qapi/qapi-types.[ch]
> -/qapi/qapi-visit-*.[ch]
> -!/qapi/qapi-visit-core.c
> -**/qapi/qapi-visit.[ch]
> -**/qapi/qapi-doc.texi
> -/qemu-edid
> -/qemu-img
> -/qemu-nbd
> -/qemu-options.def
> -/qemu-options.texi
> -/qemu-img-cmds.texi
> -/qemu-img-cmds.h
> -/qemu-io
> -/qemu-ga
> -/qemu-bridge-helper
> -/qemu-keymap
> -/qemu-monitor.texi
> -/qemu-monitor-info.texi
> -/qemu-storage-daemon
> -/qemu-version.h
> -/qemu-version.h.tmp
> -/module_block.h
> -/scsi/qemu-pr-helper
> -/vhost-user-scsi
> -/vhost-user-blk
> -/vhost-user-gpu
> -/vhost-user-input
> -/fsdev/virtfs-proxy-helper
> -*.tmp
> -*.[1-9]
> -*.a
> -*.aux
> -*.cp
> -*.exe
> -*.msi
> -*.dll
> -*.so
> -*.fn
> -*.ky
> -*.log
> -*.pdf
> -*.pod
> -*.cps
> -*.fns
> -*.kys
> -*.pg
> -*.pyc
> -*.toc
> -*.tp
> -*.vr
> -*.d

Yeah!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> -!/.gitlab-ci.d
> -!/scripts/qemu-guest-agent/fsfreeze-hook.d
> -*.o
>  .sdk
> -*.gcda
> -*.gcno
> -*.gcov
> -/pc-bios/bios-pq/status
> -/pc-bios/edk2-*.fd
> -/pc-bios/vgabios-pq/status
> -/pc-bios/optionrom/linuxboot.asm
> -/pc-bios/optionrom/linuxboot.bin
> -/pc-bios/optionrom/linuxboot.raw
> -/pc-bios/optionrom/linuxboot.img
> -/pc-bios/optionrom/linuxboot_dma.asm
> -/pc-bios/optionrom/linuxboot_dma.bin
> -/pc-bios/optionrom/linuxboot_dma.raw
> -/pc-bios/optionrom/linuxboot_dma.img
> -/pc-bios/optionrom/pvh.asm
> -/pc-bios/optionrom/pvh.bin
> -/pc-bios/optionrom/pvh.raw
> -/pc-bios/optionrom/pvh.img
> -/pc-bios/optionrom/multiboot.asm
> -/pc-bios/optionrom/multiboot.bin
> -/pc-bios/optionrom/multiboot.raw
> -/pc-bios/optionrom/multiboot.img
> -/pc-bios/optionrom/kvmvapic.asm
> -/pc-bios/optionrom/kvmvapic.bin
> -/pc-bios/optionrom/kvmvapic.raw
> -/pc-bios/optionrom/kvmvapic.img
> -/pc-bios/s390-ccw/s390-ccw.elf
> -/pc-bios/s390-ccw/s390-ccw.img
> -/docs/built
> -/docs/interop/qemu-ga-qapi.texi
> -/docs/interop/qemu-ga-ref.html
> -/docs/interop/qemu-ga-ref.info*
> -/docs/interop/qemu-ga-ref.txt
> -/docs/interop/qemu-qmp-qapi.texi
> -/docs/interop/qemu-qmp-ref.html
> -/docs/interop/qemu-qmp-ref.info*
> -/docs/interop/qemu-qmp-ref.txt
> -/docs/version.texi
> -/contrib/vhost-user-gpu/50-qemu-gpu.json
> -*.tps
>  .stgit-*
>  .git-submodule-status
>  cscope.*
>  tags
>  TAGS
> -docker-src.*
>  *~
>  *.ast_raw
>  *.depend_raw
> -trace.c
> -trace-ust.h
> -trace-ust.h
> -trace-dtrace.h
> -trace-dtrace.dtrace
> -trace-root.h
> -trace-root.c
> -trace-ust-root.h
> -trace-ust-root.h
> -trace-ust-all.h
> -trace-ust-all.c
> -trace-dtrace-root.h
> -trace-dtrace-root.dtrace
> -trace-ust-all.h
> -trace-ust-all.c
> -/target/arm/decode-sve.c.inc
> 


