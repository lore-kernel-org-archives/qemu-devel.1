Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D27621739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 22:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpl5ZrEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D27621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8tJ9-0001UI-DV
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 17:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j8tIY-00015e-6b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j8tIV-0007Ix-Tb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:12:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j8tIV-0007Ic-O5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 17:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583187142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZn2JwmPsAs5y0uC93tgqZp7Ay76JPZd6KCetj9qg0I=;
 b=fpl5ZrEZoT5IU13m1wCHT2FIFVMNRNDUT9SkWTCTBxUgKGNg5UydTTLH/y/24PAPBPD3qq
 SiRJvCsSSm7SnzVMYHVYV5qQJ4pG9AphNPwLd9NG57C2aSm3a0D0FCsrhCTAwnbq49gtaU
 3E9x1uFYDzopQl/Y+Do8+Wwdyg6rdzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-LPR_drDBM3ajVrc2GB0nRQ-1; Mon, 02 Mar 2020 17:12:19 -0500
X-MC-Unique: LPR_drDBM3ajVrc2GB0nRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9D1A100550E;
 Mon,  2 Mar 2020 22:12:17 +0000 (UTC)
Received: from localhost (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DFCE90CF4;
 Mon,  2 Mar 2020 22:12:17 +0000 (UTC)
Date: Mon, 2 Mar 2020 17:12:16 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: CPU reset vs DeviceState reset
Message-ID: <20200302221216.GQ4440@habkost.net>
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
 <20200302174551.GK4440@habkost.net>
 <CAFEAcA8AY4ZPuWh=oPd4heepAAZziLP1DLNHhrC_3jLuMXnBcQ@mail.gmail.com>
 <20200302214036.GO4440@habkost.net>
 <CAFEAcA_4yf6+BujSKEpX6TwTurE_GP5vOZ16OnfsQP10CAWeMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4yf6+BujSKEpX6TwTurE_GP5vOZ16OnfsQP10CAWeMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 09:55:42PM +0000, Peter Maydell wrote:
> On Mon, 2 Mar 2020 at 21:40, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Mon, Mar 02, 2020 at 06:41:31PM +0000, Peter Maydell wrote:
> > > On Mon, 2 Mar 2020 at 17:45, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> > > >
> > > > My impression is that this is just historical legacy, but I'm not
> > > > sure how much work a conversion to the new system would require.
> > > > I see lots of cpu_reset() calls scattered around the code.
> > >
> > > I think we can just make the cpu_reset() function be a
> > > wrapper that calls device_cold_reset(DEVICE(cpu)).
> > > We would need to update the prototypes for
> >
> > [1] This might have unintended side effects, as it will also call
> >     cpu_common_reset().  I still think we should try it.
>=20
> Yes, but cpu_reset() ends up calling cpu_common_reset()
> at the moment (every subclass uses cpu_class_set_parent_reset()
> to put in its own reset implementation and save a pointer to
> the base class reset function, which it then invokes from
> its own reset method). A DeviceClass::reset changeover works
> exactly the same way.
>=20
> (I have some working code for this, just need to test it a bit
> more and satisfy myself that there aren't any weird places
> that call DeviceClass::reset on a CPU object and expect it
> to be a no-op like it is right now. I don't think there should be
> any since a CPU object is never on a qbus, and none of the
> direct calls to functions that do device-object resets are
> dealing with CPUs.)
>=20
> > > At least for Arm CPUs, I don't think it does (well, it
> > > has the default DeviceState base class reset method
> > > which does nothing). Is there somewhere I missed?
> >
> > TYPE_CPU points DeviceClass::reset to cpu_common_reset(),
> > so I believe this affects all TYPE_CPU descendants.
>=20
> Where does it do that? cpu_class_init() sets CPUClass::reset
> to cpu_common_reset and doesn't touch DeviceClass::reset:
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/core/cpu.c;h=3Dfe65ca6=
2aceef581d4d9ef3cb9e1b0d7df4e5bfa;hb=3DHEAD#l416
> (the two reset methods have different type signatures so
> you wouldn't be able to assign cpu_common_reset() to
> DeviceClass::reset without an ugly and undefined-behaviour
> cast...)

Oops, my mistake.  I misread k->reset as DeviceClass::reset.
Forget everything I said above.


>=20
> > > (I'm currently attempting to wrestle Coccinelle into
> > > doing the conversion of the target/ code automatically.)
> >
> > I see 3 separate problems we might want to address:
> >
> > 1) Making device_cold_reset() end up calling CPUClass::reset
> >    in addition to existing cpu_common_reset()
> >    (easier to do without side effects).  This would get rid of
> >    the custom reset callbacks on machine code.
> >
> > 2) Making cpu_reset() call device_cold_reset()
> >    (will have side effects, needs additional care[1]).
> >    This would make us have only one method of resetting CPUs.

Correcting myself: this part won't have side effects.

> >
> > 3) Replacing CPUClass::reset with the new reset mechanisms..
> >    This would let us get rid of legacy CPU reset code.
>=20
> My work-in-progress patch does:
>  * cpu_reset() calls device_cold_reset()
>  * all the targets, plus the base TYPE_CPU class, implement
>    DeviceClass::reset instead of CPUClass::reset
>  * CPUClass::reset goes away entirely
> It passes 'make check' and 'make check-acceptance', so it's
> basically right, I think.

Sounds good to me.

>=20
> Note that this does not do anything about the need for each
> machine or whatever to use qemu_register_reset() to arrange
> to call cpu_reset() -- that is necessary because CPU objects
> are not on any qbus, so they don't get reset when the qbus
> tree rooted at the sysbus bus is reset, and that doesn't change.
> That's a different and much trickier problem to try to tackle
> (I don't currently have any good ideas for how we would want
> to approach it).

Understood.

--=20
Eduardo


