Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96831C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619BA20792
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hz+lyDeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619BA20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyajL-0006jQ-Qr
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyai8-0005Qc-KF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:52:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jyai6-0007Sa-PI
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtNS0ll3AdNgX5NyteqXdnAXVncPiIlhIvU3g97QHWM=;
 b=hz+lyDeWv/fHhzzx4WBRtDxN5yJroEbNj5Bsw6h4/aHlaFvVQ0WrE1yvzFqgAULZBNg1Vu
 gfgzdPQ0DOtF+JOp7l5vpLnj72JY0FypQRWAJJtHyIDaEr1H/5ztvy5kKu3qNeIjsJFEB5
 +MlvkOnr2BnbPE/77GM2iEBh34WK0I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-_exN7OoVO022NvSPWITPrA-1; Thu, 23 Jul 2020 08:52:28 -0400
X-MC-Unique: _exN7OoVO022NvSPWITPrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EAAA1009455;
 Thu, 23 Jul 2020 12:52:27 +0000 (UTC)
Received: from work-vm (ovpn-114-148.ams2.redhat.com [10.36.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D17285BAD5;
 Thu, 23 Jul 2020 12:52:25 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:52:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: 5.1.0-rc1 regression: reset fails with kvm and -cpu host
Message-ID: <20200723125223.GI2621@work-vm>
References: <bf007af9-f81e-3542-0237-5ea467f34377@siemens.com>
 <20200722173513.GO1274972@habkost.net>
 <7be95bd6-dfc6-2c22-85a1-a1c932d07fdd@siemens.com>
 <20200722204731.GP1274972@habkost.net>
 <20200722212159.GQ1274972@habkost.net>
 <20200723084026.GB2622@work-vm>
 <3eba2f87-5527-bd7c-2eb7-ce67cb32d9ef@redhat.com>
 <87pn8mo20i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87pn8mo20i.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
> > +Vitaly
> >
> > On 7/23/20 10:40 AM, Dr. David Alan Gilbert wrote:
> >> * Eduardo Habkost (ehabkost@redhat.com) wrote:
> >>> On Wed, Jul 22, 2020 at 04:47:32PM -0400, Eduardo Habkost wrote:
> >>>> On Wed, Jul 22, 2020 at 08:05:01PM +0200, Jan Kiszka wrote:
> >>>>> On 22.07.20 19:35, Eduardo Habkost wrote:
> >>>>>> Hi Jan,
> >>>>>>
> >>>>>> What was the last version where it worked for you?  Does using
> >>>>>> "-cpu host,-vmx" help?
> >>>>>
> >>>>> Yeah, -vmx does indeed help.
> >>>>>
> >>>>> I didn't have the time to bisect yet. Just check my reflog, picked
> >>>>> eb6490f544, and that works.
> >>>>
> >>>> Thanks!
> >>>>
> >>>> I could reproduce it locally[1], I will bisect it.
> >>>>
> >>>> The good news is that "-cpu host,+vmx" still works, on commit
> >>>> eb6490f544.
> >>>>
> >>>> [1] Linux 5.6.19-300.fc32.x86_64, Intel Core i7-8665U CPU.
> >>>
> >>> Bisected to:
> >>>
> >>> commit b16c0e20c74218f2d69710cedad11da7dd4d2190
> >>> Author: Paolo Bonzini <pbonzini@redhat.com>
> >>> Date:   Wed May 20 10:49:22 2020 -0400
> >>>
> >>>     KVM: add support for AMD nested live migration
> >>>
> >>>     Support for nested guest live migration is part of Linux 5.8, add the
> >>>     corresponding code to QEMU.  The migration format consists of a few
> >>>     flags, is an opaque 4k blob.
> >>>
> >>>     The blob is in VMCB format (the control area represents the L1 VMCB
> >>>     control fields, the save area represents the pre-vmentry state; KVM does
> >>>     not use the host save area since the AMD manual allows that) but QEMU
> >>>     does not really care about that.  However, the flags need to be
> >>>     copied to hflags/hflags2 and back.
> >>>
> >>>     In addition, support for retrieving and setting the AMD nested virtualization
> >>>     states allows the L1 guest to be reset while running a nested guest, but
> >>>     a small bug in CPU reset needs to be fixed for that to work.
> >>>
> >>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> 
> >> Guesswork led me to try reverting the chunk in kvm_put_nested_state;
> >> without it the reset seems to work; I can't explain that code though.
> >> 
> 
> (sorry, missed the beginning of the discussion)
> 
> So one does:
> 
> (qemu) system_reset 
> 
> on Intel wiht '-cpu host' and the result is:
> 
> (qemu) KVM: entry failed, hardware error 0x80000021

Interesting; I hadn't seen that error - I just see a hard hung guest
rather than a reset one.

(i7-8650U laptop 5.7.9 fedora 32)

Dave

> If you're running a guest on an Intel machine without unrestricted mode
> support, the failure can be most likely due to the guest entering an invalid
> state for Intel VT. For example, the guest maybe running in big real mode
> which is not supported on less recent Intel processors.
> 
> EAX=00000064 EBX=91df5efe ECX=00000000 EDX=000003f8
> ESI=00000000 EDI=91ee32c0 EBP=90643260 ESP=00013c68
> EIP=906428e6 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
> ES =0000 00000000 0000ffff 00009300
> CS =f000 ffff0000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00
> GDT=     00000000 0000ffff
> IDT=     00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? <??> ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??
> 
> I can take a look (if no one beats me to it).
> 
> -- 
> Vitaly
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


