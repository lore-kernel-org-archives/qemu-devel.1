Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A31C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495722075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CisQfBL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495722075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sQK-0007vf-Be
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2sEg-0002Yz-Na
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:23:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2sEe-0008BO-3N
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596529426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtzrzeWraKEhpjSd0OmO0eCLztlEL66QjMwruxmz6L4=;
 b=CisQfBL8FSD2Qy4Jd7QR8fsV7vcMbNoXfaRtzywyi3NlWwVrvmY7JOT/Q+LB2eloTpBhyN
 NZYcl4FwXxRk5H1w+du6riFJ5Cs4PAn/tH0HKqIrF/mXn3Ngldd8/N5rFpx0OqFuG5Ua5Q
 FxGKFnPyM5b3pO/3cHYurWz9KmFOK4I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-GDz7i-8NNkagfTx4o63qNA-1; Tue, 04 Aug 2020 04:23:45 -0400
X-MC-Unique: GDz7i-8NNkagfTx4o63qNA-1
Received: by mail-wm1-f69.google.com with SMTP id g72so792714wme.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 01:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CtzrzeWraKEhpjSd0OmO0eCLztlEL66QjMwruxmz6L4=;
 b=ejXBFphkR0SnXWDN/JWROXxptPjRYCYVCEbo29FK+XF2S/u2RMzZki4ea3oz779SMG
 H2gX1idoMkZUwWPpsXMLTMO7ZsHO4hpQ82x76/IrN9qGmEQRLx7fayOOGY/LwR8jL6rk
 CORcKgJEYDnSWNmN02VIPkOENxxXBbHkKyccrS/5c8N0r6aRaoh4cYRUkjkSHSD69TZc
 YjgOmr1/ghlRe7ZRYKq0+9Hdf9mkvN6Fl50mXpLFLYHTcEeApWhKjB/WToC28DITCMNC
 0e7S4U0OSyTnUWJVZ9gNPWWY/Gxz2hb9b9FxAHn5zLAAs1XdguZemowZjFXdrY9OpmKh
 qosQ==
X-Gm-Message-State: AOAM531HmGAN8SLnvtrRSLSsRZb10VrF25JwxlpF5MKz8R+y5f/9SeZv
 MXn4lhnKw9D1lfhquxWCr6cPCktkJkcTSe0H252dMP5L4UxtjRJzWscPaH7X6PPXuEETPVnHLFi
 A3PyDdLUFCrCY/vU=
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr18217652wrr.299.1596529423817; 
 Tue, 04 Aug 2020 01:23:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/o53A2vCySyJpQdU2D9vpgDZqBsIA2hVISfnrx9waA0Sibd7jOpsfuq+Dv5peF0CAvHa89A==
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr18217620wrr.299.1596529423606; 
 Tue, 04 Aug 2020 01:23:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id d14sm29180357wre.44.2020.08.04.01.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 01:23:42 -0700 (PDT)
Subject: Re: [RFC v3 1/8] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-2-cfontana@suse.de>
 <910286a7-805d-3b62-a3b0-aeb5d0a9606e@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b34dad3-9868-c773-4ce0-0063837e17a2@redhat.com>
Date: Tue, 4 Aug 2020 10:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <910286a7-805d-3b62-a3b0-aeb5d0a9606e@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, haxm-team@intel.com,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/20 10:13, Claudio Fontana wrote:
>> -        if (mem && use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
>> +        if (mem && icount_enabled() && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
> 
> 
> 
> In this specific case, where dma_blk_cb() changes its behaviour to be more deterministic
> if icount_enabled(),
> 
> do you think that if qtest_enabled() we should also follow the more deterministic path,
> or should we go through the "normal" path instead, as this patch does?
> 
> Tests pass in any case, but I wonder what would be the best behavior for qtest accel in this case.
> (Maybe Pavel?)

No, qtests simply should not use SG lists that cause the problematic
nondeterminism.  We don't have that luxury for guests.

Paolo


