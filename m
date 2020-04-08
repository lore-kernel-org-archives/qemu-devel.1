Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A3C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C68A20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="IAEXonTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C68A20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMBCj-0000E0-IT
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jMBCB-0008Eh-1w
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 09:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jMBCA-0001dD-29
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 09:56:46 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:34796 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jMBC9-0001aA-RL
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 09:56:46 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 049EB412E3;
 Wed,  8 Apr 2020 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1586354199;
 x=1588168600; bh=Tw2LpjvR5OuzVCFXuR1FIYGtXOSpPdgpLso6uLGxgWU=; b=
 IAEXonTpPolw3lFXc1ATv6ZAvLPAedm3GY8D3BLwCB6gGV8IFRcq+1HMgeMsIEY0
 BP177dcznM6qpdzNE4H7SYqYpPk7oyoV3MqKtUBOzLYFpvNEjQnsu81XRHR2ChpN
 WWBOd4souvvaaLI0xZJ3c+ltveH4/UZXbXftxjsNRX8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gGDXiregbh8X; Wed,  8 Apr 2020 16:56:39 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id BAEAA412CA;
 Wed,  8 Apr 2020 16:56:39 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 8 Apr
 2020 16:56:40 +0300
Date: Wed, 8 Apr 2020 16:56:39 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v1 3/3] hvf: Support AVX512 guests on capable hardware
Message-ID: <20200408135639.GA17172@SPB-NB-133.local>
References: <cover.1585607927.git.dirty@apple.com>
 <1da0fc0a4f119e951ae11b29ff26ee587f4748aa.1585607927.git.dirty@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1da0fc0a4f119e951ae11b29ff26ee587f4748aa.1585607927.git.dirty@apple.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 05:16:06PM -0700, Cameron Esfahani wrote:
> macOS lazily enables AVX512.  Explicitly enable it if the processor
> supports it.
> 
> cpu_x86_cpuid() tries to handle OSXSAVE but refers to env->cr[4] for the
> guest copy of CR4.  HVF doesn't support caching CPUID values like KVM,
> so we need to track it ourselves.
> 

Hi Cameron,

Side question, how did you test it? I tried the latest ubuntu and
archlinux iso with -cpu host and noticed that kernel complains about TSC
misbehaviour early during boot.

Also, I didn't look thoroughly into it but do you happen to know if
there could be a case that we're getting AVX512 support without AVX2
support? Wouldn't that be an issue?

Thanks,
Roman

