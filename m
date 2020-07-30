Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB5D2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB5D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BVp-0002uV-6i
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k1BV6-0002LG-8W
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:33:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:47318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k1BV3-0003aA-3n
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:33:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 522D2AC82;
 Thu, 30 Jul 2020 16:33:54 +0000 (UTC)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
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
 <b4de7352-87ba-df4c-fdcd-dab4028cef61@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <5a41a63f-8397-64d3-0839-6990e2965339@suse.de>
Date: Thu, 30 Jul 2020 18:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b4de7352-87ba-df4c-fdcd-dab4028cef61@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 02:10:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 7/29/20 12:01 PM, Paolo Bonzini wrote:
> On 29/07/20 10:48, Claudio Fontana wrote:
>>> If you want you can add to your accelerator ops series one for
>>> qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL), cpu_get_ticks() and
>>> qemu_start_warp_timer(), that would certainly work for me;
>>
>> The problem I see here is, as usual, one of meaning.
>>
>> Are qemu_get_clock_ns, cpu_get_ticks and qemu_start_warp_timer
>> accelerator-specific cpu interfaces?
> 
> qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL) is because it needs to take icount
> into account, likewise for cpu_get_ticks(); icount is TCG and qtest
> specific (with subtle differences between TCG makes icount optional and
> qtest makes it mandatory, so further separation of the two concepts is
> totally fine for me).
> 
> qemu_start_warp_timer() also is accelerator-specific because, besides
> icount not being applicable to virtualizing accelerators, the warp timer
> is not needed for qtest, only for TCG.
> 
>> Looking at their implementation, currently I don't think they are, what do you think?
>>
>> Should these be grouped together with
>>
>> create_vcpu_thread,
>> kick_vcpu_thread,
>> synchronize_cpu_state
>>
>> in the same interface?
> 
> I think so.
> 
> Paolo
> 

One problem I noticed is that qemu_clock_get_ns is util/qemu-timer.c, which is tools _and_ softmmu,
while I tried to extract the softmmu-only timer code in softmmu/cpu-timers.c,

and the way I saw it, accelerator cpu interface was softmmu only..

Will pause and keep thinking about this.

Thanks,

Claudio


