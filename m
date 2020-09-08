Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A437DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB42B2137B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma7SoZmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB42B2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiyD-0002B3-2b
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFixd-0001h5-31; Tue, 08 Sep 2020 15:07:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFixb-0005Eu-D0; Tue, 08 Sep 2020 15:07:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id a65so47007wme.5;
 Tue, 08 Sep 2020 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dceRSO/yZoTyPHkkawFQFL+F3GGgi1YwxzXoVr6abzU=;
 b=Ma7SoZmZuZunZ/RvcBJOGD4Ta+IOf4fAR6Ye+uFEcanb11XkCX9KBk3gts5ew0/qDx
 L4b7qHda3T/V+ayf3BOjYiwYtB7cDGfZa4x2WwmcBdIwZSzXBkv5/GOCYWGSouqYZoLQ
 tlUzwMiPN8PWhSvFAirvYkn1HqYbQYeP+p26N5qjrIy92bAc7O8q4b5BR4YBXgE6cqK6
 o3oNHCFvVzRbFvjZ2E/OsN5KAS9MhhKJgp0AMWUu8g3DPq5AdhKjxmsbGl8Mi1uGRmgP
 Dck3Kn7rc58aYpO2OWooP0AHz9JaeQ+ZHjwyvhAHYE+N2SOIb2zxEZA3N+s3xpWN0wVh
 o3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dceRSO/yZoTyPHkkawFQFL+F3GGgi1YwxzXoVr6abzU=;
 b=oj/8LGoy546KPuo7zMcwiTZg4d4LQXeBImWsnw5aUWkitpF3FeLI/7wy+n8sPmPKpt
 4BbNFT2gdO7Rh1F/PmmEuOChfLuRjXbXsYi2xIyzpQbMCmpMdBTNhHtqdMPTIPz2F9Lg
 9p/M9kZnhCeZMEeUuhba8SOgG4CuhDvM8UCv0BzJsybRyvH2yS+WNlILaIS/3dzRspXd
 MZXTY0IHxcKOWwT6Z4pgiocYDrJtv0ew+hRnvqMlFYL1fvHu2B6SC4JuZvjipD+Ct0t5
 wuWEQZSGLTJAd/3q37W1hDcCn4vOwzbGEQMdjVzm2p0R1qBM5aUTzPmz7FVcpjLjYtca
 05+g==
X-Gm-Message-State: AOAM531y3SGTxVXUYCsFgcWitWaXsQoAqXzo8uBm40Tz6sgbCKX+o+rp
 2UGPKHRgnR37txFKhSOgASc=
X-Google-Smtp-Source: ABdhPJwV1aeLNG4PUBLVyNmer3waQO0enl3tbsm9QsAKjh0O/zsRS9c7O53CXGoVevJZz3NWTjx7lw==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr540058wmb.43.1599592037671; 
 Tue, 08 Sep 2020 12:07:17 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a74sm463155wme.11.2020.09.08.12.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 12:07:16 -0700 (PDT)
Subject: Re: [PULL 02/16] ci: fixes msys2 build by upgrading capstone to 4.0.2
To: Eric Blake <eblake@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
 <20200908184918.1085-3-luoyonggang@gmail.com>
 <852c95bc-9576-cbb7-471f-f8ef037f8fda@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9a2b30f6-b840-1df2-e055-ea33d56bc9d9@amsat.org>
Date: Tue, 8 Sep 2020 21:07:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <852c95bc-9576-cbb7-471f-f8ef037f8fda@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 8:59 PM, Eric Blake wrote:
> On 9/8/20 1:49 PM, Yonggang Luo wrote:
>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>> ---
>>   capstone  | 2 +-
>>   configure | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> The commit message is sparse; it might be nice to give more details
> about what error is fixed, or possibly even mention of the fact of which
> capstone commit id that is in 4.0.2 but not the current version matters
> to qemu on msys.
> 
>>
>> diff --git a/capstone b/capstone
>> index 22ead3e0bf..1d23053284 160000
>> --- a/capstone
>> +++ b/capstone
>> @@ -1 +1 @@
>> -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
>> +Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
>> diff --git a/configure b/configure
>> index 4231d56bcc..f4f8bc3756 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5156,7 +5156,7 @@ case "$capstone" in
>>         LIBCAPSTONE=libcapstone.a
>>       fi
>>       capstone_libs="-Lcapstone -lcapstone"
>> -    capstone_cflags="-I${source_path}/capstone/include"
>> +    capstone_cflags="-I${source_path}/capstone/include
>> -I${source_path}/capstone/include/capstone"
> 
> This change was not mentioned in the commit message.  Did capstone 4.0.2
> change where its include files live?  Or is it a separate bug, and you
> are fixing two things at once (in which case, doing two separate commits
> might be nicer)?

As Richard Henderson introduced the capstone submodule, it would be
nice to have his Ack-by before updating it.

Thanks,

Phil.

