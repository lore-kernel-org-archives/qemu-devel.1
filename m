Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D5CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83320206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXcHdIOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83320206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZXD-0004CE-LY
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYZTv-0001ce-4i
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:18:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYZTr-0003Ty-4M
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589307494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1/udW/hfudiHfE0HiCrf5vcO9KbUOkm0wj1Jsrb6oU=;
 b=bXcHdIOX7p3c9T7ptpACPtZDrGoPdxNtytgtk4H7brFw5q04Iuk37W7Q4C2wBp/UIJY5Id
 VFF7n3R2bZOSYdpQ1/njx1rXL18/aJ4tpeoi9CjYrgeuZQjXcBPUabQ2n5tA34szQ0OVM7
 BvgOIDxZeAnrFDOCn/K5HRVAwlMBJc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Kaet1TNKNgGG_xtHF71T2w-1; Tue, 12 May 2020 14:18:12 -0400
X-MC-Unique: Kaet1TNKNgGG_xtHF71T2w-1
Received: by mail-wr1-f72.google.com with SMTP id z8so7278485wrp.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W1/udW/hfudiHfE0HiCrf5vcO9KbUOkm0wj1Jsrb6oU=;
 b=i1LVCQkSurbb1Tz+8NmNxsBk0ZV/xGUCGccl3fymrO1Lm3zlXZ2aTsYjUZ2tce2/vW
 nNFwsR1BrELhXfAFTdmgKwB4e0rQBV+R7im+zywOj7a9I4o6Rc7mIcDBagX6y+rvEUhb
 jHLTFDBYvDo4teEWzzD/V+GaIqgupjByMb0KXtqkFRB0W+YOOpJYDLY8No9mPd1yHVO1
 6EQkmkZoaR8o8fyym+MRqa6GA1r94abTnwLr8fdZX9h+4ZprWM2KITnNdOqZuRHIkgDv
 8yYboHb1qs8OG9/D6YTsituq1lgzKmltEfelIdONIbyLPZvajVbY9mjPevKihIBjs41v
 mylg==
X-Gm-Message-State: AGi0PuYp/VbTS8FUsnPNnxIvmJGJIitd6pTkXsbntA2esJwYthddffWY
 8D4IireImfXNLlIzaBoIlqFD5VYHpds0Wa9u/pHwHEX0HXy7qfPiJfLIS/IVdFmJXXY+zEbEz1e
 yDA8Dtf7e61m6+h0=
X-Received: by 2002:a05:6000:1104:: with SMTP id
 z4mr25118804wrw.57.1589307490969; 
 Tue, 12 May 2020 11:18:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypLrOvSSLbv+QLhFgHD3I4npx1+M3QySK3xIEFf7VldlPb4RQf52Z32zEahUWTu3OaZIrtnjhg==
X-Received: by 2002:a05:6000:1104:: with SMTP id
 z4mr25118778wrw.57.1589307490755; 
 Tue, 12 May 2020 11:18:10 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f128sm20662231wme.1.2020.05.12.11.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 11:18:10 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update Radoslaw Biernacki email address
To: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Leif Lindholm <leif@nuviainc.com>,
 qemu-arm <qemu-arm@nongnu.org>
References: <20200512170704.9290-1-rad@semihalf.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16d128a6-c07e-d2d1-129d-c4047d0da3ea@redhat.com>
Date: Tue, 12 May 2020 20:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512170704.9290-1-rad@semihalf.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 7:07 PM, Radoslaw Biernacki wrote:
> My Linaro account is no longer active and stop forwarding emails to me.
> Changing it to my current employer domain.
> 
> Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
> ---
>   .mailmap    | 1 +
>   MAINTAINERS | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6412067bde..668da447e3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -46,6 +46,7 @@ Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>   Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>   Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
> +Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
>   Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>   Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>   Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f84e3ae2c..a9d6893036 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -799,7 +799,7 @@ F: include/hw/misc/imx6_*.h
>   F: include/hw/ssi/imx_spi.h
>   
>   SBSA-REF
> -M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> +M: Radoslaw Biernacki <rad@semihalf.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   M: Peter Maydell <peter.maydell@linaro.org>
>   R: Leif Lindholm <leif@nuviainc.com>
>   L: qemu-arm@nongnu.org
> 


