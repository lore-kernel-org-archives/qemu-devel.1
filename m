Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EFF2085B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2Nb0Phj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EFF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsHg-0002sm-K9
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jlsGf-0002BQ-Lz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:59:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jlsGd-0003g3-SK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592477974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4ymCPVOrzD26cLd7e7ZxsUEn02gLoqcQg/EGZ48yLQ=;
 b=Y2Nb0PhjkVrS7cvM/DKQcKHrgsJA+WFN1g2W69/YzILglgeu+9cVjOwTzZgbJzki2Hl2aB
 fh7ueRVvygifh2dusp2unnzg1MrPs/qeKuN9MiBchtGuCbOUiZz/QVIThg/8eMuocwYaxA
 LavIgVVd15E8dkAYBgIShwt2ivJAvI4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-CDAjUWlMOLijDAKzwY_iIw-1; Thu, 18 Jun 2020 06:59:30 -0400
X-MC-Unique: CDAjUWlMOLijDAKzwY_iIw-1
Received: by mail-wr1-f72.google.com with SMTP id b14so2360284wrp.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B4ymCPVOrzD26cLd7e7ZxsUEn02gLoqcQg/EGZ48yLQ=;
 b=MOG7FTi/c0oLgdV/yoUZBujXcUODHdnHR7Lo0f4dr8/fVgUupvSEqcFwsnUP6rSdQg
 ap/vZxfWltBE+11wE23VmOAL6LKQGEQV19dK6joI0EobMmROGk2CyOn48Pczav2wHHMt
 df2PH2Mr39gXI460F/rHI0k771vV6zK2/OkPRthr+5dRcFJBw2vhQf8Pj1nDMV7ka1Lh
 X6oyKOPkJfEdecDsNT7UIhpFLw+skRwsIFJH4dgN8VkVL5kwISyYhXcsU0spFXNm0fHz
 K9r9A6IcmGqSEm7lpkWEned2NmiiGXevHZZ3th7D8q1KmA+NOe3XRRi+ZdCaQLZrQfkK
 BCoA==
X-Gm-Message-State: AOAM533ZiKLihB8+yNcW7JITdoX5yPT9xU5ayOz1ANJzeuR9SwN4DQ61
 jzqzC71cQ62s4T6h1X9IeHaOHEBck94SYCAsQeYhmkSM5y+re5lFP0NlYTRKaVfRzH9yszPrAhr
 NlDsyUJS82+08M+I=
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr3603194wmc.104.1592477969206; 
 Thu, 18 Jun 2020 03:59:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZojsPun+QYWlisetTv5WpaznMjr4VlzHf9HSBejwt4olGv5Jk/r425yF3VyrRhnGksxZcOw==
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr3603173wmc.104.1592477969038; 
 Thu, 18 Jun 2020 03:59:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id e5sm187714wrs.33.2020.06.18.03.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 03:59:28 -0700 (PDT)
Subject: Re: [PATCH] target/arm/kvm: Check supported feature per accelerator
 (not per vCPU)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Jones <drjones@redhat.com>
References: <20200617130800.26355-1-philmd@redhat.com>
 <20200618092208.nn67fgre4h7yjcnt@kamzik.brq.redhat.com>
 <8729ee44-77dd-ab25-b400-859e59ced160@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b0dd59d-40d1-745a-d083-cfdfc4a246c5@redhat.com>
Date: Thu, 18 Jun 2020 12:59:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8729ee44-77dd-ab25-b400-859e59ced160@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
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
Cc: Haibo Xu <haibo.xu@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/20 12:17, Philippe Mathieu-Daudé wrote:
>>>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>>>      }
>>>  
>>> -- 
>>> 2.21.3
>>>
>>>
>> At all callsites we pass current_accel() to the kvm_arm_<feat>_supported()
>> functions. Is there any reason not to drop their input parameter and just
>> use current_accel() internally?
> Clever idea :)

Or just the kvm_state global.

Paolo


