Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CE520723
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6gu3Eb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CE520723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheCB-00050j-Qk
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheBD-0004IU-K0
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:08:31 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheBC-0002ka-SI
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:08:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id y17so5021305plb.8
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=09zam8zRfNHK0k0a+67L7kWzXqPFefJW9hRAZoPOo50=;
 b=y6gu3Eb3SKD5qTywGP6VhEi+8PPTOpVV+MeDAwpiDM7AwRT8YWv1z9gtOV25WJYu1I
 myWN+Vsl5VXaGUIvG+gKpOO3Zkv2OcaaFfhRqoScPaWS3K+lDJl1GRUTJkb2h3UTJUKy
 9cNDNMBsxu0y49IhcdApOHjCWx0Kw8naoGNpOP/jofwVKQN35ZZFQLJmDY3Q6eVmS2ea
 8LTmfv4oKuruDhmdO7h2X8xiqx2jB8B8q+7sIqBcLEBRUg4CMptREZRqbvACeVnYNFlO
 9O6K6hbLynYUjQQiZPnFk/8+U6tFhwMDXf3FBNLrTdOoqk/IBsUTfH5m+xSvc0t8agXb
 wN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=09zam8zRfNHK0k0a+67L7kWzXqPFefJW9hRAZoPOo50=;
 b=AqKZ9K07Hq8Y0bh0bw5jz9uONHGzHHWTxnBPPadniE+3HnlbaL/rm6UfrPbnlxZwPA
 KbES0p7rPmfilHv3sKtxth4yBzBBcOXcPZcma7Qjv5Ymkw7ACrykmsePp1HwLJ6y1K7g
 NQyfSuic31DsTVqYtIsF03IEdiKXZ0c3HHt4xng16Vom8EDAKbRVyIJ+PUGiu2COFZ1J
 EW6zmplvpqgV99fBI1I92tZfpJGRlMMpu/NuEpccZwzC69U7Xo2DoQLTJ4HgCBTBv3cj
 wxLd5rE2Bjf/6QIi2GCYJ7SY1jNSnkawBvlL5c2h0rZ0PZf7UNlEFFWRHmaY83nI5DqR
 7cHA==
X-Gm-Message-State: AOAM532DDcxcAhWnTXTlW+friL7YtQ8/qdKQMOvYrCtiCubLcria3sDx
 TrpZcIUyWHD5n4Wwij2e/2ogrw==
X-Google-Smtp-Source: ABdhPJzGXDR0WwpCjqnmuRoK5z++aGgIwlTqpXMjP/BTZI4ie/45GpLkeCHy0ZH8gO/2eCy859pJ3Q==
X-Received: by 2002:a17:902:8303:: with SMTP id
 bd3mr15086175plb.217.1591470509473; 
 Sat, 06 Jun 2020 12:08:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m22sm11044795pjv.30.2020.06.06.12.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2020 12:08:28 -0700 (PDT)
Subject: Re: [PATCH 3/7] softfloat: do not return pseudo-denormal from
 floatx80 remainder
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 laurent@vivier.eu, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051900130.13777@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <34c9d812-4af2-a8f4-c77b-159913d87a43@linaro.org>
Date: Sat, 6 Jun 2020 12:08:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006051900130.13777@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 12:00 PM, Joseph Myers wrote:
> The floatx80 remainder implementation sometimes returns the numerator
> unchanged when the denominator is sufficiently larger than the
> numerator.  But if the value to be returned unchanged is a
> pseudo-denormal, that is incorrect.  Fix it to normalize the numerator
> in that case.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>


> +        if (aExp == 0 && aSig0 >> 63) {
> +            /* Pseudo-denormal argument must be returned in normalized
> +             * form.  */
> +            return packFloatx80(aSign, 1, aSig0);

We're now standardizing on

    /*
     * muli-line
     * comment
     */

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

