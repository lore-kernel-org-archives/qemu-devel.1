Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396BD20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2Bc8Iqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396BD20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnl80-0007ei-GD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnl6f-0006ay-Ea
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:45:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnl6d-0002Lt-P9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592927102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrvY17i+X9gp1rWnxKTpg7JhauXZALLP5yXiZnTDZ4o=;
 b=i2Bc8IqnEdhr0Dp1BkFYJuYS7ncZ29fe4CIcDa8mvVm9y7Z9zrtKiKIIG5x6euj2PeOUOT
 eSsiAW0d595Tr2mvwrIc4pdhmgGmsC3+ljGdHIvsZnVksJsoHBLSKZYYOF2k+ds6i5GiB7
 Iz1OQbcVKbdCH1nTVRTPD64PdzHL6Ec=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-ViIo47R-MSmEuvUsbdMNEA-1; Tue, 23 Jun 2020 11:45:00 -0400
X-MC-Unique: ViIo47R-MSmEuvUsbdMNEA-1
Received: by mail-wm1-f71.google.com with SMTP id a7so4716760wmf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 08:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SrvY17i+X9gp1rWnxKTpg7JhauXZALLP5yXiZnTDZ4o=;
 b=B1mVT0MmAchvOjhG81gy0SCy4WX5OaSf7giPmUIgdusY7cAoavZvehYxThmx4tcx6Y
 YN2Hx2bJsPTWaAZ1tyWdU5W+eO5DCh2h+soOkwH6SWPDAhhM5H7r8Pu2FTezpKdMvLT6
 Lv7py1ePFtbYPV/vl5wtBu03AZi61YF/EnnSp7b1SKn0CUhqT9RSaIZrAXIjTj4iDBTg
 B/iCKwkcYlwUpggu92RoYKO+omVdkzOZc+gA79/LDO82WRLsY8xZqZcUTeFERL90sXzA
 0jlJQ+hLa5I+HETBYByJWFtO8n/s2202OH/ur71wKSKWo2ic81YGmFMqIhb06tvKWsHw
 c2zA==
X-Gm-Message-State: AOAM531IO1DHBnUbhObXyuyybiL2rnIO/oD2IflfuM4kuXWwau6//l/T
 Y3oxWBKUOKDNYfEOBM4heBQDOklypVf3UPipmrj4vkbF1BfoVJxs92J4f7PCsX2vUhEXRLd7SGu
 KgCKQXHXQYZvQECc=
X-Received: by 2002:a7b:c952:: with SMTP id i18mr26281912wml.65.1592927099450; 
 Tue, 23 Jun 2020 08:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjsYRaFZY4Wov6Q2BSqy5hQJjhyiygVEeKNFhN55bylCagUAFn2/e+fyegswRbDgqMhQqM4A==
X-Received: by 2002:a7b:c952:: with SMTP id i18mr26281885wml.65.1592927099230; 
 Tue, 23 Jun 2020 08:44:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id m65sm4387270wmf.17.2020.06.23.08.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 08:44:58 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hyperv: vmbus: ACPI various corrections
To: Igor Mammedov <imammedo@redhat.com>
References: <20200617160904.681845-1-arilou@gmail.com>
 <e467716d-19cb-ffec-b464-494e975463e3@redhat.com>
 <20200623165741.5acc1dc6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29694844-7f52-f2cb-ddbf-97a404c80d48@redhat.com>
Date: Tue, 23 Jun 2020 17:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623165741.5acc1dc6@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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
Cc: rvkagan@yandex-team.ru, vkuznets@redhat.com, mail@maciej.szmigiero.name,
 Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 16:57, Igor Mammedov wrote:
>>>
>>>  dtc                              |  2 +-
>>>  hw/hyperv/vmbus.c                |  3 +--
>>>  hw/i386/acpi-build.c             | 17 +++++++++--------
>>>  include/hw/hyperv/vmbus-bridge.h |  3 +--
>>>  4 files changed, 12 insertions(+), 13 deletions(-)
>>>   
>> Queued, thanks.
>>
>> Paolo
>>
>>
> Paolo, there is a newer vesion on list
> and I don't think _ADR patch should be applied at all
> 

Can you explain?  The only difference I saw was the bogus dtc update.

Paolo


