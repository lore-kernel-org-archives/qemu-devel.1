Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64650C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333AB22BED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNz7ns+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333AB22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8jBZ-0006QB-Ek
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 07:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8jB3-00060z-UB
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:56:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49696
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8jB1-0005uw-OS
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597924574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBhTjgNWAR+w2XmbqpDKvQvrse6BnD8mHONHHbHbeKg=;
 b=BNz7ns+k/mRgapL3K/MwHO5lWxAdOygrrDo/nG72GXK2ppVmVPB56Kdjc/4SimX6z8n/P0
 71Gu83ihrzdJFjVDrdhVt34s98nsiLYaqRY5p9Wj7dh8DySrZkgQdC+BxMqS6J7SePkyIP
 CTQCnSWaBbjyx2eT5gNXPDQ7q5wf5Pg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-7PT5I7ufMpOIa4ly8Qtg6Q-1; Thu, 20 Aug 2020 07:56:11 -0400
X-MC-Unique: 7PT5I7ufMpOIa4ly8Qtg6Q-1
Received: by mail-wm1-f71.google.com with SMTP id z10so696543wmi.8
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 04:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UBhTjgNWAR+w2XmbqpDKvQvrse6BnD8mHONHHbHbeKg=;
 b=XND3Y5t+FWEB78CZR2xzcDzCVncteXYk7xSxPIpGsxWjAWKRLtUxBFRpUisobDAADe
 DZwV6o81i1ms+Lm7z4hSSjsFx5TMnTirx9QJPYZN8ezTDMHTW7imChkxJzizSUT0NUow
 LyBwrGjp62YZvJ+XeoZl1VKv8wGfHZUILSsppMg7bTuke7eTZTUAdeE/FgC+/UVlnc/H
 YOtvYjAdNbBn/9paXzBHFn/W22RI+gZOzVQ98sqa09kW5v8ARK9eQ+HXQCgjRHhnMGgc
 acvukdKjbiK3pmM+7YWyymN1D2wrKkIQc15g6cSlIycCBQvGe/3D47Akg3QXXJzdmFcr
 ao7A==
X-Gm-Message-State: AOAM530VEk5wSR15fDQO3ECOw029Mbm7JQHqTNet6WHPQktfJEaizOli
 ZLNcxpGduPRlpCtJ04UcmaYJIwczE9JvjMaA2h2/TiPzZ3T3tiQ6oJnaypUgab7ekS+Hy2APjOn
 bn16xf0yfvXdEJTE=
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr3207897wma.30.1597924569822; 
 Thu, 20 Aug 2020 04:56:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7UAXXBkzEcBIkIISXILSSejq276vWZe+bjhshjPU9othTn3plZZCueHhaOY81K4XnbVC9Qw==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr3207886wma.30.1597924569585; 
 Thu, 20 Aug 2020 04:56:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id l11sm3607496wme.11.2020.08.20.04.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 04:56:08 -0700 (PDT)
Subject: Re: deprecation of in-tree builds
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
Date: Thu, 20 Aug 2020 13:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200820105401.GA99531@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/08/20 12:54, Kevin Wolf wrote:
>> Paolo's conversion-to-Meson patchseries is about to land, so now
>> is the time for people who would like this "automatically create
>> a build directory and use it" behaviour to write the necessary
>> patches. Any volunteers ?
>>
>> My current plan is to land the Meson series first, because it is
>> really painful for Paolo to try to keep rebasing it as other
>> changes to the old build system occur. This would break
>> in-tree builds temporarily until the "automatic creation and
>> use of a builddir" patches go in on top of it.
>
> Usually, our requirement is that patch series don't break anything. And
> if something slips through, whoever broke it is supposed to fix it, not
> whoever is affected.

The Meson conversion was announced in October 2019 as breaking in-tree
builds, and the deprecation request is from March 2020.  So I don't
think this is a breakage but rather a widely-announced change.

Paolo


