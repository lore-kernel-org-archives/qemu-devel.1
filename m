Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C81CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 796792084D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="p7pCNMXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796792084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhG4-0000xR-MX
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cminyard@mvista.com>) id 1iRhDc-0000As-Up
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1iRhDS-0006XM-KP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:36:42 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1iRhDS-0006Wn-Bt
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:36:38 -0500
Received: by mail-ot1-x344.google.com with SMTP id u13so15322265ote.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=kXaq62zBFwFX+1cEsnENAK+4dHYXt6MbiwIJLVPMG7Y=;
 b=p7pCNMXu0aEefI8pGEeK/02MEeI1aqIEzOY/LfNE4aTlMA/p4rScXA3JF9XBBfzwMS
 JOjFhEJvyB8/eZqlYDfVS7kmHJtpTfCTNhuJg6rBnYfwEKK2Dzkoye/T5zsPizhzojh+
 O2LF6l6wjJkSyL+8KqYJq8mGk2ghH4qbisYWFbxA0inEr0givGODbp7+BLPtl2DMDVeU
 O8jal88y4duJ5wnqB594h0ynXIFW9SEzuHZ3ZvLUxQ6ctKpKOCf8j4mBBErBCT7dtO6D
 u/y1nH/Mzj4X+f5qq+qco1RRHThrwBTakidwFlHNf402EOvLkUOMW5CRRDG/BNs6xDpM
 hO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=kXaq62zBFwFX+1cEsnENAK+4dHYXt6MbiwIJLVPMG7Y=;
 b=AjE+ls1o7lOwkOzXWbSpZCAlQlfv4e9LLkmLWbIIFNjcOqAWrzI81Hgtkc7JYFYYDt
 072TkI6jJQxKilssgQqKTpEeb12xwCAgOymYRACvmPDVDx1liV2uAyR0r1epLDREWVT0
 69XJhNzbUBEnll6bWTiuxHx9RtDcCarsZptzwGlUGjhQogfmid4yy7mJYKgMC2qHd8X9
 7NPEPIEinMoSZ3mnY36oA/TP8X8XHUrs/kuT8cOwkU8z56s7IQTu/b6NKa3Dvl2ie+41
 6eRDAEkGnH1dekwy+plaGO4Gj/1xx5vhsfqplnh8r+YQS2Z5J/X64B6Ft49o88LlhvqI
 yY6Q==
X-Gm-Message-State: APjAAAU3es7wXB0iUQGp688Aeknm8nQ+O5HNZi+6rzGfz5eTJDqIdDmV
 c3+Jt7pTYSt9BBuF2MYINiJ+DA==
X-Google-Smtp-Source: APXvYqwWbwmy8t8/Fof0csiXb3O7IxHz35yWQ8ilad32cCQt1A1et/RNfYbQPmxFud0G9qJzwjtXwQ==
X-Received: by 2002:a05:6830:20c8:: with SMTP id
 z8mr7253420otq.114.1572892595061; 
 Mon, 04 Nov 2019 10:36:35 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id 22sm4716741oip.53.2019.11.04.10.36.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Nov 2019 10:36:34 -0800 (PST)
Date: Mon, 4 Nov 2019 12:36:32 -0600
From: Corey Minyard <cminyard@mvista.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 5/6] tests: only run ipmi-bt-test if CONFIG_LINUX
Message-ID: <20191104183632.GO3093@minyard.net>
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104173654.30125-6-alex.bennee@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Reply-To: cminyard@mvista.com
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 04, 2019 at 05:36:53PM +0000, Alex Bennée wrote:
> This test has been unstable on NetBSD for awhile. It seems the
> mechanism used to listen to a random port is a Linux-ism (although a
> received wisdom Linux-ism rather than a well documented one). As

Hmm.  I got reports of this issue and tried to reproduce, but I was
never able to.  I thought I had fixed it via other means, but I had no
idea this was the cause of the issue.

It's not a Linux-ism, I don't think, Richard Steven's "Unix Network
Programming" mentions that is how this works (at least on UDP), and that
is pre-Linux.  That's probably where I got this technique.  I've saw
some web pages mention that Solaris and Windows do it this way.

However, it's not specified, so it's probably a bad idea.  The only way
I can think to do it another way is to remove the bind() call, then it
should randomly assign the port (per the spec, I think).  The trouble
with that is the address will be INADDR_ANY, so it will be bound on
other interfaces besides the loopback, which make me slightly worried
from a security point of view.

I'm ok with this being linux-only, but I'd like to fix it so it works
everywhere.

-corey

> working around would add more hard to test complexity to the test I've
> gone for the easier option of making it CONFIG_LINUX only.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Corey Minyard <cminyard@mvista.com>
> Cc: Kamil Rytarowski <kamil@netbsd.org>
> ---
>  tests/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 534ee487436..8566f5f119d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -177,7 +177,9 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
>  check-qtest-i386-y += tests/rtc-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
> +ifdef CONFIG_LINUX
>  check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
> +endif
>  check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
>  check-qtest-i386-y += tests/device-plug-test$(EXESUF)
> -- 
> 2.20.1
> 

