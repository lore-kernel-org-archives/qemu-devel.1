Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C811C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E9E206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRf7FNvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E9E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0iwn-0003FH-74
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0iuJ-0001d6-1U
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:01:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0iuH-0006x4-9q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596016912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7rWNmSXDGgZIhR4D5JBYjQmPTFZo6n5p/ygQKY+Rjk=;
 b=ZRf7FNvdldP0yDfUUc1El1hIRA0EqfNCSXj+9NOSuH88WjN9Sgc+g+CoV/qCv7ZL8qTsdH
 TmqiVGIGgGgCrl8uBkwG5IDQMBDMPDvEg+5zQ5PBFViqE4FgMR7Xt21APzLXC0CdCiBJ7E
 LrFu+zq38UywrPKz6SEa96t1TI1qkEs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-DKI4D13dMtyuyqRGHPbk5g-1; Wed, 29 Jul 2020 06:01:50 -0400
X-MC-Unique: DKI4D13dMtyuyqRGHPbk5g-1
Received: by mail-wm1-f71.google.com with SMTP id z10so808624wmi.8
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W7rWNmSXDGgZIhR4D5JBYjQmPTFZo6n5p/ygQKY+Rjk=;
 b=at2Vcf+hqog2YWmHG+R4gk32aApr9ozlkcLV7vjdJsLMzXDrp1I/MqlT02Be7nHSGS
 5X2uBSPiHoz7Srp5BEM6wgf1XjueN2ELMrkvCLRMj+uAtEL+etEhZdl95v5J+vArSFMS
 8c8QMz5ptxFHNQZvRL47ma+oGgP1hthOOKxm27oe2Wvt3cGAf3d8AUdSxxpCDC9FlNUR
 h4LsZBPeiZBU2RexEJQMswl+7gZCYYdNrpBOutIAI7LFUYKxmMH4VJxSYXHIPhXD8h8E
 ERW0gD2UJzVmW9cPrw1co6bYANm3jL8LJCEkbJCJZk3nyUX5+T7vhqlG7gvu+FdSTMHj
 hccw==
X-Gm-Message-State: AOAM533yWON0/jNfZ/pnEyJyEvpbQlMgQqP180O4rJpvysmMzcsa+MrY
 +78irNqvl4vGGfffvPJuykRciFwwwkWYiZ9rDBz7fhXzqQhN0tZ1ThjW3SYQxSuHj7lygnwOf0U
 qvYtdB+rNk/66uDU=
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr5973110wmc.40.1596016909793; 
 Wed, 29 Jul 2020 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1USgnbjfk/nPqJKGfrvraxQ6BrlQ6/4yP/eg+y/2mj2f/zP1OcgQKxgyzJOfmgmE1otDWdw==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr5973092wmc.40.1596016909528; 
 Wed, 29 Jul 2020 03:01:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2943:38b:308c:e0b2?
 ([2001:b07:6468:f312:2943:38b:308c:e0b2])
 by smtp.gmail.com with ESMTPSA id u186sm4071718wmu.10.2020.07.29.03.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 03:01:48 -0700 (PDT)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <996dc455-548e-5964-9c87-f4abe5b63907@redhat.com>
 <146b0cf2-509b-6a48-e82b-b93740e4c60d@redhat.com>
 <e3cc11a4-8ba7-917a-844b-4f6ec69d140a@suse.de>
 <76aac4ac-40f5-4870-ed2b-bab8b68b0a64@redhat.com>
 <9630c685-0a37-a1e7-4614-9d692988a799@suse.de>
 <22228280-f3b4-3f64-d2ba-30cfc47c8b0d@redhat.com>
 <994492fd-5ae2-52e2-0864-7216ec9dae34@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4de7352-87ba-df4c-fdcd-dab4028cef61@redhat.com>
Date: Wed, 29 Jul 2020 12:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <994492fd-5ae2-52e2-0864-7216ec9dae34@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.74; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 01:09:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/20 10:48, Claudio Fontana wrote:
>> If you want you can add to your accelerator ops series one for
>> qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL), cpu_get_ticks() and
>> qemu_start_warp_timer(), that would certainly work for me;
> 
> The problem I see here is, as usual, one of meaning.
> 
> Are qemu_get_clock_ns, cpu_get_ticks and qemu_start_warp_timer
> accelerator-specific cpu interfaces?

qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL) is because it needs to take icount
into account, likewise for cpu_get_ticks(); icount is TCG and qtest
specific (with subtle differences between TCG makes icount optional and
qtest makes it mandatory, so further separation of the two concepts is
totally fine for me).

qemu_start_warp_timer() also is accelerator-specific because, besides
icount not being applicable to virtualizing accelerators, the warp timer
is not needed for qtest, only for TCG.

> Looking at their implementation, currently I don't think they are, what do you think?
> 
> Should these be grouped together with
> 
> create_vcpu_thread,
> kick_vcpu_thread,
> synchronize_cpu_state
> 
> in the same interface?

I think so.

Paolo


