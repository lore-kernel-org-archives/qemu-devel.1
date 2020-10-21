Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D0AC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8132080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6M+gyEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8132080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVEHa-0002XK-2z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVEFL-0000kD-29
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVEFH-00057h-Pf
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603287219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EP3Z3L9MkqOU66HQnEjwd5+BYLBLuaH8zmp+qPSjKxU=;
 b=J6M+gyEZhD49Ps56ORoOin34qFogJxY75T3AmtNXscVDWFchLsKNiwSu+cQSkB87vD/liz
 d4z5qIad44OoY81oRpswJgjs9spBMy9nXnOM7J8unyHz23ZGPbQsV2mT90IUbIt3Olqcab
 R3DrEkD3jTecFQWAq1v6do8DwlG258c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-QHPxvlBrMhq7wBoyv9amYQ-1; Wed, 21 Oct 2020 09:33:34 -0400
X-MC-Unique: QHPxvlBrMhq7wBoyv9amYQ-1
Received: by mail-wr1-f69.google.com with SMTP id i1so2663211wrb.18
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 06:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EP3Z3L9MkqOU66HQnEjwd5+BYLBLuaH8zmp+qPSjKxU=;
 b=rJwY3t2XMaXJGxafJbD5Xu/khJbnkoAwmzBQIH0UIRNf8eL0BSSPtjzvGEcWURe/Ma
 qQFNCLOIWgg/5nVLdCzLHjshZEBqRPPs8srjEHMA1Ardrjsz5PSaTb0baVcOhC2sKt+B
 LGBqqLlLpWHpqdnRHxYmG4FSHh7Jgq2Qg0W2H3HwXtiIt99JNe8cRk8lAS4C45rhiO8o
 LykAwkBadPyOtLRgeDapWqKNoV84SulE+wQTuyA/5OgsTAetseJeNDPWXmTE599zFEQC
 KNzNuxPKptQFoqJaP7xwt4/k64vPn6sYvJw1I7CPCCIJcSLzkS66mhu23IkeFgsg3VJP
 XAkw==
X-Gm-Message-State: AOAM531VeCJDVo7zvmJG3FPpflT4S8RkjyaaGzZFhCa2fz0R2t6UMIPw
 u9WnABdY0j7o67BYCsUKxFrzkdvz9hMsy3vAweLoj/h3mDHRkieER24N3hbjdODTGpqzf8qwwRD
 /mmBHY5qYjH3W+W8=
X-Received: by 2002:a5d:6cad:: with SMTP id a13mr5207814wra.347.1603287212328; 
 Wed, 21 Oct 2020 06:33:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy48Vd0aC9ygdhE7YJx6jdA93D3IqDTEIb8e8QQdoM0yt+p5/68jLq3qeMfmf+PyoDmQfVpNw==
X-Received: by 2002:a5d:6cad:: with SMTP id a13mr5207796wra.347.1603287212111; 
 Wed, 21 Oct 2020 06:33:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y14sm3312925wma.48.2020.10.21.06.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 06:33:30 -0700 (PDT)
Subject: Re: [PATCH 0/1] Do not stop guest when panic event is received
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
References: <1601606494-1154-1-git-send-email-alejandro.j.jimenez@oracle.com>
 <74a8c57d-4f2d-64cd-f2d2-32dc88b64f9b@redhat.com>
 <1c9cdb1d-5dd5-a783-96e9-8f62a498951a@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e197a153-43e9-d517-de09-2ce163571453@redhat.com>
Date: Wed, 21 Oct 2020 15:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1c9cdb1d-5dd5-a783-96e9-8f62a498951a@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 15:26, Alejandro Jimenez wrote:
> 
> 
> On 10/20/2020 1:14 PM, Paolo Bonzini wrote:
>> On 02/10/20 04:41, Alejandro Jimenez wrote:
>>> The fact that the behavior of hv-crash is also affected is why I
>>> chose to implement this change as an independent
>>> option, as opposed to making it a property of the pvpanic device
>>> (e.g. -device pvpanic,no-panicstop).
>>>
>>> Please let me know if you have any comments or suggestions.
>> Hi Alejandro, sorry for the delayed response.
>>
>> The concept is fine, and I agree this should not be a device property.
>>
>> On the other hand, we already have many similar options: -no-reboot,
>> -no-shutdown, -watchdog-action and now --no-panicstop.
>>
>> I think it's time to group them into a single option:
>>
>> * -action reboot=pause|shutdown|none
>> * -action shutdown=pause|poweroff|none
>> * -action panic=pause|shutdown|none
>> * -action watchdog=reset|shutdown|poweroff|pause|debug|none|inject-nmi
>>
>> where the existing options would translate to the new option, like:
>>
>> * -no-reboot "-action reboot=shutdown"
>> * -no-shutdown "-action shutdown=pause"
>>
>> The implementation should be relatively easy too; there's already an
>> enum WatchdogAction (that can be renamed to e.g. RunstateAction) and a
>> parsing function select_watchdog_action that can be changed to just
>> return the RunstateAction.
>>
>> Would you like to take a look at this?
> Hi Paolo,
> 
> Thank you for your reply and the advice/hints above. I'll take a look
> and try to implement what you propose.

Just one thing, for the parsing you can place it close to the existing

    qemu_opts_foreach(qemu_find_opts("name"),
                      parse_name, NULL, &error_fatal);

Paolo


