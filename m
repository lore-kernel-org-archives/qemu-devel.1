Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A339C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FB320757
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxJRD+ET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FB320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRJT-0006Ok-Tt
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPRIA-0005LD-0i
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPRI6-0003Hi-DI
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601907395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3zYXOzmUNhQCVAIu6aydxgpj0wWKxluKiW+NCUPQIs=;
 b=XxJRD+ETCDKAbES3uZoiEZHqsFZY8dwjmfLC+bF4pXNt2cPYnFKZqebCCj8nu0AuIJALol
 n0R2haUWPseCKLlOtP4+hIUuIDIpwwfWymoHOfwCd3z+MBKq1T++DsnX2LCZfoc5IqV/kV
 xE1Z78uvYWpea9gB2OrI0nMoVJhT9WE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-7VVnMOv6O0OgwK7i2AYxSw-1; Mon, 05 Oct 2020 10:16:33 -0400
X-MC-Unique: 7VVnMOv6O0OgwK7i2AYxSw-1
Received: by mail-wr1-f69.google.com with SMTP id y3so4059277wrl.21
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L3zYXOzmUNhQCVAIu6aydxgpj0wWKxluKiW+NCUPQIs=;
 b=YADgNQcioqJp6d4Eof6zNggY554xOeKJB/cucIHlcLuhRdVYaVGtgKbHNY+zDipXC1
 eqhOC1JwtP/iftOMkWB7VBsQe92Qu5EywDBdFtOJpCZk2p0O4BdmfbY+fYInpEHbzYsi
 rWbvdVWOCcbNLIZyzkmeG3+gPSgElIA7pc0kuz0ZZpXzWi4S17tr4voZR8SdQ4Y55nTH
 O39tbqOZVzEf+XgRRsOmEmHny0dsX7K8wb2VMwW8ZLeqYTBUz5swM+QPyY+JVHjjNHXZ
 sf8MRIBl3E13rJIwiCmPv/EYyhN/AL5lYDzNILYZU4Ld2j7NtucLXwV1IRNJZ1LBMjkg
 5Gow==
X-Gm-Message-State: AOAM532JOgEbTj4C6tK+w9DrEppkK7NMRYjhX0SvuSVb+YOSNsuCmx3Y
 C5YCDlyWwcZSFVonYNsHYPtQJvP6tddzlHRf+qFMbbrzZk8dzIJDnUBudy5AUvYjqxUmYYzifM5
 Ts9C/8/shTNKn/bg=
X-Received: by 2002:adf:a3d8:: with SMTP id m24mr17867986wrb.418.1601907392417; 
 Mon, 05 Oct 2020 07:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2DBnRNJJmlL2AavriVhBe9M3nuyfY0VqIqBOi1JZzeAuQnCVLULfVnXBBYdNVCHzsMHADWA==
X-Received: by 2002:adf:a3d8:: with SMTP id m24mr17867953wrb.418.1601907392168; 
 Mon, 05 Oct 2020 07:16:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2e86:3d8b:8b70:920c?
 ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id i11sm137865wre.32.2020.10.05.07.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 07:16:31 -0700 (PDT)
Subject: Re: [PATCH 2/4] dtc: Convert Makefile bits to meson bits
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201005135613.435932-1-pbonzini@redhat.com>
 <20201005135613.435932-3-pbonzini@redhat.com>
 <9fba8d68-ab43-1b2a-5af9-e19255b234c6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa14de31-70e9-bd82-5269-b2f0ab228ec4@redhat.com>
Date: Mon, 5 Oct 2020 16:16:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9fba8d68-ab43-1b2a-5af9-e19255b234c6@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: marcandre.lureau@redhat.com, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 16:13, Philippe Mathieu-Daudé wrote:
> On 10/5/20 3:56 PM, Paolo Bonzini wrote:
>> Build the library via the main meson.build just like for capstone.
>> This improves the current state of affairs in that we will re-link
>> the qemu executables against a changed libfdt.a, which we wouldn't
>> do before-hand, and lets us remove the whole recursive make machinery.
>>
>> The list of targets that require FDT is now obtained from default-configs/
>> instead of being hardcoded in the configure script.
> 
> Could this be a machine Kconfig instead of a target makevar?
> (Not asking to rewrite this patch, looking if this can be
> improved later).

Yes, I think that's a very good idea.  I'm not sure which machines need
it, but they would simply "select FDT" and meson.build can look at
config_devices to list emulators that require libfdt.

Paolo


