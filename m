Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ABAC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D02223119
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IY7xSKvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D02223119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlxR-0003tM-BS
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKlv3-0002xa-LR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKlv0-0000Tv-Kh
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600795049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aas6LLH5a/F/MrrZj6lyej2r/K44aVGsT81J7wKXVC0=;
 b=IY7xSKvLqqKhCT3WTmMwcrXVfCZnGiADnBm7fZDEZ9ZbdMigWJs2s+YY76LimYR6vvCo9x
 iJIqAZ1noc30B00QsOnZcmUoFXfwv6k3Ty3H/4rhVq7ovYRHii79xx0KpyFVEArIBOokPP
 /d5LMpict7MFKpjehzl4m/6x2H+C2qM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-lWiLaPMgNQK8vwWdjeNjQQ-1; Tue, 22 Sep 2020 13:17:27 -0400
X-MC-Unique: lWiLaPMgNQK8vwWdjeNjQQ-1
Received: by mail-wr1-f72.google.com with SMTP id d13so1275753wrr.23
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Aas6LLH5a/F/MrrZj6lyej2r/K44aVGsT81J7wKXVC0=;
 b=jzB2xroT+bC+XUojJtwsgH0/qoI/PTvdoGJDU87GlZHd00SaDeqKNEMN2YClVSV088
 qhar9c1XVyKGNjk3QUIYJQunp5OxxVV0tnbuwoctez3Ox1x8iHxzIpFMJ9uZERfsvLe3
 mx7fJax1D4LASSVyRjxMw0Y3MtTxQoSK18zNT+35NP7hBlEm7+1h0eei02km06+Y+Dkl
 T3dumruOpnvxg3ww536btru5fJvloFPONqq4uFHPlUCDFciXOgs/OTJ9oEMYEKxY7RLF
 yi0c7loqhYztbYYOYVRbLM0rYBRUvKMj2H7hNlQd8DtEkKdpJmfnJf7vUIGwHNq3zsOP
 VwyQ==
X-Gm-Message-State: AOAM533UXASXZquAuQm++B18dV79h/07cSRXW90v71TmPSXzSWfYJIBG
 +rMknvjXlrk0rqeAsNtp8zbLyO98jMEdrBpkeEthUV+U3myUec7NWa3JMe6R3zjvx0sJ20LHSfg
 1khfu5WV9C0XFt0s=
X-Received: by 2002:adf:a3db:: with SMTP id m27mr4992978wrb.277.1600795046405; 
 Tue, 22 Sep 2020 10:17:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvus+3NLsv37IjFW6+PY7wmr4+E/sq1xSi12uifQbqJONfwdmu99fivH2ic+YtLLHkAzwZLg==
X-Received: by 2002:adf:a3db:: with SMTP id m27mr4992964wrb.277.1600795046228; 
 Tue, 22 Sep 2020 10:17:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id o16sm25155780wrp.52.2020.09.22.10.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 10:17:25 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] tests/acpi: speedup acpi tests
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1473173750-11761-1-git-send-email-marcel@redhat.com>
 <5362df9c-00f8-adab-ecd2-481a33e84687@redhat.com>
 <20160906184921-mutt-send-email-mst@kernel.org>
 <41dcdc9b-ba44-3dcf-78b2-72cade130766@redhat.com>
 <20160906221822-mutt-send-email-mst@kernel.org>
 <52fc397d-bd03-e8e7-fd82-61ad278db7c3@redhat.com>
 <20200922170333.GA57321@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f6f1d85c-c805-1164-3e0d-3ca5ede4d8ff@redhat.com>
Date: Tue, 22 Sep 2020 19:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922170333.GA57321@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 19:03, Eduardo Habkost wrote:
>>  I can remove kernel_irqchip=off once
>> apic irq0 override is assumed.
> [4 years later]
> 
> Can we remove it now?  I couldn't find out if we can assume
> kvm_has_gsi_routing() is true everywhere, or just on a few
> architectures.

Yes, we can.  Other architectures don't matter, what counts is that we
can require kvm_has_gsi_routing() == true on x86.

Paolo


