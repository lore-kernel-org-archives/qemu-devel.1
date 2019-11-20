Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E5BC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749222088F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtxrBSLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749222088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXV9M-0005XH-DY
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iXV7n-0004hA-Hp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iXV7l-0000qD-Df
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:54:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iXV7k-0000pi-Fr
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574276083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibW3iAYZrucLJDK3NWPHH3vAO7MrS557DPqcE2f94zw=;
 b=PtxrBSLDoUb8eMGZdknKQEwRq1QcZIGZgP1wtdK2KmhH7oA3Ccokq0XrcsX/OihtNis0pR
 SuMk1yjN2mxv1W5VW1veTtYbu0R1P9YYlNQl4VYD2H4DiywnRchWGCSaecXIsdJP8M0D5Z
 QJJJXDmwlG7eppHwRLbEJlLqi5xHh00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-I88dyjnYOWWW4Nm8nDdoFg-1; Wed, 20 Nov 2019 13:54:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 259938024C2;
 Wed, 20 Nov 2019 18:54:39 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74D336E3F1;
 Wed, 20 Nov 2019 18:54:22 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:54:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v3 07/33] serial: register vmsd with DeviceClass
Message-ID: <20191120185420.GF2858@work-vm>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-8-marcandre.lureau@redhat.com>
 <CAFEAcA8GHqiaHSKdTjzTY_mWxYpDLZhXLYc98kjPGLUnzsG3oQ@mail.gmail.com>
 <CAMxuvawcYnH4pp8PitMO6KcTz_GdwF7i=zJxepofsN1o9Yh65w@mail.gmail.com>
 <CAFEAcA9Ee950esqNT4PJgGU0txnv_oFJWvQ+8oOn0FS9PBt=-w@mail.gmail.com>
 <CAJ+F1CKYriLP=FK5s2u=azk-rfUCAG-gR6_keXDSOPS4D0Mq3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKYriLP=FK5s2u=azk-rfUCAG-gR6_keXDSOPS4D0Mq3A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: I88dyjnYOWWW4Nm8nDdoFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Corey Minyard <cminyard@mvista.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Paul Burton <pburton@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> On Tue, Nov 19, 2019 at 2:35 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Tue, 19 Nov 2019 at 10:23, Marc-Andr=E9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > > On Mon, Nov 18, 2019 at 6:22 PM Peter Maydell <peter.maydell@linaro.o=
rg> wrote:
> > > > Did you test whether migration still works from a QEMU
> > > > version without this patch to one with it? (The migration
> > >
> > > Yes, I thought I did test correctly, but I realized testing with x86
> > > isn't correct.
> > >
> > > So with arm/musicpal for ex, I can migrate from before->after, howeve=
r
> > > after->before won't work. Is that ok?
> >
> > Broadly speaking, the only case where we care about not
> > breaking cross-version migration is where we have a versioned
> > machine type. So musicpal doesn't matter too much. Beyond
> > that, yes, generally before->after is more important than
> > after->before. I have a feeling Red Hat downstream cares about
> > after->before migration at least for x86 but you or your colleagues
> > would know that better than me :-)
> >
> > > > vmstate code is too complicated for me to be able to figure
> > > > out whether passing the 'dev' pointer makes a difference
> > > > to whot it names the state sections and whether the
> > > > 'qdev_set_legacy_instance_id' suffices to avoid problems.)
> > >
> > > I don't see a way to fix after->before, because the instance id is
> > > initially 0 with the new code, and the old code expect a different
> > > value.
> >
> > Can you explain how the instance ID stuff works? I was
> > expecting that the result of setting the legacy instance ID
> > would just be that the new version would always have
> > the older setting, so if it works for old->new it would also
> > work for new->old. But as I say I don't understand this bit
> > of the migration code.
>=20
> From what I understand, the alias_id is only used in
> savevm.c:find_se(), and thus can only be used to match against
> "legacy" instance id values. On new code, instance_id is generated
> incrementally from 0 with calculate_new_instance_id(), based on
> "qdev-path/vmsd-name".

I think there are cases here there's no qdev path that's viable;
e.g. for ISA devices, the ID is set to the ISA IO base:

hw/char/serial-isa.c
79:    qdev_set_legacy_instance_id(dev, isa->iobase, 3);

(In serial_isa_realizefn )

but to be honest I'd have to trace this out and see what values the
devices are actually using to be sure.

(And yes, please don't break backwards migration; otherwise I'll
end up having to figure out a fix).

Dave

>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


