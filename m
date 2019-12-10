Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1E1C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1D22073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEsOVkCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1D22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iefem-0003hT-1o
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iefdU-0002jt-6a
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iefdP-00029C-Oo
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:33:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52106
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iefdP-00028e-Kj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575984783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXbA/XQp8OOzgFhmZ81cZEkMdjXPRMSfTmZl+9K0WPo=;
 b=UEsOVkCCsOl5/FD/eX6KcgLF8xpaWdpE1woApVQQvkN4+WfOncBsXAzRGcFD3GMH/VbUPY
 BwwX/RkvfziBifdk5YnGPHFyl/tDBEwcfVeNzV6Mho6dHKBi3q6YjuBTphpIU7k3IJ8G/7
 KUGRSttYUTJ6Z5ldN3MFWa3hMF0a2EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-DpCF9hjAPVSXaf81I2sYTQ-1; Tue, 10 Dec 2019 08:32:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B339800C76;
 Tue, 10 Dec 2019 13:32:58 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 998255DA70;
 Tue, 10 Dec 2019 13:32:56 +0000 (UTC)
Date: Tue, 10 Dec 2019 14:32:54 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
 <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
 <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DpCF9hjAPVSXaf81I2sYTQ-1
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 11:48:38AM +0000, Peter Maydell wrote:
> On Tue, 10 Dec 2019 at 11:05, Andrew Jones <drjones@redhat.com> wrote:
> > x86 developers could easily add this feature if/when they need a way to
> > disable their current default behavior. But, since the kvm-adjvtime
> > default would likely be 'on' for them, then they'd probably prefer the
> > feature be named kvm-no-adjvtime, and default 'off'. Should we try to
> > anticipate what x86 might want when naming this feature? IMO, we should
> > not, especially because I'm doubtful that x86 will ever want to impleme=
nt
> > it. Also, what about the other KVM capable architectures? Which default=
s
> > do they have now? And do we expect them to want to expose a switch to t=
he
> > user to change it?
>=20
> My perspective here is mostly that I don't really understand
> the ins and outs of KVM and in particular handling of
> time in VMs, beyond knowing that it's complicated. So I
> prefer approaches that push back to "do everything the same
> for all architectures rather than having something that's
> arm-specific", because then things get more review from
> the larger mass of non-arm KVM/QEMU developers. Arm-specific
> switches/interfaces/designs just make arm more of a
> special-snowflake. I don't really have a basis to be able
> to review the patchset beyond those general biases.
>

So the ins and outs of this particular timekeeping issue (to the best of
my knowledge) is that x86 has implemented this behavior since
00f4d64ee76e ("kvmclock: clock should count only if vm is running"), which
was committed over six years ago. Possibly x86 VM time would behave more
like arm VM time if kvmclock was disabled, but that's not a recommended
configuration.

PPC got an equivalent patch to the x86 one in 2017, 42043e4f1241 ("spapr:
clock should count only if vm is running"), but when stopping time during
pause on spapr they actually *keep* 'date' and 'hwclock' in synch. I guess
whatever clocksource 'hwclock' uses on spapr was already stopping when
paused? For x86 those values diverge, and for arm without this series they
stay the same but experience jumps, and with this series they diverge like
x86. I don't see any way to disable the behaviour 42043e4f1241 introduces.

s390x got what appears to be its equivalent patch last year 9bc9d3d1ae3b
("s390x/tod: Properly stop the KVM TOD while the guest is not running").
The commit message doesn't state how hwclock and date values change /
don't change, and I don't see any way to disable the behavior.

MIPS has had this implemented since KVM support was introduced. No way
to disable it that I know of.

So why is this arm-specific? arm is just trying to catch up, but also
offer a switch allowing the current behavior to be selected. If other
architectures see value in the switch then they're free to adopt it too.
After having done this git mining, it looks more and more like we should
at least consider naming this feature 'kvm-no-adjvtime' and probably
also change arm's default.

Thanks,
drew


