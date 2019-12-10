Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEBFC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4382073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcFPeZuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4382073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iegaV-0005x9-Ua
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 09:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iegZn-0005OJ-FM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iegZl-0007ub-HF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:33:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iegZl-0007u2-4M
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575988400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF9FF+QH9Bg3CfnWnAhWc9idI2ShEituj8X2BRinmuo=;
 b=fcFPeZuZEKUDgFWpbRC5ZpUxGy9S/5fxRp5zUIpxYnciJiWONKzlvfPu4YDjn+8erBnY5H
 3L+o3nszRd/gSzqH8SpJAY+3gDJ8fOv3ob8tTuFu9UGTyw2FR3fKs1wU1pRrjf6SkG9Epn
 8Ref0JU+mG5jmgk8Ksu4RUAFxZrg3Fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-YCILETSNOjaWPB1QS-volA-1; Tue, 10 Dec 2019 09:33:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A9AE1800D45;
 Tue, 10 Dec 2019 14:33:15 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 911665C219;
 Tue, 10 Dec 2019 14:33:13 +0000 (UTC)
Date: Tue, 10 Dec 2019 15:33:11 +0100
From: Andrew Jones <drjones@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191210143311.4sen6blhfhzop6zw@kamzik.brq.redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <20191206155327.7adiyjjkjh56mg2t@kamzik.brq.redhat.com>
 <596d07e933cb4da48dbba5b492e81a2438e78a2f.camel@redhat.com>
 <CAFEAcA9+G0jprsHRQp8g=Aso+2-_GhoWkDGx4WWxoC88maOKEg@mail.gmail.com>
 <20191210110531.psjzlikir2ep2omo@kamzik.brq.redhat.com>
 <CAFEAcA_M61hTzU=qCiUbR4V9Mnwd0phFNqTJG9pCWKreVmjy6A@mail.gmail.com>
 <20191210133254.22vcpvr3eabcnthe@kamzik.brq.redhat.com>
 <29add42daba074ab5bdbd462b2d377115fec7c3c.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <29add42daba074ab5bdbd462b2d377115fec7c3c.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: YCILETSNOjaWPB1QS-volA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Tue, Dec 10, 2019 at 03:21:02PM +0100, Andrea Bolognani wrote:
> On Tue, 2019-12-10 at 14:32 +0100, Andrew Jones wrote:
> > After having done this git mining, it looks more and more like we shoul=
d
> > at least consider naming this feature 'kvm-no-adjvtime' and probably
> > also change arm's default.
>=20
> I agree with everything except the naming: why would
>=20
>   kvm-no-adjvtime=3Doff  vtime is adjusted      (default)
>   kvm-no-adjvtime=3Don   vtime is not adjusted
>=20
> be better than
>=20
>   kvm-adjvtime=3Don   vtime is adjusted      (default)
>   kvm-adjvtime=3Doff  vtime is not adjusted
>=20
> ? Both offer the exact same amount of flexibility, but the latter has
> the advantage of not introducing any unwieldy double negatives.
>

A default of 'off' =3D=3D 0 means not setting anything at all. There's
already precedent for 'kvm-no*' prefixed cpu features,

kvm-no-smi-migration
kvm-nopiodelay

(Unless there's something called a 'nopio' then I guess that one is
missing a -, but whatever...)

Thanks,
drew


