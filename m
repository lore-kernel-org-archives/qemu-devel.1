Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F182080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="rcF6/WZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F182080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joo7s-0001ZQ-B8
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joo7H-00016N-BX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:10:03 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35740 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joo7F-0005ut-De
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:10:02 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 4CF664C8C2;
 Fri, 26 Jun 2020 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593176998;
 x=1594991399; bh=u8aRrP2XPNlv8LX8hGx+P5qfAKuvZqOEOTkvlDu9mDc=; b=
 rcF6/WZymUGyeDgVD0VOtyQEsJtQCcslX4ydqmyCJRBrU09IbM25IqgNkzncyOHA
 n7RlsQ62YV4Z8HWnwkM4hzbqyneOCJP9fIi31aQfnXGHklJDuOasKN1SyDFjp1qc
 q7ocrUHsV9i/ys6VeHkd8VTJpjcU1jR2zU0K3iVAVyA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VW3rkmj3Ih2o; Fri, 26 Jun 2020 16:09:58 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 223014C8A7;
 Fri, 26 Jun 2020 16:09:57 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 26
 Jun 2020 16:09:57 +0300
Date: Fri, 26 Jun 2020 16:09:57 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [PATCH] timer: Handle decrements of PIT counter
Message-ID: <20200626130957.GJ25104@SPB-NB-133.local>
References: <20200613111911.65497-1-r.bolshakov@yadro.com>
 <20200624030024.GA885327@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200624030024.GA885327@morn.lan>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 09:09:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: seabios@seabios.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 11:00:24PM -0400, Kevin O'Connor wrote:
> On Sat, Jun 13, 2020 at 02:19:12PM +0300, Roman Bolshakov wrote:
> > There's a fallback to PIT if TSC is not present but it doesn't work
> > properly. It prevents boot from floppy on isapc and 486 cpu [1][2].
> > 
> > SeaBIOS configures PIT in Mode 2. PIT counter is decremented in the mode
> > but timer_adjust_bits() thinks that the counter overflows and increases
> > 32-bit tick counter on each detected "overflow". Invalid overflow
> > detection results in 55ms time advance (1 / 18.2Hz) on each read from
> > PIT counter. So all timers expire much faster and 5-second floppy
> > timeout expires in 83 real microseconds (or just a bit longer).
> > 
> > Provide counter direction to timer_adjust_bits() and normalize the
> > counter to advance ticks in monotonically increasing TimerLast.
> 
> Good catch.  Could we fix it using the patch below instead though?
> 
> -Kevin
> 
> 
> --- a/src/hw/timer.c
> +++ b/src/hw/timer.c
> @@ -180,7 +180,7 @@ timer_read(void)
>      // Read from PIT.
>      outb(PM_SEL_READBACK | PM_READ_VALUE | PM_READ_COUNTER0, PORT_PIT_MODE);
>      u16 v = inb(PORT_PIT_COUNTER0) | (inb(PORT_PIT_COUNTER0) << 8);
> -    return timer_adjust_bits(v, 0xffff);
> +    return timer_adjust_bits(-v, 0xffff);
>  }
>  
>  // Return the TSC value that is 'msecs' time in the future.

Hi Kevin,

I like the approach much more. Initial count value is 0, PIT rearms the
timer when 1 is hit, unary negation on unsigned u16 fits perfectly, then
timer_adjust_bits recieves 0, 1, 2, ... and timer is rearmed at 0xffff.

Do you want me to send v2 or you plan to apply the fix on your own?

If you plan to apply it on your own, here are the tags:

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman

