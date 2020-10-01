Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3CBC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BD3206FC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 22:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGvFtc1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BD3206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO6eA-0007O8-Jt
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 18:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO6bu-0006hZ-Ae
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 17:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO6bq-00041G-Ea
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 17:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601589568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4uP3DJlDSs57FZmTVaCSiAgusoYFv+YV3PJ1v0rB5w=;
 b=OGvFtc1Rynqp4D+xD0JF7rsklJ13glge/SIPL24xWP/2Es/RWSmuOcs43KkGn9fCZQ8vuf
 TCUahHNKjgOfzmWgSR/zvI9UPyyjB6lcy3733ugiPMTGFbXkVrBsuNxuiJu2NhtC6Y7aj+
 iJRWbv1zwJevsTxgV1sp8Emu4BspKPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-BgUVBl2fMN208bEn3h-uIQ-1; Thu, 01 Oct 2020 17:59:25 -0400
X-MC-Unique: BgUVBl2fMN208bEn3h-uIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D497E85C732;
 Thu,  1 Oct 2020 21:59:23 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA3E10013C4;
 Thu,  1 Oct 2020 21:59:22 +0000 (UTC)
Subject: Re: [PATCH 1/9] scripts/performance: Refactor topN_perf.py
From: John Snow <jsnow@redhat.com>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, philmd@redhat.com, alex.bennee@linaro.org,
 eblake@redhat.com, ldoktor@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 crosa@redhat.com
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
 <ec6e7528-0281-9bdc-5afc-4b9c8a541f13@redhat.com>
Message-ID: <85440dcc-07cf-b699-98b1-09e1f9b291d5@redhat.com>
Date: Thu, 1 Oct 2020 17:59:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ec6e7528-0281-9bdc-5afc-4b9c8a541f13@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 4:41 PM, John Snow wrote:
> I realize this review comes well after you are no longer being paid to 
> work on this, so I am offering my time to help polish your patches if 
> you would like.

Actually, I see now that you are adding your name to the MAINTAINERS 
file here, so I suspect you probably rather want to be more involved 
than not.

I cleaned up patch 1/9 provisionally with my own style preferences, but 
it's all just style stuff, and it's mostly things I wouldn't actually 
require you to do (...I went way overboard.)

https://gitlab.com/jsnow/qemu/-/commit/c66a4a6ca8ccc3d406b92796935f92057bf1e48d


What I'd recommend for your cleanup is actually *much* simpler;

Use pylint 2.6.0 and flake8 3.8.3:

 > pip3 install --user pylint==2.6.0 flake8==3.8.3

flake8's default settings should be pretty good, but pylint has a lot of 
warnings you can ignore.

In particular, it's OK to use script-style python (Scripts with a 
#!/usr/bin/env python3, and where you do not use python functions to 
avoid side-effects that occur on 'import'.) In this case, IGNORE any of 
pylint's warnings telling you that you have too many lines, that you 
need to UPPERCASE variable names, etc. It just hurts readability here.

So I'd actually ask that you revise these patches to remove all of the 
UPPERCASE variable names, and then check your code with these:

flake8 topN_perf.py
pylint --disable=invalid-name topN_perf.py

Use your best judgment -- If something seems like it looks worse, it 
probably is. If in doubt, please reach out and ask.

--js


