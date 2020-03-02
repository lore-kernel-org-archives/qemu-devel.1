Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4495C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C86D20732
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiOgQNhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C86D20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8sp8-00009e-0R
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j8snr-0007O3-KR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j8snq-0006y3-21
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:40:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j8snp-0006xj-Si
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583185241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tFrm/JrlPGHFMoTiL64w1jHrhCF9vIjPA6aWw9DThc=;
 b=LiOgQNhfrWZnboYGkvgliSYpEZpVBkROShu68E94P9ve4GTiMMaG5BYIRaPGtkTZC5Iee9
 rtjjiQPK773QLWS5DzfZY+8IKRAJ+K74+H3EaD1hRqnowfNK/l1l7scgMkSLJSrN3bou/a
 M5OFml345C6WM8vQluLnn9uRHzc4nIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-O_Br5NCQMXqcZ-xG28mirQ-1; Mon, 02 Mar 2020 16:40:39 -0500
X-MC-Unique: O_Br5NCQMXqcZ-xG28mirQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCE0613E4;
 Mon,  2 Mar 2020 21:40:37 +0000 (UTC)
Received: from localhost (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DEF15DA2C;
 Mon,  2 Mar 2020 21:40:36 +0000 (UTC)
Date: Mon, 2 Mar 2020 16:40:36 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: CPU reset vs DeviceState reset
Message-ID: <20200302214036.GO4440@habkost.net>
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
 <20200302174551.GK4440@habkost.net>
 <CAFEAcA8AY4ZPuWh=oPd4heepAAZziLP1DLNHhrC_3jLuMXnBcQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8AY4ZPuWh=oPd4heepAAZziLP1DLNHhrC_3jLuMXnBcQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 06:41:31PM +0000, Peter Maydell wrote:
> On Mon, 2 Mar 2020 at 17:45, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > My impression is that this is just historical legacy, but I'm not
> > sure how much work a conversion to the new system would require.
> > I see lots of cpu_reset() calls scattered around the code.
>=20
> I think we can just make the cpu_reset() function be a
> wrapper that calls device_cold_reset(DEVICE(cpu)).
> We would need to update the prototypes for

[1] This might have unintended side effects, as it will also call
    cpu_common_reset().  I still think we should try it.

>=20
> > To make it worse, TYPE_CPU do have a DeviceClass::reset method
> > implemented, but cpu_reset() won't call it because it bypasses
> > the Device reset system completely.  I will do some git
> > archaeology work to try to find out why the code is this way.
>=20
> At least for Arm CPUs, I don't think it does (well, it
> has the default DeviceState base class reset method
> which does nothing). Is there somewhere I missed?

TYPE_CPU points DeviceClass::reset to cpu_common_reset(),
so I believe this affects all TYPE_CPU descendants.

>=20
> (I'm currently attempting to wrestle Coccinelle into
> doing the conversion of the target/ code automatically.)

I see 3 separate problems we might want to address:

1) Making device_cold_reset() end up calling CPUClass::reset
   in addition to existing cpu_common_reset()
   (easier to do without side effects).  This would get rid of
   the custom reset callbacks on machine code.

2) Making cpu_reset() call device_cold_reset()
   (will have side effects, needs additional care[1]).
   This would make us have only one method of resetting CPUs.

3) Replacing CPUClass::reset with the new reset mechanisms..
   This would let us get rid of legacy CPU reset code.

--=20
Eduardo


