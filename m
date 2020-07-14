Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ECC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DFC22365
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKSmPAvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DFC22365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLHZ-000298-Cg
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLGw-0001je-4z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:47:02 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLGu-0001zP-Ia
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:47:01 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mn17so1608464pjb.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VO4EsOLQ9zXwlMNSKCL8OMCJ7tgsj7zp6bxn6FBaSJ8=;
 b=CKSmPAvi0g/DKbCED6JAcwjRzRpliE1P8IGZVUI+iyKa2N2+BczuUxj0Qy0D4AdQ0S
 xLsJqw7ub/v4aR7bkNKU8fptx+rYa0AnuNcou4dG6PH2HFdWWat6pn645CODwQZSHH/E
 HEw7jMOcpG7HCl6SoVd/9wYzs5tIQMuTy/z2mH/8bgubNuh3dEu1ZG/EvtNXQtqeK+D0
 PEngEKZuAYgNLNtApP6qhVrtbPeR6gF9Ti3AihpRnRcR2FoC2ZMQTug5F9/eC5RkEABr
 d0UYRy4ld+Ew60uQmeX7JEdWoQSWkCbNznZmlCLofrktKMapq+dwFfOZkNOD+afCW3H7
 HKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VO4EsOLQ9zXwlMNSKCL8OMCJ7tgsj7zp6bxn6FBaSJ8=;
 b=NXDWjjNr3nJxweexsL0BZf/xvqxhiIfaa4cXpqGaBImO/sktQ5CGBU0/6SU157eh2i
 holnOIGxo7Y17GpNkpqgCGKSszl+kzC07RubbgotzSD1lJDAqajPd342yJli3KyGMy9E
 QrOoUaq3ykapWttrrzxVNAxecUOdS0e5HMDPHuCzZLihGT6ajA/lNehRoT1uEZ480zJ3
 hW5V6NAiFbA26IvBUMBQ4gG6tirMgLQoe5jp5YSxjfLhRldzbyhcJqa5J/12xiPIFPnm
 LKZ9tzIGtYzU+s9lHrFx671QS5tFb5rdjQSzFGdUaAuRELJ9yYHK3nLQQm5sQy+lI+v6
 p9eA==
X-Gm-Message-State: AOAM533flHsr+Ny/YF01PqmhWncibi4/7ywBDsfgLJlZXNNuX+0BX/E2
 oKZZOqNZ8lTcJmjndseO2OFDnp9fiF4=
X-Google-Smtp-Source: ABdhPJwWui9Zfff+kqd4a61K/bOX4twsvsp/Rr3mRcQm5N2gTiii204WVgZxww2JEM8b708V9O5umw==
X-Received: by 2002:a17:90b:19d4:: with SMTP id
 nm20mr5073548pjb.206.1594734419081; 
 Tue, 14 Jul 2020 06:46:59 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id az13sm2622039pjb.34.2020.07.14.06.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:46:57 -0700 (PDT)
Subject: Re: [PATCH] migration/migration.c: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600433-23107-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <191131ec-cc26-3db6-bb97-a17c687ba2b8@linaro.org>
Date: Tue, 14 Jul 2020 06:46:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600433-23107-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:33 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  migration/migration.c | 2 --
>  1 file changed, 2 deletions(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

