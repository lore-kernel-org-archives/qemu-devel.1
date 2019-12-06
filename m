Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7837CC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4749E205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3fr0R0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4749E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idH3o-0004di-3c
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1idFvF-0001Oq-0g
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1idFvD-0001TF-NK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:53:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35100
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1idFvD-0001Rf-Ju
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575647614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xx+gBQINEfsdCHgzHWk9u1vbTF0umg2qaZIaBUYeVFs=;
 b=I3fr0R0v4FYy9x4JfAx8fDj3syXyx9AVruAC8wMYYhG5svmRSuArVbHajeJ09WOrTslS9S
 Oc0s3uyVf2AIVlvd0IIl+OmekIxP3DQuC06tOwqaWIHt6w/sz9g7h/m0GNQoMyp5J8rK1K
 p+y2Wa+/tFIHHp4DrXhGATT6Edsop+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-ZKWUJp0YOXu4ZFKdzCgesQ-1; Fri, 06 Dec 2019 10:53:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28DD0DB22;
 Fri,  6 Dec 2019 15:53:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFB325D9E1;
 Fri,  6 Dec 2019 15:53:28 +0000 (UTC)
Date: Fri, 6 Dec 2019 16:53:27 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ZKWUJp0YOXu4ZFKdzCgesQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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

On Fri, Dec 06, 2019 at 03:22:58PM +0000, Peter Maydell wrote:
> On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
> >
> > v2:
> >  - move from RFC status to v1
> >  - put kvm_arm_vm_state_change() in kvm.c to share among kvm32.c and kv=
m64.c
> >  - add r-b's from Richard
> >
> >
> > This series is inspired by a series[1] posted by Bijan Mottahedeh about
> > a year ago.  The problem described in the cover letter of [1] is easily
> > reproducible and some users would like to have the option to avoid it.
> > However the solution, which is to adjust the virtual counter offset eac=
h
> > time the VM transitions to the running state, introduces a different
> > problem, which is that the virtual and physical counters diverge.  As
> > described in the cover letter of [1] this divergence is easily observed
> > when comparing the output of `date` and `hwclock` after suspending the
> > guest, waiting a while, and then resuming it.  Because this different
> > problem may actually be worse for some users, unlike [1], the series
> > posted here makes the virtual counter offset adjustment optional and no=
t
> > even enabled by default.  Besides the adjustment being optional, this
> > series approaches the needed changes differently to apply them in more
> > appropriate locations.  Finally, unlike [1], this series doesn't attemp=
t
> > to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, which
> > only ticks when the VM is not stopped, is sufficient.
>=20
> So I guess my overall question is "what is the x86 solution to
> this problem, and why is this all arm-specific?" It would also

x86 adjusts the counter offset by default, and I don't think there's any
way to turn that behavior off. I think it's too late to follow that
default for arm, but this series provides a way to opt into the same
behavior.

> be helpful to know how it fits into all the other proposals regarding
> time in VMs.

I've been lightly following the other stuff, but haven't yet seen any
overlap.

BTW, this series needs to be rebased and reposted. I've been waiting for
4.2 though.

Thanks,
drew


