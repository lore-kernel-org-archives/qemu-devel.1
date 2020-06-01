Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8251BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0FE2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I62oPMhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0FE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jftSg-0004Dc-H2
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftRN-0003eo-DP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:01:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftRL-0006Wk-HA
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:01:56 -0400
Received: by mail-pf1-x441.google.com with SMTP id g5so4133093pfm.10
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MBwhioOTO5IwQ4eAH5O+LHoa1q/Fp8wPnF66132BV6w=;
 b=I62oPMhOzcriXPS+ul3GZ3PSdaR6gFw/VI6rYaWsgLSZ8o87jK+qiDYX1EXoNw31kS
 scLDgckCgcxRHkEg2fjgKy8bxunKvxEbslJjfLH2fy6LaM5eNGEKJXSuqKC6HIfcu6G5
 1sjdhL18favA4hRG5Svk//8VYxkYwBXOdsyzPGIGequ1KZD8lvxcSTYDWVUjPWFsYFo7
 tEsmo+bc63VDHcpSunMCcQE0u6kp0t20Ilhr9e1rBr3RtNQD6zpxOYs4m1eGNc+1my7L
 fBc0NJ7WzwnfwqzlafdSBOIIPoXNMPtcJ/S/aoEuXd069UT9ifyzQRCxjdFCXMxtOv9I
 tT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MBwhioOTO5IwQ4eAH5O+LHoa1q/Fp8wPnF66132BV6w=;
 b=CFktWa73dHj+JuCfiqYpRXLAH/TuRDLJo6bjfU4i/bsRdv/lylOZ/YMFx1Jq7Sgtut
 zJ4H8xNLO2rio0MZ5EEddrcdJZY3Iy9oCkISvtY3Q5GQTGM2xEivJwZzcVzCDrn/IK8+
 CLIrN1XrQJmGIqbn9pOGBLtwhEWYB8nLtEon2fwKUrKXIDAjiUeqhHykyWVIizklsyfA
 Fy5POwqp3GJatxpcsn5c4Ad3pFc/oPcbKsRlGR9/DBTfCFxPsFfgG+73gZ6Hy6iXLAiX
 BgQ/kMdStt6Qtwv2MJosHVOCu2Lmf6dGvZM59BL/RFis3RVA6pzrcNDnl6kA7wqJWURu
 CrMA==
X-Gm-Message-State: AOAM530k+o3uLU61eSG/XIxSmlzAciSfpgBq1mFf0o/JSkGhxCw1AiYa
 wfjrNScc3Zfqrv7vVIFinUONEw==
X-Google-Smtp-Source: ABdhPJzPvt0OpTdpG2XOZd3WyGBlDV5YaW9zwKW7qD/jD4rhJEvrl+u/NspFOTeBnPF68PmgpH6SyA==
X-Received: by 2002:a63:4182:: with SMTP id
 o124mr20869141pga.195.1591052509510; 
 Mon, 01 Jun 2020 16:01:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u21sm385591pfn.123.2020.06.01.16.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:01:48 -0700 (PDT)
Subject: Re: [PATCH v4 13/13] stubs: Restrict ui/win32-kbd-hook to system-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200522172510.25784-1-philmd@redhat.com>
 <20200522172510.25784-14-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ef88218-960e-0779-e40e-13ec300c3dad@linaro.org>
Date: Mon, 1 Jun 2020 16:01:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522172510.25784-14-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 10:25 AM, Philippe Mathieu-Daudé wrote:
> In Makefile.objs, the ui/ directory is restricted to system-mode:
> 
>  43 ifeq ($(CONFIG_SOFTMMU),y)
>  ...
>  65 common-obj-y += ui/
>  66 common-obj-m += ui/
>  ...
>  82 endif # CONFIG_SOFTMMU
> 
> Restrict the ui/ stub added in commit 2df9f5718df to only build
> it for system-mode emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


