Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0089BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE22D204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="NtmWNfyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE22D204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7eJs-0000vw-SV
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7eJ4-0000GE-Ip
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:32:06 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:43696 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7eJ2-00079K-Gd
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:32:06 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 92550529B9;
 Mon, 17 Aug 2020 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1597667521;
 x=1599481922; bh=MIG94yM11ZfwVTN947p5SxY/DaTgujT4Ig+XeZ94pzQ=; b=
 NtmWNfyLkDJ2DfTJZYDxhVszuKbYY6pRTovfeNqgPotS63AkKvvqgcmWISwWiRNv
 npfRKlfB6hMHu0tgRGerfDKDvbNRQGIj7fU0H62PJ3/1hUK0YCKmHBDdRbgupE/Z
 F7tuQVL5HnIcnAx7LkcRSNBGxKVIkyvhVjgeIJxCnWI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V8Amar9uWlVk; Mon, 17 Aug 2020 15:32:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 5222152962;
 Mon, 17 Aug 2020 15:32:00 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 17
 Aug 2020 15:32:00 +0300
Date: Mon, 17 Aug 2020 15:31:59 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 10/14] cpus: add handle_interrupt to the CpusAccel
 interface
Message-ID: <20200817123159.GE98227@SPB-NB-133.local>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-11-cfontana@suse.de>
 <ee2b8640-2446-32f8-47c3-b327db42f7b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ee2b8640-2446-32f8-47c3-b327db42f7b7@linaro.org>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 07:02:56
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 02:01:01PM -0700, Richard Henderson wrote:
> On 8/12/20 11:32 AM, Claudio Fontana wrote:
> > +static void generic_handle_interrupt(CPUState *cpu, int mask)
> > +{
> > +    cpu->interrupt_request |= mask;
> > +
> > +    if (!qemu_cpu_is_self(cpu)) {
> > +        qemu_cpu_kick(cpu);
> > +    }
> > +}
> > +
> > +void cpu_interrupt(CPUState *cpu, int mask)
> > +{
> > +    if (cpus_accel && cpus_accel->handle_interrupt) {
> > +        cpus_accel->handle_interrupt(cpu, mask);
> > +    } else {
> > +        generic_handle_interrupt(cpu, mask);
> > +    }
> > +}
> 
> First, by this point you have converted all of the accelerators, so I would
> expect cpus_accel to always be non-null.  I would expect a patch immediately
> preceding this one to place an assert to that effect somewhere in the startup
> code, and to remove all of the checks.
> 
> Second, I would prefer that all methods be non-null, so that you don't need to
> check that either.  This patch would add generic_handle_interrupt (perhaps
> named cpus_accel_default_handle_interrupt declared in sysemu/cpus.h?) to the
> CpusAccel structure of all except TCG.
> 
> Similarly for all other methods that are checking non-null-ness of the method
> pointer.  Perhaps assert non-null for each method in cpus_register_accel().
> 
> 

I concur with that. It's similar to my comment to the previous revision
of the series.

Regards,
Roman

