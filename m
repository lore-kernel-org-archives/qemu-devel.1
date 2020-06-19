Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D81FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5535F20809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eR57Ocxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5535F20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJDC-0001eI-Hn
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmJCW-00018B-5X
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:45:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jmJCT-0006lI-QQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592581504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLaQtsejDWd3u5WGrZCjwGcdz4AwMv/TH/kcYt4u6Jo=;
 b=eR57OcxvdzqMBTvQO20ktBs0892x281gRv4VZPKGgQ/P7Sts/W1NwZQiphhgPCIHssiLB9
 U3UnUi21uYCfcPAhRdSxspoifhtuZl3HA5c+42mPOBu9CGQdBwU18IVGUaCJcsvXAaOYGw
 QJpdDbc/yob0nJ0tVOVypOegL33AHwM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-d1klGqD-OJGVObnOf39oTQ-1; Fri, 19 Jun 2020 11:45:02 -0400
X-MC-Unique: d1klGqD-OJGVObnOf39oTQ-1
Received: by mail-wm1-f69.google.com with SMTP id u15so2742977wmm.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SLaQtsejDWd3u5WGrZCjwGcdz4AwMv/TH/kcYt4u6Jo=;
 b=MzeMrHqrj+znMFYmNFUxWh+lu7GVDX45dJdAseDN82kuamzETUHLjPEcYr3gPYAylU
 PzNua8QQBgvWTv660CjTOoDrwM3+36ZoZqSL8YX38KXduYFVSUiRL8QXw67t+5raKfm/
 Gdd/IZ/4nzpcFDspdo1QD+r4Yj726F1mLQ0P1x1rRdBljU1sb9sGRQeU7TfBTC3hyLqt
 2MOtl6806geYyju23QxuTw6IVvIOwvjQIA3K2+D1x57etzdm5SLKVoQPZiaiNAwv0vGF
 73RyX0xC+1mNA9eBVI9Wlnj3q/x5GAE4rC8srcuIWL1+fzLQNgQaySWjTzuS8gSVsICn
 i+Bg==
X-Gm-Message-State: AOAM531Q5/NOVA4ZbfEmQTM2gsZYcx4B9v7hJ8ubs1OdsznWxa0aDVyr
 yzY49EGfAoD1zefsPdu+QpGwv3t3seU8UPpSXtQPBHU+DBMhPkPA5rLr41TeUzDT9IBvFq2FhqY
 H5WtBFrnnJxvaib0=
X-Received: by 2002:adf:9d8e:: with SMTP id p14mr4654049wre.236.1592581501494; 
 Fri, 19 Jun 2020 08:45:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY8N9Cm+LpxaCSjVcboGH6aeHKeTxBOofUuBrtU6pbFGmjIxuFswpZguAM1Xv9AN1InzT60w==
X-Received: by 2002:adf:9d8e:: with SMTP id p14mr4654031wre.236.1592581501312; 
 Fri, 19 Jun 2020 08:45:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id b18sm7465092wrn.88.2020.06.19.08.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 08:45:00 -0700 (PDT)
Subject: Re: [RFC PATCH] docs/devel: add some notes on tcg-icount for
 developers
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200619135844.23307-1-alex.bennee@linaro.org>
 <CAFEAcA-KX-2zjktg9A8dPdo6RkxtafM7YnahKaP=uftCO-7=GQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <657301f4-57d5-d55f-3f4e-c44db377aea7@redhat.com>
Date: Fri, 19 Jun 2020 17:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KX-2zjktg9A8dPdo6RkxtafM7YnahKaP=uftCO-7=GQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/20 16:54, Peter Maydell wrote:
>> +
>> +MMIO isn't the only type of operation for which we might need a
>> +correct and accurate clock. IO port instructions and accesses to
>> +system registers are the common examples here. For the clock to be
>> +accurate you end a translation block on these instructions.
>> +
>> +.. warning:: (CONJECTURE) instructions that won't get trapped in the
>> +             io_read/writex shouldn't need gen_io_start/end blocks
>> +             around them.
> I think this is backwards -- instructions where icount is handled
> by io_readx/io_writex are the ones that don't need to be marked
> with gen_io_start. It's the i/o instructions that don't go through
> io_readx/io_writex that need gen_io_start.

Yes, and likewise instructions where icount is handled by
io_readx/io_writex need not terminate the TB.

Paolo


