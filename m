Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 07:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D63222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 07:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOZL6Ndm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D63222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWxML-0007pC-Tp
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 03:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWxKu-0007Ig-3A
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 03:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWxKs-00009g-JM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 03:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603698873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDX4e3avvWqqRbiRrwD+O7eqaxfoKVKc0XJGSQvoYC4=;
 b=ZOZL6NdmyMk8st29wTr71LA4kVzhaNNM5hluqT+XpUbgjbfu9jtZcVx42pCH4Nw1PGcq8m
 NaSXcoLsw2FBIM+kEpoeeKH3/fcuKYqi88xTOjZXVXE47GMMTalTlNcyadrZ4B5HOKdzOx
 1BJO64udjK/DsQxnrGsbav6tYz4897A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-VFllqj6GNwSMrjMPId-Kyw-1; Mon, 26 Oct 2020 03:54:31 -0400
X-MC-Unique: VFllqj6GNwSMrjMPId-Kyw-1
Received: by mail-ed1-f72.google.com with SMTP id dc23so3818442edb.13
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 00:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VDX4e3avvWqqRbiRrwD+O7eqaxfoKVKc0XJGSQvoYC4=;
 b=NGA7Yk8i1kw+/rRpixFKnrweznZrgMCjjClkQDzDMYgH79hUxRe7In613pTTnN1yyX
 SHJ9pT1IblJLJ0fTF3uEpBNPuW8CrKNeoAvR1mcLTNuUWPP+lrNlby+/Fecu/yWLPjJ4
 1cRSha+uNhI4ZBqbmo9f9wPomPyQdMOG0+PYyh10MQNJa0bVBKzSsVp0LSI54yCl3M4A
 0oE29jmPrtMN4nDhCTcUlNG1BWJNAYPeDqCmTdkF4Y6v8dd6yMXtof4zK9F42009UMAl
 sbt/mbqLk3oKLEKUScm3G8+SuGm0pUqXqVEXMeAnb8n8xyRO537AF0yLit3cCMUO2/fC
 IVPQ==
X-Gm-Message-State: AOAM5313AbJNKZP34inAMi7AppFOINMYkXPSjI89zVVguUbE+SMQbShu
 rtfovTFuyU7c6pil7aYLl2mNYG7mQMzP7uhuVcjwXYr6MSwnvyYeNQ3EI8PBu8fOxfFN3MF5uJm
 pJZP+Js+JXYk/qqU=
X-Received: by 2002:aa7:de97:: with SMTP id j23mr14722947edv.45.1603698870014; 
 Mon, 26 Oct 2020 00:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw37P2ZeGGyP73IkqqV+IiLOWNQgUrD38XGK9EwGAY/e9QZKLz0DycNMwJwqbWC+yuaKp5bLg==
X-Received: by 2002:aa7:de97:: with SMTP id j23mr14722932edv.45.1603698869826; 
 Mon, 26 Oct 2020 00:54:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id sd18sm5363310ejb.24.2020.10.26.00.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 00:54:29 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
To: Joelle van Dyne <j@getutm.app>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
 <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
 <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
 <0a7b6404-55db-ec3f-2b56-1d695f840475@redhat.com>
 <CA+E+eSBgVCsfOC0Huo3wJuyBOyCvU+97usH_YFdUAEQsbe-S3Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77ef9338-de8c-82a8-7ca0-f8d708f8d1da@redhat.com>
Date: Mon, 26 Oct 2020 08:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CA+E+eSBgVCsfOC0Huo3wJuyBOyCvU+97usH_YFdUAEQsbe-S3Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/10/20 20:24, Joelle van Dyne wrote:
> As the patch stands --cross-prefix="" works but I like having the
> --enable-cross-compile option because it's more clear of the intention
> (in logs and such). I've been struggling to come up with a concise
> modification to the help text for --cross-prefix that explains that
> empty PREFIX is allowed and why you would want to do that.

--cross-prefix=PREFIX enable cross compilation, using PREFIX
                      in front of compile tools

Paolo


