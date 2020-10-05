Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B81C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C949020774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="RjDZSt5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C949020774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMwA-0004mi-Qo
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 05:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kPMvL-00047P-OJ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:36:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kPMvK-0000RJ-2C
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:36:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so8730252wrt.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=NI2NYnvgCsYHpn2kg5KdTdTYfaKgGuznw3wY1CC5/Ug=;
 b=RjDZSt5YTgia73nAdseunep7abJpnuebHDaRKK6skvaslaLZcgDag67bcx4GccDtF3
 PLcmKtJGbQIZv/Dj8AX5hPUZY4BXQD7GFMo1rn+oVv9VDFuX2m7ffWDdkVVrBVEj2kNL
 b9yuYUMt3chJbC0W2xnxY6V8vb7moeauXWLxqX0ezB+qL2S5jMfQ+npZgkjQXpCaBtfk
 Vv5xnQRrJ88fIwtFLcQvV+WzTrzXvb2eb+dX7ezO0Y/A3s7M9Sf2VzZGt9/wFXwcXCTD
 y6U3aUx5g/dm/I5Ty8+XpDg34PB4AR6m1giv7Jstv6G6fT3JmYXJDSkD4d+YvUbxEik+
 Hegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NI2NYnvgCsYHpn2kg5KdTdTYfaKgGuznw3wY1CC5/Ug=;
 b=chF57uBfpPqAqXLiPMeVTPhqSPRglpbDr0pyp/aJWuTZET84sQ3GAN/xxfELsuD//K
 3ehaL2Q9yXyBdWql72kOWnTaJArzukNLaJ+63TPdW47v1qj1ff4xeUymcXx39sN7efBo
 Glif2RLNMqWFEBd3CM526tNBHdfombWYnIthoVlTsEvbLZ0dLXv9G8lHfM03ScwRZ68O
 ruVi7w9jpcmMpgXsEpWrEswjs/MBBnGs0UT144HHw1k3iNNmi1nYFhusDcqLLKBbIWcd
 UOnmmXr3GTcwZxCWo/0C+/qPoEM4zJzZ15fFOgBNemP5mWGERE5Bb4Dho4DrmFmdFHPb
 dRjw==
X-Gm-Message-State: AOAM530zHq2MPtGWTFv0nXzpTIzTfVhmm7k0eKOJRWivGO2gXgXtric3
 8DMr6JSXLyOFdoWN//mJmq4a7g==
X-Google-Smtp-Source: ABdhPJxrETcnSv05NO29FtSJWZhzA/ZnjUu6Xk2CwI+MTRmS3Xg4bI0LOqX/xuYuA3Kua3gXDoPNWQ==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr10443906wrn.110.1601890608002; 
 Mon, 05 Oct 2020 02:36:48 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id q20sm11769707wmc.39.2020.10.05.02.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:36:47 -0700 (PDT)
Date: Mon, 5 Oct 2020 10:36:45 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 10/21] contrib/gitdm: Add Nuvia to the domain map
Message-ID: <20201005093645.3a364q5vvrwnsgu2@xora-monster>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-11-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201004180443.2035359-11-f4bug@amsat.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Leif Lindholm <leif@nuviainc.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 04, 2020 at 08:04:32PM +0200, Philippe Mathieu-Daudé wrote:
> There is a number of contributions from this domain,
> add its own entry to the gitdm domain map.
> 
> Cc: Graeme Gregory <graeme@nuviainc.com>
> Cc: Leif Lindholm <leif@nuviainc.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Graeme Gregory <graeme@nuviainc.com>

> ---
> One Reviewed-by/Ack-by from someone from this domain
> should be sufficient to get this patch merged.
> ---
>  contrib/gitdm/domain-map | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> index 39251fd97c..d7dca5efd4 100644
> --- a/contrib/gitdm/domain-map
> +++ b/contrib/gitdm/domain-map
> @@ -25,6 +25,7 @@ codesourcery.com Mentor Graphics
>  microsoft.com   Microsoft
>  nokia.com       Nokia
>  nutanix.com     Nutanix
> +nuviainc.com    NUVIA
>  oracle.com      Oracle
>  proxmox.com     Proxmox
>  redhat.com      Red Hat
> -- 
> 2.26.2
> 

