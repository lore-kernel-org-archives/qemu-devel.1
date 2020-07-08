Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB57CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E1B20775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPTsy4Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E1B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI8R-000202-KC
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHgU-0006bG-CR
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:32:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtHgR-0002jb-Dk
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IxqGh05efWlWicC9Rwyf4ornE0UGz0vxYZ8lCuEUqAc=;
 b=UPTsy4Wpz0vcoeB9IMUzQnkYKOZMRUadCEMC+NBg5j+FjnMKxjt5p7AOb49CNNHi/VYntT
 STNxcXZ2lhwKLeBIU3IgxCpiPQmpjcppoWswPWhxTqcegqaYpxZLm5NamtdyxaN2Hy8X9E
 6fEm/dVk1bbJiMZuRqb/6/EsayuxQDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-MRzdKAozNAeFOnc7m6ouQw-1; Wed, 08 Jul 2020 17:32:44 -0400
X-MC-Unique: MRzdKAozNAeFOnc7m6ouQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8406802788;
 Wed,  8 Jul 2020 21:32:42 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12E227F8A9;
 Wed,  8 Jul 2020 21:32:41 +0000 (UTC)
Date: Wed, 8 Jul 2020 17:32:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200708213240.GC780932@habkost.net>
References: <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
 <20200708160316.GA7276@habkost.net>
 <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
 <20200708173620.GB780932@habkost.net>
 <CAFEAcA_bLs+PzjfmCaHQQ3z1BrQ9Uack_Qj7Za-dJwtHWu=8kw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bLs+PzjfmCaHQQ3z1BrQ9Uack_Qj7Za-dJwtHWu=8kw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 09:11:55PM +0100, Peter Maydell wrote:
> On Wed, 8 Jul 2020 at 18:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Wed, Jul 08, 2020 at 06:09:49PM +0100, Peter Maydell wrote:
> > > Exactly. It appears that there's a bug in our mechanisms,
> > > which is why I'm suggesting that the right thing is
> > > to fix that bug rather than marking the CPU as halted
> > > earlier in the reset process so that the KVM_RUN happens
> > > to do nothing...
> >
> > I agree this is necessary, but it doesn't seem sufficient.
> >
> > Having cpu_reset() set halted=0 on spapr (and probably other
> > machines) is also a bug, as it could still trigger unwanted
> > KVM_RUN when cpu_reset() returns (and before machine code sets
> > halted=1).
> 
> The Arm handling of starting-halted sets halted=1 within cpu_reset,
> based on whether the CPU object was created with a
> "start-powered-off" property.

Making this mechanism generic sounds like a good idea.

> 
> I'm not sure in practice that anything can get in asynchronously
> and cause a KVM_RUN in between spapr_reset_vcpu() calling
> cpu_reset() and it setting cs->halted (and the other stuff),
> though. This function ought to be called with the iothread
> lock held, so KVM_RUN will only happen if it calls some
> other function which incorrectly lets the CPU run.

Yeah, maybe it won't happen in practice.  It just seems fragile.
The same way ppc_cpu_reset() kicked the CPU by accident, code
outside cpu_reset() might one day kick the CPU by accident before
setting halted=1.

-- 
Eduardo


