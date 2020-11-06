Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5519C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22F120735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhnmDs5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22F120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6d8-0000EP-QK
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6b8-0007L8-9h
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:36:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb6b6-0006OY-SH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:36:29 -0500
Received: by mail-wr1-x442.google.com with SMTP id w1so2329083wrm.4
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=m5y+DtkcIdBwD4EiUYYjeofpoF72jpzZrd9LManDMxg=;
 b=BhnmDs5JQBN1qwwUeywmOyOPnx2dvpQeq2TtAflRbXC9Oogxp749Y3FhD/uR9IfrEp
 Q0QBOTiEKrtxP5iMCXYBIli8J0VgaO5qrFCO3j9oPnhPZFYcbt3endykgUQ/oySjUiZ7
 oBJrh55fC76yG3zShASCqzDk5F6RwFeLa2jfw4r9aVArpbiCJkwOS5ulMjLmEf0rpny6
 iNXIVwhg6tJHModrg2fJygkDgIGyraJ32ahI8VkfKeDsoDn9lFrOEhShEus/KFkoQUcg
 Un9chsZ48PfOkMg/8UBNEIj98b6vOnJYFyZ5YEOzkx6HDXbJeeV2Ho4wZBnQxTwvC9jP
 UJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m5y+DtkcIdBwD4EiUYYjeofpoF72jpzZrd9LManDMxg=;
 b=hDAmNUkOllQCSc2w/PoGDRa5LASFdAnuny3nHBYGrctsOwq9cvoWO0OvU2PfB/1yUZ
 JEdXYSNF4+nSRPKWe7Y8OWXyIaGIf27HNgT+nB3Ezzuy8pi6Qrt7JyFlWbXnpiTx6Xgi
 Du3K/RQ5BCsvmkOhuDliw5FbVizSuU7Hm5Nas25gwu4+5j630G9LtBvmLnd2PmKcSTGO
 AOJ/5UT1ZRn55PShKZnsN4o9o6OG/3uuzbPvfnFOo9k9gUlIN9jVXw1TUvj3HjlUCXCk
 G9rTutoqa7aggCf9Ot3QxJTJqvUv8nUnFtfCkt8KIkI/sqyb3xha6fmUcxIVnZ7xYX04
 etsA==
X-Gm-Message-State: AOAM530GnsVS6nqp/d5fJYZ9G7N1hE/TRjrBihxCnthRKJDm560YPyJm
 myY8RNTFgjoSpi9ebTG0cW8=
X-Google-Smtp-Source: ABdhPJwaJo5IFPal31iog0nbAsIr5OV398jmE8SUsLhgtPPQ3DpneJLWi/ear+PIrhlqaVQNqnlBxQ==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr3866630wrq.327.1604687786232; 
 Fri, 06 Nov 2020 10:36:26 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o11sm3562088wre.39.2020.11.06.10.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 10:36:25 -0800 (PST)
Subject: Re: [PATCH for-5.2 4/4] hw/net/ctucan_core: Use stl_le_p to write to
 tx_buffers
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-5-peter.maydell@linaro.org>
 <b545a78d-7b11-7c6d-cdf7-bf20272b8fd6@amsat.org>
Message-ID: <89ffeb58-4553-74aa-809a-96e8870c2ba4@amsat.org>
Date: Fri, 6 Nov 2020 19:36:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b545a78d-7b11-7c6d-cdf7-bf20272b8fd6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 7:31 PM, Philippe Mathieu-Daudé wrote:
> On 11/6/20 6:11 PM, Peter Maydell wrote:
>> Instead of casting an address within a uint8_t array to a
>> uint32_t*, use stl_le_p(). This handles possibly misaligned
>> addresses which would otherwise crash on some hosts.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/net/can/ctucan_core.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
>> index f2ce978e5ec..e66526efa83 100644
>> --- a/hw/net/can/ctucan_core.c
>> +++ b/hw/net/can/ctucan_core.c
>> @@ -305,8 +305,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
>>          addr %= CTUCAN_CORE_TXBUFF_SPAN;
>>          assert(buff_num < CTUCAN_CORE_TXBUF_NUM);
>>          if (addr < sizeof(s->tx_buffer[buff_num].data)) {
>> -            uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data + addr);
>> -            *bufp = cpu_to_le32(val);
>> +            stl_le_p(s->tx_buffer[buff_num].data + addr, val);
> 
> Out of curiosity, how did you notice? Passing by while reviewing?

$ git grep -P '^\s+\*.*=.*(cpu_to.*|to_cpu)\('|wc -l
82

