Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D20204FD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7Q76IY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D20204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDV1A-0000cQ-TI
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDV05-0008AB-WC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDV04-0005Li-72
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yR6onRbUCu2efTHpxN5z/iOCCOTM/yNvUqSC0Z61Ky4=;
 b=A7Q76IY0Pd3nU4mZmydfOCS2T7ew+Na/1zDD8XQISUKvV1Z3Zjpt/Br2jQWB7p+M5T9mWF
 1dB+w0IDwFm4IcQZCyFRi1LkYusMVgHLZ2dOd+Bo/lS8jNlZjx4717KImmYt8OOpajkctG
 N14Y+hKvbjxija5dpcmu1DJwapGXTnA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-641n-SASMy-9FKpIZaoXQg-1; Wed, 02 Sep 2020 11:48:34 -0400
X-MC-Unique: 641n-SASMy-9FKpIZaoXQg-1
Received: by mail-wm1-f72.google.com with SMTP id g79so1598219wmg.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 08:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yR6onRbUCu2efTHpxN5z/iOCCOTM/yNvUqSC0Z61Ky4=;
 b=T+55Dm/i1tsveI/2+dAjFbm9W8sqFT7mDhORHR2lxG/LoDP638NCVfm7tQ1JtgEM+E
 sUcejbmaOvmR9cpTbkiakuEu9cQct+SVYiI/PWdqiaNrqMi7cjXITzzHVPdzVCDSjb5z
 cTtv3SSnURbfLSDl58Fh2zh8jgJFqKTtDSu/wkWkkZHDJ86lw0NI0l+wHnwnKaorzGQd
 93JSAngBUnRCuxl2L7nIiJd5X3xsr1nKboa0K2hOy04/6gFNsomWCyFyni74I53gi9te
 7vUPFk+GNKI+69AmwIv8Qc/6sXIK34XPZxSjPTZyxR4zHYq9E3D7X4KR0/aXmG4kRFQ1
 NqCw==
X-Gm-Message-State: AOAM531B44FyhURe9k7uNPuwaua/wYfGrhCCUN4dv9SAII511koQzFGd
 T4gylZ94qXorqzKSbPVKP5fbpDFlH0eX69ek/Q9D2gAfbs7c4mZasO7+xtvKk/59fe0BdlxRHSE
 7kPATk1VwqixF/LM=
X-Received: by 2002:a5d:5150:: with SMTP id u16mr7734090wrt.197.1599061713178; 
 Wed, 02 Sep 2020 08:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY/sVzQd8df8cSR1F5Sv4WNLonGee3v5FtyOYM2BcmrKGuwqjq1CSAv0Fn5iSpvBKaKfRBHQ==
X-Received: by 2002:a5d:5150:: with SMTP id u16mr7734075wrt.197.1599061712965; 
 Wed, 02 Sep 2020 08:48:32 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id i26sm122744wmb.17.2020.09.02.08.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:48:32 -0700 (PDT)
Subject: Re: [PATCH 2/3] fuzz: Add support for custom fuzzing library
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200902143800.124073-1-alxndr@bu.edu>
 <20200902143800.124073-3-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41c43170-d680-960a-b9ce-afd01516d6c8@redhat.com>
Date: Wed, 2 Sep 2020 17:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902143800.124073-3-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, darren.kenny@oracle.com,
 bsd@redhat.com, Thomas Huth <thuth@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 16:37, Alexander Bulekov wrote:
> On oss-fuzz, we must use the LIB_FUZZING_ENGINE and CFLAGS environment
> variables, rather than -fsanitize=fuzzer. With this change, when
> LIB_FUZZING_ENGINE is set, the --enable-fuzzing configure option will
> use that environment variable during the linking stage, rather than
> -fsanitize=fuzzer
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  configure                    | 12 ++++++++++--
>  tests/qtest/fuzz/meson.build |  4 ++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/configure b/configure
> index 6ecaff429b..4182a88e75 100755
> --- a/configure
> +++ b/configure
> @@ -6165,7 +6165,7 @@ fi
>  
>  ##########################################
>  # checks for fuzzer
> -if test "$fuzzing" = "yes" ; then
> +if test "$fuzzing" = "yes" && test -z "${LIB_FUZZING_ENGINE+xxx}"; then
>    write_c_fuzzer_skeleton
>    if compile_prog "$CPU_CFLAGS -Werror -fsanitize=fuzzer" ""; then
>      have_fuzzer=yes
> @@ -7505,7 +7505,14 @@ if test "$have_mlockall" = "yes" ; then
>    echo "HAVE_MLOCKALL=y" >> $config_host_mak
>  fi
>  if test "$fuzzing" = "yes" ; then
> -  QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
> +  # If LIB_FUZZING_ENGINE is set, assume we are running on OSS-Fuzz, and the
> +  # needed CFLAGS have already been provided
> +  if test -z "${LIB_FUZZING_ENGINE+xxx}" ; then
> +    QEMU_CFLAGS="$QEMU_CFLAGS -fsanitize=fuzzer-no-link"
> +    FUZZ_LINK_COMMAND="-fsanitize=fuzzer"
> +  else
> +    FUZZ_LINK_COMMAND="$LIB_FUZZING_ENGINE"
> +  fi
>  fi

Can you name this FUZZ_EXE_LDFLAGS?

>  if test "$plugins" = "yes" ; then
> @@ -7620,6 +7627,7 @@ fi
>  if test "$fuzzing" != "no"; then
>      echo "CONFIG_FUZZ=y" >> $config_host_mak
>  fi
> +echo "FUZZ_LINK_COMMAND=$FUZZ_LINK_COMMAND" >> $config_host_mak
>  
>  if test "$edk2_blobs" = "yes" ; then
>    echo "DECOMPRESS_EDK2_BLOBS=y" >> $config_host_mak
> diff --git a/tests/qtest/fuzz/meson.build b/tests/qtest/fuzz/meson.build
> index 3432c3e7c3..59a630802a 100644
> --- a/tests/qtest/fuzz/meson.build
> +++ b/tests/qtest/fuzz/meson.build
> @@ -9,8 +9,8 @@ specific_fuzz_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio_scsi_fuz
>  # unfortunately declare_dependency does not support link_depends, so
>  # this will be duplicated in meson.build

Also for patch 1: the comment is now obsolete.

Paolo

>  fork_fuzz = declare_dependency(
> -  link_args: ['-fsanitize=fuzzer',
> -              '-Wl,-wrap,qtest_inb',
> +  link_args: config_host['FUZZ_LINK_COMMAND'].split() +
> +             ['-Wl,-wrap,qtest_inb',
>                '-Wl,-wrap,qtest_inw',
>                '-Wl,-wrap,qtest_inl',
>                '-Wl,-wrap,qtest_outb',
> 


