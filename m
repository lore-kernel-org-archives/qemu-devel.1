Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63C2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2259214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQjxMyKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2259214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifCQf-00057Y-QC
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 19:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifCOB-0002nG-W9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifCO4-000849-HH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:31:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifCO3-000823-AB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576110682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJGOP2uBpm5En8S36aOhtvQxYnoYYWbOTtm9lAZdCHs=;
 b=QQjxMyKkqLe+0TPITzH+FcBBaIl8Y8ueWC+TQF5bARO+Od32T2uO/9h9nta4pdBtURS3eA
 1kXcuHrEggoGpQfLbzPT1pOMoOYHmQ1fp7HDmjzuiq6u+P6u2a7flh1HbHQGeCHqQDOLtX
 P9MtSmPwbvMJj/qEMJtTfpPdBJ5tfKE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-TykT7G5XMxiSs8NWJWXUWQ-1; Wed, 11 Dec 2019 19:31:07 -0500
Received: by mail-wr1-f72.google.com with SMTP id 90so311766wrq.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 16:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UJGOP2uBpm5En8S36aOhtvQxYnoYYWbOTtm9lAZdCHs=;
 b=VOLpbk650fuWCzCLnNmD5TUxnQwNnIs8TkL9kun9k/vhjBUFiD7NFMxbnkWd2YXmOK
 ZwgbT9ESM7m4ncGAgJouhZCH2HrOpL8mo/qvzQQC1B4b3oizNxC7tfJZVqWtL2HvhaI0
 J6zGjU8ZC87zIbeQbjPCtt48YfspXZkpCkMdHUV6DvROwVVJQlglop08ih7/61v4L7I+
 C3V2QANsq6svkvQbtXmso1zjzOoeEJSvzOSoFGgybKd+mdrgIICJYh5+zVBWPtH1jRrn
 Z1JZt/rg4Koo/76QF0MAB+THl3zVy2VXGE61V/IZ15umeTSKxJ3b2E54t0avfwrprKhl
 0NqA==
X-Gm-Message-State: APjAAAUgarlvAZ6ThGTCaDjjcTh2i2SHAsoML6S2yett+DT62A3P+eE4
 IWGu6xPZ8mzARPQdix4+GQ7IvkQcYyfK2/4mpCteixFCqO5svYAPxiOFJJB7rAOwd6cGqsL7km6
 PKuc1re5DQCw84L0=
X-Received: by 2002:adf:fa12:: with SMTP id m18mr2711295wrr.309.1576110666141; 
 Wed, 11 Dec 2019 16:31:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcqfZatkvH4PnwiUjxdpl7g13EVDB2oLVNPnTsYZZ1kdm4muEW6fxgbOom+YOWS/ntbE1v+Q==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr2711276wrr.309.1576110665845; 
 Wed, 11 Dec 2019 16:31:05 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id f1sm4231998wml.11.2019.12.11.16.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:31:05 -0800 (PST)
Subject: Re: [PATCH 1/1] tests/Makefile: Fix check-report.* targets shown in
 check-help
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, 
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20191211204427.4681-1-wainersm@redhat.com>
 <20191211204427.4681-2-wainersm@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <daf920c0-7b3e-5b2e-c865-ccaf39ba1740@redhat.com>
Date: Thu, 12 Dec 2019 01:31:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211204427.4681-2-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: TykT7G5XMxiSs8NWJWXUWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 11/12/19 21:44, Wainer dos Santos Moschetta wrote:
> The check-report.html and check-report.xml targets were replaced
> with check-report.tap in commit 9df43317b82 but the check-help
> text was not updated so it still lists check-report.html.
> 
> Fixes: 9df43317b82
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/Makefile.include | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 8566f5f119..680bd8a669 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -16,12 +16,10 @@ check-help:
>  	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
>  	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
>  	@echo
> -	@echo " $(MAKE) check-report.html    Generates an HTML test report"
> +	@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test report"
>  	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>  	@echo " $(MAKE) check-clean          Clean the tests and related data"
>  	@echo
> -	@echo "Please note that HTML reports do not regenerate if the unit tests"
> -	@echo "have not changed."
>  	@echo
>  	@echo "The variable SPEED can be set to control the gtester speed setting."
>  	@echo "Default options are -k and (for $(MAKE) V=1) --verbose; they can be"
> 

Cc: qemu-trivial@nongnu.org


