Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F856C433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFE220708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5Mnx/xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFE220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTJa-0007vG-O3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgamal@redhat.com>) id 1jtTIw-0007Ib-N1
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:57:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mgamal@redhat.com>) id 1jtTIu-00045Z-2K
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594288639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/byDZR5miLLIr77Ayjm7tLWzx/DUykji1i3ZcXU7KNw=;
 b=M5Mnx/xl9NmW+iMilx32vKFTNfc49P1sXy49tbfkUmZH60Orq7pdnmM1mt0WUxhH25tsxe
 VMc/0gQuQ+8XM1+6MAOk6S7fnkpRdYiA8NK3uZmX2Y1eNMvZXoNWJcA4DrhN4SFNM8Qu4o
 WMCVSSJEBKLFINSugOIR6z2EUFvC5no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-PG-tSwNDOvmfzM3tWFLtVg-1; Thu, 09 Jul 2020 05:56:03 -0400
X-MC-Unique: PG-tSwNDOvmfzM3tWFLtVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B11368015F7;
 Thu,  9 Jul 2020 09:56:01 +0000 (UTC)
Received: from ovpn-115-114.ams2.redhat.com (ovpn-115-114.ams2.redhat.com
 [10.36.115.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B0046FEC2;
 Thu,  9 Jul 2020 09:55:51 +0000 (UTC)
Message-ID: <8ed00a46daec6b41e7369123e807342e0ecfe751.camel@redhat.com>
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
From: Mohammed Gamal <mgamal@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>
Date: Thu, 09 Jul 2020 11:55:50 +0200
In-Reply-To: <20200709094415.yvdh6hsfukqqeadp@sirius.home.kraxel.org>
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
 <20200708171621.GA780932@habkost.net> <20200708172653.GL3229307@redhat.com>
 <20200709094415.yvdh6hsfukqqeadp@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mgamal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Guilherme Piccoli <gpiccoli@canonical.com>,
 Pedro Principeza <pedro.principeza@canonical.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, Dann Frazier <dann.frazier@canonical.com>,
 mtosatti@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, Laszlo Ersek <lersek@redhat.com>, fw@gpiccoli.net,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-07-09 at 11:44 +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > (CCing libvir-list, and people who were included in the OVMF
> > > thread[1])
> > > 
> > > [1] 
> > > https://lore.kernel.org/qemu-devel/99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com/
> > > Also, it's important that we work with libvirt and management
> > > software to ensure they have appropriate APIs to choose what to
> > > do when a cluster has hosts with different MAXPHYADDR.
> > 
> > There's been so many complex discussions that it is hard to have
> > any
> > understanding of what we should be doing going forward. There's
> > enough
> > problems wrt phys bits, that I think we would benefit from a doc
> > that
> > outlines the big picture expectation for how to handle this in the
> > virt stack.
> 
> Well, the fundamental issue is not that hard actually.  We have three
> cases:
> 
> (1) GUEST_MAXPHYADDR == HOST_MAXPHYADDR
> 
>     Everything is fine ;)
> 
> (2) GUEST_MAXPHYADDR < HOST_MAXPHYADDR
> 
>     Mostly fine.  Some edge cases, like different page fault errors
> for
>     addresses above GUEST_MAXPHYADDR and below
> HOST_MAXPHYADDR.  Which I
>     think Mohammed fixed in the kernel recently.
> 
> (3) GUEST_MAXPHYADDR > HOST_MAXPHYADDR
> 
>     Broken.  If the guest uses addresses above HOST_MAXPHYADDR
> everything
>     goes south.
> 
> The (2) case isn't much of a problem.  We only need to figure
> whenever
> we want qemu allow this unconditionally (current state) or only in
> case
> the kernel fixes are present (state with this patch applied if I read
> it
> correctly).
> 
> The (3) case is the reason why guest firmware never ever uses
> GUEST_MAXPHYADDR and goes with very conservative heuristics instead,
> which in turn leads to the consequences discussed at length in the
> OVMF thread linked above.
> 
> Ideally we would simply outlaw (3), but it's hard for backward
> compatibility reasons.  Second best solution is a flag somewhere
> (msr, cpuid, ...) telling the guest firmware "you can use
> GUEST_MAXPHYADDR, we guarantee it is <= HOST_MAXPHYADDR".

Problem is GUEST_MAXPHYADDR > HOST_MAXPHYADDR is actually a supported
configuration on some setups. Namely when memory encryption is enabled
on AMD CPUs[1].

> 
> > As mentioned in the thread quoted above, using host_phys_bits is a
> > obvious thing to do when the user requested "-cpu host".
> > 
> > The harder issue is how to handle other CPU models. I had suggested
> > we should try associating a phys bits value with them, which would
> > probably involve creating Client/Server variants for all our CPU
> > models which don't currently have it. I still think that's worth
> > exploring as a strategy and with versioned CPU models we should
> > be ok wrt back compatibility with that approach.
> 
> Yep, better defaults for GUEST_MAXPHYADDR would be good too, but that
> is a separate (although related) discussion.
> 
> take care,
>   Gerd
> 
[1] - https://lkml.org/lkml/2020/6/19/2371


