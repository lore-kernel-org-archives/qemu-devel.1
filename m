Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780B7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BAE204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG6dJtJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BAE204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0hn-0005y5-Cy
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw0gv-0005RR-4g; Thu, 16 Jul 2020 06:00:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw0gt-0000Xl-IT; Thu, 16 Jul 2020 06:00:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id 22so9721528wmg.1;
 Thu, 16 Jul 2020 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3qlwHGRFr9qgDZuvl1pc40Mt2g7o43wUiH/I8W7K+Tw=;
 b=QG6dJtJ0avm5wTbRxrNnocHcrO94ZfQK+FgdWTt63Dxe6sYGkM73YC9DVf8DHSTfl3
 L7vI+oUZ/j6+eV7TxIWY9glNiJ43ahZNSEvl/QjJQ0MBljapC3U84zDVZedHPZY3SnWf
 y95M/lrCoQOUzUVQnPMLmnFc2fae05MfbcRPF2on+5JXgXAhSoKJ5xN60Mcrtxlt3qsD
 1cn07yflbxKNiX7zFiFIl7D5gS/ZDMnvWeUk5/wATTvUE4TLBy2iXHHhvu3ig5tp8N39
 2Qvqguj+W/SxpxnprKjZb5rb3+QQn/DtnUR2KVV8+bjCvYpFSokXOt2Qes/Fy5HLdVvx
 lIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3qlwHGRFr9qgDZuvl1pc40Mt2g7o43wUiH/I8W7K+Tw=;
 b=IuzOQ5LlFAtNLfJUSNa/iObZ0+H8j/IX2ecaHyMSdV95d24H31QOBvJ1pR1bl39Wdk
 BnVA2jd0ZGNzFeW3qwGbSG0jmkswxdAos2cznrWhk3wuk3FuSYU90G1YTNnRlLji5Pzv
 5WdJu5/gbDXDxmox1fb4ANYqEp5Ri3bQvJDxHYRv1bc8GQyVCOSloKrqOSBSTP9gZhWh
 kVIg0EoqLAm2u4j1j0jtxJxRN09pQvHYJhNESsS7eeQsqiIsGqcd705UHkRTcd6LloTX
 yZ4HGUUdNe3yBGA1EoiucNwdL6rJOuRl3Rv9n80Zu0ni/9NdLJwUtQp/vZVvOeatfAlz
 hu+Q==
X-Gm-Message-State: AOAM533JpO42Zn7eIkOHxSxS/jBOCD2AtqbCf7+T8y0QeaEqCGTKGsqX
 jcUNtKPbUPQRleDeYP0BcUM=
X-Google-Smtp-Source: ABdhPJxBo/Rf/dAjTSqPYFPxif+gwk2PyQjyVCRZWq4rWM2/kSPdZvcy5Sww+xPx0KzYQSM1Ep88lQ==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr3437226wmh.166.1594893633148; 
 Thu, 16 Jul 2020 03:00:33 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d18sm8398711wrj.8.2020.07.16.03.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 03:00:32 -0700 (PDT)
Subject: Re: [PATCH 01/18] migration/vmstate: Document vmstate_dummy
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200703201911.26573-1-f4bug@amsat.org>
 <20200703201911.26573-2-f4bug@amsat.org> <20200716095219.GJ227735@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3c93ea47-3916-eb98-6207-9d34b1430f0d@amsat.org>
Date: Thu, 16 Jul 2020 12:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200716095219.GJ227735@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 11:52 AM, Daniel P. Berrangé wrote:
> On Fri, Jul 03, 2020 at 10:18:54PM +0200, Philippe Mathieu-Daudé wrote:
>> vmstate_dummy is special and restricted to linux-user. See commit
>> c71c3e99b8 ("Add a vmstate_dummy struct for CONFIG_USER_ONLY").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/migration/vmstate.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index f68ed7db13..af7d80cd4e 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -194,7 +194,7 @@ struct VMStateDescription {
>>      const VMStateDescription **subsections;
>>  };
>>  
>> -extern const VMStateDescription vmstate_dummy;
>> +extern const VMStateDescription vmstate_dummy; /* Exclusively for linux-user */
> 
> Originally in the commit mentioned above, this was enforced at build time:
> 
>   +#ifdef CONFIG_USER_ONLY
>   +extern const VMStateDescription vmstate_dummy;
>   +#endif
> 
> 
> but this was removed in
> 
>   commit 6afc14e92ac81b29c25f097468f7751d5df1b5bc
>   Author: Stefan Weil <sw@weilnetz.de>
>   Date:   Fri Feb 6 22:43:10 2015 +0100
> 
>     migration: Fix warning caused by missing declaration of vmstate_dummy
>     
>     Warning from the Sparse static analysis tool:
>     
>     stubs/vmstate.c:4:26: warning:
>      symbol 'vmstate_dummy' was not declared. Should it be static?
> 
> 
> So if this is really intended to only be used by linux-user, then I
> suggest we put CONFIG_USER_ONLY back, and figure out a different
> way to address the undeclared symbol problem. I guess the problem
> was that stub code is shared both both user/softmmu builds. So
> perhaps we need to stub this in linux-user only code, instead of
> having it in the main stub library that is common.

Good idea, I'll look at it.

Thanks,

Phil.

