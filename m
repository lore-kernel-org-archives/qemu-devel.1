Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D690C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 11:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D542145D
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 11:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzpGCNWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D542145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp9T9-0002zd-Kn
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 07:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9SN-0002K4-PP
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 07:57:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9SK-0002Hb-VU
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 07:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593259031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zv89ZB4vUrTNP7ZwdErfKoo67nnhoyETbniK4o3J5xM=;
 b=DzpGCNWzs6DMy3G9+om5TNvgW6EbrIlGTWcXpoMLoz/0Eh2BVlBw32M++gXQBP80QflFyV
 VaOhA3z+jb8HT+ugwCHz49mZt84QT59JJwp6EWHPbFz13zO6AX9Jlk1ZAyXNwDvribTX4s
 zpKKDf4sS73h0JotJ3GLjLTHuPYd7dA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-WoZ5SFRhOVef-JcF9RTO3w-1; Sat, 27 Jun 2020 07:57:10 -0400
X-MC-Unique: WoZ5SFRhOVef-JcF9RTO3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC3601800D4A;
 Sat, 27 Jun 2020 11:57:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A84A42B4B5;
 Sat, 27 Jun 2020 11:57:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2269211384A6; Sat, 27 Jun 2020 13:57:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 06/46] error: Avoid error_propagate() when error is not
 used here
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-7-armbru@redhat.com>
 <45536875-9cf2-72d5-b555-8b8b1992085b@virtuozzo.com>
Date: Sat, 27 Jun 2020 13:57:07 +0200
In-Reply-To: <45536875-9cf2-72d5-b555-8b8b1992085b@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 26 Jun 2020 17:36:27 +0300")
Message-ID: <87eeq0rab0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 07:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> When all we do with an Error we receive into a local variable is
>> propagating to somewhere else, we can just as well receive it there
>> right away.  Coccinelle script:
>>
>>      @@
>>      identifier fun, err, errp;
>>      expression list args;
>>      @@
>>      -    fun(args, &err);
>>      +    fun(args, errp);
>>           ... when != err
>>               when strict
>>      -    error_propagate(errp, err);
>>
>>      @@
>>      identifier fun, err, errp;
>>      expression list args;
>>      expression ret;
>>      @@
>>      -    ret = fun(args, &err);
>>      +    ret = fun(args, errp);
>>           ... when != err
>>               when strict
>>      -    error_propagate(errp, err);
>>
>>      @@
>>      identifier fun, err, errp;
>>      expression list args;
>>      expression ret;
>>      @@
>>      -    ret = fun(args, &err);
>>      +    ret = fun(args, errp);
>>           ... when != err
>>               when strict
>>           if (
>>      (
>>               ret
>>      |
>>               !ret
>>      |
>>               ret == 0
>>      |
>>               ret != 0
>>      |
>>               ret < 0
>>      |
>>               ret != NULL
>>      |
>>               ret == NULL
>>      )
>>              )
>>           {
>>               ... when != err
>>                   when strict
>>      -        error_propagate(errp, err);
>>               ...
>>           }
>>
>>      @@
>>      identifier fun, err, errp;
>>      expression list args;
>>      @@
>>           if (
>>      (
>>      -        fun(args, &err)
>>      +        fun(args, errp)
>>      |
>>      -        !fun(args, &err)
>>      +        !fun(args, errp)
>>      |
>>      -        fun(args, &err) == 0
>>      +        fun(args, errp) == 0
>>      |
>>      -        fun(args, &err) != 0
>>      +        fun(args, errp) != 0
>>      |
>>      -        fun(args, &err) < 0
>>      +        fun(args, errp) < 0
>>      |
>>      -        fun(args, &err) == NULL
>>      +        fun(args, errp) == NULL
>>      |
>>      -        fun(args, &err) != NULL
>>      +        fun(args, errp) != NULL
>>      )
>>              )
>>           {
>>               ... when != err;
>>                   when strict
>>      -        error_propagate(errp, err);
>>               ...
>>           }
>>
>> The first two rules are prone to fail with "error_propagate(...)
>> ... reachable by inconsistent control-flow paths".  Script without
>> them re-run where that happens.
>>
>> Manually double-check @err is not used afterwards.  Dereferencing it
>> would be use after free, but checking whether it's null would be
>> legitimate.  One such change to qbus_realize() backed out.
>>
>> Suboptimal line breaks tweaked manually.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> [..]
>
>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
>> index 8d6156578f..6705220380 100644
>> --- a/hw/intc/xics_kvm.c
>> +++ b/hw/intc/xics_kvm.c
>> @@ -316,9 +316,8 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
>>               continue;
>>           }
>
> local_err becomes unused in this function, we should drop it

Will fix.

> with this fixed:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks!

>
>>   -        ret = ics_set_kvm_state_one(ics, i, &local_err);
>> +        ret = ics_set_kvm_state_one(ics, i, errp);
>>           if (ret < 0) {
>> -            error_propagate(errp, local_err);
>>               return ret;
>>           }
>>       }


