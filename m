Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5026E214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK4uMn7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5026E214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmdk-00064m-8j
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmd0-0005eD-AY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:14:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmcy-0007B5-MY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599844463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdOkU6KDB+zqpvG4B96bXuMbnp+ZRtfRyFz0sHWDg7I=;
 b=fK4uMn7LDT+FwqbYhGoajL/1cUtv+n7yxerxDMlvwKyzQzG3fpW5QGhbkYFi3XNdH4Z7Lp
 iw6RCm8IBl+MzOfdT/GCOPy4j6TJR8FwbCBUcdhQvfh5sEqRiI+QkyVrBj757zT1iaL5Hj
 zi+YHvSQZmckxJO4wYtSCjf4+Dbn+FE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-5kvUJbHQP8uVORGEKAfomA-1; Fri, 11 Sep 2020 13:14:20 -0400
X-MC-Unique: 5kvUJbHQP8uVORGEKAfomA-1
Received: by mail-wm1-f71.google.com with SMTP id m25so1181745wmi.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fdOkU6KDB+zqpvG4B96bXuMbnp+ZRtfRyFz0sHWDg7I=;
 b=kbGDc9/tebXB/LyPhBqe6P54FmvI/yKTlj3cJvBVYzIXHOl0iZsbW7fkXqc4AfRecC
 5p0WJuicr72TsKwWfsUQXT4yZUrvgU5p8rGYsFwbDJUAV/uD00rNTn3eyq5s7qZ4edO8
 7U+a235C7xWLfF/Z4jK5uS7vYGcxDPaIzI4Q4ZioItpKz5+HEfbLgnRsJDcTrRgrj9YI
 a287DDQKP2MVdRm2Zo8Y+dIR9B9dOYRIedZ3U9J//sSuKgZzI6FQePf00q8rKMCFL3+X
 HRsAOwKxsaHKBkNHPyBv5f1VLGeeq8DUENE3rnOlMA2QdMx0neJned7Tucjz2PoDcZp8
 ek/Q==
X-Gm-Message-State: AOAM532A5zfu79OhrEX4+WDSz/GAiKS+PHW71OBWUqfWu8Scwu90bz9F
 T2s4fdma0NWaNjMbr1aykJHBB0kKDXVKiPdrbIPyokZSTeCnlzY7ku+4CNKbjWhRqIbVMdKRJML
 mbZuVtwNzP6+mqHM=
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr3122423wma.111.1599844459277; 
 Fri, 11 Sep 2020 10:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7mOF/wXJBKx0MVW7PzG/kpDk9Vf72zWNtCCayAfY0Yvs5pBf5eBQWU+7Ipxmdq15Da8wr0Q==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr3122383wma.111.1599844458788; 
 Fri, 11 Sep 2020 10:14:18 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id f6sm5726023wro.5.2020.09.11.10.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 10:14:18 -0700 (PDT)
Subject: Re: [PATCH v2] configure: Do not intent to build WHPX on 32-bit host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200910054516.405777-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d57351c5-13bd-1ba9-9b54-0ac4459daeb1@redhat.com>
Date: Fri, 11 Sep 2020 19:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910054516.405777-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 07:45, Philippe Mathieu-Daudé wrote:
> Hyper-V is available on 64-bit versions of Windows,
> do not try to build its support on 32-bit versions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v1: Handle MinGW automatic detection (Thomas, Stefan)
> ---
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 4231d56bcc0..91c5d781845 100755
> --- a/configure
> +++ b/configure
> @@ -2980,7 +2980,10 @@ fi
>  
>  ##########################################
>  # Windows Hypervisor Platform accelerator (WHPX) check
> -if test "$whpx" != "no" ; then
> +if test "$whpx" = "yes" && test "$ARCH" != "x86_64"; then
> +  error_exit "WHPX requires 64-bit host"
> +fi
> +if test "$whpx" != "no" && test "$ARCH" = "x86_64"; then
>      if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"; then
>          whpx="yes"
>      else
> 

Queued this one instead.

Paolo


