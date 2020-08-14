Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0854C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F26205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Go+yU8ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F26205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6fCR-0001Bq-OW
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 15:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6fBT-0000ED-2m
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:16:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6fBR-0003ja-B6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:16:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id r11so4997192pfl.11
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=InNc5iHyglONxzuoFETmtv9+FjywY4fvZ1hOaUZz9Ek=;
 b=Go+yU8ZWD14hiW26+P60cZUQGFT7K7OML/yNyMI0w0jeT3XBbgobsCnQ/FwcrRMRCD
 KP2limwFF1f4/PwNvXVKlvz4ImfcWGdjXYvxVQ8APzgGblPY3jvtuIgJEG078XcNWOAc
 Ch0onKUeFUlTTJEc3AWKGvC6AMWbhmbAPT3a5G8yjX2zmh3m4MGbnOaICwJ+aqgsvTJD
 Bp/1qKbYj9pO0fOnkQm+4jFlNxXXlP31DiJVMI9xZKf8LgR3frqkdqnpltCC7cMzgyYe
 m3A4uEz9LETo21oH7DQiyBfmnTMVPTsi+0vmU3INbyFvhPk0uXMVuIyFMd5c6godmZeE
 lUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=InNc5iHyglONxzuoFETmtv9+FjywY4fvZ1hOaUZz9Ek=;
 b=pZ84QxRAwH1OiLWTu7dgUlVX+Bh9AKNtjmyRMjuidTA6JTOFq5Yr3/VX9xUu+5AwdX
 JMCP2HzcKGgSpAmKVziPaBD/k7X75N7IVIVGbMXUf98FbPRbKcYgsKvba73TdDgI2002
 LuuFW7g7yhoHbN6X5T+CuBXj2cf2N8K+CzzaLizuDTlEIwrJVnEGyKqLO/N9NC3tj3g+
 JAUe9PloqBf9XVNRNnO+oImRi+5OapHwN8Qz+bBhn4X+ZLHKrzP5/MFtPeSZ0CiF2ISt
 GQWCAWN8q7El0wOHm3+nRVJCbQ4n0A5KP72YHn+VodFazRqblC1cv18DiVkD4JaICk5k
 XIRw==
X-Gm-Message-State: AOAM531nO0TcKEIO+B1utn2ZrFEryi4mJ6vi2QjC1FebByr9QgFgOU9y
 wxPr/aJ2H0wBE0+h9OdsYIGkHww2qS73iQ==
X-Google-Smtp-Source: ABdhPJxGynV3G8Z3Ck5JHTQcJHWQTUWke9ka7g9qSDz5q+rcoEpegOMT5kkRBcS2I71JLC89eEthYg==
X-Received: by 2002:a63:3157:: with SMTP id x84mr2643857pgx.256.1597432567709; 
 Fri, 14 Aug 2020 12:16:07 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x22sm9981761pfn.41.2020.08.14.12.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 12:16:07 -0700 (PDT)
Subject: Re: [PATCH 2/7] target/arm/kvm: spe: Add helper to detect SPE when
 using KVM
To: Haibo Xu <haibo.xu@linaro.org>, peter.maydell@linaro.org
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <76aa68f9ec73ced85070b81ef5251771ca27d072.1596768588.git.haibo.xu@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <25bc0f3e-49d7-b98a-760e-4ef091a449b9@linaro.org>
Date: Fri, 14 Aug 2020 12:16:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <76aa68f9ec73ced85070b81ef5251771ca27d072.1596768588.git.haibo.xu@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 1:10 AM, Haibo Xu wrote:
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  target/arm/kvm.c     |  5 +++++
>  target/arm/kvm_arm.h | 13 +++++++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

