Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5E5221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 08:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ib9ssucU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5E5221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMok6-0001Gv-5j
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 04:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMogN-0008Dl-6q; Mon, 28 Sep 2020 04:38:51 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:39270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1kMogK-000679-J6; Mon, 28 Sep 2020 04:38:50 -0400
Received: from [172.16.11.103] (unknown [172.16.11.103])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 4ECE321C3A;
 Mon, 28 Sep 2020 08:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1601282324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8TjYQ8RvXA/fU4PxuKnBfQ6cVO7M17iJbn3diQ3Dow=;
 b=ib9ssucUhkBOeEKx4RT/4tzBjIg+cGoDCyOHnPgqWHLeDy8WlPHEdbgxARRqQb6jqcB6kX
 mlBiFV6ddKAVwdsLMaP/Miwe+S8588GiolecsY8aRydpxgBwaQ3gXldrPodi8wLSrgY3pw
 bJub03jivghvQOkLYcaKssD3BLGlxOU=
Subject: Re: [PATCH 01/14] hw/core/clock: provide the VMSTATE_ARRAY_CLOCK macro
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-2-luc@lmichel.fr>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <88f58796-e8e6-e913-dac7-4401d117789f@greensocs.com>
Date: Mon, 28 Sep 2020 10:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-2-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=damien.hedde@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 04:38:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.011,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/25/20 12:17 PM, Luc Michel wrote:
> Signed-off-by: Luc Michel <luc@lmichel.fr>

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

> ---
>  include/hw/clock.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> index d357594df9..c93e6113cd 100644
> --- a/include/hw/clock.h
> +++ b/include/hw/clock.h
> @@ -79,10 +79,15 @@ struct Clock {
>  extern const VMStateDescription vmstate_clock;
>  #define VMSTATE_CLOCK(field, state) \
>      VMSTATE_CLOCK_V(field, state, 0)
>  #define VMSTATE_CLOCK_V(field, state, version) \
>      VMSTATE_STRUCT_POINTER_V(field, state, version, vmstate_clock, Clock)
> +#define VMSTATE_ARRAY_CLOCK(field, state, num) \
> +    VMSTATE_ARRAY_CLOCK_V(field, state, num, 0)
> +#define VMSTATE_ARRAY_CLOCK_V(field, state, num, version)          \
> +    VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(field, state, num, version, \
> +                                       vmstate_clock, Clock)
>  
>  /**
>   * clock_setup_canonical_path:
>   * @clk: clock
>   *
> 

