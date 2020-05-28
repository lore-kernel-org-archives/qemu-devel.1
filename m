Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F410A207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBXC6Cc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F410A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeG17-0004bz-6g
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jeG0F-00043T-4E
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:43:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jeG0E-00034z-FH
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590662589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tXT4XcrAuT+IlS/1CQKZQEZ5Zenp1FldGU8m7xWHRw=;
 b=WBXC6Cc1zBkkQ6HXD7JQswCaaLLu303wgJJwzQmg6DLTQQ5tBFRvkEQLBh/fP5X5TYE8Kf
 XYudY0bCQ/p4yDmch8huKNDM2RHeib0mPC5onvCpg8Us4F9WEJlavHVkWhK5dHJEqa3Dtc
 nJtElWGIBzUujAd6bEuBGzlQj611pko=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-rFxmWMyrPvaPLv5jBs176Q-1; Thu, 28 May 2020 06:43:07 -0400
X-MC-Unique: rFxmWMyrPvaPLv5jBs176Q-1
Received: by mail-ed1-f72.google.com with SMTP id k21so11376365edq.13
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 03:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+tXT4XcrAuT+IlS/1CQKZQEZ5Zenp1FldGU8m7xWHRw=;
 b=HwYGXUM8mwOhjxoAbqNqOumr6X1SMC4DLMkhIZwzmfm6gZsUT36LF1eqBsW8M+4IMz
 5Q9p6MiLQPBSBWPYcBA8oKY+EI/rthdFO3BANEW3ZkEP7oLd3eqRiRAN+tZRtJGWJkC0
 rayr+fmcXlfLl05U16FiV5SSMfab4LKdwsGFAzRHnVBA9ongkEtiyi8yVZ4wy42lL6aR
 iN/I++MyPLmDsQIdPqxSFN+1s5xShFxOc7CNUbsbW3Vl0Z3pXaeqUkStlABuWwT70pCK
 3KynwXLZONY7xzepyFEtqnAPo3b0sAjAG3JoOSBPXvhUdF+TcLbnEZc9mDZivDld+q4S
 PDPw==
X-Gm-Message-State: AOAM531GiQ2EcPzbyNdxn1aI74Kq6J8K7FHUKcTumZ6M5pUwt0e1GRDP
 w9KX3MhpfsvhYIjeNsKNGQ8FDn4EwEfPogeEJ8sALrctVgU3yIJRCzCAuQZHHj35YFt51vlcshC
 bvjq0v/Kj8Aoqbh0=
X-Received: by 2002:a17:906:3597:: with SMTP id
 o23mr2378919ejb.174.1590662586447; 
 Thu, 28 May 2020 03:43:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykHnY8UhawJLo2OlN1jWxSMSKp1o3UqHOqcMnJEXjGYUx2v18S9EVNbgVQ9ae/vutVYEJxSA==
X-Received: by 2002:a17:906:3597:: with SMTP id
 o23mr2378904ejb.174.1590662586214; 
 Thu, 28 May 2020 03:43:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id qt19sm802316ejb.14.2020.05.28.03.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 03:43:05 -0700 (PDT)
Subject: Re: How to fuzz devices that use timers?
To: Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <93600c7c-ccd5-01b9-36d1-5631bfb63b7e@amsat.org>
 <A624C443-3525-43A6-A221-BD29BE67B891@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc0eed62-566a-3195-1f55-12f15a8ea04c@redhat.com>
Date: Thu, 28 May 2020 12:43:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <A624C443-3525-43A6-A221-BD29BE67B891@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/20 11:52, Christophe de Dinechin wrote:
> 
> Since we run the fuzzer with the QTest accelerator, my first idea was to
> check for 'if (qtest_enabled())' in the timer code, and directly expire
> a timer instead of scheduling it. This way we can test reproducers.
> However various tests require/verify precise timing, so this would break
> various qtests.

There is a clock_step command that advance the QEMU_CLOCK_VIRTUAL clock
to the next deadline.  You just have to insert it into the fuzzing input.

Paolo


