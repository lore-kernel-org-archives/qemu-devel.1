Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B14C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C639B2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="mxPrUilh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C639B2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAW1F-0002BI-4i
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAW0d-0001lr-Nm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:16:55 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49588 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAW0b-0004HW-Pp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:16:55 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B355E574F9;
 Tue, 25 Aug 2020 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1598350610;
 x=1600165011; bh=Fxg+up5Z/FRU94GiVytR8HSsi10H+k79nxqhoalmp1I=; b=
 mxPrUilhGPnuVMol1cNKPJcff+dkDAZ3p11Q1HKgIhztChpd91gFosXwFxW+Jvhx
 XmWWbwiKEifyRvP5MXRbD/VtIAYre0tGvq1hU32/wm102KbugMzg0Nn2jGqZzvo5
 hXRnSK3IFgLQThzd6pW5Wh2C/fGsey1l1tJK4V9193s=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjvsvNC7SOj4; Tue, 25 Aug 2020 13:16:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6A15E5282A;
 Tue, 25 Aug 2020 13:16:50 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 25
 Aug 2020 13:16:50 +0300
Date: Tue, 25 Aug 2020 13:16:49 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] configure: Use discovered make for in-source build
Message-ID: <20200825101649.GC38400@SPB-NB-133.local>
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-2-r.bolshakov@yadro.com>
 <0d4354b5-87bc-ee2b-a028-bc9e64baf4f0@redhat.com>
 <20200824220755.GC41106@SPB-NB-133.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200824220755.GC41106@SPB-NB-133.local>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 05:04:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:07:55AM +0300, Roman Bolshakov wrote:
> On Mon, Aug 24, 2020 at 09:37:07AM -0500, Eric Blake wrote:
> > On 8/22/20 4:21 PM, Roman Bolshakov wrote:
> > > @@ -38,6 +38,8 @@ then
> > >   # This file is auto-generated by configure to support in-source tree
> > >   # 'make' command invocation
> > > +include build/config-host.mak
> > 
> > Should this use '-include' (also spelled 'sinclude'), to avoid halting the
> > build if build/config-host.mak doesn't exist for whatever reason?
> > 
> 
> Sure I can do (and thanks for the noticed typos) but I tested that if
> the build is interrupted too early (before Makefile is symlinked to
> build directory but after GNUmakefile is created) it would fail even if
> -include is used:
> 
> $ make
> changing dir to build for /Library/Developer/CommandLineTools/usr/bin/make ""...
> make[1]: Makefile: No such file or directory
> make[1]: *** No rule to make target `Makefile'.  Stop.
> changing dir to build for /Library/Developer/CommandLineTools/usr/bin/make ""...
> make[1]: Makefile: No such file or directory
> make[1]: *** No rule to make target `Makefile'.  Stop.
> make: *** [all] Error 2
> 
> I'm also curious why the switch happens twice... According to the debug
> trace, it tries to remake build/config-host.mak using the implicit force
> rule:
> 
> GNUmakefile:12: update target 'build/config-host.mak' due to: force
> 
> Then there should be an explicit empty rule for build/config-host.mak. I
> will send a fix for that in v2. Then it would fail like this:
> 
> $ make
> changing dir to build for /Library/Developer/CommandLineTools/usr/bin/make ""...
> make[1]: Makefile: No such file or directory
> make[1]: *** No rule to make target `Makefile'.  Stop.
> make: *** [all] Error 2
> 
> > > +
> > >   ifeq ($(MAKECMDGOALS),)
> > >   recurse: all
> > >   endif
> > > 
> > 

Hi Eric,

What if we just print an error if build/config-host.mak can't be found?

ifeq ($(wildcard build/config-host.mak),)
$(error "Incomplete configuration. Please run ./configure")
endif

IMO this is more sane approach than proceeding with partially-configured
not working build without a Makefile in proper place.

Regards,
Roman

