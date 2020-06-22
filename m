Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 23:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1CA20656
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 23:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCzWjagx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1CA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnVVF-0007hr-53
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 19:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnVUO-0007CA-Ag
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 19:04:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58447
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnVUM-00029x-6Q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 19:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592867068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRzCWX3ReFeVc/uIdEctANg6zEVQMutBkN5Zs6/zBBA=;
 b=SCzWjagx3fGp3CtkKL3CH+NOjl64qn11nHPgwI0sXM6PuKlpx2OsuW3szWTp0K+cc0XQvM
 /nhp6csc6RcQeJ6LjW5WcFGC1N75DwAIo0gN20mhTpKB0RZCsHWjchXNXJbyfD1eHrSaVN
 DE1v/Tpcb0D6BIo55MAuW+ORvsEb3BM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-8kru431SNtOWdyWVGR7XJA-1; Mon, 22 Jun 2020 19:04:25 -0400
X-MC-Unique: 8kru431SNtOWdyWVGR7XJA-1
Received: by mail-wm1-f71.google.com with SMTP id b63so766947wme.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 16:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xRzCWX3ReFeVc/uIdEctANg6zEVQMutBkN5Zs6/zBBA=;
 b=EiLcxmCCzx3lfVbbLZvsus3DK0S0miny1rVk7qxMJBgo8vGWzoKL4Gi97SbLMasuns
 cw8RmxJZnM0K+mV4QUEK2mOaM2uKkIr0MsjpW1tjba3tbDZojmhdhPHDpX3DMpN6wvSH
 0ozhsmFbrT1uuOBHwXtxtyNagZR+gg3mHubDc8YUPzRBweEkxMZv1dsBUdrh+zE5zUdL
 iLYDPwlNgg44V2Q4+tCgSMLFkgmAV90hX1SWBP1meP9tHELyXMH+GOPiAUfsCRPTRUTe
 AKNRXN/LZ9fdJvdR1jOQrP/e3Upux7enjzWB9/dwB5IUT9LqPguQ64Z1/HUDiaEx7z24
 T05g==
X-Gm-Message-State: AOAM532VpgVSPE7QJeFOjbNOO0AHn0Ol4A+ZOqnbFPagZPwpcH/uqCkY
 cCfwvTW5XeHr0ZA0e1DNP0XFaE6euOHbjphsuIfQTHoGQtuUI0YZNPQxtOZp4YWGL9EOVH9iFBj
 g5e4UDQViF2Sz6wI=
X-Received: by 2002:adf:de12:: with SMTP id b18mr13456212wrm.390.1592867063885; 
 Mon, 22 Jun 2020 16:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCMm76vknqfhl5TfPdRFe6d9kiyEXsSRCmb/qlBxD84BMRtMxK4i/hWNfm4fQnzbqWzWzSGw==
X-Received: by 2002:adf:de12:: with SMTP id b18mr13456180wrm.390.1592867063556; 
 Mon, 22 Jun 2020 16:04:23 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id 1sm1202692wmf.0.2020.06.22.16.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 16:04:23 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm: Check supported KVM features globally (not
 per vCPU)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200619095542.2095-1-philmd@redhat.com>
 <20200619120202.GH2690@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3ceeab9-aeab-175c-f778-22574f49f684@redhat.com>
Date: Tue, 23 Jun 2020 01:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619120202.GH2690@work-vm>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/20 14:02, Dr. David Alan Gilbert wrote:
>> Paolo, does this break migration of encrypted memory assumptions?
>>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Supersedes: <20200617130800.26355-1-philmd@redhat.com>
> I'm not seeing the relevance to migration.

I told Philippe that there could be a possibility in the future of
having more than one KVMState to support SEV live migration, so removing
all KVMState* arguments is not a good idea.  But for kvm_check_extension
calls it should be safe, as those should be the same for all VMs.

Paolo


