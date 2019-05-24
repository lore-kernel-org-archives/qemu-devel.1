Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29C0C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3E321848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3E321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFMs-0007VW-Qa
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:56:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUFFK-0001fB-L8
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUFFJ-0008IR-O1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:48:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hUFFJ-0008Hd-HZ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:48:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id t4so2702528wrx.7
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 11:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+gqJe3j0xGeqGTYD6iGLPjrIIcY9EDv0g/JCrJlQacM=;
	b=l5FftV6yM720+dTL7tGE0XGd6ERklZE0waKx2SR0bEfuuelaHoAMY+hcDwsNSkZX3a
	k+tQbW+Qu6pH/hIJoTq5xsctKzqb3w6wDT2grgGW8XjXQldFAjGdrgWwjiXesA50XVyt
	FNlf7/hspVCOkpwGPHkzHLA4WYVzFTQmKkIDy7KdMRNAq9g4NJqq53+iD//rAXbFv3Fb
	svFXnibsU3H2qyhnbAaM1Porog6JHhVYD9qCNy+1ebs+/EA3nRG1Y4SyRWXPYzN5VkSz
	V72rEYcAqOdCNGdoWmG0GgGdyo3WSfYt8xbELMmqTRBTPFBqfhJef8Yg3IlPftA+vUUk
	lU8g==
X-Gm-Message-State: APjAAAXsl6aluXtcNoVM34psNfTxFEGYYwyZ8/hpiRpHLnYl93c+091K
	orDwxbr04goRvlRolCZtIlIQwTPU+XQ=
X-Google-Smtp-Source: APXvYqzy7H2mbQ0W1buNcUTM+zOWMzMgpG/KJvKSYYq/CzyzoF6Itv6W4tsFPw361J/v1DXOBjcRrA==
X-Received: by 2002:adf:e742:: with SMTP id c2mr11616443wrn.249.1558723728218; 
	Fri, 24 May 2019 11:48:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4d53:18d:3ffd:370?
	([2001:b07:6468:f312:4d53:18d:3ffd:370])
	by smtp.gmail.com with ESMTPSA id
	o23sm2475616wro.13.2019.05.24.11.48.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 11:48:47 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190524181411.8599-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1539f5bb-bb62-6328-c79d-46dfe0f924b2@redhat.com>
Date: Fri, 24 May 2019 20:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524181411.8599-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] configure: remove tpm_passthrough &
 tpm_emulator
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/19 20:14, Marc-André Lureau wrote:
> This is a left-over from commit 7aaa6a16373 "tpm: express dependencies
> with Kconfig".
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  configure | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/configure b/configure
> index 528b9ff705..4da99ee750 100755
> --- a/configure
> +++ b/configure
> @@ -6434,8 +6434,6 @@ echo "gcov              $gcov_tool"
>  echo "gcov enabled      $gcov"
>  echo "TPM support       $tpm"
>  echo "libssh2 support   $libssh2"
> -echo "TPM passthrough   $tpm_passthrough"
> -echo "TPM emulator      $tpm_emulator"
>  echo "QOM debugging     $qom_cast_debug"
>  echo "Live block migration $live_block_migration"
>  echo "lzo support       $lzo"
> @@ -7133,14 +7131,6 @@ fi
>  
>  if test "$tpm" = "yes"; then
>    echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
> -  # TPM passthrough support?
> -  if test "$tpm_passthrough" = "yes"; then
> -    echo "CONFIG_TPM_PASSTHROUGH=y" >> $config_host_mak
> -  fi
> -  # TPM emulator support?
> -  if test "$tpm_emulator" = "yes"; then
> -    echo "CONFIG_TPM_EMULATOR=y" >> $config_host_mak
> -  fi
>  fi
>  
>  echo "TRACE_BACKENDS=$trace_backends" >> $config_host_mak
> 

Queued, thanks.

Paolo

