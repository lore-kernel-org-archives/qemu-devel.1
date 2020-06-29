Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02429C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AD923D98
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="QLfkSzre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AD923D98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuPt-0003qS-0k
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jpuOm-0003AM-FH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:04:41 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51314 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jpuOj-0003uZ-OF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:04:39 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D61664C879;
 Mon, 29 Jun 2020 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593439474;
 x=1595253875; bh=3oJeGwcMwoxTKPA5AIgxamTnj3oY0QRZ6YmWXiFqbEE=; b=
 QLfkSzreQzWuXDFFWUP1ByuSGObSGPo8f6+SfNUzDU99h3RRbNz6PWyRGOaQ7bQ/
 NnO1dz6FhZLdI1sJyBlbm8tng3akNRql+Vd4xBr51z/MKAOm8ZTIRjzGE5BT93rt
 s91OPqE+ZfPO19FNXJQa27EfV6qtaRlyUnsdueaJtJo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8gRYzbbU9l7; Mon, 29 Jun 2020 17:04:34 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 71DFE4C84A;
 Mon, 29 Jun 2020 17:04:34 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 29
 Jun 2020 17:04:34 +0300
Date: Mon, 29 Jun 2020 17:04:33 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
Message-ID: <20200629140433.GO25104@SPB-NB-133.local>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
 <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
 <20200629113107.GL25104@SPB-NB-133.local>
 <d1d7cf19-d56c-c095-a3b8-45e2be0752ea@redhat.com>
 <20200629132911.GN25104@SPB-NB-133.local>
 <0c8d14fa-e2cf-00e7-135f-d88fda38f31d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c8d14fa-e2cf-00e7-135f-d88fda38f31d@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 07:31:11
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
Cc: Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 03:35:16PM +0200, Paolo Bonzini wrote:
> On 29/06/20 15:29, Roman Bolshakov wrote:
> >>> macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special
> >>> declaration for hv_vcpu_run_until(), that's not available 10.15 -
> >>> HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of
> >>> VMX-preeemption counter). Perhaps the performance issue is addressed
> >>> there.
> >> Possibly.  I'm worried that the preemption-timer trick will fail to run
> >> there, but we'll see.
> >>
> > Well, I've got new VM-exits (caused by zero preemption timer) on either
> > of my laptops.
> 
> If you have already tried 11.0 that's great.  I was worried that it
> would forcibly clear the preemption timer bit when passed
> HV_DEADLINE_FOREVER.
> 

I did not but I can check how it works on it then, note that I'm not
using hv_vcpu_run_until() because it doesn't have HV_DEADLINE_FOREVER
and it performs poorly on macOS 10.15. My approach is based
hv_vcpu_run() and should hopefully work almost anywhere where
Hypervisor.framework is available because Hypervisor framework exposes
timer value
(https://developer.apple.com/documentation/hypervisor/vmcs_guest_vmx_timer_value)
since macOS 10.10.3+.

I can also test how hv_vcpu_run_until() performs with HV_DEADLINE_FOREVER
on the Beta. And if the performance issues with VMX-preemption timer and
hv_vcpu_run_until() are fixed there.

-Roman

