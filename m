Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA4C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B7621707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggJUBLhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B7621707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPC1-0007kW-3X
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXP0Q-00017F-Mo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXP0A-0007GE-7G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cC+6TT/+GqEjatYKGJLGO6JhXZ+8V6ee7H9Pi2A6Ac=;
 b=ggJUBLhsbbdsUSOSsNsSJR4U95eKuYyC/Wtvys6yaXKwKTV/jOyQc/M2ZZHlVpJ6gY/7wN
 Ra+PjlWWR1ViGnANtJDTKjtZCvH6yuwQHoXugDA/PvQLKqKykZhQJUO0kghhyutj4JvzDY
 t3mBQ9onIYgSL2nn3vThFumuVWS1HDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-Euq9UwEyOPWTUjIzZVxU7A-1; Tue, 27 Oct 2020 09:26:48 -0400
X-MC-Unique: Euq9UwEyOPWTUjIzZVxU7A-1
Received: by mail-wm1-f72.google.com with SMTP id s25so586239wmj.7
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/cC+6TT/+GqEjatYKGJLGO6JhXZ+8V6ee7H9Pi2A6Ac=;
 b=mKCPWoeJ6bDI3T3ddRxVXNA8sMhcIjVGpT0ohJ/WNAwAvRp7LZ7qerwj7tUIw71tU1
 BJgFhzDsZ0LiQz6dq34fo0Tb8IeXLBJe9NWhTpm4w0rauA/H0Ma2rf4EToT+YuBKn64N
 r/TcEKlMxZj7a/vWTh7xip/SmuhO9Gt6KZNZ98n9+62A+3Hoz7h8X+X0NpsBrnGAO1ju
 zgfFOWwahuohmz5nnQ/WAdurbfhQbM4+xP/AiUZaF1xE/5Ia5/WE9T3demJrup27Cf1F
 0KneYpI50ucgU9TB8hmeO7oqbAPsasiztBuVrzOsnecqLwzuYoj2CUNSRSreaULbd4ZC
 8AsQ==
X-Gm-Message-State: AOAM530eZgCAV5meMGOAGlWV3H78O9hJzIunK/8fFuZKLvyH1ddR4Dgb
 l7Yd7F5Ysjei4uqo0iDRVkccQAohUmG/anxors7dJcNxCR1ZuPptL0zmI0QlwPosqGm3cUlkphQ
 w0zd71Ai+cZbfrmY=
X-Received: by 2002:a05:600c:255:: with SMTP id
 21mr2806920wmj.69.1603805206897; 
 Tue, 27 Oct 2020 06:26:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI2nlelGO/uwaibZZMQ8wheqS5yfQv1wSA7yBYEWVbuAAsJcf4hUzo+zTSySXMW1gJrx2xyA==
X-Received: by 2002:a05:600c:255:: with SMTP id
 21mr2806899wmj.69.1603805206671; 
 Tue, 27 Oct 2020 06:26:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id w1sm1937420wrp.95.2020.10.27.06.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 06:26:45 -0700 (PDT)
Subject: Re: [PATCH 07/15] m68k: remove bios_name
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-8-pbonzini@redhat.com>
 <457e6a0b-8c33-0d40-950b-6829d4f9a1d1@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1594dc6-8696-0e9e-a825-d4b0ee3c1d79@redhat.com>
Date: Tue, 27 Oct 2020 14:26:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <457e6a0b-8c33-0d40-950b-6829d4f9a1d1@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 20:11, Laurent Vivier wrote:
>>      /* Load kernel.  */
>>      if (!kernel_filename) {
>> -        if (qtest_enabled() || bios_name) {
>> +        if (qtest_enabled() || machine->firmware) {
>>              return;
>>          }
>>          error_report("Kernel image must be specified");
> Why do you do differently for mcf5208 than the others?
> 
>     const char *bios_name = machine->firmware;
> 
> and no other changes?

because in this case you can use machine->firmware, I'm keeping
bios_name for the cases where machine->firmware cannot be used directly
(e.g. there is a default).

Paolo


