Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22942077D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIcdHYEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22942077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqexh-0003pF-Th
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqewd-0002rO-RZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:46:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqewb-0000lz-2x
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593618399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QyMu8Tnry7x/0OjVIwhRuRLkBtdZFOiyHxNZC+0maQ=;
 b=AIcdHYEVoKsf1eYTFbrYvX0Ot1L/YrQwANY7qz/Th7NDnlQc5Q3lxhbtdYn3I0hUeAVYAG
 Y83VnN0B6g74oFhCrYL4u0Vz2k/hiX+XjLjfRnmJLyLNT9y3UtN45OAuJFxWmHD2QVdnTJ
 MzV8wHM7jukGY54f/nQIx/V8tJhW4c0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-O60e4mwjPi-fokwyZFrkPw-1; Wed, 01 Jul 2020 11:46:35 -0400
X-MC-Unique: O60e4mwjPi-fokwyZFrkPw-1
Received: by mail-ed1-f70.google.com with SMTP id x20so21439074edr.20
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9QyMu8Tnry7x/0OjVIwhRuRLkBtdZFOiyHxNZC+0maQ=;
 b=SOLRd6RuJQcMt9mS5+05mmnTbSDXanU57AXKEpfGpAsV2ALPyp76pvWL/NoDzH+Ack
 RkM7hOkwtHH2dFQQxdDmSLcmiXqvg0aMb+sks1HlbwIJ9u/hmbV4UvagzdqWkBhseg5w
 s0ggRjR9HgtF2p1C5kHEBXTtdjkgEb3kVZo6TQ/G4Mqi2lMCzE82CDR7qbESAqYencen
 OsCEXRzYhycp4VDqF5CqoslAQF4Me4olFLcLngbrYh7JDrcmxd4XrLqUvz6v0jes3X6X
 xEnUbSlo1NIWKd3wZWJrchdBveTHZRr+iNknodkZ7PBkktDm5pYkSXr5idVzQ/CuriF1
 Xebg==
X-Gm-Message-State: AOAM5335H3x2qm/t8xd947kP1cYDYaYKk1nwkRoPay4l4/cXlfP/AiPd
 eaL99DR+SwICp5kS1iKVXGT/8SHAKaLRdCIHrsrUiPAnQc93NMTUDRoXjfFJBQ/HW/WgFLK8+6J
 NefEk9Q3Cf8/mwtM=
X-Received: by 2002:a05:6402:1b0e:: with SMTP id
 by14mr28853629edb.266.1593618394389; 
 Wed, 01 Jul 2020 08:46:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDqkjTiGUKOIloYVs03WXtug1l6aSs5F6K1RuVpQ+Rsgimk5AvD8+U9MwndB401AlGe5BcGA==
X-Received: by 2002:a05:6402:1b0e:: with SMTP id
 by14mr28853613edb.266.1593618394211; 
 Wed, 01 Jul 2020 08:46:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d66:2ca3:22cf:9fa9?
 ([2001:b07:6468:f312:9d66:2ca3:22cf:9fa9])
 by smtp.gmail.com with ESMTPSA id b4sm6372902edx.96.2020.07.01.08.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:46:33 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 chen huacai <zltjiangshi@gmail.com>
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
 <1fdab6eb-9258-7df1-75ea-b4717a9c2b87@amsat.org>
 <3ae1ef05-8caa-b5ce-a1ce-9670fc0a7cd3@amsat.org>
 <009f6fed-f043-cce3-f2c8-9aefd70d9601@amsat.org>
 <CABDp7VoRWPft-aXi5OfreUQ0AzoRWe+cg8wySHwmbf8wADg=JA@mail.gmail.com>
 <CAHiYmc4Go4RmdOC4dBE0Z4tu0d8mciiG1VUSz4=k9t58b54MDg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96553b01-2e8c-3c04-df7f-8aeca8ccbc7c@redhat.com>
Date: Wed, 1 Jul 2020 17:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4Go4RmdOC4dBE0Z4tu0d8mciiG1VUSz4=k9t58b54MDg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 15:53, Aleksandar Markovic wrote:
> Although, honestly speaking, your
> credentials for being a maintainer are - at least - three order of
> magnitude higher than for some other maintainer.

Aleksandar, this is not an acceptable way to refer to other people
contributing to QEMU.

To date, the QEMU community has not explicitly set rules around
acceptable behavior nor has it adopted a Code of Conduct, mostly because
we never had to deal with serious harassment.  However, the basic
standards for getting along with others still apply, and they were not
respected in this case.

Respectfully,

Paolo


