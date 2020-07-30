Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF33FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923D520829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahfkbHuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923D520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Gku-0008VD-U3
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 18:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Gjg-0007Rb-94
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:09:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58140
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1Gjc-0000lA-TT
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596146947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlezEbcGbemcrB5KKTPYUUKfJWK3NqsY9WL1vRFrtzQ=;
 b=ahfkbHuCTXewJ+4CsFCTVkyvqUdxloSJjtc/gPEQ4yD8OG7NU+M58Mk1JRXxXh19mfYsVF
 YT2HnSDIeyzKN55z+XruK2aZbErOZOKCetCwDw0IdFE7SMlZ/U6X8fkuU1mc2RxM3l6jNx
 S0BuAqMSnMTlQNjDoljX6Qa3px8cWWI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-3iqHlxd5PM6xHGEOlbfZsg-1; Thu, 30 Jul 2020 18:09:05 -0400
X-MC-Unique: 3iqHlxd5PM6xHGEOlbfZsg-1
Received: by mail-wm1-f69.google.com with SMTP id h6so1688579wml.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 15:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PlezEbcGbemcrB5KKTPYUUKfJWK3NqsY9WL1vRFrtzQ=;
 b=oxvAqbs+OyIqS3PdOoOkyFYvkzm6tHT2XdQib6QmC5EDa3QOLU4wRqzgn3uBCrryjp
 wFVpA+qY2Hfa004HgIRMrEkpMJbGQ4c4mr4Gf+sed+4tBdrLD6+HLnQf/kS2zChfKSeU
 MgVapI9LfrRfEaBZYOdNJ/aQom+TEg0wyZcT9K7yG+SArBAPPJxxijD/lMCI8nxJ6VPM
 D3o9OOH5Yiqvk+lAdtXeSmeW6phetFBAqDrzDVvXF0u9ptxZoj3KlsZOOgyKlF9a0Q3b
 jGPEWNWnf7kCNpiGQosXJyLmMerACv817w60RiKPknG009yGCHNqf4usv51wye3gQrIi
 Hkjg==
X-Gm-Message-State: AOAM532l1kHv3cTi8R1TQGIjZUGqTp4pWb28tsRG6sz1gPTmmVgKwLrx
 AQnGSKjcgGszg1fg8vdEKXaxld7yYjO7MPt/OViqqZrck5uwPq2rgoNfnHUjIkTUh4whx38xV4y
 vWiEtt00Ikkfjlik=
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr705334wrx.219.1596146944629; 
 Thu, 30 Jul 2020 15:09:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNPFDfH17cIBG25poaOTwNdr5PQ6UgGTiJ5lbwejo+7XJao3qgOQMzDnv6nNu1WYbSQIs2dQ==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr705301wrx.219.1596146944369; 
 Thu, 30 Jul 2020 15:09:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id p6sm10627307wmg.0.2020.07.30.15.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 15:09:03 -0700 (PDT)
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
 <b4de7352-87ba-df4c-fdcd-dab4028cef61@redhat.com>
 <5a41a63f-8397-64d3-0839-6990e2965339@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8aaa983a-c720-88f2-5ad4-b88078ef705e@redhat.com>
Date: Fri, 31 Jul 2020 00:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5a41a63f-8397-64d3-0839-6990e2965339@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/20 18:33, Claudio Fontana wrote:
> One problem I noticed is that qemu_clock_get_ns is util/qemu-timer.c,
> which is tools _and_ softmmu, while I tried to extract the
> softmmu-only timer code in softmmu/cpu-timers.c,

Not all of it, only the VIRTUAL clock which is

        if (use_icount) {
            return cpu_get_icount();
        } else {
            return cpu_get_clock();
        }

and would be changed to something like

	return cpu_get_virtual_clock();

In turn cpu_get_virtual_clock() is

	return (accel_ops->cpu_get_virtual clock ?: cpu_get_clock)();

in the emulators, plus a stub that replaces stubs/cpu-get-icount.c and
is just

	return get_clock_realtime();

as in stubs/cpu-get-clock.c.

Paolo


