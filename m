Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B6EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9F6214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbdjfT2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9F6214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmcG-000592-Pd
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmbh-0004iC-HT
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:13:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGmbe-00073X-Ve
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599844381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEew7zaetB9TRx1ab8e3L550da5frXjfO4J9iCNGFb8=;
 b=WbdjfT2UNJNvDaF3/bhiZ5WSn0x/DUNyjMUW4ZtFIs0XF5MMMgK3kW6Jv2wRw2JNoB9NAA
 TuJbcSxjso7Z8Ny88E6jY1EcL2DApwdUe5V4oS34UD67tJsnLeX2ufMHkKu/nNRLphUMND
 3qqZ1kxVR4LH+KFkz2qp3a15AYW9M0E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-fmVkVUTYOsecZFfntDAnZQ-1; Fri, 11 Sep 2020 13:13:00 -0400
X-MC-Unique: fmVkVUTYOsecZFfntDAnZQ-1
Received: by mail-wr1-f69.google.com with SMTP id k13so3732272wrl.4
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QEew7zaetB9TRx1ab8e3L550da5frXjfO4J9iCNGFb8=;
 b=D+jRnePLog5qrmA7kPqfopZl+i6W2wuDAqFMJOb/qYpUCObDKiZbIu3hGBP4NyWVXB
 Lsxo08qzb1TGym8IPxrOJ+AKN7ZSD05XX0YENqfDgcqkikfnny8Aq4jzTPNTBJS2yTTI
 6feKozDVfAurBwRz17Uyal4RWhbHCtPA6TL46PNpkgIIdvapKpewrhHEPwDk8nSVBA54
 5/8cCQ+zLJ6r2AmPDJk7WinU9b8tduh0dvgFhI++Ggm5Kv0E+Q8AJsmwPqmIglMv69Na
 oy0kD1X0ixPCLm1Eb5tZcx4PTdXIWYAjChfsnirQHlLPM8zc9FMBzR47Zs5FhehbDV8t
 6X+g==
X-Gm-Message-State: AOAM531W+mBjUkLRCxik19niHnqTpVLDmF5FARya/78EHJ7y0lQFVkg3
 gyMFkOXW2G+vO/p+bKSTNgGDY5vhEibXPpNlGfW/Q2bEJfso4OdMPgD+SRoUaVQrOUjVFrx5d8X
 Hz495FOdwUUpwcHg=
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr3128870wmh.103.1599844378868; 
 Fri, 11 Sep 2020 10:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1bbIWjSO/e7cM7WVjkU6zmNQVmz9TZY+IpS/q6FFRZ6BU9iT/dRE6hak5iBU00Uf4qlMtCQ==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr3128855wmh.103.1599844378665; 
 Fri, 11 Sep 2020 10:12:58 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id t15sm5478558wmj.15.2020.09.11.10.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 10:12:58 -0700 (PDT)
Subject: Re: [PATCH] configure: Do not intent to build WHPX on 32-bit host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200909182449.360472-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12b65458-3655-4091-7060-e8d3763d57dd@redhat.com>
Date: Fri, 11 Sep 2020 19:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909182449.360472-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, Sunil Muthuswamy <sunilmut@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 20:24, Philippe Mathieu-Daudé wrote:
> Hyper-V is available on 64-bit versions of Windows,
> do not try to build its support on 32-bit versions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configure b/configure
> index 4231d56bcc0..4bd08f5469b 100755
> --- a/configure
> +++ b/configure
> @@ -2989,6 +2989,9 @@ if test "$whpx" != "no" ; then
>          fi
>          whpx="no"
>      fi
> +    if test "$whpx" = "yes" && test "$ARCH" = "i386"; then
> +      error_exit "WHPX requires 64-bit host"
> +    fi
>  fi
>  
>  ##########################################
> 

Queued, thanks.

Paolo


