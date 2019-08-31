Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235982187F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veSA9bvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235982187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4983-0001EN-2T
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 15:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i492h-0008EF-SI
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i492f-0007qq-W3
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:28:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1i492f-0007py-Pb
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:28:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so10121579wrd.3
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=zdKNIRnvI/S9QDAUlcBwkaS2Xp64B/LoBPPm2r5+e0k=;
 b=veSA9bvEvI5F/ABgiTEndSZi7gTk+K58g29RV9gjM0+1UwbK/uqbGCcwSKXSEeyMI7
 jBPr11ydLoBUHAmUWB5jqMnB3wdQc4hDSxuEtQwOumYUUgSsjE7BYwFwjWvhH/LAz0hu
 ESU2bPrfDfsI0do4SCvrabgAfZWzv8254qlFq8RKoUfm4uhGSP/vTXyQV1nPpIPzy0gE
 EPKFFhqR/f33S8QhdhA3jDKuw8JNgBFDXbbFYvNUl0AA7RZi6r3oTH2HDav9+imGEl5e
 HwSMrwf/K25rWB7xVbmuwcCHcYflwk6Wsr+5ki5B03LF3AZqcF9bCG53QCS6WK3GX8ga
 TVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zdKNIRnvI/S9QDAUlcBwkaS2Xp64B/LoBPPm2r5+e0k=;
 b=k4gMgBXjx7BHJw8Efczzc85buUEULYxADXdYT00o4GeRjW1xaoIKcdbbCacGcklJF3
 MYj+Wi1U5gysKE6BvthHUCDxAsd+vJJ+P2fSTOe85QDDpm/JJWIzf+2GHRMHFMXhOt+f
 Feo1mSC054si2fykuzCiXPVfO/nYpCUWq9Ehn+lqhitTQyfMy9JQo4mWFvTy5MA6w9ni
 dpaObY3zjsgpHPHqQnzPToQWgS7/5+oiZZGtotaypFH166OcmX3Vp6DGm5n8iz8qMpPc
 sJ2VgPiMREG1aI9H6S/4g1WVsHIzuZ+wyMz2/2I/3s7dxqtO8nXuIK6tbv1EA6nQ3OkQ
 VMCw==
X-Gm-Message-State: APjAAAVqQoVFS5HIjbeAOiiWkWilb2bRlokI2DuSxIb5apyNkoM9zUDU
 B55Fskf338y5HgnmI8ZfvQJkSW/twMw=
X-Google-Smtp-Source: APXvYqxRwOfq56JTJbs/hRMln4rCAMCbNSTSVcLDXakGl3ub6lX7Id1ZXX1FUzuHB1KkndlbijOl+A==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr335506wrp.157.1567279688006;
 Sat, 31 Aug 2019 12:28:08 -0700 (PDT)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id s192sm9499339wme.17.2019.08.31.12.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2019 12:28:07 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>, berrange@redhat.com,
 thuth@redhat.com, philmd@redhat.com, pbonzini@redhat.com, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
 <20190818132107.18181-2-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <e9e23e9c-5fa3-0619-bb34-15a05df08c38@gmail.com>
Date: Sat, 31 Aug 2019 22:28:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818132107.18181-2-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 1/2] configure: Check if we can use
 ibv_reg_mr_iova
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



On 8/18/19 4:21 PM, Yuval Shaia wrote:
> The function reg_mr_iova is an enhanced version of ibv_reg_mr function
> that can help to easly register and use guest's MRs.
>
> Add check in 'configure' phase to detect if we have libibverbs with this
> support.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   configure | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/configure b/configure
> index 714e7fb6a1..e8e4a57b6f 100755
> --- a/configure
> +++ b/configure
> @@ -3205,6 +3205,34 @@ else
>       pvrdma="no"
>   fi
>   
> +# Let's see if enhanced reg_mr is supported
> +if test "$pvrdma" = "yes" ; then
> +
> +cat > $TMPC <<EOF &&
> +#include <infiniband/verbs.h>
> +
> +int
> +main(void)
> +{
> +    struct ibv_mr *mr;
> +    struct ibv_pd *pd = NULL;
> +    size_t length = 10;
> +    uint64_t iova = 0;
> +    int access = 0;
> +    void *addr = NULL;
> +
> +    mr = ibv_reg_mr_iova(pd, addr, length, iova, access);

Here you check if the API is changed, right?
Can you query for a library version instead?

Thanks,
Marcel

> +
> +    ibv_dereg_mr(mr);
> +
> +    return 0;
> +}
> +EOF
> +    if ! compile_prog "" "-libverbs"; then
> +        QEMU_CFLAGS="$QEMU_CFLAGS -DLEGACY_RDMA_REG_MR"
> +    fi
> +fi
> +
>   ##########################################
>   # VNC SASL detection
>   if test "$vnc" = "yes" && test "$vnc_sasl" != "no" ; then


