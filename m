Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C614DC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 20:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3C7206EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 20:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFplq8a6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3C7206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUz7D-0000VC-OM
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 15:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iUz5Q-0007um-8E
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 15:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iUz5O-00033Y-Nq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 15:17:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iUz5O-00031I-GA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 15:17:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id u18so3365321wmc.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9lNDgQkDfCzQ/3MlGyJwzhb0EoaDDahlQMSOPxjM410=;
 b=yFplq8a6ZgGqWj//YGa/xCWerTQyz39Ex7IBLs4WKaKsyklsG1ICH7++jwykzdTFZQ
 v6dCFnnRxp4HJReq36JqaEhlyOS9P02TakQfObUFzMBJxuHwquOceY+JJNCCmJsricII
 suLettqUklvumTePT3swoQWF/GRajVtY+G7wp5mz37T3ODxd7sHqUdBuBkqzl3IFpzIm
 lMsrU7vlARf18OmMpFWHhE+vwRqdAy/+Nu9VtRHZIWg99xkwozYc6ed93WxrXhEnBWzW
 txpkDWlkpb6UBi8wdyXxz1s6wZtLs6o6GLlrHGLX98ZG0RUrZ/y97VzYsPbnZsczacTE
 DjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9lNDgQkDfCzQ/3MlGyJwzhb0EoaDDahlQMSOPxjM410=;
 b=d34+G0CUFU7wzVHf6WjbJ6gZOAEQ1cPhY6WJ783ZQvh8igJ/iEvvgEB3SgUxUkNYZN
 nvYlVAxLQGS5S+cj028ni6bDm9dvLwTgMaDT5WA9UYkEOLKMk4PMD2lu/n+3alUSgV6x
 8NKEONhZSJ5jAEdQPomlvCkDd0aOwUEG3rNlt/koQI25yUQjmv+0Juw36AsWh+XynJcx
 Ct9GDb/eYvPZNhSGs8xe2jiyV8eazmaaq51lGnh/AI7V16bSet4ryBjGZKhQVpTEwDRa
 kajhUO416CUC/aOPZsqUBK2sQYTlS/MQij94dgy2HLM6YJnNve0AHwPOKzCwQsjum39y
 cZ6Q==
X-Gm-Message-State: APjAAAUVX8dvq0PTM7Z0kAdOn3ZoIGdgelHWph2LINR5zqZoRdVzu2s9
 VOzRS33DkOD7W0AyF2hktZLfxtdoj246WQ==
X-Google-Smtp-Source: APXvYqxeqmfW5SRDiR14WaZ+auR7RVfXP+xdnO25t/oOrIXwAjin88RO5Ja2tuGLTr2+opVixcRF9Q==
X-Received: by 2002:a1c:46:: with SMTP id 67mr4761187wma.51.1573676272809;
 Wed, 13 Nov 2019 12:17:52 -0800 (PST)
Received: from [192.168.8.102] (219.red-37-158-56.dynamicip.rima-tde.net.
 [37.158.56.219])
 by smtp.gmail.com with ESMTPSA id a186sm3018233wmc.48.2019.11.13.12.17.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 12:17:52 -0800 (PST)
Subject: Re: [PULL 04/11] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
 <20191101085140.5205-5-peter.maydell@linaro.org>
 <CAFEAcA-xYWLzsfDAWWmEk4DhXcO5zqKVZMrRp9=4t9MBAasaMA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ac0c7520-2f6b-fb49-c725-37b46272c835@linaro.org>
Date: Wed, 13 Nov 2019 21:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xYWLzsfDAWWmEk4DhXcO5zqKVZMrRp9=4t9MBAasaMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

On 11/12/19 11:23 AM, Peter Maydell wrote:
>> +static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
>> +{
>> +    uint32_t start_vq = (start_len & 0xf) + 1;
>> +
>> +    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
> 
> "Subtract operation overflows on operands
> arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"
> 
> Certainly it looks as if arm_cpu_vq_map_next_smaller() can
> return 0, and claiming the valid length to be UINT_MAX
> seems a bit odd in that case.

The lsb is always set in the map, the minimum number we send to next_smaller is
2 -> so the minimum number returned from next_smaller is 1.

We should never return UINT_MAX.

>     return bitnum == vq - 1 ? 0 : bitnum + 1;

But yes, this computation doesn't seem right.

The beginning assert should probably be (vq >= 2 ...)
and here we should assert bitnum != vq - 1.


r~

