Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B687FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46DD221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQvFyNfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46DD221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8cx-0002I8-PW
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kV8cN-0001nf-HU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kV8cL-0003vI-BF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603265583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drQIBCvwPTHKzcjVldTcsWwfjAwlKRo7oPSqthEqeCg=;
 b=OQvFyNfpTX8m/AD3/YPG0qwZs8TqSyckKhgEffTrXa/8QQ7zQsdfzHkQm2dzel6e5sNI/A
 xGq7qReL4X0Rpez26LkcGY9KjcuSeOkSxeC6MGb3MKKhcX5NitCbMa8RyHWbKEXA4cDONk
 a0qyF1XjIiL8yvWMPHMfChssQw01vyM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-C5-2Gd0BPB-5p4mNfeMgZQ-1; Wed, 21 Oct 2020 03:33:01 -0400
X-MC-Unique: C5-2Gd0BPB-5p4mNfeMgZQ-1
Received: by mail-wm1-f72.google.com with SMTP id u5so119351wme.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=drQIBCvwPTHKzcjVldTcsWwfjAwlKRo7oPSqthEqeCg=;
 b=Yl2fJ2Dx+UrEhnHr4+JG/norGthKWy9cIHWeY2klkATqIC2slxJkX2TLm2dGPNo+Nk
 BgTmXzFAhXmRcya+Z1mvcF2xYcBb0ttIv0wXq9XSw4/6X5X9Bpt8KisvWAvEhLa1LCnR
 1xDpJ79RlfkzCONknfL23921FUXpQgBJyb8vKTZuSmBMG4VzWlwn00JNH1M6dM5ayZ8F
 HsJ02nA9y8vrJ+fWpjCP06wv5hTe5I0Eg8csy9m3u5AGNXfLzvh96oZGoqQvHs2m+C9/
 FhHrZvRDmDZNk0EbQWrKQyExm7e2W+OGiL73pD3Akamano9q8M6fd8W36xZ25J3/wq7y
 H4MA==
X-Gm-Message-State: AOAM532H68To52umygH91O8IOyJ/0RbeE+HcFZKrczrD27FXwivaWotg
 P/74FXCk0eXBuPlyVz/UQLnYa7gnLwNGfdAxV56vtS52BQTk+chbPSYBs8rNQznjDNvPh1e8jfi
 dNqmhaJ1TofzV00E=
X-Received: by 2002:a1c:2905:: with SMTP id p5mr2103947wmp.187.1603265580596; 
 Wed, 21 Oct 2020 00:33:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLjWksnHireEkxxCfxbJbmPjUZ6fahDy9do6lslhuiinI21OwyhB/F+ThR6inazUHJ0u2HnA==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr2103925wmp.187.1603265580389; 
 Wed, 21 Oct 2020 00:33:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id c18sm1925055wmk.36.2020.10.21.00.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 00:32:59 -0700 (PDT)
Subject: Re: [PATCH] pc: Implement -no-hpet as sugar for -machine hpet=off
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201020220150.1326086-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50e184db-bf46-48c1-b3a2-f4151d00cdf6@redhat.com>
Date: Wed, 21 Oct 2020 09:32:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020220150.1326086-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 00:01, Eduardo Habkost wrote:
> +    pcms->hpet_enabled = true;

Should this be within #ifdef CONFIG_HPET?  Otherwise

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


