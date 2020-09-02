Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C2F20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyJ2mdiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C2F20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOLD-0000yL-DO
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDOJp-0007Sm-5N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:40:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29537
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDOJn-0006J0-LH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599036035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0e7rurbyMF+VdAfKkAgXtPuenFkasb0AW4NrOZeqY5o=;
 b=gyJ2mdiQTrSSuNfh1IvYd/H5o0USPjLnjXiNDpfyKADEabRFUax0yxTh3UP0wEyADxmt3P
 Hp4T13JnhN6jsZ/bFgEL7aEgcQTZK/yHF2VDFcBUNOXTL3M2Zu+3t0rrtBSX77FSpzrDvp
 Oaa9pkpSgVoik3xNhdRh7H740H6IJC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-SJOm2ImyOlCz95tdGdKheQ-1; Wed, 02 Sep 2020 04:40:32 -0400
X-MC-Unique: SJOm2ImyOlCz95tdGdKheQ-1
Received: by mail-wr1-f72.google.com with SMTP id a10so1660056wrw.22
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0e7rurbyMF+VdAfKkAgXtPuenFkasb0AW4NrOZeqY5o=;
 b=iULln3LmY7f/C/JXkwyF8Hnt4+5MPUUbIUO7Kovue4iOI8DTiAUBAZHXafdTLkFSEq
 XlZsyWq5CAQWqduKyWvtMSOCF5LAzPD9iJyiNhR+XqiQqoRpL0ohNwiVRakXcktEV9Su
 YvaS0ulrPf6INwayXyeedPlpu8V5UwIyu9xu1g1vaahcsHDNM/gmsvnLT5dN+1Ws22i9
 psZ7/UpFQYXMhbfKZfBCvBHrAYYxcLiZbadyitcXHXUlX+ZZTbfuaM9fN5QJBEo62FoD
 ojX6zqitx74U9RWj6MoOGbXMWW8GstFaHpXJE5YRE6XtftHxK9o4CTWNjXUYJyU00Fup
 dRng==
X-Gm-Message-State: AOAM531J3pTCuuOS5NvmyghaegsG1kx9R3WnI/DrIoLidrSEDCKtewkq
 Ip0LgO5H4Ex86Jj5CsxlUjz1MUHq3ELxcxACSzpPtlX5csu85BrAO0L9wr1WcFUJpz/Z8IiHT1q
 l02zgcJC5v0uaBHI=
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr5829622wmj.33.1599036031290; 
 Wed, 02 Sep 2020 01:40:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8bfQR+IIdmiGOAAjPFNsqYaUsqIxVrOVLLD2mkgen9TjLwzjt7guJeiQRYPRMoplsaA/rNQ==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr5829602wmj.33.1599036031116; 
 Wed, 02 Sep 2020 01:40:31 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id l21sm5137670wmj.25.2020.09.02.01.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:40:30 -0700 (PDT)
Subject: Re: [PATCH 07/13] net: relocate paths to helpers and scripts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <20200901062020.26660-8-pbonzini@redhat.com>
 <5f5f038a-9c65-baa3-1f9e-0c04a08b0f71@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6ac086a-d71b-1af8-3bb7-7c156adb6153@redhat.com>
Date: Wed, 2 Sep 2020 10:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5f5f038a-9c65-baa3-1f9e-0c04a08b0f71@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 10:24, Philippe Mathieu-Daudé wrote:
>> -    helper = bridge->has_helper ? bridge->helper : DEFAULT_BRIDGE_HELPER;
>> +    if (!bridge->has_helper) {
>> +        helper = default_helper = get_relocated_path(DEFAULT_BRIDGE_HELPER);
>> +    } else {
>> +        helper = bridge->helper;
>> +    }
> Nitpicking, I find easier to review adding simply once after out of the
> if() statement:
> 
>   helper = bridge->helper;
> 

Even better,

-    helper = bridge->has_helper ? bridge->helper : DEFAULT_BRIDGE_HELPER;
+    helper = bridge->has_helper ? bridge->helper : NULL;

and move the get_relocated_path in net_bridge_run_helper.

Paolo


