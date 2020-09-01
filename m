Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD87CC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9770F204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0d22XGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9770F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8n7-0003ME-PB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD8mR-0002lF-Ll
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:05:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD8mP-0004Ut-9W
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598976304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=387My/1j+cOpwPl3vTQQVGHNRtZRADI5t5vrkXvtZsg=;
 b=H0d22XGPNqfN2C5KFkncAlApIOgd0LrC3sLhYPjhzvYlcPNRq2NCSKD3QayO0nL6qRaHtC
 c24BCKFD8nv4EG0PGiW/im4lggXTlU4YDKT0Xnl1LtjdGbtLlKKIzLJ+ucZOm3qwIbUcvH
 lQ6xGminSd02RSfL6z0tslxt4nT+F0c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-RlkqRRvsNQWogH8Uo9C3bQ-1; Tue, 01 Sep 2020 12:05:02 -0400
X-MC-Unique: RlkqRRvsNQWogH8Uo9C3bQ-1
Received: by mail-wr1-f72.google.com with SMTP id c17so758855wrt.12
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=387My/1j+cOpwPl3vTQQVGHNRtZRADI5t5vrkXvtZsg=;
 b=SpHN1mJnwY9cVivKgwoX04V6hqOUKkqYZOEC1GyCgR95vYxGQmBHhOr3M5CMDL9fHU
 cjt5f8JKozE1Z81aee8uP1kL0UZMvRHo/rXxKw5n9vGtmZ1hrC+6Tu5vcuxZ2iyB+n5e
 XHNTWYPa1kT0ozU2CX0g8d2/O0rEZoWOYxTMeIYVE4W7eyxsssE3reUC0X4O3b07bcU6
 ULwkUsVTd5l+2WvE2LsfPnLHdEEMLqn2g6UYF9H9vfTjCie0NIlIjXeMTSQM0rMViibE
 wJ5k40NxZZiVUNfSn7koq2j8XlmWUJY4xPPB8B0Qk9T3THDuFdsbuPbZro/Hfu9qRxCG
 logg==
X-Gm-Message-State: AOAM532PuFYDu8UVgwNIUY12O/sMIyLTZbco3YhUZ2rJFXA/Qtrq1Ght
 jH5uJt6eyAp35gIaFTDe/llGmXMJXMpL3cveb1EyLJQdDGJFy2z4IIzceHVDa0MXiFU5puLZyI3
 iNwzmjaZI5WKuO2U=
X-Received: by 2002:adf:81c6:: with SMTP id 64mr2566230wra.176.1598976301022; 
 Tue, 01 Sep 2020 09:05:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVxBAAuFmN6mSw7dicJQ7W3ubGTVkK8uk0kEp0Ziax/hqW4omH0vEeNGwzA2lQdYw40NrgRg==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr2566204wra.176.1598976300784; 
 Tue, 01 Sep 2020 09:05:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7fbd:8007:1fa7:ed17?
 ([2001:b07:6468:f312:7fbd:8007:1fa7:ed17])
 by smtp.gmail.com with ESMTPSA id v2sm2835575wrn.44.2020.09.01.09.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 09:05:00 -0700 (PDT)
Subject: Re: [PATCH 1/2] Makefile: Add back TAGS/ctags/cscope rules
To: Connor Kuehl <ckuehl@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
References: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
 <159897001005.442705.16516671603870288336.stgit@bahia.lan>
 <f31b9650-9db4-e038-9e4d-bd5faf1f5b96@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a3c31f0-b9e7-5ae8-2c58-0e8cee06d469@redhat.com>
Date: Tue, 1 Sep 2020 18:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f31b9650-9db4-e038-9e4d-bd5faf1f5b96@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/20 16:59, Connor Kuehl wrote:
> On 9/1/20 9:20 AM, Greg Kurz wrote:
>> It is a bit of a pain to be forced to run configure before being able
>> to use cscope and friends. Add back the rules to build them in-tree
>> as before commit a56650518f5b.
>>
>> Fixes: a56650518f5b ("configure: integrate Meson in the build system")
>> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> This might be a user error on my part, but the way I read this it sounds
> like I could do this:
> 
>     $ rm -rf build
>     $ make cscope
> 
> and have it emit a cscope file,  but when I do so it complains about the
> build dir not existing. As I understand it, running ./configure (or
> meson build) is what generates that build dir. Here's the error for
> posterity:
> 
> changing dir to build for make "cscope"...
> make[1]: *** build: No such file or directory.  Stop.
> make: *** [GNUmakefile:11: cscope] Error 2

You have a stray GNUmakefile in your source directory.  It's not
introduced by Greg's patch.

I suggest that you remove the GNUmakefile and just use out-of-tree builds.

> [...]
> Since this recipe doesn't output an artifact called "cscope" I wonder if
> this should be:
> 
> .PHONY: cscope
> cscope:
>     ...
> 
> or alternatively:
> 
> cscope.out:
>     ...

Yes it should be phony.  I have adjusted the patch and queued it.

Paolo


