Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DBAC2D0C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320E02073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 09:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe1Eyyg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320E02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iecCX-0007SY-A6
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 04:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1iecBM-0006v5-Bx
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1iecBJ-0007OV-3p
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:51:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1iecBI-0007O4-JO
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 04:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575971507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1J4KRTPTQfJmDBAoGFDnI8xY6ixnsml6F3fxdBMK8HA=;
 b=Fe1Eyyg5E/P41k1OQOsIfNnbDMkvTfJIbT/acVwiylpADjeHepDMM4TRbgHz+3b8FXc0Pe
 XncqXX2LbUu5MI0oC+VqR+3W77rVVYgXB+sizTueMksTGi+6Cpjt8NzZS/FHWfdUwqs5Ob
 vffaENrw/6X3R++ly5jlvdOAGaRo5So=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-PIEVm6txMBOzTznv_OPOCA-1; Tue, 10 Dec 2019 04:51:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6175F107ACC7;
 Tue, 10 Dec 2019 09:51:44 +0000 (UTC)
Received: from ovpn-205-69.brq.redhat.com (ovpn-205-69.brq.redhat.com
 [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 934715D72C;
 Tue, 10 Dec 2019 09:51:41 +0000 (UTC)
Message-ID: <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
From: Andrea Bolognani <abologna@redhat.com>
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2019 10:51:38 +0100
In-Reply-To: <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PIEVm6txMBOzTznv_OPOCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-12-06 at 16:53 +0100, Andrew Jones wrote:
> On Fri, Dec 06, 2019 at 03:22:58PM +0000, Peter Maydell wrote:
> > On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
> > > This series is inspired by a series[1] posted by Bijan Mottahedeh about
> > > a year ago.  The problem described in the cover letter of [1] is easily
> > > reproducible and some users would like to have the option to avoid it.
> > > However the solution, which is to adjust the virtual counter offset each
> > > time the VM transitions to the running state, introduces a different
> > > problem, which is that the virtual and physical counters diverge.  As
> > > described in the cover letter of [1] this divergence is easily observed
> > > when comparing the output of `date` and `hwclock` after suspending the
> > > guest, waiting a while, and then resuming it.  Because this different
> > > problem may actually be worse for some users, unlike [1], the series
> > > posted here makes the virtual counter offset adjustment optional and not
> > > even enabled by default.  Besides the adjustment being optional, this
> > > series approaches the needed changes differently to apply them in more
> > > appropriate locations.  Finally, unlike [1], this series doesn't attempt
> > > to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, which
> > > only ticks when the VM is not stopped, is sufficient.
> > 
> > So I guess my overall question is "what is the x86 solution to
> > this problem, and why is this all arm-specific?" It would also
> 
> x86 adjusts the counter offset by default, and I don't think there's any
> way to turn that behavior off. I think it's too late to follow that
> default for arm, but this series provides a way to opt into the same
> behavior.

My understanding is that turning kvm-adjvtime either on or off
results in a different set of advantages and drawbacks, with neither
begin a one-size-fits-all solution. So it's good that we offer a way
for the user to pick one or the other based on their specific needs.

The main difference is that kvm-adjvtime=on matches x86's behavior,
which is fairly well understood and thoroughly documented, along with
the corresponding workarounds, dos and don'ts.

With that in mind, in my opinion it would make sense to make
kvm-adjvtime=on the behavior for newer machine types so that people
coming from an x86 background and/or having to manage both at the
same time will get a consistent experience and will be able to draw,
even for aarch64, on the considerable amount of existing x86-centric
literature on the subject.

-- 
Andrea Bolognani / Red Hat / Virtualization


