Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C005206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgaCWSKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C005206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ylb-0008DI-B8
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yj1-0005S7-PG
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:31:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yj0-000311-0k
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596792700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f96sXlcTus/APgqVuz0+9hxMLyyEv/PLv0GfXHUjE3A=;
 b=MgaCWSKDPazkKul9ocD9+kA5ka1XOyvOKrbNDu0Vlugy0jWigbfgbnewVDB2RwhuJAUMAE
 lTnqmxOK14z3nzwtNhJ9/YOiuMCbpvmuM0ajMgPrDpbZyVL8uigrxhhz0SSFlYCUafGCfT
 eIffSOwBdYoPrTaEsEYsuF3iFhVIwX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-mlrvb2yCNzirdYXDm7gwrg-1; Fri, 07 Aug 2020 05:31:38 -0400
X-MC-Unique: mlrvb2yCNzirdYXDm7gwrg-1
Received: by mail-wr1-f71.google.com with SMTP id 89so518168wrr.15
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f96sXlcTus/APgqVuz0+9hxMLyyEv/PLv0GfXHUjE3A=;
 b=U2Gb/yxjPf1tgNqB36LCfJtj2Z+I4CdDa/3UWqw6Hn53tkOAbnF5tlYNFabI9kH0sB
 qTbdpAHdt7b3CDh9s2ZDNnn8tBTFAGN4vNHwg8AElKPFehevafvkMWtSauUi1/YzWNce
 wljYiXs+7EI0j53Jv1zPgNakYHfG5Ki0xYN0FOwS6z8jU3Pcv3wed2nydJJny3GBWbJB
 JOOnUKBERuOtg8nVRydKMYGGj2/M10EiaTWi5zOEC4YtJnGka1kjta1vsXLH3pOfJiwF
 yKvP3AN7QigoZtjWFzE9BM5tyC5hs7EdVL2G+C278Va9rCvMZbPvUKhtVlWWmMg3IGlL
 uHHw==
X-Gm-Message-State: AOAM530pSGlyRL8NuvkHGfcoxSkwL5bmxn5lzeM6Ocvcbix+/HU4YHs9
 duhoAshiK1YYsWDiHJmF61/Mw0Lu3qtROTL5tk1RC+nwOvZVcm89tmV2cijVUDnVuj39DUorllW
 yhwxDvFU3A5s//9w=
X-Received: by 2002:a7b:c205:: with SMTP id x5mr12698573wmi.161.1596792697720; 
 Fri, 07 Aug 2020 02:31:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjZoRJOMyQce0TMZf+T8QKPjyexNH5etfZM9vnBKt/bnXJtP/fJ2HHf3KcPcznf+TNdz1Inw==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr12698550wmi.161.1596792697484; 
 Fri, 07 Aug 2020 02:31:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id a11sm10760245wrq.0.2020.08.07.02.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:31:37 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c894412-b156-607e-1ea9-9e9ba14cbf1a@redhat.com>
Date: Fri, 7 Aug 2020 11:31:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 10:51, Thomas Huth wrote:
> 2) With --meson=git added, I also do not get much further:
>  "./ui/meson.build:77:0: ERROR: Program 'keycodemapdb/tools/keymap-gen'
> not found"
> 
>  https://gitlab.com/huth/qemu/-/jobs/675546229
> 
> Any idea what's going wrong here?

This is also a submodule not being initialized,
ui/keycodemapdb/tools/keymap-gen comes from a submodule.

Paolo


