Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BC5C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F311120663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2LJfQNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F311120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCqR-0002CY-90
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfS-0001Rb-TY
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfS-0007vi-0N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfR-0007ug-PE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so3119231wma.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TlinqMiI0XnNpF5PDe6h/VtVQZwjyIh7N8OSWH29deA=;
 b=o2LJfQNp32F+LBPbs5mKuIFvKfPbjGDX2iCoxCi3E3aLoRi31GAgZhJn5AWfpQ7MMM
 Rwx+nyG23C+NrWJiMTsA7d9rY5rD8E01c8Ht5rS+faHD06V9YR1yCjcUwDC2TOggoqya
 ku28IAve7BPCqoXs6q43kPuPWeSXcWsHMPdUcVzBf3J3VRpIm8uyA8Xo3xTmGCZW2brB
 isW74UvNqDzUwQd1BmNXWbjjkWISXx9kg5G1l66yZsmC84YPYZ5P1nHmyxEsQieA/h85
 kPm9OJSEFXj9hhs8SnA6eZ5o6vJ47CXXOS5zICRF8dfaslBU+crgxZhk6cDTyEy6XoI+
 wtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TlinqMiI0XnNpF5PDe6h/VtVQZwjyIh7N8OSWH29deA=;
 b=cb+rUspBccNMO1AsiqtmPquw8Wp6VN7GqnBCbzFgXrG1Rx1XHCWXlNK7+3aoAP57AW
 89VEfBry4AOo/5A+c0FA5TBFwb4Nz2OGJmxi+sjnSRu0qV7aBuB6PvY/7iAxOm5vXice
 T97V3UNok5hJHT0Wj34Eh4sL/DrahfkAyHHzivyJnhjdgj1Ez9WZwL33P6y4b3q5mR30
 gViiXwYDE+FXxTISDKfQXZwTGgTuTt3jHhRaIg4F8HyPHAXGhjzkv5ZSR7RJdKLMv90T
 k9373mefOMqPE2lJ0GtrBwiUcqMP4wWRkfaprVlRw8B+R1V/e1As45nlFG3iP6/4zxCQ
 ZXPQ==
X-Gm-Message-State: APjAAAUIxEf85k+TlV24Adm/fOPWineCpdMyFMvpxsmNQpcSx4YzhWtd
 AVhteZYsNE5td7hCc3yL98jVjQ==
X-Google-Smtp-Source: APXvYqz3IgYAemkF6MzC5BiDq72EvLPgrxuftT+0RpZNi6zva8cr6fvkyS+Iw0JTkPOKUxMLoP7mRw==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr254634wmm.62.1561573752606; 
 Wed, 26 Jun 2019 11:29:12 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id o2sm17267186wrq.56.2019.06.26.11.29.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:11 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-13-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9fa08d2a-eecd-e7ee-9f7c-abc763ab417c@linaro.org>
Date: Wed, 26 Jun 2019 13:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-13-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 12/14] target/arm/kvm: scratch vcpu:
 Preserve input kvm_vcpu_init features
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> kvm_arm_create_scratch_host_vcpu() takes a struct kvm_vcpu_init
> parameter. Rather than just using it as an output parameter to
> pass back the preferred target, use it also as an input parameter,
> allowing a caller to pass a selected target if they wish and to
> also pass cpu features. If the caller doesn't want to select a
> target they can pass -1 for the target which indicates they want
> to use the preferred target and have it passed back like before.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/kvm.c   | 20 +++++++++++++++-----
>  target/arm/kvm32.c |  6 +++++-
>  target/arm/kvm64.c |  6 +++++-
>  3 files changed, 25 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


