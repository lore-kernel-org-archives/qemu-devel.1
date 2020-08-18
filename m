Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAC12067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkynIBkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAC12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84Sy-0005LO-UG
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k84OS-0000Gh-DB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:23:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k84OP-0003Ly-W3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597767800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNuzNQVewYBh90l1WlUw8Ph7Zj8ZoxC+01USXrxt380=;
 b=QkynIBkSEezH5OMLaU6A8ZwL6enbBGhMGjsKhWsSnTZ/td4n+BM9yNHmCDWx6VCGBYl1AH
 a/PtIQRoLm/7jNfL33hxL33dXS+5hP+4iGMN5QZJElSbkgERaAX1RxaY7uAHPHkV8kUEtR
 Vd3Fud1zhI8JZXY1D6z7Xy5kFbVW4X4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-nE5TAEywM4GxOVGPNXNh8g-1; Tue, 18 Aug 2020 12:23:18 -0400
X-MC-Unique: nE5TAEywM4GxOVGPNXNh8g-1
Received: by mail-wr1-f71.google.com with SMTP id t12so8461347wrp.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 09:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aNuzNQVewYBh90l1WlUw8Ph7Zj8ZoxC+01USXrxt380=;
 b=qSgIv1aJ66/DrM7h9H+jiiFiW9gAB6p552dS55c596kC72Qw8+ityekEOz/ZpW5yJA
 wIwtD0oiGkDTb1ahlMpx9mAmS1IR3lP/bTwaxaTAc8FYDX+DJNFxLcYyRkDSu4d2EOL6
 XlpPo3e3/zsaLi0uEWcNz1dc8CjZttgF5L9QQbOZbUd3o7a/GlzzcLV4tnoJN12h2wty
 JfUcFUcuMxjEhbj6fY56m5d0V/9x3umCNFCqEw76rFa43njzthxUmNvt8yp6J3CeacyS
 6MFOL+TRoB6AlNgS1CaYTkkMssjMN6B6n2gRwppF+9h7WUBBCsEa/XCf0XznAYQRMqtq
 UQoQ==
X-Gm-Message-State: AOAM531dW91vciTA1JX0aoWgl/h/E1EjVBkhGvUIJ29W+iaU6ffKXGtx
 L4JPw+wbAfZkC4ZAb3CzTrkk++OxOiFVyrPa2SGZ9IyWNpIHF+pq2HJXvlgKgrzrYeIFmejbgHD
 p+eU4ZghRHjQ4hFs=
X-Received: by 2002:adf:ee83:: with SMTP id b3mr47191wro.163.1597767796767;
 Tue, 18 Aug 2020 09:23:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxovvpGR8/T7UHQ8VB9LQAe5ilIUCYvnO7OdlDIqIX5faXgbSqrQXg3dB/sgjya8WWOKJtgVw==
X-Received: by 2002:adf:ee83:: with SMTP id b3mr47177wro.163.1597767796532;
 Tue, 18 Aug 2020 09:23:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:38e0:ccf8:ca85:3d9b?
 ([2001:b07:6468:f312:38e0:ccf8:ca85:3d9b])
 by smtp.gmail.com with ESMTPSA id q19sm36710942wrf.48.2020.08.18.09.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 09:23:15 -0700 (PDT)
Subject: Re: [RFC PATCH] os-posix: fix regression for install-less datadir
 location
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200716141100.398296-1-marcandre.lureau@redhat.com>
 <8c8090d3-9f81-77ba-6f8e-3f26b11ed77a@redhat.com>
 <CAFEAcA_v0qtNyjOPUZ_erjuF113O3xb9Gr8uC=+TMF-QZ0g55w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <560accc3-a5ce-41cb-9417-d20166a4e514@redhat.com>
Date: Tue, 18 Aug 2020 18:23:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_v0qtNyjOPUZ_erjuF113O3xb9Gr8uC=+TMF-QZ0g55w@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Joe Slater <joe.slater@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/08/20 15:10, Peter Maydell wrote:
>> So for example all references to CONFIG_QEMU_DATADIR would invoke
>> get_relocatable_path(CONFIG_QEMU_DATADIR), which would return something
>> like "/usr/bin/../share/qemu".
> Unless you have that series ready-to-roll, I think it would
> be useful to just fix the regression (and cc qemu-stable on it
> so it gets backported to 5.1.1) for the moment.

I have it ready but I agree it's not suitable for backporting (among
other things, I've never tested it on the non-meson build system).  I
can rebase it on top of this patch with no issue.

Paolo


