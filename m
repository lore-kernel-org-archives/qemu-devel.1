Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BE1C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C0122275
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 13:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="QahjWA5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C0122275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaFs-0000K3-WC
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 08:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kZaDI-0006Xv-F3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:49:36 -0500
Received: from pharaoh.lmichel.fr ([149.202.28.74]:58734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kZaDF-00028r-EG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 08:49:35 -0500
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 8B642C60010;
 Mon,  2 Nov 2020 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1604324969;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KngahSW9XKPcsD9lJYIFsTzeKTBH7gdtMLueEsN6e1o=;
 b=QahjWA5pgJX2qUPfp9MogxZMBaAlrcNDgZPdmAIMNOSVKXy/QkGOKldLiBbOCaD9Ficb7D
 uPqCMVfkVAP22zbzs/nd6TyX1TO9xP7ss9XunkanqDARbbhcjucEyavh55igazivyHoRpo
 qVAJdbzcyEscobud5kUxWUsd6MGkHbrG7TzTsX2iGpTZ0W7H7g8DJCvWMqFA1R+QSnGthS
 VGiTCjaeu7AlEGC81aTo0Lqh4MaUvuLgJxMz6g5qCCrUf8Id2ZA48xJgyl0r92zSsZfrMT
 wvDQ8DL94A5u4wPvIBTMDmLM8XLZeCdWQwKfhwMJYyreOBzK+Wm0EeSPREV+PA==
Date: Mon, 2 Nov 2020 14:50:42 +0100
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.2 v3] util/cutils: Fix Coverity array overrun in
 freq_to_str()
Message-ID: <20201102135042.gc35bz364m3esz62@sekoia-pc.home.lmichel.fr>
References: <20201101215755.2021421-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201101215755.2021421-1-f4bug@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1604324969;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KngahSW9XKPcsD9lJYIFsTzeKTBH7gdtMLueEsN6e1o=;
 b=JhnfQLVnqXiWUnvCOvOioE1DjBJBoPq/X2bPeWrjmlnM5XHP5iYwqemkLTmFM3/E4vZunS
 L+aOhUb3PeSYr0r+baYQk5zpp88UGvHdPwfDedqLkhQyjTpXzTrMEFF4m5xZVFrMky7lb7
 mTlcwn1eh9sz1dX9pMfgSx6gNjACc25qRQOWRCOy5tvK9LdeBEqzM/gVVqsx8/Sd191/zK
 X+h6lV1jYbcaw1qLedmvgQRbbd/rLzGrp2FicaJ6TFHNwJ6wsc6N8YUGw+Bi5Kmafzjv1y
 BZBAE6LJW1SqlQoA0Npljr0yiZbON7lOre6REgYYiMz78cklkTU+mz9afu6low==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1604324969; a=rsa-sha256; cv=none;
 b=HxFZTZlQpk7rgQ2PBiX22Dw3HWgNbFRkQZSsefoSNjg225KLMJoWWHatVNwPfM0jGmnFRcW/UFp1mw3ggfmJj1/ignefoshz5UVTT2TlMevOnwOadyS2IXdpISsy+L7WwCGIimZYXXJQ4mDUZEklaiGqR4bddfCzS7bKJ/Tz4052dzEK+r+bDPDL/CvgMmI7lri2OZ8Cqq7w2i0oM4jJto/okgRMAzqpDwOUPz46ZlV5We+JZK27kOvceSf4etIhMVsL7ewBSFxlnDxXnqmfStUoId/tz1pIQGcrwXgLJCnPNRXfue2NPTcHg65JsmgXs/jlcqJLLFmR3u/UyLXyDw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 08:49:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22:57 Sun 01 Nov     , Philippe Mathieu-Daudé wrote:
> Fix Coverity CID 1435957:  Memory - illegal accesses (OVERRUN):
> 
> >>> Overrunning array "suffixes" of 7 8-byte elements at element
>     index 7 (byte offset 63) using index "idx" (which evaluates to 7).
> 
> Note, the biggest input value freq_to_str() can accept is UINT64_MAX,
> which is ~18.446 EHz, less than 1000 EHz.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
> v3: Follow Peter's suggestion
> ---
>  util/cutils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index c395974fab4..2f869a843a5 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -891,10 +891,11 @@ char *freq_to_str(uint64_t freq_hz)
>      double freq = freq_hz;
>      size_t idx = 0;
>  
> -    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
> +    while (freq >= 1000.0) {
>          freq /= 1000.0;
>          idx++;
>      }
> +    assert(idx < ARRAY_SIZE(suffixes));
>  
>      return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
>  }
> -- 
> 2.26.2
> 

-- 

