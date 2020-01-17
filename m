Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB31C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B392072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqQD5lKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B392072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMf7-0006O6-IS
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 03:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isMeS-0005x4-AS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isMeQ-0005Wo-Fz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:06:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isMeQ-0005WA-C6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579248401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4BB2IAob1UsFEdt2S0pw3B6hK2+ghCgtJwyUDYiOAU=;
 b=dqQD5lKNH/rV8DNgc/SWxh3La1IrX8NZK7wmTIcnmsVE8cjMYmkVWvTsCa8SNzq+VBNV7F
 0cgaFdGISa+Vef1lad4Y/uyYmeogtUpcS9oLUGBCzk88yNd1VvXLp+FPT1AkjJiShB6dCP
 vstNLFGTb3iDq2uZm9ysRiM9cqmF9c4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-cGjTzGChMfCnV4CsDGyS1g-1; Fri, 17 Jan 2020 03:06:40 -0500
Received: by mail-wm1-f69.google.com with SMTP id t4so1965032wmf.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 00:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T4BB2IAob1UsFEdt2S0pw3B6hK2+ghCgtJwyUDYiOAU=;
 b=jKSNI2XUpd3kG+2X5qPsCN2HSHrv1OmDNmReTF/oXyUNK5XAtZVPNESnq2lyy5gAkj
 EqXO0GNw8DHCTHwaFlm9Xy+OqZZrkyYW8p6c+vXgNdW2L4f3HKq2RSoswkLsKwa85sC5
 WUKTdzFZYeFaVD0yEcvJkL7vlCWpSQCDSr2xysb9PIDvIcCvG/R+I7iBnas0ZcidHl3c
 q1slAY/o/y5E4uJ3sXo2wBZJsKFOvlrJovrUx7ll2ij80EiNjeb9fwZP5KiJJpoAqoNf
 o/AIhNodxuDo7VwFNBQHgxLizlP+DlP9TItvpgTP3nui6RE+GhsODBKWqJ9E5bh6cl4p
 m29g==
X-Gm-Message-State: APjAAAX88m9k3EEeJTo9YXzPrqCWDfXdtiC5mMBSUL4riJt0ql8/BCye
 jH9N18Ds5ciVggrKwY2TJYYuQ5/Szu4ojS6N/Xzkpxp9XoI179XhwWZfVFbsJb3qtDzKcsDK2Mn
 ZroiwTpmqFhp8UzY=
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr3354354wml.83.1579248399168; 
 Fri, 17 Jan 2020 00:06:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUSpz+3v7fXhJJ7qHrxJ5MXcvR86FNHFl3oVFGwR7hXyzJgAkp9bZ0gnpKKvwAOHsgj64wBA==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr3354336wml.83.1579248398934; 
 Fri, 17 Jan 2020 00:06:38 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c195sm3487708wmd.45.2020.01.17.00.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 00:06:38 -0800 (PST)
Subject: Re: [PATCH v2 85/86] numa: make exit() usage consistent
To: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-86-git-send-email-imammedo@redhat.com>
 <a4feb8cd-a105-bcfd-b8c3-27ac5bb0f474@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e76bbe6-1dda-818a-49a2-68843a08f989@redhat.com>
Date: Fri, 17 Jan 2020 09:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a4feb8cd-a105-bcfd-b8c3-27ac5bb0f474@redhat.com>
Content-Language: en-US
X-MC-Unique: cGjTzGChMfCnV4CsDGyS1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 Riku Voipio <riku.voipio@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 David Gibson <dgibson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 1/16/20 5:43 PM, Thomas Huth wrote:
> On 15/01/2020 16.07, Igor Mammedov wrote:
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> CC: ehabkost@redhat.com
>> ---
>>   hw/core/numa.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index 3177066..47d5ea1 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -718,7 +718,7 @@ void numa_complete_configuration(MachineState *ms)
>>           /* Report large node IDs first, to make mistakes easier to spot */
>>           if (!numa_info[i].present) {
>>               error_report("numa: Node ID missing: %d", i);
>> -            exit(1);
>> +            exit(EXIT_FAILURE);
>>           }
>>       }
>>   
>> @@ -759,7 +759,7 @@ void numa_complete_configuration(MachineState *ms)
>>               error_report("total memory for NUMA nodes (0x%" PRIx64 ")"
>>                            " should equal RAM size (0x" RAM_ADDR_FMT ")",
>>                            numa_total, ram_size);
>> -            exit(1);
>> +            exit(EXIT_FAILURE);
>>           }
>>   
>>           if (!numa_uses_legacy_mem()) {
> 
> Please don't. We've had exit(1) vs. exit(EXIT_FAILURE) discussions in
> the past already, and IIRC there was no clear conclusion which one we
> want to use. There are examples of changes to the numeric value in our
> git history (see d54e4d7659ebecd0e1fa7ffc3e954197e09f8a1f for example),
> and example of the other way round (see 4d1275c24d5d64d22ec4a30ce1b6a0
> for example).
> 
> Your patch series here is already big enough, so I suggest to drop this
> patch from the series. If you want to change this, please suggest an
> update to CODING_STYLE.rst first so that we agree upon one style for
> exit() ... otherwise somebody else might change this back into numeric
> values in a couple of months just because they have a different taste.

TBH I find your suggestion a bit harsh. If you noticed this, it means 
you care about finding a consensus about which style the project should 
use, but then you ask Igor to update to CODING_STYLE to restart the 
discussion until we get an agreement, so he can apply his patch.

If this patch were single, this could be understandable. Now considering 
the series size, as you suggested, as the patch author I'd obviously 
drop my patch and stay away of modifying a 'exit()' line forever.

Maybe it is a good opportunity to restart the discussion and settle on a 
position, update CODING_STYLE.rst, do a global cleanup, update 
checkpatch to keep the code clean.
As I don't remember such discussions, they might predate my involvement 
with the project. Do you mind starting a thread with pointers to the 
previous discussions?

Thanks,

Phil.


