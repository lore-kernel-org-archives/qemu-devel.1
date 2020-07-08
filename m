Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586AAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22174206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFD6pV2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22174206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtII2-0005Sm-BZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHkc-000510-7M
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:37:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50777
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHkX-0003K3-Pd
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UuAdTDv+dUPrs6AoSqoCsiFBVr4wGjrphEtfpnHhCR4=;
 b=BFD6pV2kMlpVWAyLzSwlM7eH4BnXN7YfiLcwttwKbbHMT6d4cvb6jaXtMUpAql/f1a8CZA
 nsJ4fE7g1csWjrFffLwCVMOegwSd4fx3KgAddATbY1nibH20XKTnLLOPFaVX2kIitp7/3q
 gvr1xDNA81PpVeTizJ8a1IKjvO9U+ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-dAW7sxZcMbGcfPTp7gCcpg-1; Wed, 08 Jul 2020 13:36:23 -0400
X-MC-Unique: dAW7sxZcMbGcfPTp7gCcpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EE8819253C2;
 Wed,  8 Jul 2020 17:36:22 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6E011A7CA;
 Wed,  8 Jul 2020 17:36:21 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:36:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200708173620.GB780932@habkost.net>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net>
 <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
 <20200708160316.GA7276@habkost.net>
 <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 06:09:49PM +0100, Peter Maydell wrote:
> On Wed, 8 Jul 2020 at 17:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Wed, Jul 08, 2020 at 04:32:51PM +0100, Peter Maydell wrote:
> > > On Wed, 8 Jul 2020 at 16:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > On Wed, Jul 08, 2020 at 02:14:03PM +0100, Peter Maydell wrote:
> > > > > The original bug as described in the commit message sounds
> > > > > to me like something we should look to fix in the implementation
> > > > > of async_run_on_cpu() -- it shouldn't cause a CPU that's halfway
> > > > > through reset to do a KVM_RUN or otherwise run guest code,
> > > > > whether that CPU is going to start powered-up or powered-down.
> > > >
> > > > What "halfway through reset" means, exactly?  Isn't halted==1
> > > > enough to indicate the CPU is in that state?
> > >
> > > I mean "while we're in the middle of the CPU method that's
> > > called by cpu_reset()". "halted==1" says "the CPU is halted";
> > > that's not the same thing. KVM_RUN happening
> > > as a side effect in the middle of that code is a bug
> > > whether the CPU happens to be intended to be put into the
> > > halted state or not. If the CPU is intended to be created
> > > not-halted then KVM_RUN can happen after cpu reset
> > > completes, but not before.
> >
> > Wait, I thought we already had mechanisms to prevent that from
> > happening.  Otherwise, it would never be safe for cpu_reset() to
> > touch the CPU registers.
> 
> Exactly. It appears that there's a bug in our mechanisms,
> which is why I'm suggesting that the right thing is
> to fix that bug rather than marking the CPU as halted
> earlier in the reset process so that the KVM_RUN happens
> to do nothing...

I agree this is necessary, but it doesn't seem sufficient.

Having cpu_reset() set halted=0 on spapr (and probably other
machines) is also a bug, as it could still trigger unwanted
KVM_RUN when cpu_reset() returns (and before machine code sets
halted=1).

-- 
Eduardo


