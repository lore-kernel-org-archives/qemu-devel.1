Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DB4C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 15:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE200206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 15:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOsk0TvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE200206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJgFh-0000qb-38
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 11:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJgEe-0008V7-96
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 11:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJgEc-0002mL-NI
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 11:56:44 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJgEc-0002kD-CE
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 11:56:42 -0400
Received: by mail-pf1-x444.google.com with SMTP id v4so8968051pff.6
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZpqDtJNiTrDdHKUPEGMugxzNUKMrW/D2GgZfRfu7UHA=;
 b=GOsk0TvXcIbDyTP8CCukWLgQhDGZ/1i8Yik3vIVuzruTd97uEQ4p1qq6dJy7kBbTbj
 a09GPW2yMarSILUXw4LC2yYPHDjmQ0VilWffOC7Toxki5Zx+160A5/g9vkJWxpjCXxBK
 7dKedVVVKjQ3YHuCA855EcCSQFCYs3G+A4ANfRaLpygFbgBDWuxEvs1dhkQaGNa5nG9P
 /Wriob6dg5+bSysGlfuJCho0CzWCBDvL5UfbmppKwbVVpaokcHd3GpMjS3hxxR+zkmPH
 HFW/l1stPyyQRj/clTl3l/PG9vKhGxJ0T7FozZ87uVYqjpJdrnkCHeeZb+NQ8RvrUrTi
 JKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZpqDtJNiTrDdHKUPEGMugxzNUKMrW/D2GgZfRfu7UHA=;
 b=Fsitk53DjZsmMjTVVFApEvg7GLyNcXOo80vRVob5J8tT1B2gENoiRaQtbZJ9MgrBna
 dIIFpswsnz8DlWHfsdj0INWOOc55FNJfzutBtRHBAqhZTLFg7W1paO3yIScGBbfk7JyQ
 M6mY3dkn9r5IPxXzPpCN3VF1fDqFYxW+omjSyaJE97PCpVb2/dExQ1CC9k9MtviThvFS
 u7iV+AguDwlJr3cMJcSaJ9r2NFJ4uVf+MyjOprWz4xAQz0ZUm9z8psLLENqqTKKuaOAZ
 vPHjG4EZEYXHzX5HBwwMTicn5MVrr5xCjUrlhUX6zScV/oNmI2eeGDDrS+9W2QkvdEp6
 JhDA==
X-Gm-Message-State: APjAAAUSstP5++u+HqIDCpUoVvrQZaoMSQBXAXqBoAhwAs9exr5IUpgt
 ruzicR+wo3f+XAB1gty2WHcncg==
X-Google-Smtp-Source: APXvYqyeeAnfaJykAKuqcvxg7izyt41OO7f5+zuihMJX6Dq7DJKDQN1Qi97bCMFuzJaGaKKXFaEoZg==
X-Received: by 2002:a17:90b:945:: with SMTP id
 dw5mr31524423pjb.34.1570982200754; 
 Sun, 13 Oct 2019 08:56:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 196sm24404695pfz.99.2019.10.13.08.56.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Oct 2019 08:56:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
To: Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com,
 ehabkost@redhat.com, imammedo@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, den@openvz.org,
 marcandre.lureau@redhat.com, kraxel@redhat.com, mst@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mark.cave-ayland@ilande.co.uk, david@gibson.dropbear.id.au,
 yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com, sw@weilnetz.de
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-2-richardw.yang@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <41a924dc-f91b-c03b-4f82-570757105798@linaro.org>
Date: Sun, 13 Oct 2019 11:56:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191013021145.16011-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/19 10:11 PM, Wei Yang wrote:
> Use ROUND_UP() to define, which is a little bit easy to read.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  include/exec/cpu-all.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index ad9ab85eb3..255bb186ac 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -220,7 +220,7 @@ extern int target_page_bits;
>  
>  #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
>  #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
> -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
>  
>  /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
>   * when intptr_t is 32-bit and we are aligning a long long.
> @@ -228,9 +228,8 @@ extern int target_page_bits;
>  extern uintptr_t qemu_host_page_size;
>  extern intptr_t qemu_host_page_mask;
>  
> -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qemu_host_page_mask)
> -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size - 1) & \
> -                                    qemu_real_host_page_mask)
> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size)


No, please.

(1) The compiler does not know that qemu_*host_page_size is a power of 2, and
will generate a real division at runtime.  The same is true for
TARGET_PAGE_SIZE when TARGET_PAGE_BITS_VARY.

(2) The first hunk conflicts with an in-flight patch of mine:

https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04526.html


r~

