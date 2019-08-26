Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428AC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33912070B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT8WUmX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33912070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Ktn-0004Xy-K3
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2Kfm-00062t-PQ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2Kfl-0002ix-97
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:29:02 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i2Kfl-0002ig-4G
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:29:01 -0400
Received: by mail-qk1-x743.google.com with SMTP id d23so15068851qko.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xIT0ESiLlCaULfyeMiqg9mmteZK4nFwTDji/sT0Tixg=;
 b=bT8WUmX6UTpKgVRIN3lXsfSis6nxbdS9lf4szsDDELJ1iDwMq+kQ6c5B2bZjKhk+8t
 Uy8+fc1QMMu5t02+4mV+sXZiFBW4HqkA5VXETLtFmwcpyH9bTgNLM9MVpAH4dY+fh3hN
 C+SAIwwH43mf9vS5UoVpO/DJ//iP2H75H9DFQtoFdnjZqbSNlAPxCVboJZEFl+eQ/8ct
 zjbgb+CDlFYhgHdoaRqHxKgiwqeJg/NMbBa79YsHuRlis+QjM7zuKo/5KDIK+LrmmXAG
 qea5j/geKjjzwG/wjp+Zm/v/vMF8YmdHAYHVPIrGL6uxYAGDqto6igOAEtZsLPdDBqHO
 45Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xIT0ESiLlCaULfyeMiqg9mmteZK4nFwTDji/sT0Tixg=;
 b=UjlvE5V6qiO854I9tSCVPz1dQlkki+I8XPJZ75l5f3UO2f//XGR/0ePMz4R8Mzc7lz
 1rz2Lo09QV3NjxF72UuXxOgjn+UmQHhAORUfI32KFRxEzMFt+0cZVFvlAKprgHK0RUSu
 9aZbE0OqQFJH6JBJ+UFWFnyQPtYdOlmjjHV9eX6oz5IVMJk1G06SZL5ycfeg3v+lHWlU
 U6lNqbCNOGtelLyY+Jw3HSmRHwbq9JsVLeyMKBnHeR0RFyrS7uKNy6VlF2QrbC5ZWeDh
 UZEW3EpnhIrdRRwfsjuIKk8MyDNseh4OYVQzzTZJGQLJM+8Np1MCeXWuaq5J0IuLFI8+
 nO/g==
X-Gm-Message-State: APjAAAVTZj3yT1He1c/KxA56gSjilBkCFzfd685pyRpYTZ4tcg6YM6qp
 ROKIAG+T51dIHoGWpVmDTXE=
X-Google-Smtp-Source: APXvYqyXcnwXQSC8kgkSZOS1KT3rAWxUCadMkTGtANLcI8wu+FXP0s+LECEUZHHNqLoz89kCilkD/Q==
X-Received: by 2002:a37:63d1:: with SMTP id
 x200mr17396114qkb.131.1566847740206; 
 Mon, 26 Aug 2019 12:29:00 -0700 (PDT)
Received: from ?IPv6:fd00:835b:d940:d4fc::5?
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.googlemail.com with ESMTPSA id u45sm8119409qta.13.2019.08.26.12.28.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 12:28:59 -0700 (PDT)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
 <9db7233c490836c221bab463305d08e34db9f037.1566779143.git.DirtY.iCE.hu@gmail.com>
 <117a307ac9ec4169d173eb80e68288a89d181386.camel@redhat.com>
Message-ID: <8ca01890-b337-6590-c415-48563ca938d1@gmail.com>
Date: Mon, 26 Aug 2019 21:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <117a307ac9ec4169d173eb80e68288a89d181386.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH 2/3] audio: paaudio: fix client name
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-08-26 10:21, Maxim Levitsky wrote:
> On Mon, 2019-08-26 at 02:29 +0200, Kővágó, Zoltán wrote:
>> pa_context_new expects a client name, not a server socket path.
>>
>> Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>> ---
>>  audio/paaudio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/audio/paaudio.c b/audio/paaudio.c
>> index bfef9acaad..777b8e4718 100644
>> --- a/audio/paaudio.c
>> +++ b/audio/paaudio.c
>> @@ -866,7 +866,7 @@ static void *qpa_conn_init(const char *server)
>>      }
>>  
>>      c->context = pa_context_new(pa_threaded_mainloop_get_api(c->mainloop),
>> -                                server);
>> +                                "qemu");
>>      if (!c->context) {
>>          goto fail;
>>      }
> 
> Also tested, and this works.
> 
> May I suggest though to make this configurable as well, for the sake of
> usability since gnome sound settings show only the client name, and it
> is per each sound card.
> Although on the other thing the client name is qemu.

There is a small problem with that.  Currently we only open one
connection to pa, even with multiple -audiodevs (they will just create
different streams), which means we can only use a single client name per
qemu process.  Because of that, I wouldn't turn this into an audiodev
property.  Some other kind of global setting could work, but I'm not
sure whether it's worth it or not.

Regards,
Zoltan

> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Best regards,
> 	Maxim Levitsky
> 
> 


