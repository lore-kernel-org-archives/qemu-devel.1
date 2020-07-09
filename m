Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E676C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2F92074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEv7eKIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2F92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTXX-0006dw-JD
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTWv-00066R-OI
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:11:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTWu-000629-7T
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594289507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3LOABQZfanvD1gLTv79zBx1EWnFuqzfDG4sVWnQIEA=;
 b=IEv7eKIeg6iogFwgFm816n8HYVYy2MMplWq8N+CB+eGvlio5vaNzLvx35om/XCUgzdPgM5
 jau1ssug0SjS5bm8U7zm8xgGWbFrRTNLvF4Iv3mootI3mZMkoeOBVLq6FeT+V/BS2JR/DD
 kFQtNfb4FAxjmsfwUqN0PRpXtSPeLCw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-dUJay4R_P-CHklyf8h5lUA-1; Thu, 09 Jul 2020 06:11:45 -0400
X-MC-Unique: dUJay4R_P-CHklyf8h5lUA-1
Received: by mail-wr1-f71.google.com with SMTP id g14so1576584wrp.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L3LOABQZfanvD1gLTv79zBx1EWnFuqzfDG4sVWnQIEA=;
 b=CyEdVNKFyptajcMY8PyMTx7GiEQ/7n1uoE1RVmcbb404VuXt+tiJs5EjiuMmYwj7/L
 EtOUhNM7RkJCTpaJ18GK9ALoU5hn2T6Pec4h/njpVyFmmK1igBcS0VIhZeXxon+kLCDq
 OekmfKcboj0sX6TXJ53UDt8zXKZ2ahy3oV9OrwKyRrDas0DvYZCWLroU2Fb0ti8d0Zaf
 KJIjrmpqeHz+ZYoW5ibMiU9K2cKStnFkX/gDDHThJMK28k9B/CzyUEpgZmdX7hwITmme
 QzYCBJk/GZb928j+3+mp15NABe3jU2svtTx05riaTwAEEDSacuAqWAqMZISPbahR299P
 ZoNA==
X-Gm-Message-State: AOAM530XjXhRbU4mjay/wf0wr/xjRY6kCXkmgVyEBPI5V3wAUtcvPJdw
 DsnT0/ad1DizPy361Kh9uYoi0th+fqq2djL0+FZbzId2Q05XNaEWqFVnd3EFtuQNjtU2dZ8tNp3
 F4Zx53ELNlHo3PB0=
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr63561664wro.317.1594289504596; 
 Thu, 09 Jul 2020 03:11:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGPWAhbR1dQfzcHSvUvPl+es2gcwjD/rPtFt+Q4iK/eWDgs8nAz8mGGQ6YFGC802OkBVyVlw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr63561644wro.317.1594289504399; 
 Thu, 09 Jul 2020 03:11:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id z1sm4893109wru.30.2020.07.09.03.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 03:11:42 -0700 (PDT)
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
To: Mohammed Gamal <mgamal@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
 <20200708171621.GA780932@habkost.net> <20200708172653.GL3229307@redhat.com>
 <20200709094415.yvdh6hsfukqqeadp@sirius.home.kraxel.org>
 <8ed00a46daec6b41e7369123e807342e0ecfe751.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c9ec76e-7cfc-f613-ef9b-cb1e7cc54ade@redhat.com>
Date: Thu, 9 Jul 2020 12:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8ed00a46daec6b41e7369123e807342e0ecfe751.camel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Guilherme Piccoli <gpiccoli@canonical.com>,
 Pedro Principeza <pedro.principeza@canonical.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, Dann Frazier <dann.frazier@canonical.com>,
 mtosatti@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org,
 Laszlo Ersek <lersek@redhat.com>, fw@gpiccoli.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 11:55, Mohammed Gamal wrote:
>> Ideally we would simply outlaw (3), but it's hard for backward
>> compatibility reasons.  Second best solution is a flag somewhere
>> (msr, cpuid, ...) telling the guest firmware "you can use
>> GUEST_MAXPHYADDR, we guarantee it is <= HOST_MAXPHYADDR".
> Problem is GUEST_MAXPHYADDR > HOST_MAXPHYADDR is actually a supported
> configuration on some setups. Namely when memory encryption is enabled
> on AMD CPUs[1].
> 

It's not that bad since there's two MAXPHYADDRs, the one in CPUID and
the one computed internally by the kernel.  GUEST_MAXPHYADDR greater
than the host CPUID maxphyaddr is never supported.

Paolo


