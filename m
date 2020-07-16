Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A545C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F58207CB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="l+7zv0rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F58207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw96B-0007Rn-DX
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jw949-0005z9-NN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:57:09 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:40720 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jw947-0002tC-PL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 14:57:09 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 31EA34C902;
 Thu, 16 Jul 2020 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1594925823;
 x=1596740224; bh=S9QKpLPtCTpBsSeU5kES0RWy8qWiNfrxlwCKnuVWisI=; b=
 l+7zv0rlTqYWhOg5e1mYrtUKNhbUBa2K+roWGfEXaU4t9EkD5a9aHNA8D6UgXRtB
 fkB/FmLsxQumPSf1L5F+dqShwsU0/31umelvmKiit0ZMCxizdYGjMfgUYNI0gAP8
 Vkd3PnePdLY5YPfoWl4NWj0ZcYB1u8P4eIAVee7dHkE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZ6sSSMYiZbc; Thu, 16 Jul 2020 21:57:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 13D074C8C0;
 Thu, 16 Jul 2020 21:57:02 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 16
 Jul 2020 21:57:01 +0300
Date: Thu, 16 Jul 2020 21:57:01 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH for-5.1] i386: hvf: Explicitly set CR4 guest/host mask
Message-ID: <20200716185701.GF90799@SPB-NB-133.local>
References: <20200714090726.41082-1-r.bolshakov@yadro.com>
 <20200714103932.GB90799@SPB-NB-133.local>
 <CABgObfYgRVpy6WvjzFG0Zb+2bjQp6HYOuZePbtkbxWjLkxBYjw@mail.gmail.com>
 <20200716181457.GM1274972@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200716181457.GM1274972@habkost.net>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 14:57:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: programmingkidx@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 02:14:57PM -0400, Eduardo Habkost wrote:
> On Tue, Jul 14, 2020 at 08:20:04PM +0200, Paolo Bonzini wrote:
> > Hi Roman, please ask Peter to apply it directly because I won't be able to
> > send a pull request in the next couple of weeks.
> > 
> > Paolo
> > 
> > Il mar 14 lug 2020, 12:39 Roman Bolshakov <r.bolshakov@yadro.com> ha
> > scritto:
> > 
> > > On Tue, Jul 14, 2020 at 12:07:27PM +0300, Roman Bolshakov wrote:
> > > > Removal of register reset omitted initialization of CR4 guest/host mask.
> > > > x86_64 guests aren't booting without it.
> > > >
> > > > Fixes: 5009ef22c6bb2 ("i386: hvf: Don't duplicate register reset")
> > > > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > > >
> > >
> > > If one has a chance to test or review it, it'd be very helpful. That'd
> > > allow to include it in RC0.
> > >
> 
> I'll queue it for my -rc1 pull request.
> 

Thanks!

-Roman

