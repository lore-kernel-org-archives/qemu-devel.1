Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F406EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC3F2077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 16:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9/xtnlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC3F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iei4q-0005lQ-0H
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 11:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iei3v-00055h-QE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iei3t-00068B-5e
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:08:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iei3t-00067y-1H
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 11:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575994112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omvEPFgMa0ImghPBOD0QaB8/kVCMWZVlsLSkdCnszF4=;
 b=J9/xtnlVc6uYxfk9Q/xvovWVwqaj/zqkCRF2ukMAMws5eGbzi2jKVwSC4AdnMEYqn0AIm9
 2IxKMMQ5m9Kg7BrqH7ikgP/8KHF1wn1RFtaVTQyko7UPCLpnq7ALZNZd+SeZzivvhD1e8e
 zx3/QgFKIdmlkC4jvqHfR4A4E4VOjWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-qYuj1O5nOgqp6Uz9pr90jA-1; Tue, 10 Dec 2019 11:08:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3148610054E3;
 Tue, 10 Dec 2019 16:08:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 811FD5C1B0;
 Tue, 10 Dec 2019 16:08:27 +0000 (UTC)
Date: Tue, 10 Dec 2019 17:08:25 +0100
From: Andrew Jones <drjones@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191210160825.ioah26u36eu2i3z2@kamzik.brq.redhat.com>
References: <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
 <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
 <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
 <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
 <29add42daba074ab5bdbd462b2d377115fec7c3c.camel@redhat.com>
 <20191210143311.4sen6blhfhzop6zw@kamzik.brq.redhat.com>
 <e0f86b200d0b3c08769cdbaa080569c3ec3db3ab.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e0f86b200d0b3c08769cdbaa080569c3ec3db3ab.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qYuj1O5nOgqp6Uz9pr90jA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 04:47:49PM +0100, Andrea Bolognani wrote:
> On Tue, 2019-12-10 at 15:33 +0100, Andrew Jones wrote:
> > On Tue, Dec 10, 2019 at 03:21:02PM +0100, Andrea Bolognani wrote:
> > > I agree with everything except the naming: why would
> > >=20
> > >   kvm-no-adjvtime=3Doff  vtime is adjusted      (default)
> > >   kvm-no-adjvtime=3Don   vtime is not adjusted
> > >=20
> > > be better than
> > >=20
> > >   kvm-adjvtime=3Don   vtime is adjusted      (default)
> > >   kvm-adjvtime=3Doff  vtime is not adjusted
> > >=20
> > > ? Both offer the exact same amount of flexibility, but the latter has
> > > the advantage of not introducing any unwieldy double negatives.
> >=20
> > A default of 'off' =3D=3D 0 means not setting anything at all. There's
> > already precedent for 'kvm-no*' prefixed cpu features,
> >=20
> > kvm-no-smi-migration
> > kvm-nopiodelay
>=20
> Sorry, I'm not sure I understand. Do you mean that the array where
> you store CPU features is 0-inizialized, so it's more convenient to
> have off (0) as the default because it means you don't have to touch
> it beforehand? Or something different?
>

Right. The CPU feature flag (a boolean member of the CPU state) will
be zero by default because C. It's not a big deal, though, because the
property default can easily be set to true while it's added to a cpu
type.

I don't have a strong enough opinion about kvm-adjvtime vs.
kvm-no-adjvtime to insist one way or another. I agree double inversions
are easier to mess up, but I also like the way the '-no-' better
communicates that the default is [probably] 'yes'.

All interested parties, please vote. I'll be sending v2 soon and I can
call this thing anything the majority (or the dominate minority) prefer.

Thanks,
drew


